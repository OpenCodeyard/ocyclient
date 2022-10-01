import 'package:flutter/material.dart';

/// {@category Blocs}
class CommunityBloc extends ChangeNotifier {
  bool _hasCompletedCurtainAnimation = false;

  bool get hasCompletedCurtainAnimation => _hasCompletedCurtainAnimation;

  void setCurtainAnimationStatus() {
    _hasCompletedCurtainAnimation = true;
    notifyListeners();
  }

}
