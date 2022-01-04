import 'package:automated_payroll/Pages/splash_screen.dart';
import 'package:automated_payroll/Pages/user/user_dashboard.dart';
import 'package:automated_payroll/Pages/user/user_login.dart';
import 'package:automated_payroll/Pages/user/user_chat_view_message.dart';
import 'package:automated_payroll/Pages/hr/view_employee.dart';
import 'package:flutter/material.dart';

import 'hr/HR_view_chat_replay.dart';
import 'user/view_location.dart';
import 'hr/hr_dashboard.dart';

void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
       home:LoginScreen(),
        // LoginScreen(),
      routes:{
    'login  ':(context)=>LoginScreen(),
    'dashboard':(context)=>hr_dash(),
      'user_dash':(context)=>user_dash(),
        'hr_dash':(context)=>hr_dash(),
      }
    );
  }
}
