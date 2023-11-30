import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDcvg47GO5V2mP_4pbNVk_FfqSqQEG-OBM",
      appId: "1:422055844203:android:aa5099991cdfd590ddd42e",
      messagingSenderId: "422055844203",
      projectId: "myfluttercollege-267f0",
    ),
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String studentName = "";
  String studentID = "";
  String studyProgramID = "";
  double studentGPA = 0.0;

  void getStudentName(name) {
    studentName = name;
  }

  void getStudentID(id) {
    studentID = id;
  }

  void getStudyProgramID(programID) {
    studyProgramID = programID;
  }

  void getStudentGPA(gpa) {
    studentGPA = double.tryParse(gpa) ?? 0.0;
  }

  createData() {
    print("created");
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyStudents").doc(studentName);

    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentID": studentID,
      "studyProgramID": studyProgramID,
      "studentGPA": studentGPA
    };
    documentReference.set(students).whenComplete(() {
      print("$studentName created");
    });
  }

  readData() {
    print("read");
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyStudents").doc(studentName);

    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        Map<String, dynamic>? data =
            datasnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          print(data["studentName"]);
          print(data["studentID"]);
          print(data["studyProgramID"]);
          print(data["studentGPA"]);
        } else {
          print("Data is null");
        }
      } else {
        print("Document does not exist");
      }
    });
  }

  updateData() {
    print("updated");
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyStudents").doc(studentName);

    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentID": studentID,
      "studyProgramID": studyProgramID,
      "studentGPA": studentGPA
    };
    documentReference.set(students).whenComplete(() {
      print("$studentName updated");
    });
  }

  deleteData() {
    print("deleted");
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyStudents").doc(studentName);

    documentReference.delete().whenComplete(() {
      print("$studentName deleted");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My students details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Name",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String name) {
                  getStudentName(name);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Student ID",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String id) {
                  getStudentID(id);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Study Program",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String programID) {
                  getStudyProgramID(programID);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "GPA",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String gpa) {
                  getStudentGPA(gpa);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text('Create'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    createData();
                  },
                ),
                ElevatedButton(
                  child: Text('Read'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    readData();
                  },
                ),
                ElevatedButton(
                  child: Text('Update'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    updateData();
                  },
                ),
                ElevatedButton(
                  child: Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    deleteData();
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                textDirection: TextDirection.ltr,
                children: [
                  Expanded(child: Text("Name")),
                  Expanded(child: Text("Student ID")),
                  Expanded(child: Text("Program ID")),
                  Expanded(
                    child: Text("GPA"),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Expanded(
                  child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("MyStudents")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          return Row(
                            children: [
                              Expanded(
                                  child: Text(documentSnapshot["studentName"])),
                              Expanded(
                                  child: Text(documentSnapshot["studentID"])),
                              Expanded(
                                  child:
                                      Text(documentSnapshot["studyProgramID"])),
                              Expanded(
                                  child: Text(documentSnapshot["studentGPA"]
                                      .toString())),
                            ],
                          );
                        });
                  } else {
                    return Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: CircularProgressIndicator());
                  }
                },
              )),
            )
          ],
        ),
      ),
    );
  }
}
