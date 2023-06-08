import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../util/app_details.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({Key? key}) : super(key: key);

  _launchGithub() {
    launchUrl(
      Uri.parse(AppDetails.repositoryLink),
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Informações"),
        ),
        body: ListView(children: <Widget>[
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage("assets/mascote2.png"),//mascote1.jpg
              ),
            ),
          ),
          const SizedBox(height: 15),
          Center(
            child: Text("${AppDetails.appName} ${AppDetails.appVersion}",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.primary)),
          ),
          const SizedBox(height: 15),
          ListTile(
            title: Text("Dev",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary)),
          ),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text(
              "Aplicativo criado utilizando o Flutter e a linguagem Dart.",
            ),
          ),
          ListTile(
            title: Text("Código Fonte",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary)),
          ),
          ListTile(
            onTap: () {
              _launchGithub();
            },
            leading: const Icon(Icons.open_in_new_outlined),
            title: const Text("Ver no Github",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                    color: Colors.blue)),
          ),
        ]));
  }
}
