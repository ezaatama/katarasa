import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:katarasa/models/auth/register/register_request.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/extension.dart';
import 'package:katarasa/widgets/button/primary_button.dart';
import 'package:katarasa/widgets/customize_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? _genderOption;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded,
                size: 24, color: ColorUI.BLACK),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Edit Profile",
          style: BLACK_TEXT_STYLE.copyWith(
              fontSize: 22, fontWeight: FontUI.WEIGHT_SEMI_BOLD),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name",
                style: BLACK_TEXT_STYLE.copyWith(
                    fontWeight: FontUI.WEIGHT_SEMI_BOLD),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name must not be empty!';
                  }
                  return null;
                },
                hintText: "Name",
              ),
              const SizedBox(height: 10),
              Text(
                "Email",
                style: BLACK_TEXT_STYLE.copyWith(
                    fontWeight: FontUI.WEIGHT_SEMI_BOLD),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email must not be empty!';
                  } else if (!isValidEmail(value)) {
                    return 'Please entry email validate!';
                  }
                  return null;
                },
                hintText: "Email",
              ),
              const SizedBox(height: 10),
              Text(
                "Phone Number",
                style: BLACK_TEXT_STYLE.copyWith(
                    fontWeight: FontUI.WEIGHT_SEMI_BOLD),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Phone number must not be empty!';
                  } else if (!isValidPhoneNumber(value)) {
                    return 'Please entry validate phone number';
                  }
                  return null;
                },
                hintText: "Phone Number",
              ),
              const SizedBox(height: 10),
              Text("Gender",
                  style: BLACK_TEXT_STYLE.copyWith(
                      fontWeight: FontUI.WEIGHT_SEMI_BOLD)),
              const SizedBox(height: 10),
              DropdownButtonFormField2<String>(
                  hint: Text(
                    "Gender",
                    style: LIGHT_BROWN_TEXT_STYLE.copyWith(fontSize: 14),
                  ),
                  isExpanded: true,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorUI.BROWN.withOpacity(.60)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorUI.BROWN.withOpacity(.50)),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    filled: true,
                    fillColor: ColorUI.WHITE,
                  ),
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 24,
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Gender wajib diisi!';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    if (value!.isEmpty) {
                      _genderOption = value.toString();
                    } else {
                      _genderOption = value;
                    }
                  },
                  value: _genderOption,
                  onChanged: (String? newValue) {
                    setState(() {
                      _genderOption = newValue!;
                      debugPrint("ini choice gender => $_genderOption");
                    });
                  },
                  items: RegisterRequest.gender.map((e) {
                    return DropdownMenuItem(
                        value: e,
                        child: Text(e, style: const TextStyle(fontSize: 14)));
                  }).toList()),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PrimaryButton(text: "Save Profile", onPressed: () {}),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
