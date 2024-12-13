import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lecognition/common/helper/message/display_message.dart';
import 'package:lecognition/widgets/appbar.dart';
import 'package:lecognition/widgets/form.dart';
import 'package:lecognition/data/user/models/update_user_profile_params.dart';
import 'package:lecognition/domain/user/entities/user.dart';
import 'package:lecognition/domain/user/usecases/update_user_profile.dart';
import 'package:lecognition/presentation/profile/pages/avatar.dart';
import 'package:lecognition/service_locator.dart';

class EditAccount extends StatefulWidget {
  EditAccount({required this.userData});
  final UserEntity userData;

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
  void initState() {
    super.initState();
    _emailController.text = widget.userData.email ?? '';
    _usernameController.text = widget.userData.username ?? '';
  }

  @override
  Widget build(BuildContext context) {
    print(widget.userData.avatar);
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
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 100,
                            backgroundImage: AssetImage('assets/avatars/Avatar_${widget.userData.avatar}.png'),
                            backgroundColor: Colors.transparent,
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: _editIconButton(context),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              _buildFormFields(context),
              const SizedBox(height: 20),
              Center(
                child: _isSubmitting ? CircularProgressIndicator() : _submitButton(context),
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
            MaterialPageRoute(
              builder: (context) => EditAvatar(userData: widget.userData,),
            ),
          );
        },
        icon: Icon(Icons.edit, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildFormFields(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          FormBoilerplate.buildTextField(
            'e-mail',
            'E-mail',
            widget.userData.email ?? 'Enter e-mail',
            Icons.email,
            _emailController,
            TextInputType.emailAddress,
            context,
            [
              FormBuilderValidators.required(errorText: "Email tidak boleh kosong"),
              FormBuilderValidators.email(errorText: "Email tidak valid"),
            ],
          ),
          const SizedBox(height: 20),
          FormBoilerplate.buildTextField(
            'username',
            'Username',
            widget.userData.username ?? 'Enter username',
            Icons.person,
            _usernameController,
            TextInputType.text,
            context,
            [
              FormBuilderValidators.required(errorText: "Username tidak boleh kosong"),
              FormBuilderValidators.minLength(6, errorText: "Username minimal 6 karakter"),
            ],
          ),
          const SizedBox(height: 20),
          FormBoilerplate.buildTextField(
            'password',
            'Password',
            'Enter new password',
            Icons.lock,
            _passwordController,
            TextInputType.text,
            context,
            [
              FormBuilderValidators.required(errorText: "Password tidak boleh kosong"),
              FormBuilderValidators.minLength(6, errorText: "Password minimal 6 karakter"),
            ],
          ),
          const SizedBox(height: 20),
          FormBoilerplate.buildTextField(
            'confPassword',
            'Confirm Password',
            'Re-enter new password',
            Icons.lock,
            _confirmPasswordController,
            TextInputType.text,
            context,
            [
              FormBuilderValidators.required(errorText: "Konfirmasi password tidak boleh kosong"),
              (val) {
                if (val != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ],
          ),
        ],
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
                Navigator.pop(context);
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
