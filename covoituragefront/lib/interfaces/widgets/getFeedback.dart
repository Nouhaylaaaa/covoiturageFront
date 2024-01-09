// ignore_for_file: prefer_const_constructors, camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class getFeedback extends StatefulWidget {
  final dynamic offer;
  final bool shouldRefresh;
  final Function()? onRefreshFeedbackList;

  const getFeedback({
    Key? key,
    required this.offer,
    required this.shouldRefresh,
    this.onRefreshFeedbackList,
  }) : super(key: key);

  @override
  State<getFeedback> createState() => _getFeedbackState();
}

class _getFeedbackState extends State<getFeedback> {
  List<dynamic> feedbackList = [];

  @override
  void initState() {
    super.initState();
    fetchFeedback();
  }

  @override
  void didUpdateWidget(covariant getFeedback oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldRefresh) {
      fetchFeedback();
      widget.onRefreshFeedbackList?.call();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchFeedback();
  }

  Future<void> fetchFeedback() async {
    try {
      final idOffer = widget.offer['id'];
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/feed/getfeedback?id_offer=$idOffer'),
      );

      if (response.statusCode == 200) {
        setState(() {
          feedbackList = json.decode(response.body);
        });
      } else {
        // Handle error cases
      }
    } catch (error) {
      // Handle exceptions or network errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await fetchFeedback(); // Refresh offers on pull down
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: feedbackList.length,
                itemBuilder: (BuildContext context, int index) {
                  dynamic feedback = feedbackList[index];
                  String userName = feedback['user']['username'];
                  String feedbackMessage = feedback['feedback'];

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(userName),
                      subtitle: Text(feedbackMessage),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
