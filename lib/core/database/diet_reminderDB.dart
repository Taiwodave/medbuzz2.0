import 'package:MedBuzz/core/models/diet_reminder/diet_reminder.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

//Crazelu renamed this as DietReminderDB for better disctinction
class DietReminderDB extends ChangeNotifier {
  // Hive box name

  static const String _boxname = "dietReminderBox";

  // Making an emptylist of diets

  List<DietModel> _diet = [];

  List<DietModel> get diets => _diet;

  // get all diets

  void getAlldiets() async {
    var box = await Hive.openBox(_boxname);
    _diet = box.values.toList();
    print(_diet.length);
    notifyListeners();
  }

  // get a specific diet by it's index

  DietModel getDiet(index) {
    return _diet[index];
  }

  // add a  diet

  void addDiet(DietModel diet) async {
    var box = await Hive.openBox<DietModel>(_boxname);

    await box.put(diet.id, diet);

    _diet = box.values.toList();
    box.close();
    getAlldiets();
    notifyListeners();
  }

  // delete a diet
  void deleteDiet(key) async {
    var box = await Hive.openBox<DietModel>(_boxname);

    _diet = box.values.toList();
    box.delete(key);
    box.close();
    getAlldiets();
    notifyListeners();
  }

  // edit DIet

  void editDiet({DietModel diet}) async {
    var box = await Hive.openBox<DietModel>(_boxname);

    box.put(diet.id, diet);

    _diet = box.values.toList();
    box.close();
    getAlldiets();
    notifyListeners();
  }

  int getdietcount() {
    return _diet.length;
  }
}
