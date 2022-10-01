import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:ocyclient/models/team/team_model.dart';

/// {@category Blocs}
class TeamsBloc extends ChangeNotifier {

  ///API URL for teams
  final Uri teamsUrl = Uri.parse(
    "https://raw.githubusercontent.com/OpenCodeyard/ocyclient/dev/data/teams.json?t=current%20timestamp",
  );

  ///List of teams
  List<Team> _teams = [];

  List<Team> get teams => _teams;

  ///Handles team loading state
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ///Handles error state
  bool _hasError = false;

  bool get hasError => _hasError;

  ///Stores error message in case of an error
  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  ///Running fetch logic at app start from constructor
  TeamsBloc() {
    _fetchTeams();
  }

  ///Gets list of team for org from Github API
  Future _fetchTeams() async {
    _isLoading = true;
    notifyListeners();
    try {

      ///Gets list of teams from API
      final response = await get(teamsUrl);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        ///Converts json team data to list of dart objects
        _teams = List<Team>.from(data.map((json) {
          return Team.fromJson(json);
        }).toList());
        _isLoading = false;
        notifyListeners();
      } else {
        _hasError = true;
        _errorMessage = "Something went wrong";
        notifyListeners();
      }
    } catch (e) {

      ///Handle errors here

      _hasError = true;
      if (kDebugMode) {
        print(e.toString());
      }
      _errorMessage = "Something went wrong";
      notifyListeners();
    }
  }

  ///Gets single team object using ID
  ///Returns null if not found
  Team? getTeam(String id) {
    for (Team tm in teams) {
      if (tm.id == id) {
        return tm;
      }
    }
    return null;
  }
}
