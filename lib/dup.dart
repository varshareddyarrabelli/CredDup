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
          .loadString('assets/categories.json'); // Adjust the file path as needed

      final Map<String, dynamic> jsonData = json.decode(categoriesData);
      final List<dynamic> dataList = jsonData['data'];
      final List<Map<String, dynamic>> dataMaps = dataList.cast<Map<String, dynamic>>();

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
    Navigator.pop(context, item.displayData.name);
  }

  Widget buildSubheadingsGrid(List<Item> items) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // You can adjust the number of columns here
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
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
                Image.network(
                  item.displayData.iconUrl,
                  width: 48, // Set the width as needed
                  height: 48, // Set the height as needed
                ),
                Text(
                  item.displayData.name,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  item.displayData.description,
                  style: TextStyle(
                    color: Colors.white,
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
        title: Text("Categories Page"),
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
                  Text(
                    "CRED",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
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
                        materialTapTargetSize:
                        MaterialTapTargetSize.shrinkWrap,
                      ),
                      Icon(
                        Icons.arrow_drop_down_circle_outlined,
                        color: Colors.white,
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
                    child: Text(
                      section.sectionProperties.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
                              color: Colors.white,
                            ),
                          ),
                          leading: Container(
                            width: 48, // Set the width as needed
                            height: 48, // Set the height as needed
                            child: Image.network(
                              item.displayData.iconUrl,
                              fit: BoxFit.cover, // You can adjust the fit as needed
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
