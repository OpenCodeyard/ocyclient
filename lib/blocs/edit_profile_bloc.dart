import 'package:flutter/material.dart';

/// {@category Blocs}
class EditProfileBloc extends ChangeNotifier {
  int _currentSelectedMenuItem = 0;

  int get currentSelectedMenuItem => _currentSelectedMenuItem;

  void setCurrentSelectedItem(int index) {
    _currentSelectedMenuItem = index;
    notifyListeners();
  }

}
