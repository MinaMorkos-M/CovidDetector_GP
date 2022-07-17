import 'package:covid_19_detector/business_logic_layer/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text('About'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              ListTile(
                leading: Image.asset('assets/images/Logo2.jpg'),
                title: Text(APP_NAME),
                subtitle: Text(APP_VERSION),
                trailing: IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {
                    showAboutDialog(
                      context: context,
                      applicationName: APP_NAME,
                      applicationVersion: APP_VERSION,
                      applicationIcon: Image.asset(
                        'assets/images/Logo2.jpg',
                        height: 64,
                        width: 64,
                      ),
                      children: [
                        Text(APP_DESCRIPTION),
                      ],
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Text(APP_DESCRIPTION),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.code),
                title: Text('Source code on GitHub'),
                onTap: () => url_launcher.launch(GITHUB_URL),
              )
            ],
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: 10,
                ),
                child: Text(
                  'Supervised By',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.1,
                ),
                child: Text(
                  'Dr. Ali Zidane \n TA. Mona Khamis \n TA. Nesma Mostafa',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
