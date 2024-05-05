// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/components/image_picker.dart';
import 'package:easy_delevery/components/my_button.dart';
import 'package:easy_delevery/components/my_drop_dowm_button.dart';
import 'package:easy_delevery/models/menu_item.dart';
import 'package:easy_delevery/services/auth_services.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatefulWidget {
  const DialogBox({super.key});

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  // form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CollectionReference restaurant =
      FirebaseFirestore.instance.collection('restaurants');

  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  late String categoryValue;
  late String imageUrl;

  Future newMeal() async {
    try {
      DocumentReference docRef = restaurant.doc(AuthServices.getUid);
      DocumentSnapshot docSnapshot = await docRef.get();

      MenuItem newItem = MenuItem(
          name: _nameController.text,
          description: _descriptionController.text.split('\n'),
          price: double.parse(_priceController.text),
          category: categoryValue,
          image: imageUrl);

      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        if (data['menuItems'] == null) {
          await docRef.update({
            'menuItems': [newItem.toMap()],
          });
        } else {
          List menuItems = data['menuItems'];
          menuItems.add(newItem.toMap());
          await docRef.update({
            'menuItems': menuItems,
          });
        }
      } else {
        await docRef.set({
          'menuItems': [newItem.toMap()],
        });
      }
    } catch (e) {
      print('Error updating category: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        backgroundColor: Colors.black,
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                      color: myColors.buttonColor,
                    ),
                  ],
                ),
                const Text(
                  'הוספת מנה חדשה',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: myColors.buttonColor,
                  ),
                ),

                const SizedBox(height: 15),

                // my image picker
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: MyImagePicker(
                    onImageSelected: (image) {
                      setState(() {
                        imageUrl = image;
                      });
                    },
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //* price text field
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextFormField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'יש להזין מחיר';
                            }
                            return null;
                          },
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.end,
                          decoration: const InputDecoration(
                            hintText: 'מחיר',
                            prefixText: '₪',
                            prefixStyle: TextStyle(
                              color: Colors.white,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: myColors.buttonColor,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xFFF9B413),
                              ),
                            ),
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    //* name product text field
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'יש להזין שם מנה';
                            }
                            return null;
                          },
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.end,
                          decoration: const InputDecoration(
                            hintText: 'שם המנה',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: myColors.buttonColor,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xFFF9B413),
                              ),
                            ),
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  child: MyDropdownButton(
                    onValueChanged: (value) {
                      setState(() {
                        categoryValue = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 50),

                TextFormField(
                  controller: _descriptionController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'יש להזין תיאור';
                    }
                    return null;
                  },
                  textAlign: TextAlign.end,
                  minLines: 1,
                  maxLines: 5,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    label: Text(
                      'תיאור המנה',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                      borderSide: BorderSide(
                        color: myColors.buttonColor,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                      borderSide: BorderSide(
                        color: Color(0xFFF9B413),
                        width: 2.5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2.5,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2.5,
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                MyButton(
                  text: 'אישור',
                  horizontal: 75,
                  vertical: 5,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pop();
                      return await newMeal();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
