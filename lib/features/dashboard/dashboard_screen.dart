import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:wecheck/design-system/forms/generic_number_field.dart';
import 'package:wecheck/design-system/forms/generic_text_field.dart';
import 'package:wecheck/design-system/tokens.dart';
import 'package:wecheck/features/authentication/auth_provider.dart';
import 'package:wecheck/features/authentication/auth_repository.dart';
import 'package:wecheck/features/authentication/screens/login_screen.dart';
import 'package:wecheck/features/landing-page/landing_page_screen.dart';
import 'package:wecheck/shared/general.dart';
import 'package:wecheck/shared/snackbar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignSystem.GEMSBlue,
        actions: [
          TextButton(
            child: Text(
              "Dashboard",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
          ),
          SizedBox(
            width: 10,
          ),
          TextButton(
            child: Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              try {
                await Provider.of<AuthProvider>(context, listen: false)
                    .logOut();
                navigateViaMaterialRoute(
                  context,
                  LandingPageScreen(),
                  replace: true,
                );
              } catch (e) {
                print(e);
              }
            },
          ),
          SizedBox(
            width: 40,
          )
        ],
      ),
      body: Container(
        color: DesignSystem.GrayPageBackground,
        height: MediaQuery.of(context).size.height - 55,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProfileSection(),
              PaymentFormScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  bool isProfileImageHovered = false;

  _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      withData: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );
    if (result != null) {
      List<PlatformFile> files = result.files;
      PlatformFile file = result.files.first;
      String bytesData = base64.encode(file.bytes as List<int>);
      // setState(() {
      //   isUploadingImage = true;
      // });
      try {
        await AuthRepository().uploadProfileImageAsBase64(data: bytesData);
      } catch (e) {
        // setState(() {
        //   isUploadingImage = true;
        // });
      }
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<AuthProvider>(context, listen: false).getUserProfile(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error");
        }

        if (!snapshot.hasData) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        DocumentSnapshot<Map<String, dynamic>>? data = snapshot.data;
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              InkWell(
                onHover: (value) {
                  print(data!.data()!.containsKey("profile_image"));
                  // print(value);
                  setState(() {
                    isProfileImageHovered = value;
                  });
                },
                onTap: () {
                  print("tapped");
                  _pickFile();
                },
                child: Stack(children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: data != null &&
                              data.data()!.containsKey("profile_image")
                          ? Image.memory(base64Decode(
                              data!.data()!.containsKey("profile_image")
                                  ? data["profile_image"]
                                  : ""))
                          : Image.asset(
                              "assets/img/placeholder.png",
                              width: 100,
                              height: 100,
                            ),
                    ),
                  ),
                  isProfileImageHovered
                      ? Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            color: const Color.fromARGB(122, 0, 0, 0),
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )
                      : SizedBox()
                ]),
              ),
              SizedBox(
                width: 40,
              ),
              data != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data!["fullName"] ?? "N/A",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        Text(
                          data["email"] ?? "N/A",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      ],
                    )
                  : SizedBox(),
              Expanded(
                child: Container(),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                    color: DesignSystem.WecheckBrown,
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  "PENDING",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class PaymentFormScreen extends StatefulWidget {
  @override
  State<PaymentFormScreen> createState() => _PaymentFormScreenState();
}

class _PaymentFormScreenState extends State<PaymentFormScreen> {
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expirationDateController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();
  bool isPaymentCompleted = false;

  final _form = GlobalKey<FormState>();

  _pay() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Hello World"),
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildPaymentForm() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: Form(
        key: _form,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GenericNumberField(
              controller: _cardNumberController,
              title: "Card Number",
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: GenericTextField(
                    controller: _expirationDateController,
                    title: "Expiration Date",
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: GenericNumberField(
                    controller: _cvvController,
                    title: "CVV",
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final isValid = _form.currentState!.validate();

                if (isValid) {
                  presentSnackBar(
                    message: "Payment Suuccessful",
                    context: context,
                  );
                  setState(() {
                    isPaymentCompleted = true;
                  });

                  _form.currentState!.save();
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: DesignSystem.GEMSBlue,
                  padding: EdgeInsets.symmetric(vertical: 25),
                  textStyle: TextStyle(color: Colors.white)),
              child: Text(
                'Request Background Check',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isPaymentCompleted ? FileUploader() : _buildPaymentForm();
  }
}

class FileUploader extends StatefulWidget {
  const FileUploader({super.key});

  @override
  State<FileUploader> createState() => _FileUploaderState();
}

_pickFile(BuildContext context) async {
  print("clicked");
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: false,
    withData: true,
    type: FileType.custom,
    allowedExtensions: ['jpg', 'png'],
  );
  if (result != null) {
    List<PlatformFile> files = result.files;
    PlatformFile file = result.files.first;
    String bytesData = base64.encode(file.bytes as List<int>);
    // setState(() {
    //   isUploadingImage = true;
    // });
    try {
      await AuthRepository().uploadDocumentAsBase64(data: bytesData);
      presentSnackBar(
          context: context,
          message:
              "Document Uploaded Successfully. You will receive a response via email and SMS within 2 weeks");
      // setState(() {
      //   isUploadingImage = false;
      // });
      // setState(() {
      //   profileImageUrl = image;
      // });
    } catch (e) {
      // setState(() {
      //   isUploadingImage = true;
      // });
    }
  } else {
    // User canceled the picker
  }
}

class _FileUploaderState extends State<FileUploader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 30),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey, width: 2),
          bottom: BorderSide(color: Colors.grey, width: 2),
          left: BorderSide(color: Colors.grey, width: 2),
          right: BorderSide(color: Colors.grey, width: 2),
        ),
      ),
      child: Column(
        children: [
          Text("Click to upload your ID document"),
          IconButton(
            onPressed: () {
              _pickFile(context);
            },
            icon: Icon(Icons.file_copy),
          ),
        ],
      ),
    );
  }
}
