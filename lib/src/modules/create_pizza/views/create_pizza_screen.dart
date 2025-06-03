import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../components/my_text_field.dart';
import '../components/micro.dart';

class CreatePizzaScreen extends StatefulWidget {
  const CreatePizzaScreen({super.key});

  @override
  State<CreatePizzaScreen> createState() => _CreatePizzaScreenState();
}

class _CreatePizzaScreenState extends State<CreatePizzaScreen> {
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _errorMsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                const Text(
                  'Create a New Pizza !',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    
                  },
                  child: Ink(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.photo,
                          size: 100,
                          color: Colors.grey.shade200,
                        ),
                        const SizedBox(height: 10,),
                        const Text(
                          "Add a Picture here...",
                          style: TextStyle(
                            color: Colors.grey
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    SizedBox(
                      width: 400,
                      child: MyTextField(
                        controller: nameController,
                        hintText: 'Name',
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        errorMsg: _errorMsg,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please fill in this field';
                          }
                          return null;
                          })),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 400,
                      child: MyTextField(
                        controller: nameController,
                        hintText: 'Description',
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        errorMsg: _errorMsg,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please fill in this field';
                          }
                        return null;
                      })),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 400,
                      child: Row(
                        children: [
                          Expanded(
                            child: MyTextField(
                              controller: nameController,
                              hintText: 'Price',
                              obscureText: false,
                              keyboardType: TextInputType.emailAddress,
                              errorMsg: _errorMsg,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please fill in this field';
                                }
                              return null;
                            })),
                          const SizedBox(width: 10),
                          Expanded(
                            child: MyTextField(
                              controller: nameController,
                              hintText: 'Discount',
                              suffixIcon: const Icon(
                                CupertinoIcons.percent,
                                color: Colors.grey,
                              ),
                              obscureText: false,
                              keyboardType: TextInputType.emailAddress,
                              errorMsg: _errorMsg,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please fill in this field';
                                }
                              return null;
                            })),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'Is Vege: '
                        ),
                        const SizedBox(width: 10,),
                        Checkbox(
                          value: false, 
                          onChanged: (value) {
          
                          }
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'Is Spicy: '
                        ),
                        const SizedBox(width: 10,),
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2
                                ),
                                color: Colors.green
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2
                                ),
                                color: Colors.orange
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2
                                ),
                                color: Colors.red
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Macro:'
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(
                      width: 400,
                      child: Row(
                        children: [
                          MyMicroWidget(
                            title: 'Calories',
                            value: 12,
                            icon: FontAwesomeIcons.fire,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          MyMicroWidget(
                            title: 'Protein',
                            value: 12,
                            icon: FontAwesomeIcons.dumbbell,
                          ),
                          SizedBox(width: 10),
                          MyMicroWidget(
                            title: 'Fat',
                            value: 12,
                            icon: FontAwesomeIcons.oilWell,
                          ),
                          SizedBox(width: 10),
                          MyMicroWidget(
                            title: 'Carbs',
                            value: 12,
                            icon: FontAwesomeIcons.breadSlice,
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}