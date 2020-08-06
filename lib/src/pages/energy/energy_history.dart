import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'energy_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;

class LineChart extends StatelessWidget {
  // Defining the data
  final data = [
    new EnergyData(0, 15000),
    new EnergyData(1, 17350),
    new EnergyData(2, 16780),
    new EnergyData(3, 18900),
    new EnergyData(4, 19070),
    new EnergyData(5, 23000),
    new EnergyData(6, 23600),
    new EnergyData(7, 19800),
    new EnergyData(8, 26540),
    new EnergyData(9, 27890),
    new EnergyData(10, 30200),
    new EnergyData(11, 32459),
    new EnergyData(12, 40985),
    new EnergyData(13, 45000),
    new EnergyData(14, 44565),
  ];

  _getSeriesData() {
    List<charts.Series<EnergyData, int>> series = [
      charts.Series(
          id: "Sales",
          data: data,
          domainFn: (EnergyData series, _) => series.day,
          measureFn: (EnergyData series, _) => series.energy,
          colorFn: (EnergyData series, _) =>
              charts.MaterialPalette.blue.shadeDefault)
    ];
    return series;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500,
        padding: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: new charts.LineChart(
                  _getSeriesData(),
                  animate: true,
                ),
              )
            ],
          ),
        ));
  }
}
