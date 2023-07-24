import 'package:flutter/material.dart';

class RxButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final double? height, width;
  final VoidCallback onTap;
  //final Function onTap;
  const RxButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return InkWell(
        splashColor: const Color(0xFF3B4257),
        //onTap: widget.onSelect,
        onTap: onTap,
        child: Card(
            color: Colors.deepPurple[50],
            child: Container(
              height: height,
              width: width,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(5.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: width! * 0.30,
                    ),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(fontSize: width! * 0.17),
                    )
                  ]),
            )),
      );
    });
  }
}
