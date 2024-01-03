// ignore_for_file: prefer_const_constructors, sort_child_properties_last, deprecated_member_use, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables, file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OfferScreen extends StatefulWidget {
  final String destination;

  OfferScreen({required this.destination});

  @override
  _OfferScreenState createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  List<dynamic> offers = [];

  @override
  void initState() {
    super.initState();
    fetchOffers();
  }

  Future<void> fetchOffers() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8080/offers/offersByDestination?destination=${widget.destination}'));

    if (response.statusCode == 200) {
      setState(() {
        offers = json.decode(response.body);
      });
    } else {
      // Handle error cases
      print('Failed to load offers');
    }
  }

  @override
  Widget build(BuildContext context) {
    return offers.isEmpty
        ? Center(child: CircularProgressIndicator())
        : Expanded(
            child: ListView.builder(
              itemCount: offers.length,
              itemBuilder: (BuildContext context, int index) {
                return buildSingleOfferContainer(offers[index], index);
              },
            ),
          );
  }

  Widget buildSingleOfferContainer(dynamic offer, int index) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Offer ', // Display offer index numerically
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Add functionality for the 'Check' button here
            },
            child: Text(
              'Check',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF9747FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
