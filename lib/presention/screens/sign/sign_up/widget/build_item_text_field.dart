import 'package:flutter/material.dart';
import 'package:todo_task/presention/widget/custom_text_field.dart';

class BuildItemTextField extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final GlobalKey<FormState> formState;

  const BuildItemTextField({
    Key key,
    this.emailController,
    this.passwordController,
    this.formState,
    this.phoneController,
    this.nameController,
  }) : super(key: key);

  @override
  State<BuildItemTextField> createState() => _BuildItemTextFieldState();
}

class _BuildItemTextFieldState extends State<BuildItemTextField> {
  bool _visibility = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formState,
      child: Column(
        children: [
          CustomTextField(
            controller: widget.nameController,
            textType: TextInputType.text,
            label: 'Full Name',
            prefixIcon: const Icon(Icons.drive_file_rename_outline),
            validator: (String val) {
              if (val.isEmpty) {
                return 'This field should not be empty';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            controller: widget.phoneController,
            textType: TextInputType.phone,
            label: 'Phone Number',
            prefixIcon: const Icon(Icons.phone_android),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            controller: widget.emailController,
            textType: TextInputType.emailAddress,
            label: 'Email Address',
            prefixIcon: const Icon(Icons.email),
            validator: (String val) {
              if (val.isEmpty) {
                return 'This field should not be empty';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            controller: widget.passwordController,
            textType: TextInputType.text,
            label: 'Password',
            visibility: _visibility,
            prefixIcon: const Icon(Icons.security),
            suffixIcon: IconButton(
              icon: Icon(
                _visibility ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _visibility = !_visibility;
                });
              },
            ),
            validator: (String val) {
              if (val.isEmpty) {
                return 'This field should not be empty';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
