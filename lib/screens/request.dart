import 'dart:convert';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:microdigital/Logic/cubit/auth_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:microdigital/Logic/cubit/bank_cubit.dart';
import 'package:microdigital/Logic/cubit/loan_cubit.dart';
import 'package:microdigital/auth/authservices.dart';
import 'package:microdigital/loanData/loan_data_service.dart';
import 'package:microdigital/screens/loading.dart';

import '../app_localizations.dart';
import '../components/fields.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

//fiche budgetaire
// cdi

class _RequestPageState extends State<RequestPage> {
  String? imagePath;
  String? bankId;
  String? selectedBank;
  String dropdownValue = '1';
  List<String> banks = ['1'];
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();

  TextEditingController dateinput = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _intrestRateController = TextEditingController();
  final TextEditingController _methodController = TextEditingController();
  final url = 'http://127.0.0.1:8000/transaction/getbanks/';
  List<String> _bankNames = [];
  bool status = false;

////////////////////////////// logic ////////////////////////

  Future<void> getBanks() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      setState(() {
        _bankNames = data.map<String>((bank) => bank['nom']).toList();
        selectedBank = _bankNames[0];
      });
    }
  }

  Future<bool> submit() async {
    final dynamic response = await LoanRepository.requestLoan(
      AuthService.id,
      _intrestRateController.text,
      _amountController.text,
      selectedBank,
      dateinput.text.toString(),
      "2022-01-20",
      _methodController.text,
    );

    if (response) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!
              .translate('Created successfully !'))));
      setState(() {
        status = response;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Check the provided data !')));
      setState(() {
        status = response;
      });
    }
    return status;
  }

  int currentStep = 0;
  final picker = ImagePicker();
  continueStep() {
    final isLastStep = currentStep == getSteps().length - 1;

    if (isLastStep) {
      submit();
    } else {
      if (_formKey.currentState!.validate() && currentStep == 0 ||
          _formKey1.currentState!.validate() && currentStep == 1) {
        setState(() {
          // print(_formKey.currentState!.validate());
          currentStep = currentStep + 1;
        });
      }
    }
  }

  cancelStep() {
    if (currentStep != 0) {
      setState(() {
        currentStep = currentStep - 1;
      });
    }
  }

  Widget controlsBuilder(context, details) {
    return Row(
      children: [
        // FloatingActionButton(onPressed: () {
        //   getBanks();
        // }),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.teal)),
          onPressed: () {
            continueStep();
          },
          child: currentStep == 2
              ? Text(AppLocalizations.of(context)!.translate('Confirm'))
              : Text(AppLocalizations.of(context)!.translate('Continue')),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 12,
        ),
        if (currentStep != 0)
          OutlinedButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size(90, 40)),
              foregroundColor: MaterialStateProperty.all(Colors.teal),
            ),
            onPressed: () {
              cancelStep();
            },
            child: Text(AppLocalizations.of(context)!.translate('Cancel')),
          )
      ],
    );
  }

  final DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    getBanks();
    dateinput.text = "";
    // selectedBank = _bankNames[0];
    super.initState();
  }

