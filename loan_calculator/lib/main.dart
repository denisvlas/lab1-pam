import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(LoanCalculatorApp());
}

class LoanCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loan Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoanCalculatorScreen(),
    );
  }
}

class LoanCalculatorScreen extends StatefulWidget {
  @override
  _LoanCalculatorScreenState createState() => _LoanCalculatorScreenState();
}

class _LoanCalculatorScreenState extends State<LoanCalculatorScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController percentController = TextEditingController();
  double numberOfMonths = 1;
  double monthlyPayment = 0;

  void calculateLoan() {
    double amount = double.tryParse(amountController.text) ?? 0;
    double percent = double.tryParse(percentController.text) ?? 0;

    if (amount > 0 && percent > 0 && numberOfMonths > 0) {
      double monthlyInterest = percent / 100;
      double payment = (amount * monthlyInterest) /
          (1 - pow(1 / (1 + monthlyInterest), numberOfMonths));
      setState(() {
        monthlyPayment = payment;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loan Calculator',style: TextStyle(fontSize: 30,),),
        centerTitle: true,


      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter amount',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // TextField(
            //   controller: amountController,
            //   keyboardType: TextInputType.number,
            //   decoration: InputDecoration(
            //   ),
            // ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,

              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Amount',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Enter number of months',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: numberOfMonths,
              min: 1,
              max: 60,
              divisions: 59,
              label: '${numberOfMonths.round()} luni',
              onChanged: (value) {
                setState(() {
                  numberOfMonths = value;

                });
              },
            ),
            SizedBox(height: 16),
            Text(
              'Enter % per month',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: percentController,
              keyboardType: TextInputType.number,

              decoration: InputDecoration(

                border: OutlineInputBorder(),
                hintText: 'Percent',
              ),
            ),
            SizedBox(height: 132),
            Center(
              child: Text(
                'You will pay the approximate amount monthly:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
              ),

            ),
            Center(
              child: Text(
                '${monthlyPayment.toStringAsFixed(2)}€',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 142),
            Center(
              child: ElevatedButton(
                onPressed: calculateLoan,
                child: Text('Calculate'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  textStyle: TextStyle(fontSize: 28,color: Colors.blue,
                  ),


                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
