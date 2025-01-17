import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global/global.dart';
import '../infoHandler/app_info.dart';
import '../screens/trips_history_screen.dart';

class EarningsTabPage extends StatefulWidget {
  const EarningsTabPage({Key? key}) : super(key: key);

  @override
  State<EarningsTabPage> createState() => _EarningsTabPageState();
}

class _EarningsTabPageState extends State<EarningsTabPage> {
  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      color: Colors.green,
      child: Column(
        children: [
          //earnings
          Container(
            color: darkTheme ? Colors.black : Colors.white,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 80),
              child: Column(
                children: [
                  Text(
                    "your Earnings:",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 10,),

                  Text(
                    "2300" ,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //Total Number of trips
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> TripsHistoryScreen()));
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white54
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  Image.asset(
                    onlineDriverData.car_type == "Car" ? "images/Car.png"
                        : onlineDriverData.car_type == "CNG" ? "images/CNG.png"
                        : "images/Bike.png",
                    scale: 2,
                  ),

                  SizedBox(width: 10,),

                  Text(
                    "Trips Completed",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),

                  Expanded(
                    child: Container(
                      child: Text(
                        "15",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            )
          )

        ],
      ),
    );
  }
}
