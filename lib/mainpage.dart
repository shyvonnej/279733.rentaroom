import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'room.dart';
import 'roomdetail.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List roomList = [];
  String results = "Found: ";
  int numRooms = 0;

  @override
  void initState() {
    super.initState();
    _loadRooms();
  }

  @override
  Widget build(BuildContext context) {
    late double screenHeight, screenWidth, resWidth;
    late int gridCount;

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= 600) {
      resWidth = screenWidth;
      gridCount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      gridCount = 3;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Rent A Room"),
      ),
      body: Center(
        child: SizedBox(
          width: resWidth * 2,
          height: screenHeight,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  "Available Rooms To Rent",
                  style: TextStyle(
                    fontSize: resWidth * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Text(
                  results + numRooms.toString(),
                  style: TextStyle(
                    fontSize: resWidth * 0.04,
                  ),
                ),
                SizedBox(height: screenHeight * 0.035),
                Expanded(
                  child: GridView.count(
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    crossAxisCount: gridCount,
                    children: List.generate(
                      numRooms,
                      (index) {
                        return SingleChildScrollView(
                          child: Card(elevation: 5,
                            child: InkWell(
                              onTap: (() => {_roomDetails(index),}),
                              child: Container(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(roomList[index]['title'].toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: resWidth * 0.045,fontWeight: FontWeight.bold,color: const Color(0xFF2962FF),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.020),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "[MONTHLY] RM " + roomList[index]['price'],
                                            style: TextStyle(fontSize: resWidth * 0.030,),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "[DEPOSIT] RM " + roomList[index]['deposit'],
                                            style: TextStyle(fontSize: resWidth * 0.030,),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            roomList[index]['area'] + ", " + roomList[index]['state'],
                                            style: TextStyle(fontSize: resWidth * 0.030,),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _loadRooms() {
    http.post(Uri.parse(Config.server + "/php/load_rooms.php")).then((response) {
      if (response.statusCode == 200 && response.body != "failed") {
        var parsedJson = json.decode(response.body);
        roomList = parsedJson['data']['rooms'];
        
        setState(() {
          numRooms = roomList.length;
        });
        
      } else {
        setState(() {
          results = "0";
        });
      }
    });
  }

  _roomDetails(int index) async {
    Room room = Room(
      roomid: roomList[index]['roomid'],
      contact: roomList[index]['contact'],
      title: roomList[index]['title'],
      description: roomList[index]['description'],
      price: roomList[index]['price'],
      deposit: roomList[index]['deposit'],
      state: roomList[index]['state'],
      area: roomList[index]['area'],
      dateCreated: DateTime.tryParse(roomList[index]['date_created']),
      latitude: roomList[index]['latitude'],
      longitude: roomList[index]['longitude'],
    );

    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RoomDetail(room: room))
      );
}
}