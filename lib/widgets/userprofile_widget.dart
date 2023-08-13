import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:synapserx_patient/providers/userprofile_provider.dart';
import 'package:synapserx_patient/widgets/synapsepx_snackbar.dart';
import '../providers/data_providers.dart';
import '../services/auth_services.dart';
import '../services/settings.dart';
import '../widgets/genderselector.dart';

class UserProfileWidget extends ConsumerStatefulWidget {
  const UserProfileWidget({
    super.key,
    required this.title,
    required this.isCreating,
  });
  final String title;
  final bool isCreating;
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
  late DateTime initialDate;
  var params = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = ref.watch(asyncUserProfileProvider);
    return Scaffold(
        appBar: AppBar(
          leading: widget.isCreating
              ? IconButton(
                  onPressed: () {
                    _showAlertDialog();
                  },
                  icon: const Icon(
                    Icons.clear,
                  ))
              : null,
          title: Text(widget.title.toString()),
          actions: [
            Consumer(
              builder: (context, ref, child) {
                final value = ref.watch(isSaveButtonEnabledProvider);
                return value
                    ? TextButton(
                        onPressed: () async {
                          generateParams();
                          if (!widget.isCreating) {
                            await ref
                                .watch(dioClientProvider)
                                .updateProfileInfo(data: params)
                                .then((updateOutcome) {
                              if (updateOutcome) {
                                ref
                                    .watch(isSaveButtonEnabledProvider.notifier)
                                    .saveEnabled(false);
                                ref.invalidate(asyncUserProfileProvider);
                                const GlobalSnackBar(Colors.green,
                                    message:
                                        'Your user profile has been updated');
                              }
                            });
                          } else {
                            await ref
                                .watch(dioClientProvider)
                                .createProfileInfo(data: params)
                                .then((updateOutcome) {
                              if (updateOutcome) {
                                ref
                                    .watch(isSaveButtonEnabledProvider.notifier)
                                    .saveEnabled(false);
                                ref.invalidate(asyncUserProfileProvider);
                                const GlobalSnackBar(Colors.green,
                                    message:
                                        'Your user profile has been created');
                                context.go('/home');
                              }
                            });
                          }
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ))
                    : Container();
              },
            ),
          ],
        ),
        body: profileProvider.when(
          data: (profile) {
            _firstnameTextController.text = profile.firstname ?? '';
            _lastnameTextController.text = profile.surname ?? '';
            _telephoneTextController.text = profile.telephone ?? '';
            _emailTextController.text = profile.email ?? '';
            _niaNoTextController.text = profile.nationalIdNo ?? '';
            _nhisNoTextController.text =
                profile.nationalHealthInsurancedNo ?? '';
            //make entry for gender on custom gender selecter;
            selectedGender = profile.gender ?? 'male';
            switch (selectedGender) {
              case "male":
                selectedGenderIndex = 0;
                break;
              case "female":
                selectedGenderIndex = 1;
                break;
              case "others":
                selectedGenderIndex = 2;
                break;
            }

            pxAgeController.text = (profile.ageAtRegistration ?? 0).toString();
            pxDOBController.text = profile.dateOfBirth ?? '';
            isAgeEstimated = profile.isAgeEstimated;
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
                              textCapitalization: TextCapitalization.words,
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
                            height: 10,
                          ),
                          TextFormField(
                              textCapitalization: TextCapitalization.words,
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
                                      pxDOBController.text =
                                          DateFormat("yyyy-MM-dd").format(
                                              DateTime(
                                                  today.year -
                                                      int.parse(
                                                          pxAgeController.text),
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
                                  readOnly: true,
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
                                              var parsedDate =
                                                  DateTime.tryParse(
                                                      pxDOBController.text);
                                              if (parsedDate == null) {
                                                initialDate = DateTime.now();
                                              } else {
                                                initialDate = parsedDate;
                                              }

                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      firstDate: DateTime(1910),
                                                      lastDate: DateTime.now(),
                                                      initialDate:
                                                          initialDate); //DateTime.now() - not to allow to choose before today.
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
                              keyboardType: TextInputType.phone,
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
                              keyboardType: TextInputType.emailAddress,
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
                            height: 10,
                          ),
                          TextFormField(
                              onChanged: (value) {
                                enableSaveButton();
                              },
                              controller: _nhisNoTextController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                labelText: 'National Health Insurance ID No',
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
          error: (err, stack) => Center(
            child: Text("Error: $err", style: const TextStyle(fontSize: 15)),
          ),
          loading: (() => const Center(child: CircularProgressIndicator())),
        ));
  }

  void enableSaveButton() {
    ref.watch(isSaveButtonEnabledProvider.notifier).saveEnabled(true);
  }

  void generateParams() {
    params = {
      "surname": _lastnameTextController.text.trim(),
      "firstname": _firstnameTextController.text.trim(),
      "dateOfBirth": pxDOBController.text,
      "ageAtRegistration": pxAgeController.text,
      "isAgeEstimated": isAgeEstimated,
      "telephone": _telephoneTextController.text.trim(),
      "email": _emailTextController.text.trim(),
      "gender": selectedGender.toLowerCase(),
      "nationalIdNo": _niaNoTextController.text.trim(),
      "nationalHealthInsurancedNo": _nhisNoTextController.text.trim(),
    };
    if (widget.isCreating) {
      final status = <String, bool>{"active": true};
      params.addEntries(status.entries);
    }
    print(params);
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('User Profile Required'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'A user profile is required to use synapsePx. Click Continue to create a profile or Cancel to exit the application'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Continue'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
                child: const Text('Cancel'),
                onPressed: () async {
                  GlobalData.fullname = '';
                  await AuthService.signOut(context: context);
                }),
          ],
        );
      },
    );
  }
}
