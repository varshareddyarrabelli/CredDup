import 'package:credmint/DisplayData.dart';
import 'package:flutter/material.dart';
import 'package:credmint/CategoriesPage.dart';
import 'package:google_fonts/google_fonts.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DisplayData selectedCategory = DisplayData(name: '', description: 'Please Select a Category', iconUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrxBmi22imDsMuXvlGjdIXWDpG1PE-dIzNsWG_7omXzw&s');
  void navigateToCategoriesPage() async {
    final selected = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoriesPage()),
    );

    if (selected != null) {
      setState(() {
        selectedCategory = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black, // Set the background color to black
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 50),
              child: Image.network(
                selectedCategory.iconUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover, // You can adjust the fit as needed
              )
            ),
            Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,// Align content at the bottom
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: Row(
                      children: [
                        Text(
                        "CRED",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Set the text color to white
                        ),
                      ),
                        Text(" "),
                        Text(
                          selectedCategory.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Set the text color to white
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    selectedCategory.description,
                    style: GoogleFonts.mulish(
                      textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white, // Set the text color to white
                    ),),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: 370,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: navigateToCategoriesPage,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Go to Category",
                              style: GoogleFonts.acme(
                                textStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }
}
