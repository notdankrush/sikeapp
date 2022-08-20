import 'package:card/providers/user_provider.dart';
import 'package:card/responsive/mobile_screen_layout.dart';
import 'package:card/responsive/responsive_layout_screen.dart';
import 'package:card/responsive/web_screen_layout.dart';
import 'package:card/screens/login_screen.dart';
import 'package:card/screens/signup_screen.dart';
import 'package:card/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyCdXemEqTlwjmyF8_AdZ0AMaFApu1uv8ck',
      appId: "1:7874131048:web:6f04761a961be4e3bd37dd",
      messagingSenderId: "7874131048",
      projectId: "card-app-35a6f",
      storageBucket: "card-app-35a6f.appspot.com",
    ));
  } else {
    await Firebase.initializeApp();
  }
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        debugShowCheckedModeBanner: false,
        // home: const ResponsiveLayout(
        //   mobileScreenLayout: MobileScreenLayout(),
        //   webScreenLayout: WebScreenLayout(),
        // ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                    webScreenLayout: WebScreenLayout(),
                    mobileScreenLayout: MobileScreenLayout());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: LinearProgressIndicator(color: primaryColor),
              );
            }
            return LoginScreen();
          },
        ),
      ),
    );
  }
}
