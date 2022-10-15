import 'package:amazon_clone/utilis/utilis.dart';
import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:amazon_clone/widgets/loading_widget.dart';
import 'package:amazon_clone/widgets/text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
                            onPressed: () {},
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
