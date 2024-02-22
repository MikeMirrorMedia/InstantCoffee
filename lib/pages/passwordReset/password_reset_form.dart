import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:readr_app/blocs/passwordReset/bloc.dart';
import 'package:readr_app/blocs/passwordReset/events.dart';
import 'package:readr_app/blocs/passwordReset/states.dart';
import 'package:readr_app/core/values/colors.dart';
import 'package:readr_app/pages/shared/password_form_field.dart';
import 'package:readr_app/pages/shared/password_validator_widget.dart';

class PasswordResetForm extends StatefulWidget {
  final String code;
  final PasswordResetState state;
  const PasswordResetForm({
    required this.code,
    required this.state,
  });

  @override
  _PasswordResetFormState createState() => _PasswordResetFormState();
}

class _PasswordResetFormState extends State<PasswordResetForm> {
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

  _confirmPasswordReset(String code, String newPassword) async {
    context
        .read<PasswordResetBloc>()
        .add(ConfirmPasswordReset(code: code, newPassword: newPassword));
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
        if (widget.state is PasswordResetFail) ...[
          const Center(
            child: Text(
              '密碼錯誤，請重新再試',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          ),
          const SizedBox(height: 12),
        ],
        Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: widget.state is PasswordResetLoading
              ? _confirmPasswordLoadingButton()
              : _confirmPasswordButton(_passwordIsValid),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _confirmPasswordLoadingButton() {
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

  Widget _confirmPasswordButton(bool emailAndPasswordIsValid) {
    return InkWell(
        borderRadius: BorderRadius.circular(5.0),
        onTap: emailAndPasswordIsValid
            ? () async {
                _confirmPasswordReset(
                    widget.code, _passwordEditingController.text);
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
              '登入會員',
              style: TextStyle(
                  fontSize: 17,
                  color: emailAndPasswordIsValid ? Colors.white : Colors.grey),
            ),
          ),
        ));
  }
}
