// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';

class Offer extends StatefulWidget {
  const Offer({super.key});

  @override
  State<Offer> createState() => _OfferState();
}

class _OfferState extends State<Offer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            width: 380,
            height: 150,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: AssetImage('lib/interfaces/images/purple.jpg'),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 320,
          height: 50,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2, color: Color(0xFF9747FF)),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.location_city,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              Expanded(
                  child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter destination', // Placeholder text
                  border: InputBorder.none, // Remove input field border
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
                onChanged: (value) {},
              ))
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 320,
          height: 50,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2, color: Color(0xFF9747FF)),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.location_on,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              Expanded(
                  child: TextField(
                decoration: InputDecoration(
                  hintText: 'Start point', // Placeholder text
                  border: InputBorder.none, // Remove input field border
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
                onChanged: (value) {},
              ))
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 320,
          height: 50,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2, color: Color(0xFF9747FF)),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.date_range,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              Expanded(
                  child: TextField(
                decoration: InputDecoration(
                  hintText: 'DD/MM/YYYY D-Departure', // Placeholder text
                  border: InputBorder.none, // Remove input field border
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
                onChanged: (value) {
                  // Handle entered date value
                },
              ))
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 320,
          height: 50,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2, color: Color(0xFF9747FF)),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.group,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              Expanded(
                  child: TextField(
                decoration: InputDecoration(
                  hintText: 'Passangers number', // Placeholder text
                  border: InputBorder.none, // Remove input field border
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
                onChanged: (value) {
                  // Handle entered date value
                },
              ))
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: Color(0xFF471AA0),
            ),
            child: SizedBox(
              width: 140,
              height: 50,
              child: Center(
                child: Text(
                  'Post',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ))
      ],
    ));
  }
}
