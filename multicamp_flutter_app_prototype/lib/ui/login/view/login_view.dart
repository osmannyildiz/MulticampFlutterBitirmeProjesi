import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:multicamp_flutter_app_prototype/ui/home/view/home_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    checkLoggedIn();
    return Scaffold(
        key: scaffoldKey,
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/news.png",
                      height: 100,
                    ),
                    Text(
                      "Evrenin en iyi haber uygulaması.",
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue),
                    ),
                    Text("Bu nefes kesici deneyime hazır mısın?",
                        style: TextStyle(color: Colors.grey)),
                    Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 24, bottom: 6),
                                  child: TextFormField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                        labelText: "E-posta",
                                        border: _inputBorder()),
                                    validator: (String email) {
                                      if (email.trim().isEmpty)
                                        return "E-posta adresini girmeyi unuttun.";
                                      return null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                  )),
                              TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                    labelText: "Şifre", border: _inputBorder()),
                                validator: (String password) {
                                  if (password.isEmpty)
                                    return "Şifreni girmeyi unuttun.";
                                  return null;
                                },
                                obscureText: true,
                              ),
                              Row(children: [
                                Container(
                                    width: (MediaQuery.of(context).size.width -
                                                48) /
                                            2 -
                                        3,
                                    child: SignInButtonBuilder(
                                        icon: Icons.login,
                                        backgroundColor: Colors.blue,
                                        text: "Giriş yap",
                                        onPressed: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            login();
                                          }
                                        })),
                                Container(
                                    width: (MediaQuery.of(context).size.width -
                                                48) /
                                            2 -
                                        3,
                                    margin: EdgeInsets.only(left: 6),
                                    child: SignInButtonBuilder(
                                        icon: Icons.person_add,
                                        backgroundColor: Colors.blueGrey,
                                        text: "Kayıt ol",
                                        onPressed: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            register();
                                          }
                                        }))
                              ])
                            ])),
                    Text(
                      "veya",
                      style: TextStyle(fontSize: 16),
                    ),
                    SignInButton(Buttons.Google,
                        text: "Google ile giriş yap",
                        onPressed: () async => loginWithGoogle())
                  ]),
            )));
  }

  InputBorder _inputBorder() {
    return OutlineInputBorder(
        borderSide:
            BorderSide(color: Colors.blue, width: 4), // nedense çalışmıyor
        borderRadius: BorderRadius.all(Radius.circular(6)));
  }

  Future<void> checkLoggedIn() async {
    if (_auth.currentUser != null) {
      Future.delayed(Duration(seconds: 1),
          () => Navigator.pushReplacement(context, _routeToHomeView()));
    }
  }

  void login() async {
    ScaffoldState scaffold = scaffoldKey.currentState;
    try {
      // final UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      scaffold.showSnackBar(SnackBar(content: Text("Başarıyla giriş yaptın.")));
      Navigator.pushReplacement(context, _routeToHomeView());
    } on FirebaseAuthException catch (e) {
      scaffold.showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void register() async {
    ScaffoldState scaffold = scaffoldKey.currentState;
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      final User user = userCredential.user;

      if (user != null) {
        scaffold.showSnackBar(SnackBar(
            content: Text("Başarıyla kayıt oldun. Şimdi giriş yapabilirsin.")));
      } else {
        scaffold.showSnackBar(SnackBar(content: Text("Kayıt olamadın :(")));
      }
    } on FirebaseAuthException catch (e) {
      scaffold.showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void loginWithGoogle() async {
    ScaffoldState scaffold = scaffoldKey.currentState;
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User user = userCredential.user;

      scaffold.showSnackBar(
          SnackBar(content: Text("Hoş geldin, ${user.displayName}")));
      Navigator.pushReplacement(context, _routeToHomeView());
    } on FirebaseAuthException catch (e) {
      scaffold.showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      print(e.toString());
    }
  }

  Route _routeToHomeView() {
    return MaterialPageRoute(builder: (context) => HomeView());
  }
}
