class Sensor {
  double altitude;
  double longitude;
  double latitude;
  double bpm;
  double bpmSensor;
  double dhtSensor;
  double battery;
  double hrv;
  double heartbeat;
  double spo2;
  double stress;
  double steps;
  double temperature;
  double device;
  double humidity;

  Sensor({
    required this.altitude,
    required this.longitude,
    required this.latitude,
    required this.bpm,
    required this.bpmSensor,
    required this.dhtSensor,
    required this.battery,
    required this.hrv,
    required this.heartbeat,
    required this.spo2,
    required this.stress,
    required this.steps,
    required this.temperature,
    required this.device,
    required this.humidity,
  });
  // factory Sensor.fromJson(Map<String, dynamic> json) {
  //   return Sensor(
  //       steps: json["Steps"],
  //       bpmSensor: json["BPM Sensor"],
  //       temperature: json["Temperature"],
  //       device: json["Device"],
  //       spo2: json["SPO2"],
  //       latitude: json["Latitude"],
  //       hrv: json["HRV"],
  //       longitude: json["Longitude"],
  //       stress: json["Stress"],
  //       battery: json["Battery"],
  //       heartbeat: json["Heartbeat"],
  //       humidity: json["Humidity"],
  //       dhtSensor: json["DHT Sensor"],
  //       bpm: json["BPM"],
  //       altitude: json["Altitude"]);

    // altitude: json["altitude"],
    // longitude: json["longitude"],
    // latitude: json["latitude"],
    // bpm: json["bpm"],
    // bpmSensor: json["bpmSensor"],
    // dhtSensor: json["dhtSensor"],
    // battery: json["battery"],
    // hrv: json["hrv"],
    // heartbeat: json["heartbeat"],
    // spo2: json["spo2"],
    // stress: json["stress"],
    // steps: json["steps"],
    // temperature: json["temperature"],
    // device: json["device"],
    // humidity: json["humidity"]);
  // }
}
