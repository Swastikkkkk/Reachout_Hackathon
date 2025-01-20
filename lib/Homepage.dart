import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/chatbot.dart';
// import 'package:community/screenspost.dart';
import 'post.dart';
import 'signup.dart';
import 'widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3918930754.
import 'dart:math';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:geolocator/geolocator.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:myapp/UserProfile.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_callkit/zego_callkit.dart';

final random = Random();
final _auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

// User user;
// dynamic userName = 'musk';

Set<Marker> _markers = {};
void _onMapCreated(GoogleMapController controller) {}

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

Position ?position;
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
     position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print("The location is ");
    print(position);
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  @override
  void initState() {

    super.initState();
    _determinePosition();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return HomePageMain();
  }
}

class HomePageMain extends StatefulWidget {
  const HomePageMain({
    super.key,
  });

  @override
  State<HomePageMain> createState() => _HomePageMainState();
}

class _HomePageMainState extends State<HomePageMain> with SingleTickerProviderStateMixin {
    late Animation<double> _animation;
  late AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
         
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<String> tips = [
      "Wash Your Hands Frequently",
      "Shower or Bathe Regularly",
      "Brush and Floss Daily",
      "Cover Your Coughs and Sneezes",
      "Maintain Clean Clothes",
    ];
    int tipsIndex = random.nextInt(4) + 1;
// Suggested code may be subject to a license. Learn more: ~LicenseLog:4132344214.
    String tip = tips[tipsIndex];

    // void _showStartupDialog(BuildContext context) {
    //   showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //       backgroundColor: Color(0xff3A3380),
    //       title: Text("Hygiene Tip",
    //           style: GoogleFonts.lato(
    //               textStyle: TextStyle(
    //                   color: const Color.fromARGB(255, 199, 199, 199),
    //                   fontSize: 16))),
    //       content: Text(tip,
    //           style: GoogleFonts.lato(
    //             textStyle: TextStyle(color: Colors.white, fontSize: 20),
    //           )),
    //       actions: [
    //         TextButton(
    //           onPressed: () => Navigator.pop(context),
    //           child: Text("OK",
    //               style: GoogleFonts.lato(
    //                 textStyle: TextStyle(color: Colors.white, fontSize: 16),
    //               )),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => _showStartupDialog(context));
    return Scaffold(

floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
floatingActionButton: FloatingActionBubble(
   animation: _animation,
  backGroundColor: Color(0xff3A3380),
   iconColor: Colors.white,
   iconData: Icons.menu,
 onPress: () => _animationController.isCompleted
      ? _animationController.reverse()
      : _animationController.forward(),
  items: [  Bubble(
    title:"Post",
    iconColor :Colors.white,
    bubbleColor : Color(0xff4B296A),
    icon:Icons.add,
    titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
    onPress: () {
      _animationController.reverse();
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => PostScreen()));
  },
  ),
       Bubble(
    title:"Ally",
    iconColor :Colors.white,
    bubbleColor : Color(0xff4B296A),
    icon:Icons.smart_toy,
    titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
    onPress: () {
      _animationController.reverse();
           Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChatBot()));

    },
  ),


  ],
),

        body: Column(children: [
          Expanded(
            child: Container(
              color: Color(0xff3a3380),
              child: Stack(
                children: [
                  Center(
                    child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.1), BlendMode.modulate),
                        child: SvgPicture.asset('assets/community.svg')),
                  ),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Welcome to Reachout \n',
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 22.0,
                            )),
                        TextSpan(
                            text: 'Help your community',
                            style: GoogleFonts.lato(
                                color: Colors.grey, fontSize: 13.0)),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // -----------------------------------------------Body-----------------------------------------
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: ListView(padding: EdgeInsets.all(0.0), children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Posts',
                        style: GoogleFonts.lato(
                          color: Color(0xff3a3380),
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: firestore.collection('data').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final receiveData = snapshot.data?.docs;
                          List<Widget> showCardWidgets = [];
                          for (var datas in receiveData!) {
                            dynamic lonReceived = datas.get('lon');
                            dynamic latReceived = datas.get('lat');
                            final nameReceived = datas.get('name');
                            dynamic priceReceived = datas.get('price');
                            final workReceived = datas.get('work');
                            showCardWidgets.add(Cards(
                              username:_auth.currentUser?.email,
                                name: nameReceived,
                                price: priceReceived,
                                work: workReceived,
                                lat: latReceived,
                                lon: lonReceived));
                          }
                          return Column(
                            children: showCardWidgets,
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )
                  ],
                ),
              ]),
            ),
          )
        ]));
  }
}

void getCurrentUser() async {
  try {
    final Currentuser = await _auth.currentUser;
    print(Currentuser?.email);
  } catch (e) {
    print(e);
  }
}




