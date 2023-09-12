import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:vpn_basic_project/widgets/home_card.dart';

import '../main.dart';
import '../models/vpn_config.dart';
import '../models/vpn_status.dart';
import '../services/vpn_engine.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _vpnState = VpnEngine.vpnDisconnected;
  List<VpnConfig> _listVpn = [];
  VpnConfig? _selectedVpn;

  @override
  void initState() {
    super.initState();

    ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
      setState(() => _vpnState = event);
    });

    initVpn();
  }

  void initVpn() async {
    //sample vpn config file (you can get more from https://www.vpngate.net/)
    _listVpn.add(VpnConfig(
        config: await rootBundle.loadString('assets/vpn/japan.ovpn'),
        country: 'Japan',
        username: 'vpn',
        password: 'vpn'));

    _listVpn.add(VpnConfig(
        config: await rootBundle.loadString('assets/vpn/thailand.ovpn'),
        country: 'Thailand',
        username: 'vpn',
        password: 'vpn'));

    _listVpn.add(VpnConfig(
        config: await rootBundle.loadString('assets/vpn/tur.ovpn'),
        country: 'Turkey',
        username: 'vpn',
        password: 'vpn'));

    _listVpn.add(VpnConfig(
        config: await rootBundle.loadString('assets/vpn/india.ovpn'),
        country: 'India',
        username: 'vpn',
        password: 'vpn'));

    SchedulerBinding.instance.addPostFrameCallback(
        (t) => setState(() => _selectedVpn = _listVpn.first));
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:Color.fromARGB(255, 19, 159, 229),
        leading: Icon(CupertinoIcons.home),
        title: Text('VPNDai'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.brightness_medium),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.info_rounded),
            ),
          )
        ],
      ),
      bottomNavigationBar: _changeLocation(),
      body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: mq.height * .03,
              width: double.maxFinite,
            ),
            _vpnButton(),
          
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeCard(
                  title: 'Country',
                  subtiltle: 'Free',
                  icon: CircleAvatar(
                    radius: 30,
                    child: Icon(
                      Icons.vpn_lock_rounded,
                      size: 30,
                    ),
                  ),
                ),
                HomeCard(
                  title: '100 ms',
                  subtiltle: 'PING',
                  icon: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.pink,
                    child: Icon(
                      Icons.equalizer_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
SizedBox(height: mq.height*.03,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeCard(
                  title: '0 kbps',
                  subtiltle: 'Download',
                  icon: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.lightGreen,
                    child: Icon(
                      
                      Icons.arrow_downward_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                HomeCard(
                  title: '0 kbps',
                  subtiltle: 'Upload',
                  icon: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.arrow_upward,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ]),
    );
  }

  void _connectClick() {
    ///Stop right here if user not select a vpn
    if (_selectedVpn == null) return;

    if (_vpnState == VpnEngine.vpnDisconnected) {
      ///Start if stage is disconnected
      VpnEngine.startVpn(_selectedVpn!);
    } else {
      ///Stop if stage is "not" disconnected
      VpnEngine.stopVpn();
    }
  }

//vpn button
  Widget _vpnButton() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              print('clicked');
            },
            child: Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(0.1),
              ),
              child: Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.withOpacity(0.3),
                ),
                child: Container(
                  height: mq.height * .14,
                  width: mq.width * .14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.power_settings_new_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Tap to Connect',
                          style: TextStyle(color: Colors.white),
                        ),
                      ]),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

//connection status
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: mq.height * .015, bottom: mq.height* .08),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),   
                child: Text(
                  'Not Connected',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}

Widget _changeLocation()=> SafeArea(
  child:   Container(
    padding: EdgeInsets.symmetric(horizontal: mq.width* .04),
    height: 60,
    color: const Color.fromARGB(255, 153, 69, 63),
    
    child: Row(children: [
      Icon(
        CupertinoIcons.globe,
        color: Colors.white,
        size: 28,
        ),

        SizedBox(width: 10,),

  Text('Change Location',
  style: TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w500
    ),
    ),

//this widget covers the availabe space
    Spacer(),

//for creating Icon inside the circle
CircleAvatar(
  backgroundColor: Colors.white,
  child:  Icon(
        Icons.keyboard_arrow_right_rounded,
        color: Colors.blue,
        size: 28,
        ),
),

    ]),
  ),
);




  // Center(
  //             child: TextButton(
  //               style: TextButton.styleFrom(
  //                 shape: StadiumBorder(),
  //                 backgroundColor: Theme.of(context).primaryColor,
  //               ),
  //               child: Text(
  //                 _vpnState == VpnEngine.vpnDisconnected
  //                     ? 'Connect VPN'
  //                     : _vpnState.replaceAll("_", " ").toUpperCase(),
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               onPressed: _connectClick,
  //             ),
  //           ),
  //           StreamBuilder<VpnStatus?>(
  //             initialData: VpnStatus(),
  //             stream: VpnEngine.vpnStatusSnapshot(),
  //             builder: (context, snapshot) => Text(
  //                 "${snapshot.data?.byteIn ?? ""}, ${snapshot.data?.byteOut ?? ""}",
  //                 textAlign: TextAlign.center),
  //           ),

  //           //sample vpn list
  //           Column(
  //               children: _listVpn
  //                   .map(
  //                     (e) => ListTile(
  //                       title: Text(e.country),
  //                       leading: SizedBox(
  //                         height: 20,
  //                         width: 20,
  //                         child: Center(
  //                             child: _selectedVpn == e
  //                                 ? CircleAvatar(
  //                                     backgroundColor: Colors.green)
  //                                 : CircleAvatar(
  //                                     backgroundColor: Colors.grey)),
  //                       ),
  //                       onTap: () {
  //                         log("${e.country} is selected");
  //                         setState(() => _selectedVpn = e);
  //                       },
  //                     ),
  //                   )
  //                   .toList())