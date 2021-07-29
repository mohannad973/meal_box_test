import 'package:flutter/material.dart';
import 'package:meal_box/models/menu_model.dart';
import 'package:meal_box/util/const.dart';

import 'package:yaml/yaml.dart';

class GridProduct extends StatelessWidget {
  final Item item;
  Function onItemTap;

  GridProduct({Key key, @required this.item, @required this.onItemTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3.6,
            width: MediaQuery.of(context).size.width / 2.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                "${BaseImgPath + item.image.substring(1)}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
            child: Text(
              "${item.name}",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w900,
              ),
              maxLines: 2,
            ),
          ),
          item.price == null
              ? Container()
              : Text(
                  "${item.price} TRY",
                  style: TextStyle(
                    fontSize: 11.0,
                  ),
                ),
        ],
      ),
      onTap: () {
        onItemTap();
      },
    );
  }
}
