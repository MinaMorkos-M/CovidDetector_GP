import 'package:flutter/material.dart';

class MapBottomBar extends StatefulWidget {
  @override
  _MapBottomBarState createState() => _MapBottomBarState();
}

class _MapBottomBarState extends State<MapBottomBar> {
  final bool _isBottomBarNotched = false;

  final ButtonStyle againButton = ElevatedButton.styleFrom(
    primary: Colors.grey[500],
    elevation: 5,
    minimumSize: Size(88, 50),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
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
              Icons.menu,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 50),
                            child: ElevatedButton(
                              style: againButton,
                              child: Text(
                                'Hospital',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              onPressed: () {
                                setState(() {});
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 50),
                            child: ElevatedButton(
                              style: againButton,
                              child: Text(
                                'Pharmacy',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              onPressed: () {
                                setState(() {});
                              },
                            ),
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
