// ignore_for_file: prefer_const_constructors, sort_child_properties_last, deprecated_member_use, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetOffers extends StatefulWidget {
  @override
  _GetOffersState createState() => _GetOffersState();
}

class _GetOffersState extends State<GetOffers> {
  List<dynamic> offers = [];

  @override
  void initState() {
    super.initState();
    fetchAllOffers();
  }

  Future<void> fetchAllOffers() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8080/offers/getOffer'));

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Listen for a signal from the Offer page to refresh data
    _refreshOffersOnReturn(context);
  }

  void _refreshOffersOnReturn(BuildContext context) {
    // Listen for a signal sent from the Offer page to refresh data
    final didCreateOffer = ModalRoute.of(context)?.settings.arguments as bool?;
    if (didCreateOffer != null && didCreateOffer) {
      // If a new offer was created, refresh the list of offers
      fetchAllOffers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: offers.isEmpty
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                await fetchAllOffers(); // Refresh offers on pull down
              },
              child: ListView.builder(
                itemCount: offers.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildSingleOfferContainer(offers[index]);
                },
              ),
            ),
    );
  }

  Widget buildSingleOfferContainer(dynamic offer) {
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
            '${offer['startingPoint']} -> ${offer['destination']}', // Display offer index numerically
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