/////////////////////////////// logic /////////////////////////////////////
  ///
  ///
  ///
  ///
  ///

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoanCubit(),
        ),
        BlocProvider(
          create: (context) => BankCubit(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.teal,
            ),
          ),
          child: BlocConsumer<LoanCubit, LoanState>(
            listener: (context, state) {
              if (state is LoanSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Loan created !")));
              }
            },
            builder: (context, state) {
              if (state is LoanLoading) {
                return const LoadingScreen();
              } else if (state is LoanRequested) {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    // color: Colors.red,
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'Img/man (3).png',
                          height: MediaQuery.of(context).size.height / 3,
                        ),
                        Text(
                          AppLocalizations.of(context)!
                              .translate('You are already in debt'),
                          style: const TextStyle(
                            fontFamily: 'QuickSand',
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else if (state is LoanError) {
                return const Center(child: Text('Something went wrong '));
              } else if (status) {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    // color: Colors.red,
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<LoanCubit>().checkLoan();
                          },
                          child: Image.asset(
                            'Img/checked.png',
                            height: MediaQuery.of(context).size.height / 3,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!
                              .translate('Successfully created !'),
                          style: const TextStyle(
                            fontFamily: 'QuickSand',
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return Stepper(
                  elevation: 0.0,
                  type: StepperType.horizontal,
                  currentStep: currentStep,
                  onStepContinue: continueStep,
                  onStepCancel: cancelStep,
                  controlsBuilder: controlsBuilder,
                  steps: getSteps(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
          isActive: currentStep >= 0,
          state: currentStep > 0 ? StepState.complete : StepState.disabled,
          title: const Text('Info'),
          content: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.translate('Request info'),
                  style: const TextStyle(
                    fontSize: 36,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 400,
                  // color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormField(
                        validator: (value) {
                          RegExp regex = RegExp(r'^\d{1,8}(\.\d{1,2})?$');
                          if (!regex.hasMatch(value!)) {
                            return AppLocalizations.of(context)!
                                .translate('Please enter a valid loan amount');
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        autocorrect: false,
                        maxLines: 1,
                        controller: _amountController,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            label: Text(AppLocalizations.of(context)!
                                .translate('Amount')),
                            hintText: 'Enter the amount ..'),
                      ),
                      TextFormField(
                        validator: (value) {
                          RegExp regex = RegExp(r'^\d{1,2}(\.\d{1,2})?$');
                          if (!regex.hasMatch(value!)) {
                            return AppLocalizations.of(context)!.translate(
                                'Please enter a valid interest rate');
                          }
                          return null;
                        },
                        autocorrect: false,
                        maxLines: 1,
                        controller: _intrestRateController,
                        decoration: InputDecoration(
                          label: Text(AppLocalizations.of(context)!
                              .translate('Intrest rate')),
                          hintText: AppLocalizations.of(context)!
                              .translate('Enter the intrest rate'),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      TextField(
                        autocorrect: false,
                        maxLines: 1,
                        controller: _methodController,
                        decoration: InputDecoration(
                          label: Text(AppLocalizations.of(context)!
                              .translate('Repayment method')),
                          hintText: AppLocalizations.of(context)!
                              .translate('Enter the repayment method'),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      DropdownButtonHideUnderline(
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Colors.black38,
                                width: 1,
                              )),
                          child: DropdownButton<String>(
                            dropdownColor: Colors.white,
                            value: selectedBank,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 1,
                            isExpanded: true,
                            style: const TextStyle(
                              color: Colors.teal,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                selectedBank = value!;
                                // bankId = value;
                              });
                            },
                            items: _bankNames
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      // FloatingActionButton(
                      //   onPressed: () {
                      //     LoanRepository().fetchBankList();
                      //     LoanRepository().hasLoan();
                      //   },
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
          isActive: currentStep >= 1,
          state: currentStep > 1 ? StepState.complete : StepState.disabled,
          title: const Text('Documents'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Documents',
                style: TextStyle(
                  fontSize: 36,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 400,
                // color: Colors.red,
                child: Form(
                  key: _formKey1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextField(
                        autocorrect: false,
                        // maxLength: 255,
                        maxLines: 1,
                        controller: TextEditingController(text: imagePath),
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.attachment),
                              onPressed: () async {
                                final XFile? imagePicked = await picker
                                    .pickImage(source: ImageSource.gallery);
                                setState(() {
                                  imagePath = imagePicked!.path;
                                });
                              },
                            ),
                            border: const OutlineInputBorder(),
                            label: const Text('Document 1'),
                            hintText: 'Doc1 ..'),
                      ),
                      TextFormField(
                        readOnly: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .translate('Please enter a date !');
                          }
                          return null;
                        },
                        controller: dateinput,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101));

                                  if (pickedDate != null) {
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);

                                    dateinput.text = formattedDate;
                                  } else {
                                    print("Date is not selected");
                                  }
                                },
                                icon: const Icon(
                                  Icons.calendar_month,
                                )),
                            // icon: Icon(Icons.calendar_today),
                            labelText: AppLocalizations.of(context)!
                                .translate('Enter Date')),
                        // readOnly: true,
                      ),
                      const TextField(
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Step(
          isActive: currentStep == 2,
          title: Text(AppLocalizations.of(context)!.translate('Check')),
          content: Container(
            margin: const EdgeInsets.only(bottom: 12),
            height: MediaQuery.of(context).size.height / 1.9,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  offset: Offset(1, 1),
                  color: Colors.black12,
                  blurRadius: 3,
                  spreadRadius: 2,
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    // color: Colors.red,
                    height: MediaQuery.of(context).size.height / 19,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            if (state is AuthSuccess) {
                              return Text(
                                state.user.nom,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                        const CircleAvatar(
                          radius: 23,
                          child: Icon(Icons.person),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 70,
                  ),
                  // color: Colors.blue,
                  height: MediaQuery.of(context).size.height / 2.3,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoTile(
                        fieldName:
                            AppLocalizations.of(context)!.translate('Amount'),
                        fieldContent: _amountController.text,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InfoTile(
                        fieldName: AppLocalizations.of(context)!
                            .translate('Intrest rate'),
                        fieldContent: '${_intrestRateController.text}%',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InfoTile(
                        fieldName:
                            AppLocalizations.of(context)!.translate('Bank'),
                        fieldContent: selectedBank!,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InfoTile(
                        fieldName: AppLocalizations.of(context)!
                            .translate('Start date'),
                        fieldContent: '30/04/2023',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InfoTile(
                        fieldName: AppLocalizations.of(context)!
                            .translate('Payment method'),
                        fieldContent: '${_intrestRateController.text} ',
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ];
}
