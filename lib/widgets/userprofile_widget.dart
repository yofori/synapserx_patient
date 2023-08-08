import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:synapserx_patient/providers/userprofile_provider.dart';
import '../widgets/genderselector.dart';

class UserProfileWidget extends ConsumerStatefulWidget {
  const UserProfileWidget({Key? key}) : super(key: key);
  @override
  ConsumerState<UserProfileWidget> createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends ConsumerState<UserProfileWidget> {
  final _formKey = GlobalKey<FormState>();
  final _firstnameTextController = TextEditingController();
  final _lastnameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _telephoneTextController = TextEditingController();
  final _niaNoTextController = TextEditingController();
  final _nhisNoTextController = TextEditingController();
  final pxDOBController = TextEditingController();
  final pxAgeController = TextEditingController();
  final List<Gender> genders = <Gender>[
    Gender("Male", Icons.male, false),
    Gender("Female", Icons.female, false),
    Gender("Others", Icons.transgender, false)
  ];
  late String selectedGender = '';
  late int selectedGenderIndex = 0;
  late bool isAgeEstimated = false;

  var params = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                      onChanged: (value) {
                        enableSaveButton();
                      },
                      controller: _firstnameTextController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        labelText: 'First names',
                        hintText: 'First names',
                        prefixIcon: const Icon(Icons.person_2_outlined),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade500,
                            width: 1,
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                      onChanged: (value) {
                        enableSaveButton();
                      },
                      controller: _lastnameTextController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        labelText: 'Last name',
                        hintText: 'Last name',
                        prefixIcon: const Icon(Icons.person_2_outlined),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade500,
                            width: 1,
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Gender',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GenderSelector(
                      genders: genders,
                      selectedGenderIndex: selectedGenderIndex,
                      onSelect: (String gender) {
                        selectedGender = gender;
                        enableSaveButton();
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: isAgeEstimated,
                          onChanged: (bool? value) {
                            setState(() {
                              isAgeEstimated = value!;
                            });

                            enableSaveButton();
                          }),
                      const Text('Age is estimated'),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 30,
                        child: TextFormField(
                            controller: pxAgeController,
                            onChanged: ((value) {
                              var today = DateTime.now();
                              pxDOBController.text = DateFormat("yyyy-MM-dd")
                                  .format(DateTime(
                                      today.year -
                                          int.parse(pxAgeController.text),
                                      today.month,
                                      today.day));
                              enableSaveButton();
                            }),
                            keyboardType: TextInputType.number,
                            enabled: isAgeEstimated,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(5.0),
                              border: OutlineInputBorder(),
                            )),
                      ),
                    ],
                  ),
                  Row(children: [
                    const SizedBox(
                      width: 20,
                    ),
                    const Text('Date of birth:'),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 160,
                      //height: 36,
                      child: TextFormField(
                          onChanged: (value) {
                            enableSaveButton();
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Patient's DOB is required";
                            }
                            return null;
                          },
                          controller: pxDOBController,
                          keyboardType: TextInputType.datetime,
                          enabled: !isAgeEstimated,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(8),
                            suffixIcon: GestureDetector(
                              onTap: isAgeEstimated
                                  ? null
                                  : () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.parse(
                                              pxDOBController.text),
                                          firstDate: DateTime(1910),
                                          lastDate: DateTime
                                              .now()); //DateTime.now() - not to allow to choose before today.
                                      if (pickedDate != null) {
                                        pxDOBController.text =
                                            DateFormat("yyyy-MM-dd")
                                                .format(pickedDate);

                                        pxAgeController.text =
                                            (DateTime.now().year -
                                                    pickedDate.year)
                                                .toString();
                                      }
                                      enableSaveButton();
                                    },
                              child: const Icon(Icons.calendar_month),
                            ),
                            isDense: true,
                            border: const OutlineInputBorder(),
                          )),
                    ),
                  ]),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      onChanged: (value) {
                        enableSaveButton();
                      },
                      controller: _telephoneTextController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        labelText: 'Telephone',
                        hintText: 'Telephone',
                        prefixIcon: const Icon(Icons.phone),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade500,
                            width: 1,
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      onChanged: (value) {
                        enableSaveButton();
                      },
                      controller: _emailTextController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        labelText: 'Email',
                        hintText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade500,
                            width: 1,
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      onChanged: (value) {
                        enableSaveButton();
                      },
                      controller: _niaNoTextController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        labelText: 'National ID No',
                        hintText: 'National ID No',
                        prefixIcon: const Icon(Icons.badge_outlined),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade500,
                            width: 1,
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                      onChanged: (value) {
                        enableSaveButton();
                      },
                      controller: _nhisNoTextController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        labelText: 'National Health Inusrance ID No',
                        hintText: 'Nation Health Insurance ID No',
                        prefixIcon: const Icon(Icons.credit_card),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade500,
                            width: 1,
                          ),
                        ),
                      )),
                ],
              ))),
    ));
  }

  void enableSaveButton() {
    ref.watch(isSaveButtonEnabledProvider.notifier).saveEnabled(true);
  }

  void generateParams() {
    params = {
      "surname": _lastnameTextController.text,
      "firstname": _firstnameTextController.text,
      "dateOfBirth": pxDOBController.text,
      "ageAtRegistration": pxAgeController.text,
      "isAgeEstimated": isAgeEstimated,
      "telephone": _telephoneTextController.text,
      "email": _emailTextController.text,
      "gender": selectedGender.toLowerCase(),
      "nationalIdNo": _niaNoTextController.text,
      "nationalHealthInsurancedNo": _nhisNoTextController.text
    };
    print(params);
  }
}
