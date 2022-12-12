import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitForm,
    this.isLoading,
  );

  final bool isLoading;
  final void Function({
    @required String email,
    @required String password,
    @required String username,
    @required bool isLogin,
    @required BuildContext ctx,
    String token,
  }) submitForm;
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _email = '';
  String _username = '';
  String _password = '';
  String _token = '';

  void _submit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      widget.submitForm(
        email: _email.trim().toLowerCase(),
        password: _password.trim(),
        username: _username.trim(),
        token: _token.trim(),
        isLogin: _isLogin,
        ctx: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: ValueKey('email'),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value.isEmpty ||
                          !RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(value)) {
                        // TODO: Email Validator
                        return 'Email not valide';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: 'GitHub Username',
                      ),
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          // TODO: github username check
                          return 'Username must be at least 4 char long';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _username = value;
                      },
                    ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('token'),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: 'GitHub token (optional)',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.help_outline),
                          onPressed: () async {
                            const url =
                                "https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token";
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
                          },
                        ),
                      ),
                      onSaved: (value) {
                        _token = value;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 char long';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      onPressed: _submit,
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      child: Text(_isLogin ? 'Create new account' : 'Login'),
                      style: TextButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
