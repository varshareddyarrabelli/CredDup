import 'dart:convert';
import 'package:credmint/Item.dart';
import 'package:flutter/material.dart';
import 'package:credmint/section.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<Section> categoryData = [];
  bool isGrid = false;

  @override
  void initState() {
    super.initState();
    loadCategoriesData();
  }

  Future<void> loadCategoriesData() async {
    try {
      final String categoriesData = await DefaultAssetBundle.of(context)
          .loadString(
              'assets/categories.json'); // Adjust the file path as needed

      final Map<String, dynamic> jsonData = json.decode(categoriesData);
      final List<dynamic> dataList = jsonData['data'];
      final List<Map<String, dynamic>> dataMaps =
          dataList.cast<Map<String, dynamic>>();

      final List<Section> sections =
          dataMaps.map((json) => Section.fromJson(json)).toList();

      setState(() {
        categoryData = sections;
      });
    } catch (error) {
      print("Error loading JSON data: $error");
    }
  }

  void _onCategorySelected(Item item) {
    // Pass the selected category back to the Home page
    Navigator.pop(context, item.displayData);
  }

  Widget buildSubheadingsGrid(List<Item> items) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () {
            _onCategorySelected(item);
          },
          child: Card(
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50, // Set the width as needed
                  height: 50, // Set the height as needed
                  child: Image.network(
                    item.displayData.iconUrl,
                    fit: BoxFit.cover, // You can adjust the fit as needed
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    item.displayData.name,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "explore",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 7,),
                      Text(
                        "CRED",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Switch.adaptive(
                        value: isGrid,
                        onChanged: (bool value) {
                          setState(() {
                            isGrid = value;
                          });
                        },
                        activeTrackColor: Colors.white,
                        activeColor: Colors.white,
                        inactiveTrackColor: Colors.white,
                        inactiveThumbColor: Colors.white,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_drop_down_circle_outlined),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            for (var section in categoryData)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(
                        section.sectionProperties.title,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  isGrid
                      ? buildSubheadingsGrid(section.sectionProperties.items)
                      : Column(
                          children: section.sectionProperties.items.map((item) {
                            return GestureDetector(
                              onTap: () {
                                _onCategorySelected(item);
                              },
                              child: ListTile(
                                title: Text(
                                  item.displayData.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  item.displayData.description,
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                  ),
                                ),
                                leading: Container(
                                  width: 70, // Set the width as needed
                                  height: 70,
                                  margin: EdgeInsets.fromLTRB(25, 0, 30, 0),
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  // padding: EdgeInsets.fromLTRB(0, 0, 20, 0),// Set the height as needed
                                  child: Image.network(
                                    item.displayData.iconUrl,
                                    fit: BoxFit
                                        .cover, // You can adjust the fit as needed
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                ],
              ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
