import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutDeveloperView extends StatefulWidget {
  @override
  _AboutDeveloperViewState createState() => _AboutDeveloperViewState();
}

class _AboutDeveloperViewState extends State<AboutDeveloperView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Geliştirici hakkında"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "assets/developer.png",
                        height: 200,
                      ))),
              Text(
                "Osman Nuri Yıldız",
                style: TextStyle(fontSize: 36),
              ),
              Text(
                "@osmannyildiz",
                style: TextStyle(fontSize: 24, color: Colors.grey),
              ),
              Container(
                  margin: EdgeInsets.only(top: 16),
                  width: MediaQuery.of(context).size.width - 48,
                  child: TextButton.icon(
                      onPressed: () =>
                          launch("https://github.com/osmannyildiz"),
                      icon: Icon(Icons.link),
                      label: Text("GitHub'da ziyaret et"),
                      style: ButtonStyle(
                          foregroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.black)))),
              Container(
                  width: MediaQuery.of(context).size.width - 48,
                  child: TextButton.icon(
                      onPressed: () =>
                          launch("mailto:iamosmannyildiz@gmail.com"),
                      icon: Icon(Icons.mail_outline),
                      label: Text("E-posta yaz"),
                      style: ButtonStyle(
                          foregroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.black)))),
            ],
          ),
        ));
  }
}
