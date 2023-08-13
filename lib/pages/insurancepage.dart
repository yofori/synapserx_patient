import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../providers/insurancepolicies_provider.dart';

class InsurancePage extends ConsumerStatefulWidget {
  const InsurancePage({super.key});

  static String get routeName => 'insurance';
  static String get routeLocation => '/$routeName';

  @override
  ConsumerState<InsurancePage> createState() => _InsurancePageState();
}

class _InsurancePageState extends ConsumerState<InsurancePage> {
  TextEditingController insuranceCompanyNameController =
      TextEditingController();
  TextEditingController policyStartDateController = TextEditingController();
  TextEditingController benefitPackageNameController = TextEditingController();
  TextEditingController benefitPackageCodeController = TextEditingController();
  TextEditingController policyNumberController = TextEditingController();
  TextEditingController policyExpiryDateController = TextEditingController();
  TextEditingController idController = TextEditingController();

  bool isEditing = false;
  late DateTime initialDate;

  @override
  Widget build(BuildContext context) {
    final insurancePolicyList = ref.watch(insurancePoliciesProvider);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              isEditing = false;
              addEditInsurancePolicy();
            }),
        appBar: AppBar(
          title: const Text('Insurance Policies'),
        ),
        body: insurancePolicyList.when(
            data: (policylists) => (policylists.isNotEmpty)
                ? ListView.builder(
                    itemCount: policylists.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: ListTile(
                        title: Text(
                            policylists[index].insuranceCompanyName.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  isEditing = true;
                                  insuranceCompanyNameController.text =
                                      policylists[index]
                                          .insuranceCompanyName
                                          .toString();
                                  policyStartDateController.text =
                                      policylists[index].startDate.toString();
                                  benefitPackageNameController.text =
                                      policylists[index]
                                          .benefitPackageName
                                          .toString();
                                  benefitPackageCodeController.text =
                                      policylists[index]
                                          .benefitPackageCode
                                          .toString();
                                  policyNumberController.text =
                                      policylists[index].policyNo.toString();
                                  policyExpiryDateController.text =
                                      policylists[index].expiryDate.toString();
                                  idController.text = policylists[index].id;
                                  addEditInsurancePolicy();
                                },
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () async {
                                  print(policylists[index].id);
                                  var delete = await _showDeletePolicyDialog(
                                      policylists[index]
                                          .insuranceCompanyName
                                          .toString());
                                  if (delete == true) {
                                    ref
                                        .read(
                                            insurancePoliciesProvider.notifier)
                                        .deleteInsurancePolicy(
                                            policylists[index].id);
                                  }
                                },
                                icon: const Icon(Icons.delete)),
                          ],
                        ),
                      ));
                    })
                : const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(
                        'You do not have any Insurance Policy added yet. Click on the Add button to add an Insurance Policy',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
            error: (err, stack) => Text('Error: $err'),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                )));
  }

  addEditInsurancePolicy() {
    isEditing ? null : clearFormFields();
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          border: Border.all(color: Colors.deepPurple),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0))),
                      child: const Text(
                        'Enter Insurance Policy Details',
                        textScaleFactor: 1.25,
                        style: TextStyle(color: Colors.white),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      controller: insuranceCompanyNameController,
                      decoration: const InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          labelText: 'Insurance Company Name',
                          hintText:
                              'Enter your Insurance Company\'s Name here'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "An insurance company name must be provided";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      controller: policyNumberController,
                      decoration: const InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          labelText: 'Policy No',
                          hintText: 'Enter your Policy No here'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "A Policy No must be provided";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      controller: benefitPackageCodeController,
                      decoration: const InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          labelText: 'Benefit Package Code',
                          hintText: 'Enter your Benefit Package Code here'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "A Benefit Package Code must be provided";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      controller: benefitPackageNameController,
                      decoration: const InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          labelText: 'Benefit Package Name',
                          hintText: 'Enter your Benefit Package Name here'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "A Benefit Package Name must be provided";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      controller: policyStartDateController,
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () async {
                              var parsedDate = DateTime.tryParse(
                                  policyStartDateController.text);
                              if (parsedDate == null) {
                                initialDate = DateTime.now();
                              } else {
                                initialDate = parsedDate;
                              }

                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1910),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 365)),
                                  initialDate:
                                      initialDate); //DateTime.now() - not to allow to choose before today.
                              if (pickedDate != null) {
                                policyStartDateController.text =
                                    DateFormat("dd-MM-yyyy").format(pickedDate);
                              }
                            },
                            child: const Icon(Icons.calendar_month),
                          ),
                          isDense: true,
                          border: const OutlineInputBorder(),
                          labelText: 'Policy Start Date',
                          hintText:
                              'Enter your Policy Start Date here (dd-MM-yyyy)'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "A Policy Start Date must be provided";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      controller: policyExpiryDateController,
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () async {
                              var parsedDate = DateTime.tryParse(
                                  policyStartDateController.text);
                              if (parsedDate == null) {
                                initialDate = DateTime.now();
                              } else {
                                initialDate = parsedDate;
                              }

                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1910),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 1095)),
                                  initialDate: initialDate);
                              if (pickedDate != null) {
                                policyExpiryDateController.text =
                                    DateFormat("dd-MM-yyyy").format(pickedDate);
                              }
                            },
                            child: const Icon(Icons.calendar_month),
                          ),
                          isDense: true,
                          border: const OutlineInputBorder(),
                          labelText: 'Policy Expiry Date',
                          hintText:
                              'Enter your Policy Expiry Date here (dd-MM-yyyy)'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "A Policy Expiry Date must be provided";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: const BorderSide(
                                  width: 1.0,
                                  color: Colors.deepPurple,
                                )),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.deepPurple),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              var params = {};
                              params = {
                                "code": "trailcode",
                                "insuranceCompanyName":
                                    insuranceCompanyNameController.text,
                                "policyNo": policyNumberController.text,
                                "benefitPackageCode":
                                    benefitPackageCodeController.text,
                                "benefitPackageName":
                                    benefitPackageNameController.text,
                                "startDate": policyStartDateController.text,
                                "expiryDate": policyExpiryDateController.text,
                              };
                              if (isEditing) {
                                final status = <String, String>{
                                  "id": idController.text
                                };
                                params.addEntries(status.entries);
                              }
                              print(params);
                              isEditing
                                  ? ref
                                      .read(insurancePoliciesProvider.notifier)
                                      .updateInsurancePolicy(params)
                                  : ref
                                      .read(insurancePoliciesProvider.notifier)
                                      .addInsurancePolicy(params);
                              Navigator.pop(context);
                            },
                            child: const Text('Save')),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        });
  }

  void clearFormFields() {
    insuranceCompanyNameController.text = '';
    policyStartDateController.text = '';
    benefitPackageNameController.text = '';
    benefitPackageCodeController.text = '';
    policyNumberController.text = '';
    policyExpiryDateController.text = '';
  }

  _showDeletePolicyDialog(String policyName) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('Delete Insurance Policy'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Your are about to delete your Insurance Policy with $policyName. Click Confirm to delete or Cancel to exit'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                }),
          ],
        );
      },
    );
  }
}
