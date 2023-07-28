import 'package:flutter/material.dart';

class GenderSelector extends StatefulWidget {
  final Function(String) onSelect;
  final List genders;
  final int? selectedGenderIndex;
  const GenderSelector(
      {super.key,
      required this.onSelect,
      required this.genders,
      this.selectedGenderIndex});

  @override
  GenderSelectorState createState() => GenderSelectorState();
}

class GenderSelectorState extends State<GenderSelector> {
  //List<Gender> genders = <Gender>[];

  @override
  void initState() {
    super.initState();
    setInitialGender(widget.selectedGenderIndex);
  }

  void setInitialGender(int? initialIndex) {
    if (initialIndex != null) {
      widget.genders[initialIndex].isSelected = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: widget.genders.length,
          itemBuilder: (context, index) {
            return InkWell(
              splashColor: const Color(0xFF3B4257),
              //onTap: widget.onSelect,
              onTap: () {
                setState(() {
                  for (var gender in widget.genders) {
                    gender.isSelected = false;
                  }
                  widget.genders[index].isSelected = true;
                  widget.onSelect(widget.genders[index].name);
                });
              },
              child: CustomRadio(widget.genders[index]),
            );
          }),
    );
  }
}

class CustomRadio extends StatelessWidget {
  final Gender _gender;

  const CustomRadio(this._gender, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: _gender.isSelected ? Colors.deepPurple : Colors.white,
        child: Container(
          height: 80,
          width: 80,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                _gender.icon,
                color: _gender.isSelected ? Colors.white : Colors.grey,
                size: 40,
              ),
              const SizedBox(height: 10),
              Text(
                _gender.name,
                style: TextStyle(
                    color: _gender.isSelected ? Colors.white : Colors.grey),
              )
            ],
          ),
        ));
  }
}

class Gender {
  String name;
  IconData icon;
  bool isSelected;

  Gender(this.name, this.icon, this.isSelected);
}
