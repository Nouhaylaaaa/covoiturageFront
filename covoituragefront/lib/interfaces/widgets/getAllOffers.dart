// ignore_for_file: prefer_const_constructors, sort_child_properties_last, deprecated_member_use, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print, file_names

import 'package:covoituragefront/interfaces/pages/checkOfferPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetOffers extends StatefulWidget {
  final bool shouldRefresh;

  const GetOffers({Key? key, required this.shouldRefresh}) : super(key: key);
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
  void didUpdateWidget(covariant GetOffers oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldRefresh) {
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckOffer(offer: offer),
                ),
              );
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
