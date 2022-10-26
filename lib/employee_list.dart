import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:office/employee_model.dart';

import 'restapi.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({Key? key}) : super(key: key);

  @override
  EmployeeListState createState() => EmployeeListState();
}

class EmployeeListState extends State<EmployeeList> {
  DataService ds = DataService();

  List data = [];
  List<EmployeeModel> employee = [];

  selectAllEmployee() async {
    data = jsonDecode(await ds.selectAll('63476bd999b6c11c094bd531', 'office',
        'employee', '63476e1599b6c11c094bd6e6'));
    employee = data.map((e) => EmployeeModel.fromJson(e)).toList();

    setState(() {
      employee = employee;
    });
  }

  // Reload depend on navigator
  FutureOr reloadDataEmployee(dynamic value) {
    setState(() {
      selectAllEmployee();
    });
  }

  @override
  void initState() {
    selectAllEmployee();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: const Text("Employee List"),
          backgroundColor: Colors.indigo,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, 'employee_form_add');
                    Navigator.pushNamed(context, 'employee_form_add')
                        .then(reloadDataEmployee);
                  },
                  child: const Icon(
                    Icons.add,
                    size: 26.0,
                  ),
                )),
          ],
        ),
        body: ListView.builder(
          // Let the ListView know how many items it needs to build
          itemCount: employee.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final item = employee[index];

            return ListTile(
              title: Text(item.name),
              subtitle: Text(item.birthday),
              onTap: () {
                // Navigator.pushNamed(context, 'employee_detail',
                //    arguments: [item.id]);
                Navigator.pushNamed(context, 'employee_detail',
                    arguments: [item.id]).then(reloadDataEmployee);
              },
            );
          },
        ));
  }
}
