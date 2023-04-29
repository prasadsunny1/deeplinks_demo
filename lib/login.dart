import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    initDynamicLinks(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/page1');
          },
          child: const Text('Login'),
        ),
      ),
    );
  }

  initDynamicLinks(BuildContext context) async {
    // await Future.delayed(const Duration(seconds: 3));
    var initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      // Example of using the dynamic link to push the user to a different screen
      Navigator.pushNamed(context, deepLink.path);
    }
    FirebaseDynamicLinks.instance.onLink.listen(
      (pendingDynamicLinkData) {
        final Uri deepLink = pendingDynamicLinkData.link;
        Navigator.pushNamed(context, deepLink.path);
      },
    );
  }
}
