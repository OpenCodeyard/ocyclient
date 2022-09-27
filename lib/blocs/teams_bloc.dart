import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:ocyclient/models/team/team_model.dart';

/// {@category Blocs}
class TeamsBloc extends ChangeNotifier {
  final Uri teamsUrl = Uri.parse(
    "https://raw.githubusercontent.com/OpenCodeyard/ocyclient/dev/data/teams.json?t=current%20timestamp",
  );

  List<Team> _teams = [];

  List<Team> get teams => _teams;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _hasError = false;

  bool get hasError => _hasError;

  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  TeamsBloc() {
    _fetchTeams();
  }

  Future _fetchTeams() async {
    _isLoading = true;
    notifyListeners();
    // try {
    final response = await get(teamsUrl);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      _teams = List<Team>.from(data.map((json) {
        print(json);
        return Team.fromJson(json);
      }).toList());
      _isLoading = false;
      notifyListeners();
    } else {
      _hasError = true;
      _errorMessage = "Something went wrong";
      notifyListeners();
    }
    // } catch (e) {
    //   _hasError = true;
    //   if (kDebugMode) {
    //     print(e.toString());
    //   }
    //   _errorMessage = "Something went wrong";
    //   notifyListeners();
    // }
  }

  Team? getTeam(String id) {
    for (Team tm in teams) {
      if (tm.id == id) {
        return tm;
      }
    }
    return null;
  }
}
