import 'package:brainwavesocialapp/common/common.dart';
import 'package:brainwavesocialapp/domain/domain.dart';
import 'package:flutter/material.dart';

class UserPassForm extends StatelessWidget with EmailPassValidators {
  UserPassForm({
    super.key,
    required this.buttonLabel,
    required this.onFormSubmit,
  });

  final String buttonLabel;
  final Function(String, String) onFormSubmit;

  // create a global key that will uniquely identify the form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // create controllers for the form fields
    final userNameController = TextEditingController();
    // create controllers for the form fields
    final passwordController = TextEditingController();

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          AppTextFormField(
            fieldController: userNameController,
            fieldValidator: validateEmail,
            label: 'Username',
          ),
          GapWidgets.h8,
          AppTextFormField(
            fieldController: passwordController,
            fieldValidator: validatePassword,
            obscureText: true,
            label: 'Password',
          ),
          GapWidgets.h24,
          HighlightButton(
            text: buttonLabel,
            onPressed: () {
              // make sure the form is valid
              // before submitting
              if (_formKey.currentState!.validate()) {
                onFormSubmit(
                  userNameController.text,
                  passwordController.text,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
