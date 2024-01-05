// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_local_variable, unused_element, use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For DateFormat

class Offer extends StatefulWidget {
  const Offer({super.key});

  @override
  State<Offer> createState() => _OfferState();
}

class _OfferState extends State<Offer> {
  TextEditingController destinationController = TextEditingController();
  TextEditingController startingPointController = TextEditingController();
  TextEditingController dateDepartureController = TextEditingController();
  TextEditingController numberOfPassengersController = TextEditingController();
  TextEditingController vehiculeController = TextEditingController();

  Future<void> postOffer() async {
    final url = Uri.parse('http://10.0.2.2:8080/offers/addOffer');
    final offer = {
      'destination': destinationController.text,
      'startingPoint': startingPointController.text,
      'dateDeparture': dateDepartureController.text,
      'numberOfPassengers': numberOfPassengersController.text,
      'vehicule': vehiculeController.text,
    };

    try {
      final response = await http.post(
        url,
        body: json.encode(offer),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Navigator.pop(context, true);
        resetFields();
        showSuccessDialog();
      } else {
        // Handle error cases
      }
    } catch (error) {
      // Handle exceptions or network errors
    }
  }

  void resetFields() {
    destinationController.clear();
    startingPointController.clear();
    dateDepartureController.clear();
    numberOfPassengersController.clear();
    vehiculeController.clear();
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success!'),
          content: Text('You\'ve got a new offer.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Initial date when calendar opens
      firstDate: DateTime(2000), // The earliest selectable date
      lastDate: DateTime(2101), // The latest selectable date
    );
    if (picked != null) {
      setState(() {
        DateTime? selectedDate;
        selectedDate = picked; // Update selected date if a new one is picked
        dateDepartureController.text = DateFormat('dd/MM/yyyy')
            .format(picked); // Set the text in the text field
      });
    }
  }

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
                controller: destinationController,
                decoration: InputDecoration(
                  hintText: 'Enter destination', // Placeholder text
                  border: InputBorder.none, // Remove input field border
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
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
                controller: startingPointController,
                decoration: InputDecoration(
                  hintText: 'Start point', // Placeholder text
                  border: InputBorder.none, // Remove input field border
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
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
                controller: dateDepartureController,
                decoration: InputDecoration(
                  hintText: 'DD/MM/YYYY D-Departure', // Placeholder text
                  border: InputBorder.none, // Remove input field border
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      _selectDate(
                          context); // Open the date picker when the calendar icon is tapped
                    },
                  ),
                ),
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
                controller: numberOfPassengersController,
                decoration: InputDecoration(
                  hintText: 'Passangers number', // Placeholder text
                  border: InputBorder.none, // Remove input field border
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
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
                  Icons.directions_car,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              Expanded(
                  child: TextField(
                controller: vehiculeController,
                decoration: InputDecoration(
                  hintText: 'Vehicule', // Placeholder text
                  border: InputBorder.none, // Remove input field border
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ))
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Flexible(
          child: ElevatedButton(
              onPressed: postOffer,
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
              )),
        )
      ],
    ));
  }
}
