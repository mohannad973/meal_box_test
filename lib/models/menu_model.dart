// To parse this JSON data, do
//
//     final menuModel = menuModelFromJson(jsonString);

import 'dart:convert';

MenuModel menuModelFromJson(String str) => MenuModel.fromJson(json.decode(str));

String menuModelToJson(MenuModel data) => json.encode(data.toJson());

class MenuModel {
  MenuModel({
    this.menus,
  });

  List<Menu> menus;

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        menus: List<Menu>.from(json["menus"].map((x) => Menu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "menus": List<dynamic>.from(menus.map((x) => x.toJson())),
      };
}

class Menu {
  Menu({
    this.key,
    this.description,
    this.items,
    this.orderTag,
  });

  String key;
  String description;
  List<Item> items;
  String orderTag;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        key: json["key"],
        description: json["description"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        orderTag: json["orderTag"] == null ? null : json["orderTag"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "description": description,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "orderTag": orderTag == null ? null : orderTag,
      };
}

class Item {
  Item({
    this.name,
    this.caption,
    this.image,
    this.items,
    this.price,
    this.subMenus,
  });

  String name;
  String caption;
  String image;
  List<Item> items;
  dynamic price;
  List<String> subMenus;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        caption: json["caption"] == null ? null : json["caption"],
        image: json["image"],
        items: json["items"] == null
            ? null
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        price: json["price"] == "null" ? null : json["price"],
        subMenus: json["subMenus"] == null
            ? null
            : List<String>.from(json["subMenus"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "caption": caption == null ? null : caption,
        "image": image,
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toJson())),
        "price": price == null ? null : price,
        "subMenus": subMenus == null
            ? null
            : List<dynamic>.from(subMenus.map((x) => x)),
      };
}
