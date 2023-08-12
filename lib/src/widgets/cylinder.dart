import 'package:flutter/material.dart';

class CylinderWidget extends StatelessWidget {
  const CylinderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.18,
      width: MediaQuery.of(context).size.width * 0.22,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.15,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    border: Border.all(width: 1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    border: Border.all(width: 0.8),
                    borderRadius: BorderRadius.circular(20)),
              )
            ],
          )
        ],
      ),
    );
  }
}
