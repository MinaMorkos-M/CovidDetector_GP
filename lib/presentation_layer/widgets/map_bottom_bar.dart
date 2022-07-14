import 'package:covid_19_detector/presentation_layer/screens/nearest%20hospital%20&%20pharmacy/nearest_hospital_map.dart';
import 'package:covid_19_detector/presentation_layer/screens/nearest%20hospital%20&%20pharmacy/nearest_pharmacy_map.dart';
import 'package:flutter/material.dart';

class MapBottomBar extends StatefulWidget {
  @override
  _MapBottomBarState createState() => _MapBottomBarState();
}

class _MapBottomBarState extends State<MapBottomBar> {
  final bool _isBottomBarNotched = false;
  bool noneButton = true;
  bool hospitalButton = false;
  bool pharmacyButton = false;

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    primary: Colors.grey[500],
    elevation: 5,
    minimumSize: Size(88, 50),
    textStyle: TextStyle(
      color: Colors.black,
    ),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30),
      ),
    ),
  );


  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: this._isBottomBarNotched ? const CircularNotchedRectangle() : null,
      color: Theme.of(context).primaryColor,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.local_hospital_outlined,
              color: Colors.white,
            ),
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (BuildContext context) => Container(
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Find Nearest',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.local_hospital,
                            ),
                            title: Text('Hospital'),
                            trailing: Icon(Icons.keyboard_arrow_right_sharp),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NearestHospitalMap(
                                  ),
                                ),
                              );
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.local_pharmacy,
                            ),
                            title: Text('Pharmacy'),
                            trailing: Icon(Icons.keyboard_arrow_right_sharp),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NearestPharmacyMap(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
