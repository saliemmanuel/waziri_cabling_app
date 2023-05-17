import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waziri_cabling_app/desktop/screen/home/widget/shimmer_table.dart';
import 'package:waziri_cabling_app/models/users.dart';

import '../../../../config/config.dart';
import '../../../../global_widget/accueil_card.dart';
import '../provider/home_provider.dart';
import '../widget/app_header.dart';
import '../widget/table_type_abonnement.dart';

class Comptabilite extends StatelessWidget {
  final Users users;
  const Comptabilite({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    Provider.of<HomeProvider>(context, listen: false)
        .provideListeTypeAbonnement();
    List<_SalesData> data = [
      _SalesData('Jan', 12),
      _SalesData('Fev', 2),
      _SalesData('Mars', 6),
      _SalesData('Avr', 25),
      _SalesData('Mai', 0),
      // _SalesData('Juin', 7),
      // _SalesData('Juil', 5),
      // _SalesData('Août', 9),
      // _SalesData('Sept', 6),
      // _SalesData('Oct', 2),
      // _SalesData('Nov', 45),
      // _SalesData('Déc', 40),
    ];
    var data2 = [
      _ChartData('Janvier', 12),
      _ChartData('Fevrier', 0),
    ];
    return Scaffold(
      backgroundColor: Palette.scaffold,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Palette.backgroundColor,
            borderRadius: BorderRadius.circular(10.0)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              appHeader("Comptabilité"),
              Container(
                height: 350.0,
                margin: const EdgeInsets.only(
                    top: 20.0, left: 40.0, right: 40.0, bottom: 20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18.0)),
                child: Row(
                  children: [
                    Expanded(
                        child: SfCircularChart(
                            title: ChartTitle(
                                text: 'Analyse des nombres d\'abonnement'),
                            legend: Legend(isVisible: true),
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: [
                          DoughnutSeries<_ChartData, String>(
                              dataSource: data2,
                              xValueMapper: (_ChartData data, _) => data.x,
                              yValueMapper: (_ChartData data, _) => data.y,
                              name: 'Gold')
                        ])),
                    Expanded(
                      child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          title: ChartTitle(text: 'Analyse des activités'),
                          legend: Legend(isVisible: true),
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<_SalesData, String>>[
                            LineSeries<_SalesData, String>(
                                dataSource: data,
                                xValueMapper: (_SalesData sales, _) =>
                                    sales.year,
                                yValueMapper: (_SalesData sales, _) =>
                                    sales.sales,
                                name: 'Tandence',
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true))
                          ]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 40.0, right: 40.0, bottom: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(spacing: 18.0, runSpacing: 18.0, children: const [
                    AccueilCard(containerColor: Colors.yellow),
                    AccueilCard(containerColor: Colors.pink),
                    AccueilCard(containerColor: Colors.blueGrey),
                    AccueilCard(containerColor: Colors.teal),
                  ]),
                ),
              ),
              Container(
                height: 350.0,
                margin: const EdgeInsets.only(
                    top: 20.0, left: 40.0, right: 40.0, bottom: 20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18.0)),
                child: Row(
                  children: [
                    Expanded(
                        child: SfCircularChart(
                            title: ChartTitle(
                                text: 'Analyse des nombres d\'abonnement'),
                            legend: Legend(isVisible: true),
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: [
                          DoughnutSeries<_ChartData, String>(
                              dataSource: data2,
                              xValueMapper: (_ChartData data, _) => data.x,
                              yValueMapper: (_ChartData data, _) => data.y,
                              name: 'Gold')
                        ])),
                    Expanded(
                      child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          title: ChartTitle(text: 'Analyse des activités'),
                          legend: Legend(isVisible: true),
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<_SalesData, String>>[
                            LineSeries<_SalesData, String>(
                                dataSource: data,
                                xValueMapper: (_SalesData sales, _) =>
                                    sales.year,
                                yValueMapper: (_SalesData sales, _) =>
                                    sales.sales,
                                name: 'Sales',
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true))
                          ]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 40.0, right: 40.0, bottom: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(spacing: 18.0, runSpacing: 18.0, children: const [
                    AccueilCard(containerColor: Colors.yellow),
                    AccueilCard(containerColor: Colors.pink),
                    AccueilCard(containerColor: Colors.blueGrey),
                    AccueilCard(containerColor: Colors.teal),
                  ]),
                ),
              ),
              Container(
                height: 350.0,
                margin: const EdgeInsets.only(
                    top: 20.0, left: 40.0, right: 40.0, bottom: 20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18.0)),
                child: Consumer<HomeProvider>(builder: (context, value, child) {
                  return value.listTypeAbonnement == null
                      ? const ShimmerTable()
                      : TableTypeAbonnement(
                          users: users,
                          listTypeAbonnement: value.listTypeAbonnement);
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 40.0, right: 40.0, bottom: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(
                      spacing: 18.0,
                      runSpacing: 18.0,
                      children: List.generate(
                        4,
                        (index) => const AccueilCard(
                          containerColor: Colors.teal,
                        ),
                      )),
                ),
              ),
              const SizedBox(height: 50.0)
            ],
          ),
        ),
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
