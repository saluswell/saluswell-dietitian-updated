
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dietationapp/src/apppointmentsSection/providers/appointmentProvider.dart';
import 'package:dietationapp/src/authenticationsection/providers/authProvider.dart';
import 'package:dietationapp/src/authenticationsection/providers/savUserDetailsProvider.dart';
import 'package:dietationapp/src/authenticationsection/screens/bankingInformation.dart';
import 'package:dietationapp/src/authenticationsection/screens/createAccountScreen.dart';
import 'package:dietationapp/src/authenticationsection/screens/loginScreen.dart';
import 'package:dietationapp/src/authenticationsection/screens/personalInformationScreen.dart';
import 'package:dietationapp/src/authenticationsection/screens/professionalInformationScreen.dart';
import 'package:dietationapp/src/dashboardsection/provider/bottom_navbar_provider.dart';
import 'package:dietationapp/src/dashboardsection/screens/bottomNavScreen.dart';
import 'package:dietationapp/src/dashboardsection/screens/homeScreen.dart';
import 'package:dietationapp/src/authenticationsection/screens/splashScreen.dart';
import 'package:dietationapp/src/notesSection/providers/soap_note_provider.dart';
import 'package:dietationapp/src/onboardingsection/screens/onboardingscreen_one.dart';
import 'package:dietationapp/src/onboardingsection/screens/onboardingscreen_three.dart';
import 'package:dietationapp/src/onboardingsection/screens/onboardingscreen_two.dart';
import 'package:dietationapp/src/resourcesSection/healthTipsSection/providers/resourceProvider.dart';

import 'package:dietationapp/src/reviewsSection/providers/review_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'common/helperFunctions/navigatorHelper.dart';
import 'common/utils/themes.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  createNotification(
    title: message.data['title'].toString(),
    body: message.data['body'].toString(),
  );
}




Future<void> createNotification(
    {required String title, required String body}) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 1, channelKey: 'basic_channel', title: title, body: body),
  );
}

///starting point
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();

  AwesomeNotifications().initialize(
    'resource://drawable/notificationlogo',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        defaultColor: Colors.teal,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        channelDescription: '',
      ),
    ],
  ).then((value) => print(value));
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}




class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    //  initAgora();
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content:
                  const Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Don\'t Allow',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: const Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
    FirebaseMessaging.onMessage.listen((message) {
      createNotification(
        title: message.data['title'].toString(),
        body: message.data['body'].toString(),
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      createNotification(
        title: message.data['title'].toString(),
        body: message.data['body'].toString(),
      );
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
        ChangeNotifierProvider(create: (context) => AppointmentProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => ResourceProvider()),
        ChangeNotifierProvider(create: (context) => SoapNoteProvider()),
        ChangeNotifierProvider(create: (context) => ReviewProvider()),
      ],
      child: GestureDetector(
        onTap: () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        },
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            navigatorKey: navstate,
            theme: AppTheme.themeData,
            routes: {
              LoginScreen.routeName: (context) => LoginScreen(),
              CreateAccountScreen.routeName: (context) =>
                  const CreateAccountScreen(),
              HomeScreen.routeName: (context) => const HomeScreen(),
              BottomNavScreen.routeName: (context) => const BottomNavScreen(),

              OnBoardingScreenOne.routeName: (context) =>
                  const OnBoardingScreenOne(),
              OnBoardingScreenTwo.routeName: (context) =>
                  const OnBoardingScreenTwo(),
              OnBoardingScreenThree.routeName: (context) =>
                  const OnBoardingScreenThree(),
              PersonalInformationScreen.routeName: (context) =>
                  const PersonalInformationScreen(),
              BankingInformationScreen.routeName: (context) =>
                  const BankingInformationScreen(),
              ProfessionalInformationScreen.routeName: (context) =>
                  const ProfessionalInformationScreen(),
            },
            home: SplashScreen()),
      ),
    );
  }
}
