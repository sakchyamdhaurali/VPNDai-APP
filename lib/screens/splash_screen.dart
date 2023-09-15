import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:vpn_basic_project/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 2000),
    (){
SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

      Get.off(()=>HomeScreen());
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen())

      
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [

          Positioned(
            left: mq.width*.3,
            top: mq.height* .3,
            width: mq.width* .4,
            child: Image.asset(
              'assets/images/logo.png',
              scale: 3.5,
            ),
          ),



          Positioned(
            bottom: mq.height* .20,
            width: mq.width,
            child: Text(
              "VPNDai 🌏 Since 2023",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 1
              ),
              ),
              
              ),
        ],
      ),
    );
  }
}
