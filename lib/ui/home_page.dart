import 'package:flutter/material.dart';
import 'package:meal_box/providers/menu_provider.dart';
import 'package:meal_box/widgets/grid_product.dart';
import 'package:provider/provider.dart';

import 'package:yaml/yaml.dart';
import "package:flutter/services.dart" as services;

import 'dart:convert';

import 'menu_items.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void getMenuData() async {
    final data = await services.rootBundle.loadString('assets/menu.yaml');
// final json1 = json.encode(data);
//
// print("json con ${json1}");
// print("json con2 ${json1.length}");
    final mapData = loadYaml(data);
// MenuModel menu = menuModelFromJson(mapData['menus'].toString());
    debugPrint('data: ${mapData['menus']}');
  }

  Future getData() async {
    await Provider.of<MenuProvider>(context, listen: false).getMenuData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var menuProvider = Provider.of<MenuProvider>(context);
    var menu = Provider.of<MenuProvider>(context).menuList;
    var mainMenu = Provider.of<MenuProvider>(context).menu;
    return Scaffold(
        body: Stack(
      children: [
        menu == null
            ? Container()
            : Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.02, right: size.width * 0.02),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 40.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mainMenu.key,
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                mainMenu.description,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // SizedBox(height: 10.0),

                      GridView.builder(
                        shrinkWrap: true,
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.25),
                        ),
                        itemCount: mainMenu.items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GridProduct(
                            item: mainMenu.items[index],
                            onItemTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return MenuItems(
                                      items: mainMenu.items[index].items,
                                      title: mainMenu.items[index].name,
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),

                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
        menuProvider.isLoading()
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ))
            : Container()
      ],
    ));
  }
}
