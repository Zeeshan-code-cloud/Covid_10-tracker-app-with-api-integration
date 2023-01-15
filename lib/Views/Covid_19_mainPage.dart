import 'dart:async';
import 'package:covid_19_tracker/utils/World_Recods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import '../Models/API_Models.dart';
import 'countries_list.dart';

class Covid_19_main extends StatefulWidget {
  const Covid_19_main({Key? key}) : super(key: key);

  @override
  State<Covid_19_main> createState() => _Covid_19_mainState();
}

class _Covid_19_mainState extends State<Covid_19_main>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 4),
      animationBehavior: AnimationBehavior.normal,
      vsync: this)
    ..repeat();

  FetchWorldRecord fetchWorldRecord = FetchWorldRecord();

  final colorlist = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              FutureBuilder(
                  future: fetchWorldRecord.getRecord(),
                  builder: (BuildContext context,
                      AsyncSnapshot<ApiModels> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 60.0,
                          duration: const Duration(seconds: 2),
                          controller: _controller,
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          PieChart(
                              animationDuration:
                                  const Duration(microseconds: 1201),
                              chartRadius: 200,
                              chartType: ChartType.ring,
                              legendOptions: const LegendOptions(
                                showLegends: true,
                                legendPosition: LegendPosition.left,
                              ),
                              colorList: colorlist,
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              dataMap: {
                                "total": double.parse(
                                    snapshot.data!.cases.toString()),
                                // double.parse(snapshot.data!.cases.toString()),
                                "recover": double.parse(
                                    snapshot.data!.recovered.toString()),
                                // double.parse(snapshot.data!.recovered.toString()),
                                "death": double.parse(
                                    snapshot.data!.recovered.toString()),
                                // double.parse(snapshot.data!.deaths.toString()),
                              }),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Card(
                              color: const Color(0xff777777),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ReusableRow(
                                      title: "total",
                                      value: snapshot.data!.cases.toString(),
                                    ),
                                    const Divider(),
                                    ReusableRow(
                                      title: "Recover",
                                      value:
                                          snapshot.data!.recovered.toString(),
                                    ),
                                    const Divider(),
                                    ReusableRow(
                                      title: "Death",
                                      value: snapshot.data!.deaths.toString(),
                                    ),
                                    const Divider(),
                                    ReusableRow(
                                      title: "active",
                                      value: snapshot.data!.active.toString(),
                                    ),
                                    const Divider(),
                                    ReusableRow(
                                      title: "critical",
                                      value: snapshot.data!.critical.toString(),
                                    ),
                                    const Divider(),
                                    ReusableRow(
                                      title: "tests",
                                      value: snapshot.data!.tests.toString(),
                                    ),
                                    const Divider(),
                                    ReusableRow(
                                      title: "todayCases",
                                      value:
                                          snapshot.data!.todayCases.toString(),
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const Countries_list()));
                            },
                            child: Container(
                              height: 50,
                              margin:
                                  const EdgeInsets.only(left: 22, right: 22),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.green,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.greenAccent.withOpacity(0.4),
                                      blurRadius: 4,
                                    )
                                  ]),
                              child: const Center(
                                child: Text(
                                  "Track Countries",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    //
                    // } else {
                  }
                  // },
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }
}
