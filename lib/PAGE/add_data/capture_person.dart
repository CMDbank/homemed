import 'dart:io';
import 'package:flutter/material.dart';
import '../add_data/addinfo.dart';
import '../add_data/temp.dart';
import '../../config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class Cap_person extends StatefulWidget {
  @override
  State<Cap_person> createState() => _Cap_personState();
}

class _Cap_personState extends State<Cap_person> {
  void initState() {
    super.initState();
  }

  File? _image;

  Future<void> _uploadPhoto(File image) async {
    final prefs = await SharedPreferences.getInstance();

    String? idcardNumberpatients = prefs.getString("id_card_Number_patients");
    String? fullName = prefs.getString("full_name");
    String? birthdate = prefs.getString("birthdate");
    String? expiredate = prefs.getString("expiredate");
    String? HNNumber = prefs.getString("HN_number");
    String? user = prefs.getString("ID");

    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + '/add_patient/'));
    var multipartFile = await http.MultipartFile.fromPath('image', image.path);
    request.files.add(multipartFile);
    request.fields['user'] = user!;
    request.fields['id_card_number'] = idcardNumberpatients!;
    request.fields['full_name'] = fullName!;
    request.fields['birthdate'] = birthdate!;
    request.fields['expiredate'] = expiredate!;
    request.fields['HN_number'] = HNNumber!;

    var response = await request.send();
    print(response.statusCode);
  }

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image == null) {
      return;
    }

    final imageTemporary = File(image.path);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("image", imageTemporary.path);

    setState(() {
      _image = imageTemporary;

      // _uploadPhoto(_image!);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Addinfo()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(115, 117, 115, 115),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textstyle(
                      text: "สแกนบัตรประชาชน",
                      fontSize: 25,
                      color: Colors.white,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Addinfo()));
                      },
                      child: Row(
                        children: [
                          textstyle(
                            text: "ข้าม",
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 450,
              ),
              TextButton(
                onPressed: () {
                  getImage();
                },
                child: Icon(
                  Icons.circle,
                  size: 90,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
