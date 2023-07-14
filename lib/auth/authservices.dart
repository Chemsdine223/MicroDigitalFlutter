import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:microdigital/auth/Models/loan_model.dart';
import 'package:microdigital/auth/Models/user_model.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// const apiUrl = 'https://chemsdine223.pythonanywhere.com/';
const apiUrl = 'https://pubgmobilemmj.pythonanywhere.com';

// const apiUrl = 'http://192.168.100.30:8000/';
// 192.168.0.103:8000
const loginUrl = '$apiUrl/users/login/';
const signUpUrl = '$apiUrl/users/register/';
const refreshUrl = '$apiUrl/refresh/';

class AuthService {
  static String accessToken = '';
  static String refreshToken = '';
  static String id = '';
  final bool _requireConsent = false;

  Future<void> initializeOneSignal() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    await OneSignal.shared.setAppId("50c2523b-ad83-4410-8945-c16f92a18b50");
    OneSignal.shared.setRequiresUserPrivacyConsent(_requireConsent);
    OneSignal.shared.setExternalUserId('1');
  }

  static Future<User> loGin(String number, String pass) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'phone': number,
          'password': pass,
        },
      ),
    );
    final data = jsonDecode(response.body);
    // print(data);
    print(data);
    accessToken = data['access'];
    refreshToken = data['refresh'];
    id = data['id'].toString();
    OneSignal.shared.setExternalUserId(id);

    await saveTokens();

    if (response.statusCode == 200) {
      final user = User.fromJson(data);

      return user;
    } else {
      throw data['message'].toString();
    }
  }

  static Future<bool> signUp(
    String nni,
    String nom,
    dynamic phone,
    String prenom,
    String password,
    String password2,
  ) async {
    final response = await http.post(
      Uri.parse(signUpUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          "nom": nom,
          "prenom": prenom,
          "phone": phone,
          "nni": nni,
          "password": password,
          "password2": password2,
        },
      ),
    );
    print('${response.statusCode} ========');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
      // print(response.body);
      // throw Exception('Failed to sign up');
    }
  }

  static Future<String> refresh() async {
    final response = await http.post(
      Uri.parse(refreshUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh': refreshToken}),
    );
    final data = jsonDecode(response.body);
    accessToken = data['access'];
    await saveTokens();
    return accessToken;
  }

  static Future<void> saveTokens() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
    await prefs.setString('id', id);
  }

  static Future<String> loadTokens() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token') ?? '';
    refreshToken = prefs.getString('refresh_token') ?? '';
    id = prefs.getString('id') ?? '';

    return accessToken;
  }

  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    await prefs.remove('id');
  }

  static bool isAuthenticated() {
    if (accessToken.isNotEmpty && !JwtDecoder.isExpired(accessToken)) {
      return true;
    } else {
      return false;
    }
  }
}

class UserRepository {
  static Future<User> getUserData() async {
    if (!AuthService.isAuthenticated()) {
      await AuthService.loadTokens();
      await AuthService.refresh();
    }

    final response = await http.get(
      Uri.parse('$apiUrl/users/getuser/${AuthService.id}'),
      headers: {
        // 'content-type': 'form-data',
        'Authorization': 'Bearer ${AuthService.accessToken}',
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final user = User.fromJson(data);

      await AuthService.saveTokens();
      return user;
    } else {
      throw data['message'].toString();
    }
  }
}

class LoanData {
  Future<LoanModel> getLoanData() async {
    if (!AuthService.isAuthenticated()) {
      await AuthService.loadTokens();
      await AuthService.refresh();
    }

    final response = await http.get(
      Uri.parse('$apiUrl/transaction/loans/${AuthService.id}'),
      headers: {
        'Authorization': 'Bearer ${AuthService.accessToken}',
      },
    );
    final data = jsonDecode(response.body);
    final loan = LoanModel.fromJson(data);
    print(loan);
    print(data);
    return loan;
  }

  Future<Map<String, dynamic>> requestLoan(
    String id,
    String loanAmount,
    String intrestRate,
    String loanStatus,
    DateTime loanStart,
    DateTime loanEnd,
    String paymentMethod,
  ) async {
    if (!AuthService.isAuthenticated()) {
      await AuthService.loadTokens();
      await AuthService.refresh();
    }
    final response =
        await http.post(Uri.parse('$apiUrl/transactions/loans/'), headers: {
      'Authorization': 'Bearer ${AuthService.accessToken}',
    }, body: {
      "borrower": id,
      "loan_amount": loanAmount,
      "interest_rate": intrestRate,
      "loan_status": loanStatus,
      "loan_start_date": loanStart,
      "loan_end_date": loanEnd,
      "repayment_method": paymentMethod,
    });
    final data = jsonDecode(response.body);
    return data;
  }
}
