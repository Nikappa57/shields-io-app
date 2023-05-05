import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readme_editor/provider/shield.dart';
import 'package:readme_editor/screens/single_readme.dart';
import 'package:url_launcher/url_launcher.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _repo = '';
  bool _isLoading = true;

  void _getShields(BuildContext context) async {
    await Provider.of<Shields>(context, listen: false).setData();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _submit(BuildContext ctx) async {
    FocusScope.of(ctx).unfocus();
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();
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
    _getShields(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ReadMe Shield Editor'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Your static info",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 500,
                child: Card(
                  margin: const EdgeInsets.all(26),
                  elevation: 10.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
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
                            onSaved: (value) {
                              _repo = value;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: _isLoading
                                ? null
                                : () {
                                    _submit(context);
                                  },
                            child: const Text('Submit'),
                          ),
                          if (_isLoading)
                            Container(
                              child: Text("Loading shields..."),
                              margin: EdgeInsets.only(top: 20),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Card(
                child: Container(
                  width: 200,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Credits",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                          child: const Text('Shield.io'),
                          onTap: () => launch('https://shields.io/')),
                      InkWell(
                          child: const Text('ileriayo'),
                          onTap: () => launch(
                              'https://ileriayo.github.io/markdown-badges ')),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
