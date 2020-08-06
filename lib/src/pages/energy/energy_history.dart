import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'energy_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;

class LineChart extends StatelessWidget {
  // Defining the data - L00PPY energyConsumption
  final data = [
    new EnergyData(0, 5000),
    new EnergyData(1, 5350),
    new EnergyData(2, 5780),
    new EnergyData(3, 5900),
    // new EnergyData(4, 5070),
    // new EnergyData(5, 5000),
    // new EnergyData(6, 5600),
    // new EnergyData(7, 4800),
    // new EnergyData(8, 5540),
    // new EnergyData(9, 5890),
    // new EnergyData(10, 5200),
    // new EnergyData(11, 5459),
    // new EnergyData(12, 5985),
    // new EnergyData(13, 5000),
    // new EnergyData(14, 5565),
  ];

  _getSeriesData() {
    List<charts.Series<EnergyData, int>> series = [
      charts.Series(
          id: "Sales",
          data: data,
          domainFn: (EnergyData series, _) => series.day,
          measureFn: (EnergyData series, _) => series.energy,
          colorFn: (EnergyData series, _) =>
              charts.MaterialPalette.purple.shadeDefault)
    ];
    return series;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
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
