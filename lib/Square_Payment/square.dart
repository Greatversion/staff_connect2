import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void createPaymentWithBankDetails() async {
  // Define the endpoint URL
  final url = Uri.parse('https://connect.squareup.com/v2/payments');

  // Create the request body
  final requestBody = jsonEncode({
    'source_id':
        'YOUR_BANK_ACCOUNT_ID', // Replace with the employee's bank account ID
    'amount_money': {
      'amount':
          1000, // Replace with the payment amount in the smallest currency unit (e.g., cents)
      'currency': 'USD', // Replace with the currency code
    },
    'autocomplete': true,
    'location_id': 'YOUR_LOCATION_ID', // Replace with the Square location ID
  });

  // Set the request headers
  final headers = <String, String>{
    'Authorization':
        'Bearer YOUR_ACCESS_TOKEN', // Replace with your Square Access Token
    'Content-Type': 'application/json',
  };

  // Send the POST request
  final response = await http.post(url, headers: headers, body: requestBody);

  // Handle the response
  if (response.statusCode == 200) {
    // Request successful
    print('Payment created successfully');
    print(response.body);
  } else {
    // Request failed
    print('Failed to create payment');
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: ElevatedButton(
                onPressed: () {
                  createPaymentWithBankDetails();
                },
                child: const Text("enter"))),
      ),
    );
  }
}
