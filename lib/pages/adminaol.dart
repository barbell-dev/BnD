import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminAolPage extends StatefulWidget {
  @override
  _AdminAolState createState() => _AdminAolState();
}

class _AdminAolState extends State<AdminAolPage> {
  var courses = ['Happiness Program', 'AMP'];
  var modes = ['Online', 'Offline'];
  var months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  var selectedCourse = null;
  var selectedMode = null;
  DateTime? startDate;
  DateTime? endDate;

  void _selectStartDate() async {
    final DateTime? pickedStartDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (pickedStartDate != null && pickedStartDate != startDate) {
      setState(() {
        startDate = pickedStartDate;
      });
    }
  }

  void _selectEndDate() async {
    final DateTime? pickedEndDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (pickedEndDate != null && pickedEndDate != endDate) {
      setState(() {
        endDate = pickedEndDate;
      });
    }
  }

  Future<void> addCourse() async {
    if (selectedCourse == null ||
        selectedMode == null ||
        startDate == null ||
        endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("All options must be filled.")));
    } else if (startDate!.isAfter(endDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "Starting date of course cannot be after ending date of course.")));
    } else {
      try {
        final DatabaseReference aolCoursesRef =
            FirebaseDatabase.instance.ref().child('aolCourses');
        await aolCoursesRef.push().set({
          "Course name": selectedCourse,
          "Course mode": selectedMode,
          "Course starting date": startDate.toString(),
          "Course ending date": endDate.toString()
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "$selectedCourse  added in $selectedMode mode from $startDate to $endDate!")));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Error encountered while adding the course. $e. ")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Art Of Living Courses  Schedule',
          style: TextStyle(
            fontFamily: 'poppinssb',
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: 150,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color.fromARGB(200, 200, 200, 200),
              ),
              child: Center(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 30, 20),
                    child: Wrap(
                      runSpacing: 4.0,
                      children: [
                        DropdownButton(
                          isExpanded: true,
                          hint: Text(
                            'Select Course',
                            textAlign: TextAlign.center,
                          ),
                          value: selectedCourse,
                          items: courses.map((String course) {
                            return DropdownMenuItem(
                              value: course,
                              child: Text(course),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCourse = value!;
                            });
                          },
                        ),
                      ],
                    )),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: 150,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color.fromARGB(200, 200, 200, 200),
              ),
              child: Center(
                child: DropdownButton(
                  hint: Text('Select Mode'),
                  value: selectedMode,
                  items: modes.map((String mode) {
                    return DropdownMenuItem(
                      value: mode,
                      child: Text(mode),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMode = value!;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: 150,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color.fromARGB(200, 200, 200, 200),
              ),
              child: Center(
                child: ElevatedButton(
                  onPressed: _selectStartDate,
                  child: Text(
                    startDate == null
                        ? 'Select Start Date'
                        : 'Start Date: ${DateFormat('yyyy-MM-dd').format(startDate!)}',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: 150,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color.fromARGB(200, 200, 200, 200),
              ),
              child: Center(
                child: ElevatedButton(
                  onPressed: _selectEndDate,
                  child: Text(
                    endDate == null
                        ? 'Select End Date'
                        : 'End Date: ${DateFormat('yyyy-MM-dd').format(endDate!)}',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(top: 120),
              child: ElevatedButton(
                onPressed: addCourse,
                child: Text('Add course'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 226, 99, 14),
                    foregroundColor: Color.fromARGB(255, 80, 253, 0)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AdminAolPage(),
  ));
}
