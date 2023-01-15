import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/Countries_based_record.dart';
import 'Details_screen.dart';

class Countries_list extends StatefulWidget {
  const Countries_list({Key? key}) : super(key: key);

  @override
  State<Countries_list> createState() => _Countries_listState();
}

class _Countries_listState extends State<Countries_list> {
  Countries_based_record countries_based_record = Countries_based_record();
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextFormField(
              controller: searchController,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 25,
                  ),
                  hintText: "Search here",
                  hintStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Color(0xffffffff),
                    ),
                  )),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: FutureBuilder(
                  future: countries_based_record.GetCountriesList(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.blueGrey,
                                child: ListTile(
                                  leading: Container(
                                    height: 20,
                                    width: 60,
                                    color: Colors.white,
                                    margin: const EdgeInsets.only(top: 5),
                                  ),
                                  title: Container(
                                    height: 20,
                                    width: 80,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    height: 25,
                                    width: 80,
                                    color: Colors.white,
                                  ),
                                ));
                          });
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String title = snapshot.data![index]["country"];
                            if (searchController.text.isEmpty) {
                              return ListTile(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Details_screen(
                                          name: snapshot.data![index]["country"],
                                          image: snapshot.data![index]["countryInfo"]["flag"],
                                          cases: snapshot.data![index]["cases"],
                                          todaycases: snapshot.data![index]["todayCases"],
                                          death: snapshot.data![index]["deaths"],
                                          todaydeath: snapshot.data![index]["todayDeaths"],
                                          recoverd: snapshot.data![index]["recovered"],
                                          todayrecoverd: snapshot.data![index]["todayRecovered"],
                                          active: snapshot.data![index]["active"],
                                          critical: snapshot.data![index]["critical"]
                                      )));
                                },
                                leading: Image(
                                  width: 60,
                                  height: 60,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']["flag"]),
                                ),
                                title: Text(
                                  snapshot.data![index]["country"],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: Text(
                                  snapshot.data![index]["cases"].toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              );
                            } else if (title.toLowerCase().contains(
                                searchController.text.toLowerCase())) {
                              return ListTile(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Details_screen(
                                          name: snapshot.data![index]["country"],
                                          image: snapshot.data![index]["countryInfo"]["flag"],
                                          cases: snapshot.data![index]["cases"],
                                          todaycases: snapshot.data![index]["todayCases"],
                                          death: snapshot.data![index]["deaths"],
                                          todaydeath: snapshot.data![index]["todayDeaths"],
                                          recoverd: snapshot.data![index]["recovered"],
                                          todayrecoverd: snapshot.data![index]["todayRecovered"],
                                          active: snapshot.data![index]["active"],
                                          critical: snapshot.data![index]["critical"]
                                      )));
                                },
                                leading: Image(
                                  width: 60,
                                  height: 60,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']["flag"]),
                                ),
                                title: Text(
                                  snapshot.data![index]["country"],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: Text(
                                  snapshot.data![index]["cases"].toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          });
                    }
                  },
                )),
          )
        ],
      ),
    );
  }
}
