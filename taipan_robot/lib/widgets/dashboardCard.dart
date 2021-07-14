import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  StatusCard(this.icn, this.line1);
  final IconData icn;
  final String line1;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.grey[20],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icn,
            color: Colors.amberAccent,
            size: 80,
          ),
          Text(
            line1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
