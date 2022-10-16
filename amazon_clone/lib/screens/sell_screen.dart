import 'package:amazon_clone/layout/screen_layout.dart';
import 'package:amazon_clone/provider/user_details_provider.dart';
import 'package:amazon_clone/screens/sign_up.dart';
import 'package:amazon_clone/utilis/utilis.dart';
import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:amazon_clone/widgets/loading_widget.dart';
import 'package:amazon_clone/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  bool isLoading = false;
  int selected = 1;
  Uint8List? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController costController = TextEditingController();
  List<int> keysForDiscount = [0, 70, 60, 50];

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    costController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: !isLoading
          ? SingleChildScrollView(
              child: SizedBox(
                height: screenSize.height,
                width: screenSize.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            image == null
                                ? Image.network(
                                    "https://cdn.pixabay.com/photo/2016/03/09/16/28/frame-1246811_1280.jpg",
                                    height: screenSize.height / 10,
                                  )
                                : Stack(
                                    children: [
                                      Image.memory(
                                        image!,
                                        height: screenSize.height / 10,
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            Uint8List? temp =
                                                await Utilis().pickImage();
                                            if (temp != null) {
                                              setState(() {
                                                image = temp;
                                              });
                                            }
                                          },
                                          icon: const Icon(Icons.file_upload))
                                    ],
                                  ),
                            IconButton(
                                onPressed: () async {
                                  Uint8List? temp = await Utilis().pickImage();
                                  if (temp != null) {
                                    setState(() {
                                      image = temp;
                                    });
                                  }
                                },
                                icon: const Icon(Icons.file_upload))
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          height: screenSize.height * 0.7,
                          width: screenSize.width * 0.7,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextFieldWidget(
                                  hintText: "Enter the name of the item",
                                  title: "Name",
                                  controller: nameController,
                                  obscureText: false),
                              TextFieldWidget(
                                  hintText: "Enter the cost of the item",
                                  title: "Cost",
                                  controller: costController,
                                  obscureText: false),
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Discount",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: const Text("None"),
                                leading: Radio(
                                    value: 1,
                                    groupValue: selected,
                                    onChanged: (int? i) {
                                      setState(() {
                                        selected = i!;
                                      });
                                    }),
                              ),
                              ListTile(
                                title: const Text("70%"),
                                leading: Radio(
                                    value: 2,
                                    groupValue: selected,
                                    onChanged: (int? i) {
                                      setState(() {
                                        selected = i!;
                                      });
                                    }),
                              ),
                              ListTile(
                                title: const Text("60%"),
                                leading: Radio(
                                    value: 3,
                                    groupValue: selected,
                                    onChanged: (int? i) {
                                      setState(() {
                                        selected = i!;
                                      });
                                    }),
                              ),
                              ListTile(
                                title: const Text("50%"),
                                leading: Radio(
                                    value: 4,
                                    groupValue: selected,
                                    onChanged: (int? i) {
                                      setState(() {
                                        selected = i!;
                                      });
                                    }),
                              ),
                            ],
                          ),
                        ),
                        CustomButton(
                            color: Colors.orange,
                            isLoading: isLoading,
                            onPressed: () async {
                              String output = await uploadDataToDatabase(
                                  image: image,
                                  productName: nameController.text,
                                  rawCost: costController.text,
                                  discount: keysForDiscount[selected - 1],
                                  sellerName: Provider.of<UserDetailsProvider>(
                                          context,
                                          listen: false)
                                      .userDetails
                                      .name,
                                  sellerUid:
                                      FirebaseAuth.instance.currentUser!.uid);

                              if (output == "success") {
                                Utilis()
                                    .showSnackBar(context, "Posted product");
                              } else {
                                Utilis().showSnackBar(context, output);
                              }
                            },
                            child: const Text(
                              "Sell",
                              style: TextStyle(color: Colors.black),
                            )),
                        CustomButton(
                            color: Colors.grey,
                            isLoading: false,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Back",
                              style: TextStyle(color: Colors.black),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : const LoadingWidget(),
    ));
  }
}

Future<String> uploadDataToDatabase({
  required Uint8List? image,
  required String productName,
  required String rawCost,
  required int discount,
  required String sellerName,
  required String sellerUid,
}) async {
  productName.trim();
  rawCost.trim();
  String output = "Something went wrong";

  if (image != null && productName != "" && rawCost != "") {
    try {
      String url =
            await uploadImageToDatabase(image: image, uid: "3u89tfwii4039rfji");

      output = "success";
    } catch (e) {
      output = e.toString();
    }
  } else {
    output = "Please fill all the required fields";
  }
  return output;
}
Future<String> uploadImageToDatabase(
      {required Uint8List image, required String uid}) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child("products").child(uid);
    UploadTask uploadTask = storageRef.putData(image);
    TaskSnapshot task = await uploadTask;
    return task.ref.getDownloadURL();
  }
