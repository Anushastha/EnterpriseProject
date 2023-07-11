import 'package:flutter/material.dart';

class DataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DataPoint('Altitude', '0'),
              DataPoint('BPM', '0'),
              DataPoint('BPM Sensor', '1'),
              DataPoint('Battery', '0'),
              DataPoint('DHT Sensor', '1'),
              DataPoint('Device', '1'),
              DataPoint('HRV', '0'),
              DataPoint('Heartbeat', '0'),
              DataPoint('Humidity', '0'),
              DataPoint('Latitude', '28.2152083'),
              DataPoint('Longitude', '83.956615'),
              DataPoint('SPO2', '0'),
              DataPoint('Steps', '1'),
              DataPoint('Stress', '71.158425273'),
              DataPoint('Temperature', '0'),
            ],
          ),
        ),
      ),
    );
  }
}

class DataPoint extends StatelessWidget {
  final String label;
  final String value;

  DataPoint(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DataScreen(),
              ),
            );
          },
          child: Text('Show Data'),
        ),
      ),
    );
  }
}
