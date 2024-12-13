import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormBoilerplate {
  static Widget buildTextField(
      String name,
      String labelText,
      String hintText,
      IconData icon,
      TextEditingController controller,
      TextInputType textType,
      BuildContext context,
      List<String? Function(String?)> validators) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: FormBuilderTextField(
        name: name,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: Icon(icon),
          fillColor: Theme.of(context).colorScheme.onPrimaryFixed,
        ),
        controller: controller,
        validator: FormBuilderValidators.compose(validators),
        keyboardType: textType,
        obscureText: name == 'password' || name == 'confPassword',
      ),
    );
  }
}
