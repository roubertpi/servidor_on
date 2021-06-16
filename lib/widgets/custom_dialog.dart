import 'package:flutter/material.dart';
import '../providers/app_provider.dart';

class CustomDialog extends StatelessWidget {
  final TextEditingController controller;
  final AppProvider appProvider;

  CustomDialog({
    @required this.controller,
    @required this.appProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 10,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 300,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text('Adicionar novo Servidor'),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.url,
                maxLines: 1,
                expands: false,
                autofocus: true,
                controller: controller,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  prefix: Text('https://'),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  minWidth: MediaQuery.of(context).size.width * 0.25,
                  height: 40,
                  color: Colors.red,
                  // ignore: prefer_const_constructors
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                MaterialButton(
                  onPressed: () async {
                    String text = controller.text;
                    if (text.contains('http')) {
                      text.replaceFirst('http', '');
                    }
                    appProvider.addUrl('https://$text');
                    Navigator.of(context).pop();
                  },
                  minWidth: MediaQuery.of(context).size.width * 0.25,
                  height: 40,
                  color: Colors.blueAccent,
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
