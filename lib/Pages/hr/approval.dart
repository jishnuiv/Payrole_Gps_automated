import 'package:automated_payroll/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart'as http;
import 'package:intl/intl.dart';
class ApprovalAttendance extends StatefulWidget {
  const ApprovalAttendance({Key key}) : super(key: key);

  @override
  _ApprovalAttendanceState createState() => _ApprovalAttendanceState();
}

class _ApprovalAttendanceState extends State<ApprovalAttendance> {

  approvalData({date}) async {

    var parameters = {
      "current_date": date,

    };
    http.Response result = await http
        .post(Uri.parse(baseurl+"Attendance_apprv.php"), body: parameters);
    print(parameters);}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(body:
    Center(
        child: SizedBox(
            height:80, //height of button
            width:300, //width of button
            child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue, //background color of button
                    side: BorderSide(width:3, color:Colors.brown), //border width and color
                    elevation: 3, //elevation of button
                    shape: RoundedRectangleBorder( //to set border radius to button
                        borderRadius: BorderRadius.circular(30)
                    ),
                    padding: EdgeInsets.all(20)
                ),
                onPressed: (){
                  setState(() {
                    approvalData(date: DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),);
                  });
                },
                child: Text("Approve")
            )
        )
    )




    );
  }
}
