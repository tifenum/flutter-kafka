import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;

  User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }

  Future signOut() async {
    await auth.signOut();
    return;
  }

  Future<void> signIn(BuildContext context, String email, String password) async {

    final Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };

    final body = json.encode(data);

    try {
      final response = await http.post(
        Uri.http('192.168.1.41:3010', '/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        Navigator.pushNamed(context, "/nav");
      } else {
        final responseData = json.decode(response.body);
        String errorMessage = responseData['message'] ?? 'Authentication failed';
        showErrorSnackBar(context, errorMessage);
      }
    } catch (error) {
      showErrorSnackBar(context, 'An unexpected error occurred.');
    }
  }

  void showErrorSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
