import 'package:flutter/material.dart';

class CommunityBloc extends ChangeNotifier {
  bool _hasCompletedCurtainAnimation = false;

  bool get hasCompletedCurtainAnimation => _hasCompletedCurtainAnimation;

  void setCurtainAnimationStatus() {
    _hasCompletedCurtainAnimation = true;
    notifyListeners();
  }

}
