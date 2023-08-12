import 'package:flutter/material.dart';
import 'package:state_play/src/widgets/cylinder.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () => alertFormAddCylinder(context),
                    icon: const Icon(Icons.add_box_outlined)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                )
              ],
            ),
            CylinderWidget()
          ],
        ),
      ),
    ));
  }

  Widget spaceHeightForm(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.012,
    );
  }

  Future alertFormAddCylinder(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: const EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: _formInserData(context),
            ),
          ));

  Widget _formInserData(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(
            'Nombre',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.018,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Cilindro 1'),
          ),
          spaceHeightForm(context),
          Text(
            'Peso: 40 Lib',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.018,
              fontWeight: FontWeight.w600,
            ),
          ),
          const TextField(
            decoration: InputDecoration(hintText: '40'),
          ),
          spaceHeightForm(context),
          Text(
            'Precio',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.018,
              fontWeight: FontWeight.w600,
            ),
          ),
          const TextField(
            decoration: InputDecoration(hintText: '72.000'),
          ),
          spaceHeightForm(context),
          ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF448AFF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              child: const Text(
                'Agregar Cilindro',
                style: TextStyle(fontWeight: FontWeight.w600),
              ))
        ],
      ),
    );
  }
}
