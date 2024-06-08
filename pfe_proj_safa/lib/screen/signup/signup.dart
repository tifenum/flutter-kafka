import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key});

  Future<void> _registerUser(BuildContext context, String username, String email, String password) async {
    try {
        
      
      final Map<String, dynamic> data = {
        'username': username,
        'email': email,
        'password': password,
      };    
      final body = json.encode(data);
      final response = await http.post(
        Uri.http('192.168.1.41:3010', '/api/register'),
        headers: {'Content-Type': 'application/json'},
        body: body
      );

      if (response.statusCode == 200) {

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Success'),
            content: const Text('User registered successfully.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to register user: ${response.body}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      print('Error registering user: $error');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('An unexpected error occurred.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String username = '';
    String email = '';
    String password = '';
    String confirmPassword = '';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                TextField(
                  onChanged: (value) => username = value,
                ),

                TextField(
                  onChanged: (value) => email = value,
                ),

                TextField(
                  onChanged: (value) => password = value,
                ),

                TextField(
                  onChanged: (value) => confirmPassword = value,
                ),

                ElevatedButton(
                  onPressed: () {
                    if (password == confirmPassword) {
                      _registerUser(context, username, email, password);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Passwords do not match.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
