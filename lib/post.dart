import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'widget/Button.dart';
import 'widget/universalform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:dio/dio.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
// AIzaSyA91Cr-suDb3VDBPwLDp_ci6NOkWCKEw7k
var Username;
var price;
var work;

final firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
const samePadding = EdgeInsets.symmetric(horizontal: 20.0);

var lat = 26.912434;
var lon = 75.787270;
CameraPosition _initialCameraPosition() {
  return CameraPosition(
    target: LatLng(lat,lon),
    zoom: 11.5,
  );
}

Completer<GoogleMapController> _controllerGoogleMap = Completer();
GoogleMapController? controllerMaps;

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {}
  @override
  void dispose() {
    super.dispose();
    controllerMaps;
  }

  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    lat = await position.latitude;
    lon = await position.longitude;
    print("Your position is");
    print(position);
    // lat = 26.912434;
    // lon = 75.78727;
    LatLng latlanPos = LatLng(lat, lon);
    CameraPosition camerapos = CameraPosition(target: latlanPos, zoom: 16);

    controllerMaps?.animateCamera(CameraUpdate.newCameraPosition(camerapos));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.arrow_back,
                    size: 10.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 1.5,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Create a post !',
                    textStyle: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 25.0),
                    speed: const Duration(milliseconds: 200),
                    textAlign: TextAlign.start,
                  ),
                ],
                repeatForever: true,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: samePadding,
                  child: CreateForm(
                    onchanged: (value) {
                      Username = value;
                    },
                    hintText: 'Name',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color(0xff3a3380),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Padding(
                  padding: samePadding,
                  child: CreateForm(
                    hintText: 'Set the Price',
                    prefixIcon: Icon(FontAwesomeIcons.dollarSign,
                        color: Color(0xff3a3380)),
                    onchanged: (value) {
                      price = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Padding(
                  padding: samePadding,
                  child: CreateForm(
                    hintText: 'Need help with',
                    prefixIcon: Icon(Icons.work, color: Color(0xff3a3380)),
                    onchanged: (value) {
                      work = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Padding(
                  padding: samePadding,
                  child: Container(
                      height: 20.h,
                      child: GoogleMap(
                        markers: _markers,
                        myLocationButtonEnabled: true,
                        onMapCreated: (GoogleMapController controller) {
                          _controllerGoogleMap.complete(controller);
                          controllerMaps = controller;

                          getCurrentLocation();
                        },
                        // markers: _markers,
                        zoomControlsEnabled: false,

                        initialCameraPosition: _initialCameraPosition(),
                      )),
                ),
                SizedBox(
                  height: 1.h,
                ),
                GestureDetector(
                  onTap: () {
                    getCurrentLocation();
                    setState(() {
                      _markers.add(
                        Marker(
                            markerId: MarkerId('id-1'),
                            position: LatLng(lat, lon)),
                      );
                    });
                  },
                  child: Container(
                    child: Text('Get current location',
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff3a3380),
                          fontSize: 15.0,
                          decoration: TextDecoration.underline,
                        )),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Button(
                  buttonText: 'Post',
                  ontap: () {
                        AnimatedSnackBar.material(
                    'Your post has successfully posted',
                    type: AnimatedSnackBarType.success,
                    mobileSnackBarPosition: MobileSnackBarPosition.top,
                    desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
                  ).show(context);
                    print("post clicked");
                    firestore.collection('data').add({
                      'lat': lat,
                      'lon': lon,
                      'name': Username,
                      'price': price,
                      'work': work,
                    });
                    // bool res =  MapsLauncher.launchCoordinates(lat, lon);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
