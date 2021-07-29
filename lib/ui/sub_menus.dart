import 'package:flutter/material.dart';
import 'package:meal_box/providers/menu_provider.dart';
import 'package:meal_box/widgets/grid_product.dart';
import 'package:provider/provider.dart';

import 'package:yaml/yaml.dart';

class SubMenus extends StatefulWidget {
  List<String> subMenusList;

  SubMenus({Key key, this.subMenusList}) : super(key: key);

  @override
  _SubMenusState createState() => _SubMenusState();
}

class _SubMenusState extends State<SubMenus> {
  Future getData() async {
    await Provider.of<MenuProvider>(context, listen: false)
        .getSubMenu(widget.subMenusList);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    var menuProvider = Provider.of<MenuProvider>(context);
    var subMenu = Provider.of<MenuProvider>(context).subMenu;

    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Padding(
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
                          "Sub Menus",
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // SizedBox(height: 10.0),

                ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: subMenu.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Column(
                        children: [
                          Text(
                            subMenu[i].key,
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            primary: false,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: MediaQuery.of(context)
                                      .size
                                      .width /
                                  (MediaQuery.of(context).size.height / 1.25),
                            ),
                            itemCount: subMenu[i].items.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GridProduct(
                                item: subMenu[i].items[index],
                                onItemTap: () {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Added To Order"),
                                  ));
                                },
                              );
                            },
                          ),
                        ],
                      );
                    }),

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
