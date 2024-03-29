import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ocyclient/blocs/auth_bloc.dart';
import 'package:ocyclient/blocs/navigation_bloc.dart';
import 'package:ocyclient/widgets/Utils/custom_inputfields.dart';
import 'package:provider/provider.dart';

import '../../../configs/config.dart';

class PersonalTab extends StatefulWidget {
  const PersonalTab({Key? key}) : super(key: key);

  @override
  PersonalTabState createState() => PersonalTabState();
}

class PersonalTabState extends State<PersonalTab> {
  DateTime? dob;

  DateFormat formatter = DateFormat("dd/MM/yyyy");

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneCtrl = TextEditingController();
  final FocusNode _phoneNode = FocusNode();

  final TextEditingController _localityCtrl = TextEditingController();
  final FocusNode _localityNode = FocusNode();

  final TextEditingController _bioCtrl = TextEditingController();
  final FocusNode _bioNode = FocusNode();

  List<String> employmentStatus = [
    "Student",
    "Professor",
    "Government Service",
    "Corporate",
    "Other",
  ];

  String? currentEmploymentStatus;

  int? gender;

  bool dataInitialised = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AuthenticationBloc ab =
          Provider.of<AuthenticationBloc>(context, listen: false);

      _phoneCtrl.text = ab.userModel.phoneNumber ?? "";
      _bioCtrl.text = ab.userModel.bio ?? "";
      _localityCtrl.text = ab.userModel.locality ?? "";
      if (ab.userModel.dob != null && ab.userModel.dob != "") {
        dob = formatter.parse(ab.userModel.dob ?? "");
      }
      gender = getGenderFromString(ab.userModel.gender);
      currentEmploymentStatus = ab.userModel.employmentStatus;
      dataInitialised = true;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    AuthenticationBloc ab = Provider.of<AuthenticationBloc>(context);
    NavigationBloc nb = Provider.of<NavigationBloc>(context);

