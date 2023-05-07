import 'package:flutter/material.dart';

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Icon(Icons.abc),
              Container(
                child: Text(''),
              ),
            ],
          ),
          Column(
            children: [
              Icon(Icons.abc),
              Container(
                child: Text(''),
              ),
            ],
          ),
          Column(
            children: [
              Icon(Icons.abc),
              Container(
                child: Text(''),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
