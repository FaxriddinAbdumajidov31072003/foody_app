import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foody_app/view/pages/auth/set_photo.dart';
import 'package:foody_app/view/style/diss_keyboard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controller/auth_controller.dart';
import '../../components/custom_textform.dart';
import '../../components/gender_choose.dart';
import '../../components/label_textformfield.dart';
import '../../components/warning_container.dart';

class FillBioPage extends StatefulWidget {
  const FillBioPage({super.key});

  @override
  State<FillBioPage> createState() => _FillBioPageState();
}

class _FillBioPageState extends State<FillBioPage> {
  TextEditingController fullname = TextEditingController();
  TextEditingController nickname = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController passwor = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController genderController = TextEditingController();
  bool value = false;
  bool visibilityOfpasswor = false;
  bool isFullNameEmpty = false;
  bool isNickNameEmpty = false;
  bool isPhoneNumberEmpty = false;
  bool isGenderEmpty = false;
  bool isDateOfBirthEmpty = false;
  bool isAddressEmpty = false;
  bool isPasswEmty = false;
  String initialvalue = 'Male';
  String datetext = '';
  var items = ['Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: OnUnFocusTap(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.18, vertical: 8.18),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9.82)),
                              color: Color.fromARGB(255, 234, 175, 194)),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xffF43F5E),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Text(
                          'Fill in your bio',
                          style: GoogleFonts.sourceSansPro(
                              fontSize: 26, fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ),
                24.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'This data will be displayed in your account profile for security',
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                35.verticalSpace,
                Padding(
                    padding: const EdgeInsets.only(left: 48),
                    child: Label(
                      text: 'Full Name',
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
                  child: CustomTextFrom(
                    onchange: (value) {
                      isFullNameEmpty = false;
                      setState(() {});
                    },
                    label: '',
                    controller: fullname,
                    keyboardType: TextInputType.emailAddress,
                    hintext: 'Full Name',
                  ),
                ),
                isFullNameEmpty
                    ? Padding(
                        padding:
                            const EdgeInsets.only(left: 24, top: 8, right: 24),
                        child: Warning(
                          text: 'Please fill the full Name',
                        ))
                    : const SizedBox.shrink(),
                35.verticalSpace,
                Padding(
                    padding: const EdgeInsets.only(left: 48),
                    child: Label(
                      text: 'Nick Name',
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
                  child: CustomTextFrom(
                    onchange: (value) {
                      isNickNameEmpty = false;
                      setState(() {});
                    },
                    controller: nickname,
                    label: '',
                    keyboardType: TextInputType.name,
                    hintext: 'Nick Name',
                  ),
                ),
                isNickNameEmpty
                    ? Padding(
                        padding:
                            const EdgeInsets.only(left: 24, top: 8, right: 24),
                        child: Warning(text: 'Please fill the Nick Name'))
                    : const SizedBox.shrink(),
                35.verticalSpace,
                Padding(
                    padding: const EdgeInsets.only(left: 48),
                    child: Label(
                      text: 'Phone Number',
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
                  child: CustomTextFrom(
                    onchange: (value) {
                      isPhoneNumberEmpty = false;
                      setState(() {});
                    },
                    controller: phonenumber,
                    label: '',
                    keyboardType: TextInputType.phone,
                    hintext: 'Phone Number',
                  ),
                ),
                isPhoneNumberEmpty
                    ? Padding(
                        padding:
                            const EdgeInsets.only(left: 24, top: 8, right: 24),
                        child: Warning(text: 'Please fill the Phone Number'))
                    : const SizedBox.shrink(),
                35.verticalSpace,
                Padding(
                    padding: const EdgeInsets.only(left: 48),
                    child: Label(
                      text: 'Gender',
                    )),
                GenderChoosing(),
                35.verticalSpace,
                Padding(
                    padding: const EdgeInsets.only(left: 48),
                    child: Label(
                      text: 'Date of Birth',
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
                  child: TextFormField(
                    onChanged: (value) {
                      bool isDateOfBirthEmpty = false;
                      setState(() {});
                    },
                    controller: dateOfBirth,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: (() {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1970),
                                  lastDate: DateTime.now())
                              .then((value) {
                            dateOfBirth.text = DateFormat('MMMM dd, yyyy')
                                .format(value ?? DateTime.now());
                            setState(() {});
                          });
                        }),
                        icon: SvgPicture.asset(
                          'assets/svg/calendar.svg',
                          height: 24,
                          width: 24,
                          color: Colors.grey,
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(
                          left: 24, right: 24, top: 12, bottom: 12),
                      hintText: 'Date of Birth',
                      hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffDADEE3)),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 221, 206, 206)),
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 221, 206, 206)),
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                    ),
                  ),
                ),
                35.verticalSpace,
                Padding(
                    padding: const EdgeInsets.only(left: 48),
                    child: Label(
                      text: 'Password',
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
                  child: CustomTextFrom(
                    onchange: (value) {
                      isPasswEmty = false;
                      setState(() {});
                    },
                    label: '',
                    isObscure: true,
                    controller: passwor,
                    keyboardType: TextInputType.emailAddress,
                    hintext: 'Password',
                  ),
                ),
                isAddressEmpty
                    ? Padding(
                        padding:
                            const EdgeInsets.only(left: 24, top: 8, right: 24),
                        child: Warning(text: 'Please fill the Password'))
                    : const SizedBox.shrink(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: InkWell(
                    onTap: () async {
                      if (fullname.text.isEmpty) {
                        isFullNameEmpty = true;
                        setState(() {});
                      } else if (nickname.text.isEmpty) {
                        isNickNameEmpty = true;
                        setState(() {});
                      } else if (phonenumber.text.isEmpty) {
                        isPhoneNumberEmpty = true;
                        setState(() {});
                      } else if (address.text.isEmpty) {
                        isAddressEmpty = true;
                        setState(() {});
                      }
                      if (fullname.text.isNotEmpty &&
                          nickname.text.isNotEmpty &&
                          phonenumber.text.isNotEmpty &&
                          passwor.text.isNotEmpty) {
                        context.read<AuthController>().setStateUser(
                            name: fullname.text,
                            username: nickname.text,
                            password: passwor.text,
                            email: email.text,
                            gender: context.read<AuthController>().gender,
                            birth: dateOfBirth.text,
                            onSuccess: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => UploadPhotoPage()),
                                  (route) => false);
                            });
                      }
                    },
                    child: AnimatedContainer(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      duration: const Duration(milliseconds: 400),
                      decoration: BoxDecoration(
                        color: fullname.text.isEmpty ||
                                nickname.text.isEmpty ||
                                phonenumber.text.isEmpty ||
                                passwor.text.isEmpty
                            ? const Color.fromARGB(244, 235, 134, 164)
                            : const Color(0xffFF1843),
                        borderRadius: const BorderRadius.all(Radius.circular(32)),
                      ),
                      child: Center(
                        child: Text(
                          'Next',
                          style: GoogleFonts.sourceSansPro(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
