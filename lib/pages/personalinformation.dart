import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:synapserx_patient/providers/userprofile_provider.dart';
import '../widgets/genderselector.dart';

class PersonalInfoPage extends ConsumerWidget {
  PersonalInfoPage({Key? key}) : super(key: key);
  static String get routeName => 'personalinfo';
  static String get routeLocation => '/$routeName';
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
  late int selectedGenderIndex;
  // final bool ageIsEstimated = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileProvider = ref.watch(asyncUserProfileProvider);
    final notifier = ref.watch(asyncUserProfileProvider.notifier);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Personal Information'),
        ),
        body: profileProvider.when(
          data: (profile) {
            _firstnameTextController.text = profile.firstname.toString();
            _lastnameTextController.text = profile.surname.toString();
            _telephoneTextController.text = profile.telephone.toString();
            _emailTextController.text = profile.email.toString();
            _niaNoTextController.text = profile.nationalIdNo.toString();
            _nhisNoTextController.text =
                profile.nationalHealthInsurancedNo.toString();
            //make entry for gender on custom gender selecter;
            selectedGender = profile.gender.toString();
            switch (selectedGender) {
              case "Male":
                selectedGenderIndex = 0;
                break;
              case "Female":
                selectedGenderIndex = 1;
                break;
              case "Others":
                selectedGenderIndex = 2;
                break;
            }

            pxAgeController.text = profile.ageAtRegistration.toString();
            pxDOBController.text = profile.dateOfBirth.toString();
            bool ageIsEstimated = profile.isAgeEstimated;
            return Padding(
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
                                print(gender);
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: ageIsEstimated,
                                  onChanged: (bool? value) {
                                    notifier.setIsAgeEastimated(!value!);
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
                                      pxDOBController.text =
                                          DateFormat("yyyy-MM-dd").format(
                                              DateTime(
                                                  today.year -
                                                      int.parse(
                                                          pxAgeController.text),
                                                  today.month,
                                                  today.day));
                                    }),
                                    keyboardType: TextInputType.number,
                                    enabled: ageIsEstimated,
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
                                  onChanged: ((value) {}),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Patient's DOB is required";
                                    }
                                    return null;
                                  },
                                  controller: pxDOBController,
                                  keyboardType: TextInputType.datetime,
                                  enabled: !ageIsEstimated,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(8),
                                    suffixIcon: GestureDetector(
                                      onTap: ageIsEstimated
                                          ? null
                                          : () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate: DateTime
                                                          .now(), //get today's date
                                                      firstDate: DateTime(
                                                          1910), //DateTime.now() - not to allow to choose before today.
                                                      lastDate: DateTime.now());
                                              pxDOBController.text =
                                                  DateFormat("yyyy-MM-dd")
                                                      .format(pickedDate!);
                                              pxAgeController.text =
                                                  (DateTime.now().year -
                                                          pickedDate.year)
                                                      .toString();
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
            );
          },
          error: (err, stack) => Text("Error: $err",
              style: const TextStyle(color: Colors.white, fontSize: 15)),
          loading: (() => const Center(child: CircularProgressIndicator())),
        ));
  }
}
