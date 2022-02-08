import 'package:dev_icons/dev_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gosclient/blocs/auth_bloc.dart';
import 'package:gosclient/blocs/edit_profile_bloc.dart';
import 'package:gosclient/blocs/navigation_bloc.dart';
import 'package:gosclient/configs/config.dart';
import 'package:gosclient/widgets/Profile/widgets/accounts.dart';
import 'package:gosclient/widgets/Profile/widgets/skill_card.dart';
import 'package:gosclient/widgets/Utils/common_widgets.dart';
import 'package:gosclient/widgets/Utils/custom_inputfields.dart';
import 'package:gosclient/widgets/Utils/gos_scaffold.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  ///TODO cover attribution <a href="https://www.freepik.com/vectors/background">Background vector created by freepik - www.freepik.com</a>

  DateFormat formatter = DateFormat("dd/MM/yyyy");

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneCtrl = TextEditingController();
  final FocusNode _phoneNode = FocusNode();

  final TextEditingController _localityCtrl = TextEditingController();
  final FocusNode _localityNode = FocusNode();

  final TextEditingController _bioCtrl = TextEditingController();
  final FocusNode _bioNode = FocusNode();

  DateTime? dob;

  List<String> employmentStatus = [
    "Student",
    "Professor",
    "Government Service",
    "Corporate",
    "Other",
  ];

  String? currentEmploymentStatus;

  int? gender;

  bool wasPersonalDataUpdated = false;

  ///TODO fix this  to change on user interaction of fields instead of form On change

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      AuthenticationBloc ab =
          Provider.of<AuthenticationBloc>(context, listen: false);

      _phoneCtrl.text = ab.userModel.phoneNumber ?? "";
      _bioCtrl.text = ab.userModel.bio ?? "";
      _localityCtrl.text = ab.userModel.locality ?? "";
      if (ab.userModel.dob != null) {
        dob = formatter.parse(ab.userModel.dob ?? "");
      }
      gender = getGenderFromString(ab.userModel.gender);
      currentEmploymentStatus = ab.userModel.employmentStatus;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    EditProfileBloc epb = Provider.of<EditProfileBloc>(context);
    AuthenticationBloc ab = Provider.of<AuthenticationBloc>(context);
    NavigationBloc nb = Provider.of<NavigationBloc>(context);

    return GosScaffold(
      body: SizedBox(
        height: size.height - 70,
        child: size.width < 1000
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: getEditProfileMenu(size, epb, ab, nb),
                          ),
                        ),
                      ),
                    ),
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
                          child: getUserCircleAvatar(
                            ab,
                          ),
                          bottom: 10,
                        ),
                      ],
                    ),
                    ...getPrimaryDetails(ab, size),
                    const Padding(
                      padding: EdgeInsets.all(
                        13.0,
                      ),
                      child: AccountWidget(),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.all(23),
                      child: Text(
                        "Edit Personal Details",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width < 700 ? 25 : 40,
                          fontFamily: "ProximaNova",
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Row(
                children: [
                  Card(
                    elevation: 10,
                    margin: EdgeInsets.zero,
                    child: SizedBox(
                      height: size.height,
                      width: 230,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 10,
                        ),
                        child: Column(
                          children: getEditProfileMenu(size, epb, ab, nb),
                        ),
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    width: 1,
                    color: Colors.black12,
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    child: SizedBox(
                      height: size.height,
                      width: (size.width - 231) * 0.8,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
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
                                      margin: const EdgeInsets.fromLTRB(
                                          210, 10, 0, 0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children:
                                                getPrimaryDetails(ab, size),
                                          ),
                                          const Spacer(),
                                          if (wasPersonalDataUpdated)
                                            ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 15,
                                                padding:
                                                    const EdgeInsets.all(16),
                                              ),
                                              onPressed: () {
                                                if (_formKey.currentState
                                                        ?.validate() ??
                                                    false) {
                                                  Map<String, dynamic>
                                                      personalData = {
                                                    Config.userBio:
                                                        _bioCtrl.text,
                                                    Config.userPhone:
                                                        _phoneCtrl.text,
                                                    Config.userDob: dob == null
                                                        ? ""
                                                        : formatter
                                                            .format(dob!),
                                                    Config.userEmploymentStatus:
                                                        currentEmploymentStatus,
                                                    Config.userLocality:
                                                        _localityCtrl.text,
                                                  };

                                                  if (gender != null) {
                                                    personalData[
                                                            Config.userGender] =
                                                        getGenderFromInt(
                                                            gender!);
                                                  }
                                                  ab.updatePersonal(
                                                      personalData);
                                                }
                                              },
                                              icon: const Icon(
                                                FontAwesomeIcons.solidSave,
                                                size: 15,
                                              ),
                                              label:
                                                  const Text("Save Personal"),
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
                                  child: getUserCircleAvatar(ab),
                                  bottom: 30,
                                  left: 30,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: const Text(
                                    "Edit Personal Details",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40,
                                      fontFamily: "ProximaNova",
                                    ),
                                  ),
                                ),
                                Form(
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    width: (size.width - 231) * 0.7,
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
                                        ),
                                        buildInputFieldThemColor(
                                          "Phone Number with country code",
                                          FontAwesomeIcons.phoneAlt,
                                          TextInputType.phone,
                                          _phoneCtrl,
                                          context,
                                          false,
                                          _phoneNode,
                                          _localityNode,
                                          true,
                                          (String? value) {
                                            String pattern =
                                                r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                            RegExp regExp = RegExp(pattern);

                                            if (value == null ||
                                                value.isEmpty) {
                                              return null;
                                            } else if (!regExp
                                                .hasMatch(value)) {
                                              return 'Please enter valid mobile number';
                                            }
                                            return null;
                                          },
                                        ),
                                        buildInputFieldThemColor(
                                          "City/Town/Village",
                                          FontAwesomeIcons.mapMarkedAlt,
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
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Row(
                                            children: [
                                              TextButton.icon(
                                                onPressed: () {
                                                  _selectDOB(context);
                                                },
                                                icon: const Icon(
                                                    Icons.calendar_today),
                                                label: Text(dob == null
                                                    ? "Select DOB"
                                                    : formatter.format(dob!)),
                                              ),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              const Text(
                                                "Employment Status :",
                                                style: TextStyle(
                                                    fontFamily: "Varela",
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              DecoratedBox(
                                                decoration:
                                                    const ShapeDecoration(
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        width: 2.0,
                                                        style:
                                                            BorderStyle.solid,
                                                        color:
                                                            Colors.deepPurple),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(
                                                        25.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12.0),
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: DropdownButton<
                                                            String>(
                                                        dropdownColor:
                                                            Colors.white,
                                                        items: employmentStatus
                                                            .map(
                                                                (String value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(
                                                              value,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onTap: () {
                                                          FocusScope.of(context)
                                                              .unfocus();
                                                        },
                                                        focusNode: FocusNode(),
                                                        value:
                                                            currentEmploymentStatus,
                                                        hint: const Text(
                                                          'Select',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        onChanged: (value) {
                                                          if (value != null) {
                                                            setState(() {
                                                              currentEmploymentStatus =
                                                                  value;
                                                            });
                                                          }
                                                        }),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  key: _formKey,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  onChanged: () {
                                    wasPersonalDataUpdated = true;
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    width: 1,
                    color: Colors.black12,
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    child: SizedBox(
                      height: size.height,
                      width: size.width - 232 - ((size.width - 231) * 0.8),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Skills",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                    fontFamily: "ProximaNova",
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.deepPurple,
                                  ),
                                )
                              ],
                            ),
                            ...List.generate(
                              ab.userModel.skills.length,
                              (index) {
                                return SkillCard(
                                  title:
                                      ab.userModel.skills.keys.toList()[index],
                                  experience: ab.userModel.skills.values
                                      .toList()[index],
                                  color: Colors.red,
                                  icon: DevIcons.javaPlain,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  List<Widget> getEditProfileMenu(
    Size size,
    EditProfileBloc epb,
    AuthenticationBloc ab,
    NavigationBloc nb,
  ) {
    bool isHorizontal = false;
    if (size.width < 1000) {
      isHorizontal = true;
    }
    return [
      getCustomSizedBoxForMenu(isHorizontal),
      if (!isHorizontal) ...[
        Image.asset(
          "assets/images/animated_gos.gif",
          width: 100,
          height: 100,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
      getSideMenuButton(
        epb,
        "Personal",
        FontAwesomeIcons.userAlt,
        0,
        isHorizontal,
      ),
      getCustomSizedBoxForMenu(isHorizontal),
      getSideMenuButton(
        epb,
        "Education",
        FontAwesomeIcons.userGraduate,
        1,
        isHorizontal,
      ),
      getCustomSizedBoxForMenu(isHorizontal),
      getSideMenuButton(
        epb,
        "Experience",
        FontAwesomeIcons.briefcase,
        2,
        isHorizontal,
      ),
      getCustomSizedBoxForMenu(isHorizontal),
      getSideMenuButton(
        epb,
        "Log Out",
        FontAwesomeIcons.signOutAlt,
        3,
        isHorizontal,
        authBloc: ab,
        navBloc: nb,
      ),
      getCustomSizedBoxForMenu(isHorizontal),
    ];
  }

  Widget getSideMenuButton(
    EditProfileBloc pb,
    String title,
    IconData icon,
    int index,
    bool isHorizontal, {
    AuthenticationBloc? authBloc,
    NavigationBloc? navBloc,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          pb.setCurrentSelectedItem(index);
          if (index == 3) {
            authBloc?.signOut(context, navBloc!);
          }
        },
        child: AnimatedContainer(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: pb.currentSelectedMenuItem == index
                ? const Color(0x73c6dbec)
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          child: SizedBox(
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: pb.currentSelectedMenuItem == index
                          ? Colors.black
                          : Colors.grey,
                      fontWeight: pb.currentSelectedMenuItem == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 14,
                      fontFamily: "Varela"),
                ),
                if (isHorizontal)
                  const SizedBox(
                    width: 20,
                  )
                else
                  const Spacer(),
                getIconForButton(icon),
                if (isHorizontal)
                  const SizedBox(
                    width: 10,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getCustomSizedBoxForMenu(bool isHorizontal) {
    return isHorizontal
        ? const SizedBox(
            width: 30,
          )
        : const SizedBox(
            height: 30,
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
                  "https://image.freepik.com/free-vector/gradient-hexagonal-background_23-2148947773.jpg"),
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
          fontFamily: "Varela",
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        children: [
          const Text(
            "Gender : ",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Varela",
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          ...getGenderRadio(0, FontAwesomeIcons.male),
          ...getGenderRadio(1, FontAwesomeIcons.female),
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
              fontFamily: "Varela",
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
      dob = newPicked;
      setState(() {});
    }
  }

  List<Widget> getGenderRadio(int val, IconData icon) {
    return [
      Radio(
        value: val,
        groupValue: gender,
        onChanged: (int? value) {
          gender = value;
          setState(() {});
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
