import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ratting extends StatefulWidget {
  final double rating;
  const Ratting({super.key, required this.rating});
  @override
  State<Ratting> createState() => _CardRatting();

}

class _CardRatting extends State<Ratting> {

  @override
  Widget build(BuildContext context) {
    double myNumber = widget.rating;
    double remainder = myNumber % 1;
    if(remainder >0.5){
      myNumber = myNumber +1;
    }
    List<Widget> stars = [];
    for (int i = 0; i < myNumber-1; i++) {
      stars.add(
        const Icon(Icons.star, color: Colors.yellow, size: 15,),
      );
    }
    if(remainder <= 0.5 && myNumber != 0 ){
      stars.add(
        const Icon(Icons.star_half, color: Colors.yellow, size: 15,),
      );
    }
    for (int i = 0; i <= 4 - myNumber; i++) {
      stars.add(
        const Icon(Icons.star_border, color: Colors.yellow, size: 15,),
      );
    }
    return Row(
        children: stars
    );
  }
}