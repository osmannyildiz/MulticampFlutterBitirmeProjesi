import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:multicamp_flutter_app_prototype/ui/settings/view/about_developer_view.dart';
import 'package:multicamp_flutter_app_prototype/ui/login/view/login_view.dart';
// import 'package:multicamp_flutter_app_prototype/ui/settings/view_model/settings_view_model.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  // SettingsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    // viewModel = getSettingsViewModelInstance();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Ayarlar"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // DropdownButtonFormField(
              //     hint: Text("qqq"),
              //     items: [
              //       DropdownMenuItem(child: Text("Asdf")),
              //       DropdownMenuItem(child: Text("Asdf")),
              //       DropdownMenuItem(child: Text("Asdf"))
              //     ],
              //     onChanged: null),
              // Container(
              //     width: MediaQuery.of(context).size.width - 48,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(Icons.nightlight_round),
              //         Container(
              //             margin: EdgeInsets.only(left: 4, right: 24),
              //             child: Text(
              //               "Karanlık tema",
              //               style: TextStyle(color: Colors.black),
              //             )),
              //         Switch(value: false, onChanged: (newValue) => null),
              //       ],
              //     )),
              // Observer(builder: (_) {
              //   return SwitchListTile.adaptive(
              //       title: Text("Koyu tema"),
              //       value: viewModel.darkTheme,
              //       onChanged: (bool newValue) =>
              //           viewModel.setDarkTheme(newValue));
              // }),
              _settingsItemWide(TextButton.icon(
                  onPressed: () =>
                      Navigator.push(context, _routeToAboutDeveloperView()),
                  icon: Icon(Icons.info_outline),
                  label: Text("Geliştirici hakkında"),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.black)))),
              _settingsItemWide(TextButton.icon(
                  onPressed: () => showLicensePage(
                      context: context,
                      applicationVersion: "v1.0",
                      applicationIcon: Image.asset(
                        "assets/news.png",
                        height: 100,
                      ),
                      applicationLegalese: "© 2020 Osman Nuri Yıldız"),
                  icon: Icon(Icons.text_snippet_outlined),
                  label: Text("Lisanslar"),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.black)))),
              _settingsItemWide(TextButton.icon(
                  onPressed: () async => logOut(),
                  icon: Icon(Icons.logout),
                  label: Text("Çıkış yap"),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.red)))),
              Container(
                  margin: EdgeInsets.only(top: 32),
                  child: Text("Haberler v1.0"))
            ],
          ),
        ));
  }

  // SettingsViewModel getSettingsViewModelInstance() {
  //   if (viewModel == null) {
  //     viewModel = SettingsViewModel();
  //     viewModel.init();
  //   }
  //   return viewModel;
  // }

  Widget _settingsItemWide(Widget child) {
    return Container(
        width: MediaQuery.of(context).size.width - 48, child: child);
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    if (await GoogleSignIn().isSignedIn()) {
      await GoogleSignIn().disconnect();
      await GoogleSignIn().signOut();
    }

    Navigator.pushReplacement(context, _routeToLoginView());
  }

  Route _routeToAboutDeveloperView() {
    return MaterialPageRoute(builder: (context) => AboutDeveloperView());
  }

  Route _routeToLoginView() {
    return MaterialPageRoute(builder: (context) => LoginView());
  }
}
