// ignore_for_file: prefer_const_constructors, file_names, use_build_context_synchronously, deprecated_member_use, sized_box_for_whitespace

import 'dart:convert';

import 'package:covoituragefront/interfaces/widgets/getFeedback.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CheckOffer extends StatefulWidget {
  final dynamic offer;

  const CheckOffer({Key? key, required this.offer}) : super(key: key);

  @override
  State<CheckOffer> createState() => _CheckOfferState();
}

class _CheckOfferState extends State<CheckOffer> {
  TextEditingController feedbackController = TextEditingController();
  late int currentPassengerCount;

  @override
  void initState() {
    super.initState();
    currentPassengerCount = widget.offer['numberOfPassengers'];
  }

  bool _shouldRefreshfeedbacks = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _refreshOffersOnReturn();
  }

  void _refreshOffersOnReturn() {
    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    if (routeArgs != null && routeArgs is bool && routeArgs) {
      setState(() {
        _shouldRefreshfeedbacks = true;
      });
    }
  }

  void resetFields() {
    feedbackController.clear();
  }

  void updateFeedbackList() {
    // Triggering a fetch of updated feedback list in getFeedback class
    setState(() {
      _shouldRefreshfeedbacks = true;
    });
  }

  Future<void> postFeedback() async {
    final url = Uri.parse(
        'http://10.0.2.2:8080/feed/addFeedback?id_offer=${widget.offer['id']}');
    final feedback = {
      'feedback': feedbackController.text,
    };

    try {
      final response = await http.post(
        url,
        body: json.encode(feedback),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        resetFields();
        showSuccessDialog();
        updateFeedbackList();
      } else {
        // Handle error cases
      }
    } catch (error) {
      // Handle exceptions or network errors
    }
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success!'),
          content: Text('You\'ve got a new feedback.'),
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

  @override
  Widget build(BuildContext context) {
    dynamic offer = widget.offer;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 16),
              Center(
                child: Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow('Destination:', offer['destination']),
                        _buildInfoRow('Date Departure:',
                            offer['dateDeparture'].toString()),
                        _buildInfoRow(
                            'Starting Point:', offer['startingPoint']),
                        _buildInfoRow('Passenger Number:',
                            offer['numberOfPassengers'].toString()),
                        _buildInfoRow('vehicule:', offer['vehicule']),
                        _buildInfoRow('price:', offer['price'].toString()),
                        _buildInfoRow('mail:', offer['user']['email']),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(children: [
                SizedBox(
                  width: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    _updatePassengerCount(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: Color(0xFF471AA0),
                  ),
                  child: SizedBox(
                      width: 80,
                      height: 30,
                      child: Center(
                        child: Text(
                          'Book now ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  width: 10,
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
                      width: 80,
                      height: 30,
                      child: Center(
                        child: Text(
                          'message',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                ),
              ]),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 300,
                height: 165,
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Feedback:',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Flexible(
                        child: TextFormField(
                          controller: feedbackController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Type your feedback here...',
                          ),
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          onChanged: (value) {
                            // Handle the feedback input here
                          },
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      ElevatedButton(
                        onPressed: postFeedback,
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF9747FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: Size(
                              80, 30), // Set your desired width and height here
                        ),
                        child: Text(
                          'Send',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 150,
                width:
                    300, // Adjust the height according to your UI requirements
                child: getFeedback(
                    offer: offer, shouldRefresh: _shouldRefreshfeedbacks),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updatePassengerCount(BuildContext context) async {
    int passengerCount = currentPassengerCount; // Default value if null

    int? newPassengerCount = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Passenger Count'),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              passengerCount = int.tryParse(value) ?? currentPassengerCount;
            },
            decoration: InputDecoration(
              labelText: 'New Passenger Count',
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(passengerCount);
              },
              child: Text('OK'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(currentPassengerCount);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );

    if (newPassengerCount != null) {
      final response = await http.put(
        Uri.parse(
            'http://10.0.2.2:8080/offers/${widget.offer['id']}/bookSeat?bookedSeats=$newPassengerCount'),
      );

      if (response.statusCode == 200) {
        // Handle successful update
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        int updatedPassengerCount = jsonResponse['numberOfPassengers'];

        setState(() {
          currentPassengerCount = updatedPassengerCount;
          widget.offer['numberOfPassengers'] =
              updatedPassengerCount; // Update the displayed value
        });
      } else if (response.statusCode == 400) {
        // Handling the case where there aren't enough available seats
        // Show an error message to the user
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('we are sorry'),
              content: Text('Not enough available seats'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Handle other errors
      }
    }
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
          Text(
            value,
            style: TextStyle(
                color: Color(0xFF471AA0),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
