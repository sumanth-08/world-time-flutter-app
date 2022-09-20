import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    print(data);

    String bgImage = data['isDayTime'] ? 'day.jpg' : 'night.jpg';
    Color? bgColor = data['isDayTime'] ? Colors.blue[400] : Colors.blue[900];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
              )

            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 250.0, 0, 0),
              child: Column(
                children: [
                  FlatButton.icon(
                      onPressed: () async {
                       dynamic result = await Navigator.pushNamed(context, '/location');
                       setState(() {
                         data = {
                           'time' : result['time'],
                           'location' : result['location'],
                           'isDayTime' : result['isDayTime'],
                           'flag' : result['flag']
                         };
                       });
                      },
                      icon: Icon(
                        Icons.edit_location,
                        color: Colors.white,),
                      label: Text('Edit Location',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0
                      ),),

                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(data['location'],
                      style: TextStyle(
                        fontSize: 32.0,
                        letterSpacing: 2.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),),

                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Text(data['time'],
                    style: TextStyle(
                      fontSize: 66.0,
                      color: Colors.white,

                    ),)
                ],
              ),
            ),
          )
      ),
    );
  }
}
