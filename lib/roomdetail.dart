import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'config.dart';
import 'room.dart';

class RoomDetail extends StatefulWidget {
  final Room room;
  const RoomDetail({Key? key, required this.room}) : super(key: key);

  @override
  _RoomDetailState createState() => _RoomDetailState();
}

class _RoomDetailState extends State<RoomDetail> {
  @override
  Widget build(BuildContext context) {
    List<String> imgList = [
      Config.server + "/images/" + widget.room.roomid! + "_1.jpg",
      Config.server + "/images/" + widget.room.roomid! + "_2.jpg",
      Config.server + "/images/" + widget.room.roomid! + "_3.jpg",
    ];

    if(widget.room.latitude?.isEmpty ?? true) {
      widget.room.latitude = "Unavailable";
    }
    if(widget.room.longitude?.isEmpty ?? true) {
      widget.room.longitude = "Unavailable";
    }

    late double screenHeight, screenWidth, resWidth;

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.70;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("ROOM DETAILS"),
      ),
      body: Center(
        child: SizedBox(
          width: resWidth * 2,
          height: screenHeight,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      widget.room.title!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: resWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      viewportFraction: 0.5,
                      enlargeCenterPage: true,
                    ),
                    items: imgList.map(
                      (item) => Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.network(
                            item,
                            fit: BoxFit.cover,),
                        )
                      ),
                    ).toList(),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    children: [
                      const Icon(Icons.description_sharp),
                      SizedBox(width: resWidth * 0.03),
                      Flexible(
                        child: Text(
                          widget.room.description!,
                          style: TextStyle(
                            fontSize: resWidth * 0.03,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    children: [
                      const Icon(Icons.phone),
                      SizedBox(width: resWidth * 0.03),
                      Flexible(
                        child: Text(
                          widget.room.contact!,
                          style: TextStyle(
                            fontSize: resWidth * 0.03,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    children: [
                      const Icon(Icons.sell),
                      SizedBox(width: resWidth * 0.03),
                      Flexible(
                        child: Text(
                          "RM " + widget.room.price! + " / month",
                          style: TextStyle(
                            fontSize: resWidth * 0.03,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    children: [
                      const Icon(Icons.attach_money_sharp),
                      SizedBox(width: resWidth * 0.03),
                      Flexible(
                        child: Text(
                          "RM " + widget.room.deposit! + " Deposit",
                          style: TextStyle(
                            fontSize: resWidth * 0.03,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    children: [
                      const Icon(Icons.location_pin),
                      SizedBox(width: resWidth * 0.03),
                      Flexible(
                        child: Text(
                          widget.room.state!,
                          style: TextStyle(
                            fontSize: resWidth * 0.03,
                          ),
                        ),
                      ),
                      SizedBox(width: resWidth * 0.3),
                      const Icon(Icons.location_city),
                      SizedBox(width: resWidth * 0.02),
                      Flexible(
                        child: Text(
                          widget.room.area!,
                          style: TextStyle(
                            fontSize: resWidth * 0.03,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    children: [
                      const Icon(Icons.location_searching),
                      SizedBox(width: resWidth * 0.02),
                      Flexible(
                        child: Text(
                          "Latitude: " + widget.room.latitude! + "     Longitude: " + widget.room.longitude!,
                          style: TextStyle(
                            fontSize: resWidth * 0.03,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    children: [
                      const Icon(Icons.post_add),
                      SizedBox(width: resWidth * 0.03),
                      Flexible(
                        child: Text(
                          "Posted: " + DateFormat('d MMM yyyy hh:mm a').format(widget.room.dateCreated!),
                          style: TextStyle(
                            fontSize: resWidth * 0.03,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}