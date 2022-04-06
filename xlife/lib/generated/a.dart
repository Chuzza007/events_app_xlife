import 'package:flutter/material.dart';

class A extends StatefulWidget {
  A({Key? key}) : super(key: key);

  @override
  _AState createState() => _AState();
  @override
  // TODO: implement key
  Key? get key {
    return super.key;
  }

}

class _AState extends State<A> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