    return size.width < 1000
        ? Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: size.height / 3 + 100,
                    width: size.width,
                  ),
                  Positioned(
                    top: 0,
                    left: 5,
                    right: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: getCoverPhoto(size),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: getUserCircleAvatar(
                      ab,
                    ),
                  ),
                ],
              ),
              ...getPrimaryDetails(ab, size),
              Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.all(23),
                    child: Text(
                      "Edit Personal Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width < 700 ? 25 : 40,
                        fontFamily: "PublicSans",
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: hasChanges(ab)
                        ? () async {
                            await saveData(ab);
                            nb.toRoute(
                              "/profile",
                              shouldPopCurrent: true,
                            );
                          }
                        : null,
                    icon: const Icon(
                      FontAwesomeIcons.floppyDisk,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
              getPersonalDataForm(size),
              const SizedBox(
                height: 20,
              ),
            ],
          )
        : Card(
            margin: EdgeInsets.zero,
            child: SizedBox(
              height: size.height,
              width: size.width < 1500
                  ? size.width - 232
                  : (size.width - 231) * 0.8,
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getCoverPhoto(size),
                            Container(
                              height: 100,
                              margin: const EdgeInsets.fromLTRB(210, 10, 0, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: getPrimaryDetails(
                                      ab,
                                      size,
                                    ),
                                  ),
                                  const Spacer(),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 15,
                                      padding: const EdgeInsets.all(16),
                                    ),
                                    onPressed: hasChanges(ab)
                                        ? () async {
                                            await saveData(ab);
                                            nb.toRoute(
                                              "/profile",
                                              shouldPopCurrent: true,
                                            );
                                          }
                                        : null,
                                    icon: const Icon(
                                      FontAwesomeIcons.floppyDisk,
                                      size: 15,
                                    ),
                                    label: const Text("Save Personal"),
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Positioned(
                          bottom: 30,
                          left: 30,
                          child: getUserCircleAvatar(ab),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: const Text(
                        "Edit Personal Details",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          fontFamily: "PublicSans",
                        ),
                      ),
                    ),
                    getPersonalDataForm(size),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  bool hasChanges(AuthenticationBloc ab) {
    if (!dataInitialised) {
      return false;
    }

    DateTime? databaseDob;
    if (ab.userModel.dob != null && ab.userModel.dob != "") {
      databaseDob = formatter.parse(ab.userModel.dob ?? "");
    }

    if (_phoneCtrl.text != (ab.userModel.phoneNumber ?? "")) {
      return true;
    } else if (_bioCtrl.text != (ab.userModel.bio ?? "")) {
      return true;
    } else if (_localityCtrl.text != (ab.userModel.locality ?? "")) {
      return true;
    } else if (gender != getGenderFromString(ab.userModel.gender)) {
      return true;
    } else if (currentEmploymentStatus != ab.userModel.employmentStatus) {
      return true;
    } else {
      if (databaseDob == null) {
        if (dob != null) {
          return true;
        }
      } else if (!databaseDob.isAtSameMomentAs(dob!)) {
        return true;
      }
    }
    return false;
  }

  Form getPersonalDataForm(Size size) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Container(
        margin: const EdgeInsets.all(10),
        width: size.width < 1500 ? size.width * 0.95 : (size.width - 231) * 0.7,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            buildDescInputFieldThemColor(
              "Short Bio",
              FontAwesomeIcons.addressCard,
              TextInputType.multiline,
              _bioCtrl,
              context,
              _bioNode,
              _phoneNode,
              true,
              false,
              onChanged: (s) {
                setState(() {});
              },
              maxLength: 500,
            ),
            buildInputFieldThemColor(
              "Phone Number with country code",
              FontAwesomeIcons.phoneFlip,
              TextInputType.phone,
              _phoneCtrl,
              context,
              false,
              _phoneNode,
              _localityNode,
              true,
              (String? value) {
                String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                RegExp regExp = RegExp(pattern);

                if (value == null || value.isEmpty) {
                  return null;
                } else if (!regExp.hasMatch(value)) {
                  return 'Please enter valid mobile number';
                }

                return null;
              },
              onChanged: (s) {
                setState(() {});
              },
            ),
            buildInputFieldThemColor(
              "City/Town/Village",
              FontAwesomeIcons.mapLocationDot,
              TextInputType.streetAddress,
              _localityCtrl,
              context,
              false,
              _localityNode,
              null,
              true,
              (String? value) {
                return null;
              },
              onChanged: (s) {
                setState(() {});
              },
            ),
            if (size.width < 550)
              const SizedBox(
                height: 20,
              ),
            if (size.width < 550)
              Row(
                children: getEmploymentStatus(),
              ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  if (dob != null)
                    const Text(
                      "DOB : ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: "PublicSans",
                      ),
                    ),
                  TextButton.icon(
                    onPressed: () {
                      _selectDOB(context);
                    },
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                      dob == null ? "Select DOB" : formatter.format(dob!),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  if (size.width >= 550) ...getEmploymentStatus(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCoverPhoto(Size size) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      // color: const Color(0xffe9f3fd),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xffe6f6f4),
            image: DecorationImage(
              image: NetworkImage(
                "https://i.imgur.com/9NDKz2U.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(10),
          width: size.width < 1000 ? size.width : size.width - 231,
          height: size.height / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [],
          ),
        ),
      ),
    );
  }

  Widget getUserCircleAvatar(AuthenticationBloc ab) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 85.0,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 80,
        backgroundImage: ab.userModel.profilePicUrl.isEmpty
            ? null
            : NetworkImage(
                ab.userModel.profilePicUrl,
              ),
      ),
    );
  }

  List<Widget> getPrimaryDetails(AuthenticationBloc ab, Size size) {
    return [
      Text(
        ab.userModel.name,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: "PublicSans",
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Gender : ",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "PublicSans",
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          ...getGenderRadio(0, FontAwesomeIcons.person),
          ...getGenderRadio(1, FontAwesomeIcons.personDress),
          ...getGenderRadio(2, Icons.transgender),
        ],
      ),
    ];
  }

  Row getIconifiedDetail(
      String detail, IconData icon, Color iconColor, double width) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 18,
        ),
        const SizedBox(
          width: 15,
        ),
        SizedBox(
          width: width,
          child: Text(
            detail,
            style: const TextStyle(
              fontFamily: "PublicSans",
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }

  Future _selectDOB(BuildContext context) async {
    var newPicked = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
      currentDate: dob,
      helpText: "Select DOB",
      builder: (context, child) => Theme(
        data: ThemeData.light().copyWith(
          secondaryHeaderColor: Colors.white,
          colorScheme: const ColorScheme.light(primary: Colors.black),
          buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        child: child ?? const SizedBox(),
      ),
      firstDate: DateTime(1970),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (newPicked != null) {
      setState(() {
        dob = newPicked;
      });
    }
  }

  List<Widget> getEmploymentStatus() {
    return [
      const Text(
        "Profession :",
        style: TextStyle(fontFamily: "PublicSans", fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        width: 10,
      ),
      DecoratedBox(
        decoration: const ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 2.0, style: BorderStyle.solid, color: Colors.deepPurple),
            borderRadius: BorderRadius.all(
              Radius.circular(
                25.0,
              ),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
                dropdownColor: Colors.white,
                items: employmentStatus.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                focusNode: FocusNode(),
                value: currentEmploymentStatus,
                hint: const Text(
                  'Select',
                  style: TextStyle(color: Colors.black),
                ),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      currentEmploymentStatus = value;
                    });
                  }
                }),
          ),
        ),
      )
    ];
  }

  Future saveData(AuthenticationBloc ab) async {
    if (!ab.isLoggedIn) {
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      Map<String, dynamic> personalData = {
        Config.userBio: _bioCtrl.text,
        Config.userPhone: _phoneCtrl.text,
        Config.userDob: dob == null ? "" : formatter.format(dob!),
        Config.userEmploymentStatus: currentEmploymentStatus,
        Config.userLocality: _localityCtrl.text,
      };

      if (gender != null) {
        personalData[Config.userGender] = getGenderFromInt(gender!);
      }
      ab.updatePersonal(personalData);
    }
  }

  List<Widget> getGenderRadio(int val, IconData icon) {
    return [
      Radio(
        value: val,
        groupValue: gender,
        onChanged: (int? value) {
          setState(() {
            gender = value;
          });
        },
        activeColor: Colors.deepPurpleAccent,
      ),
      Icon(
        icon,
        color: Theme.of(context).primaryColor,
      ),
    ];
  }

  String getGenderFromInt(int index) {
    if (index == 0) {
      return "Male";
    } else if (index == 1) {
      return "Female";
    } else {
      return "Transgender";
    }
  }

  int? getGenderFromString(String? gender) {
    if (gender == null) {
      return null;
    } else if (gender == "Male") {
      return 0;
    } else if (gender == "Female") {
      return 1;
    } else {
      return 2;
    }
  }
}
