import 'package:flutter/material.dart';

class TodoInputField extends StatelessWidget {
  final String? initialValue;
  final String field;
  final TextEditingController controller;

  const TodoInputField({
    super.key,
    this.initialValue,
    required this.field,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$field: ',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 50,
          margin: const EdgeInsets.only(bottom: 10),
          width: double.infinity,
          child: TextFormField(
            controller: controller,
          ),
        ),
      ],
    );
  }
}
