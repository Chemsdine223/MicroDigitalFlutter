import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  final String fieldName;
  final String fieldContent;

  const InfoTile({
    Key? key,
    required this.fieldName,
    required this.fieldContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            fieldName,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            fieldContent,
            style: const TextStyle(
              fontFamily: 'Quicksand',
            ),
          )
        ],
      ),
    );
  }
}
