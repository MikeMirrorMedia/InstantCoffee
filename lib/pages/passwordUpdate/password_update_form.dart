import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:readr_app/blocs/passwordUpdate/bloc.dart';
import 'package:readr_app/blocs/passwordUpdate/events.dart';
import 'package:readr_app/blocs/passwordUpdate/states.dart';
import 'package:readr_app/core/values/colors.dart';
import 'package:readr_app/pages/shared/password_form_field.dart';
import 'package:readr_app/pages/shared/password_validator_widget.dart';

class PasswordUpdateForm extends StatefulWidget {
  final PasswordUpdateState passwordUpdateState;
  const PasswordUpdateForm({
    required this.passwordUpdateState,
  });

  @override
  _PasswordUpdateFormState createState() => _PasswordUpdateFormState();
}

class _PasswordUpdateFormState extends State<PasswordUpdateForm> {
  final _passwordEditingController = TextEditingController();
  bool _passwordIsValid = false;

  @override
  void initState() {
    _passwordEditingController.addListener(() {
      setState(() {
        _passwordIsValid = _isPasswordValid();
      });
    });
    super.initState();
  }

  _updatePassword(String newPassword) async {
    context
        .read<PasswordUpdateBloc>()
        .add(UpdatePassword(newPassword: newPassword));
  }

  bool _isPasswordValid() {
    return _passwordEditingController.text.length >= 6;
  }

  @override
  void dispose() {
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          child: Text(
            '請設定新密碼。',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 17,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: PasswordFormField(
            title: '設定新密碼',
            passwordEditingController: _passwordEditingController,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: PasswordValidatorWidget(
            editingController: _passwordEditingController,
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: widget.passwordUpdateState is PasswordUpdateLoading
              ? _updatePasswordLoadingButton()
              : _updatePasswordButton(_passwordIsValid),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _updatePasswordLoadingButton() {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        color: appColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: const SpinKitThreeBounce(
        color: Colors.white,
        size: 35,
      ),
    );
  }

  Widget _updatePasswordButton(bool emailAndPasswordIsValid) {
    return InkWell(
        borderRadius: BorderRadius.circular(5.0),
        onTap: emailAndPasswordIsValid
            ? () {
                _updatePassword(_passwordEditingController.text);
              }
            : null,
        child: Container(
          height: 50.0,
          decoration: BoxDecoration(
            color: emailAndPasswordIsValid ? appColor : const Color(0xffE3E3E3),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Center(
            child: Text(
              '儲存新密碼',
              style: TextStyle(
                  fontSize: 17,
                  color: emailAndPasswordIsValid ? Colors.white : Colors.grey),
            ),
          ),
        ));
  }
}
