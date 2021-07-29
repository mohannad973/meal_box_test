import 'package:flutter/material.dart';
import 'package:meal_box/models/menu_model.dart';
import 'package:meal_box/ui/sub_menus.dart';
import 'package:meal_box/widgets/grid_product.dart';

import 'package:yaml/yaml.dart';

class MenuItems extends StatefulWidget {
  List<Item> items;
  String title;

  MenuItems({Key key, this.items, this.title}) : super(key: key);

  @override
  _MenuItemsState createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  int selectedItem = -1;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
      padding:
          EdgeInsets.only(left: size.width * 0.02, right: size.width * 0.02),
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
                      widget.title,
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

            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.25),
              ),
              itemCount: widget.items.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: MediaQuery.of(context).size.height / 3.6,
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: GridProduct(
                    item: widget.items[index],
                    onItemTap: () {
                      if (widget.items[index].subMenus != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return SubMenus(
                                subMenusList: widget.items[index].subMenus,
                              );
                            },
                          ),
                        );
                      } else {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Added To Order"),
                        ));
                      }
                    },
                  ),
                );
              },
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    ));
  }
}
