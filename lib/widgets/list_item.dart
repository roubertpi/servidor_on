import 'package:flutter/material.dart';
import '../providers/app_provider.dart';
import 'package:provider/provider.dart';

class ListItem extends StatelessWidget {
  final int _index;
  AppProvider _appProvider;

  ListItem(this._index);

  @override
  Widget build(BuildContext context) {
    _appProvider = Provider.of<AppProvider>(context, listen: false);

    Future<Widget> apagarOuNao() async {
      return await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Deseja Apagar'),
            actions: [
              FlatButton(
                child: Text("sim"),
                onPressed: () async {
                  await _appProvider.dbProvider
                      .deleteUrl(_appProvider.urls[_index]);
                  _appProvider.urls.removeAt(_index);

                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Não"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        },
      );
    }

    Future<Widget> editarOuExcluir() async {
      print('chamer');
      return await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Você Deseja'),
            actions: [
              FlatButton(
                child: Text("Apagar"),
                onPressed: () async {
                  await _appProvider.deleteUrl(_appProvider.urls[_index]);
                  Navigator.of(context).pop();
                  _appProvider.urls.removeAt(_index);
                },
              )
            ],
          );
        },
      );
    }

    return GestureDetector(
        key: Key('$_index'),
        onTap: () {
          editarOuExcluir();
        },
        child: FutureBuilder(
          future: _appProvider.ping(_appProvider.urls[_index]),
          builder: (BuildContext context, AsyncSnapshot<int> response) {
            if (response.connectionState != ConnectionState.done) {
              return ListTile(
                title: Text(_appProvider.urls[_index]),
                trailing: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
                subtitle: Text('Carregando...'),
              );
            }
            return ListTile(
              title: Text(_appProvider.urls[_index]),
              trailing:
                  response.data == 0 ? Icon(Icons.check) : Icon(Icons.clear),
              subtitle: Text(response.data == 0 ? 'Online' : 'Offline'),
            );
          },
        ));
  }
}
