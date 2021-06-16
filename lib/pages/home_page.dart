import 'dart:async';

import 'package:flutter/material.dart';
import '../providers/app_provider.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/list_item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppProvider _appProvider;
  Timer timer;
  int counter = 0;
  void recarrega() {
    setState(() {
      _appProvider.getUrls();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(seconds: 4), (Timer t) => recarrega());
  }

  @override
  Widget build(BuildContext context) {
    _appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Servidor ON',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: FutureBuilder(
        future: _appProvider.getUrls(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData &&
              snapshot.data &&
              _appProvider.urls.length >= 1) {
            return RefreshIndicator(
              onRefresh: _recarrega,
              child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return ListItem(index);
                  },
                  separatorBuilder: (BuildContext context, _) => Divider(),
                  itemCount: _appProvider.urls.length),
            );
          }
          if (snapshot.data == null)
            return Center(
              child: Text('${snapshot.error}'),
            );
          if (_appProvider.urls.length < 1)
            return Center(child: Text('You have no sites added to test'));
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: showCustomDialog),
    );
  }

  Future<void> _recarrega() async {
    var espera = await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  showCustomDialog() {
    TextEditingController controller = TextEditingController();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialog(
              controller: controller, appProvider: _appProvider);
        });
  }
}
