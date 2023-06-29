import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MedicineForm extends StatefulWidget {
  @override
  _MedicineFormState createState() => _MedicineFormState();
}

class _MedicineFormState extends State<MedicineForm> {
  final _formKey = GlobalKey<FormState>();
  final _imagePicker = ImagePicker();
  File? _image;

  String? _title;
  String? _description;
  String? _city;
  String? _communicationMethod;
  double _quantity = 0.0;
  String? _medicine;
  String? _medicineUnit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Medicine'),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final image = await _imagePicker.pickImage(
                            source: ImageSource.gallery);
                        setState(() {
                          _image = File(image!.path);
                        });
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: _image != null
                            ? Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              )
                            : const Icon(
                                Icons.camera_alt,
                                size: 50,
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _title = value;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: null,
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _description = value;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'City',
                        border: OutlineInputBorder(),
                      ),
                      value: _city,
                      items: const [
                        DropdownMenuItem(
                          child: Text('City 1'),
                          value: 'City 1',
                        ),
                        DropdownMenuItem(
                          child: Text('City 2'),
                          value: 'City 2',
                        ),
                        DropdownMenuItem(
                          child: Text('City 3'),
                          value: 'City 3',
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _city = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a city';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Communication Method',
                        border: OutlineInputBorder(),
                      ),
                      value: _communicationMethod,
                      items: const [
                        DropdownMenuItem(
                          child: Text('Phone'),
                          value: 'Phone',
                        ),
                        DropdownMenuItem(
                          child: Text('Email'),
                          value: 'Email',
                        ),
                        DropdownMenuItem(
                          child: Text('WhatsApp'),
                          value: 'WhatsApp',
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _communicationMethod = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a communication method';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Slider(
                      value: _quantity,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: _quantity.toString(),
                      onChanged: (value) {
                        setState(() {
                          _quantity = value;
                        });
                      },
                    ),
                    Text('Quantity: ${_quantity.toStringAsFixed(0)}'),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Medicine',
                        border: OutlineInputBorder(),
                      ),
                      value: _medicine,
                      items: const [
                        DropdownMenuItem(
                          child: Text('Medicine 1'),
                          value: 'Medicine 1',
                        ),
                        DropdownMenuItem(
                          child: Text('Medicine 2'),
                          value: 'Medicine 2',
                        ),
                        DropdownMenuItem(
                          child: Text('Medicine 3'),
                          value: 'Medicine 3',
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _medicine = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a medicine';
                        }
                        return null;
                      },
                    )
                  ])),
        )));
  }
}
