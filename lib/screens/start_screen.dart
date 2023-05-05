import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readme_editor/provider/shield.dart';
import 'package:readme_editor/screens/single_readme.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _repo = '';
  bool _isLoading = false;

  Future<void> _submit(BuildContext ctx) async {
    FocusScope.of(ctx).unfocus();
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState.save();
      await Provider.of<Shields>(ctx, listen: false).setData();
      setState(() {
        _isLoading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SingleReadMe(
            repo: _repo,
            username: _username,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ReadMe Shield Editor'),
      ),
      body: Center(
        child: SizedBox(
          child: Card(
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      key: ValueKey('username'),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'GitHub Username',
                        icon: const Icon(Icons.account_circle_outlined),
                      ),
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'Username must be at least 4 char long';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _username = value;
                      },
                    ),
                    TextFormField(
                      key: ValueKey('repo'),
                      autocorrect: false,
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: 'GitHub project name',
                        icon: const Icon(Icons.title),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _repo = value;
                      },
                    ),
                    _isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              _submit(context);
                            },
                            child: Text('Submit'),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
