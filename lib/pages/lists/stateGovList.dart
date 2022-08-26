import 'package:eyeris/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongolib;

class stateGovList extends StatefulWidget {
  const stateGovList({Key? key}) : super(key: key);

  @override
  State<stateGovList> createState() => _stateGovListState();
}

class _stateGovListState extends State<stateGovList> {
  Future<Widget> getRecords() async {
    var db = await mongolib.Db.create(
        "mongodb+srv://eyeris:UHgKx1WwkMiPBMRJ@eyeris.yqu1m.mongodb.net/EYEris");
    await db.open();
    var allusers = await db.collection("users").find({"level": "2"}).toList();
    List<Widget> items = [];
    int i;
    for (i = 0; i < allusers.length; i++) {
      items.add(Container(
        decoration: const BoxDecoration(
          color: Colors.amber,
        ),
        child: Column(
          children: [
            Text(allusers[i]['empid']),
          ],
        ),
      ));
    }
    db.close();
    return SingleChildScrollView(
      child: Column(
        children: items,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "State Govt. Employees",
          style: TextStyle(color: Palette.myTheme),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Palette.myTheme,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home/stateGovList/stateGov');
            },
            icon: const Icon(
              Icons.add,
              color: Palette.myTheme,
            ),
          ),
          IconButton(
            onPressed: () {
              getRecords();
            },
            icon: const Icon(
              Icons.access_alarm,
              color: Palette.myTheme,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data as Widget;
              return data;
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        future: getRecords(),
      ),
    );
  }
}
