import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meal_box/models/menu_model.dart';

import 'package:yaml/yaml.dart';
import 'dart:convert';
import "package:flutter/services.dart" as services;

class MenuProvider extends ChangeNotifier {
  bool loading = false;

  YamlMap mapData;

  String data;

  MenuModel menuList;

  Menu menu;

  List<Menu> subMenu = [];

  Future<void> getMenuData() async {
    // setLoading(true);

    loading = true;
    Timer(Duration(seconds: 1), () async {
      data = await services.rootBundle.loadString('assets/menu.yaml');
      mapData = loadYaml(data);
      var jsonData = json.encode(mapData);

      menuList = menuModelFromJson(jsonData);

      menu = menuList.menus[0];

      setLoading(false);
      notifyListeners();
    });
  }

  Future<void> getSubMenu(List<String> subMenus) async {
    subMenu = [];
    Timer(Duration(seconds: 1), () async {
      loading = true;
      for (int i = 0; i < menuList.menus.length; i++) {
        if (subMenus.contains(menuList.menus[i].key)) {
          subMenu.add(menuList.menus[i]);
        }
      }
      setLoading(false);
      notifyListeners();
    });
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }
}
