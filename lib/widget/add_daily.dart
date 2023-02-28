import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_planner/utils/theme.dart';

class AddDaily extends StatefulWidget {
  const AddDaily({super.key});

  @override
  State<AddDaily> createState() => _AddDailyState();
}

class _AddDailyState extends State<AddDaily> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueBackground,
        elevation: 0,
        leading: IconButton(
          padding: const EdgeInsets.only(top: 20, left: 20),
          icon: const Icon(Icons.arrow_back_rounded),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            'Add Daily Schedule',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: blueBackground,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Name',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                TextFormField(
                    decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Linear Algebra Class',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                )),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Category',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: button1,
                          ),
                          onPressed: () {},
                          child: Text(
                            'Study',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: blueBackground),
                          )),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      width: 100,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: button1,
                          ),
                          onPressed: () {},
                          child: Text(
                            'Work',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: blueBackground),
                          )),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      width: 100,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: button1,
                          ),
                          onPressed: () {},
                          child: Text(
                            'Others',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: blueBackground),
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
              ]),
        ),
      ),
    );
  }
}
