import 'package:covid_19_detector/widgets/account_settings_text.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool infectedSwitchValue = false;
  bool darkSwitchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Infected mode'),
            trailing: Switch(
              activeTrackColor: Colors.blue[900],
              value: this.infectedSwitchValue,
              onChanged: (bool value) {
                setState(() {
                  this.infectedSwitchValue = value;
                });
              },
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Dark mode'),
            trailing: Switch(
              activeTrackColor: Colors.blue[900],
              value: this.darkSwitchValue,
              onChanged: (bool value) {
                setState(() {
                  this.darkSwitchValue = value;
                });
              },
            ),
          ),
          Divider(),
          AccountSettingsText(),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: Icon(
                Icons.account_circle,
                color: Colors.black,
                size: 34,
              ),
            ),
            trailing: Icon(Icons.edit),
            title: Text('Name'),
            subtitle: Text('Mina morkos'),
            //onTap: () => ,
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: Icon(
                Icons.location_city,
                color: Colors.black,
                size: 34,
              ),
            ),
            trailing: Icon(Icons.edit),
            title: Text('City'),
            subtitle: Text('Cairo'),
            //onTap: () => ,
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: Icon(
                Icons.map,
                color: Colors.black,
                size: 34,
              ),
            ),
            trailing: Icon(Icons.edit),
            title: Text('Country'),
            subtitle: Text('Egypt'),
            //onTap: () => ,
          ),
        ],
      ),
    );
  }
}
