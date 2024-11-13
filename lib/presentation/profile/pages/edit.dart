import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lecognition/common/helper/message/display_message.dart';
import 'package:lecognition/common/helper/navigation/app_navigator.dart';
import 'package:lecognition/common/widgets/appbar.dart';
import 'package:lecognition/data/user/models/update_user_profile_params.dart';
import 'package:lecognition/domain/user/usecases/update_user_profile.dart';
import 'package:lecognition/presentation/profile/pages/account.dart';
import 'package:lecognition/presentation/profile/pages/avatar.dart';
import 'package:lecognition/presentation/profile/pages/profile.dart';
import 'package:lecognition/service_locator.dart';

class EditAccount extends StatefulWidget {
  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Edit Account'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Hero(
                      tag: 'profile_image',
                      child: Stack(children: [
                        CircleAvatar(
                          radius: 100,
                          backgroundImage:
                              AssetImage('assets/avatars/Avatar_3.png'),
                          backgroundColor: Colors.transparent,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: _editIconButton(context),
                        ),
                      ]),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              _buildFormFields(),
              const SizedBox(height: 20),
              Center(
                child: _isSubmitting
                    ? CircularProgressIndicator()
                    : _submitButton(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _editIconButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
      ),
      width: 35,
      height: 35,
      alignment: Alignment.center,
      child: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditAvatar()),
          );
        },
        icon: Icon(Icons.edit, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildFormFields() {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField(
              'e-mail', 'E-mail', 'old e-mail', Icons.email, _emailController, [
            FormBuilderValidators.required(),
            FormBuilderValidators.email()
          ]),
          const SizedBox(height: 20),
          _buildTextField('username', 'Username', 'old username', Icons.person,
              _usernameController, [FormBuilderValidators.required()]),
          const SizedBox(height: 20),
          _buildTextField(
              'password', 'Password', '', Icons.lock, _passwordController, [
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(6)
          ]),
          const SizedBox(height: 20),
          _buildTextField('confPassword', 'Confirm Password', '', Icons.lock,
              _confirmPasswordController, [
            FormBuilderValidators.required(),
            (val) {
              if (val != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            }
          ]),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String name,
      String labelText,
      String hintText,
      IconData icon,
      TextEditingController controller,
      List<String? Function(String?)> validators) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
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
          fillColor: Colors.white,
        ),
        controller: controller,
        validator: FormBuilderValidators.compose(validators),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState?.saveAndValidate() ?? false) {
          setState(() => _isSubmitting = true);

          try {
            final result = await sl<UpdateUserProfileUseCase>().call(
              params: UpdateUserProfileParams(
                email: _emailController.text,
                username: _usernameController.text,
                password: _passwordController.text,
              ),
            );
            result.fold(
              (failure) {
                DisplayMessage.errorMessage(context, failure.toString());
              },
              (success) {
                AppNavigator.pushAndRemove(context, const AkunScreen());
                DisplayMessage.errorMessage(context, success.toString());
              },
            );
          } catch (error) {
            DisplayMessage.errorMessage(context, error.toString());
          } finally {
            setState(() => _isSubmitting = false);
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: const Text(
        'Simpan',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
