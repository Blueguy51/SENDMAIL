import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sendmail/services/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trial',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Email Form Trial'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _loginkey = GlobalKey<FormState>();
  final ctrlEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Form(
          key: _loginkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: "Your Email Here",
                    prefixIcon: Icon(Icons.email_sharp)),
                controller: ctrlEmail,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return !EmailValidator.validate(value.toString())
                      ? 'Your email is incorrect'
                      : null;
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_loginkey.currentState!.validate()) {
            await SendMailServices.sendEmail(ctrlEmail.text).then((value) {
              var result = json.decode(value.body);
              Fluttertoast.showToast(
                  msg: result['message'].toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  fontSize: 14);
            });
          } else {
            Fluttertoast.showToast(
                msg: "Please fill the form correctly",
                toastLength: Toast.LENGTH_SHORT,
                fontSize: 14);
          }
        },
        tooltip: 'SendEmail',
        child: Icon(Icons.send),
      ),
    );
  }
}
