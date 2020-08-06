import 'package:flutter/material.dart';
import 'package:whatsapp_sticker/StaticContent.dart';
import 'package:whatsapp_sticker/Widgets/AdMob.dart';
import 'package:whatsapp_sticker/Widgets/drawer.dart';

import '../function/app_Localizations.dart';
//import 'package:whatsapp_sticker/constants.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AdmobAds.initialize();
    AdmobAds.showBannerAd();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    AdmobAds.hideBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    //bottom to add  buttons
    List<Widget> Bottom_Buttons = new List<Widget>();

    Bottom_Buttons.add(
      Container(
        height: 50.0,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title:
            Text(AppLocalization.of(context).TranslationValue('first_string')),
      ),
      body: StickrList(),
      //StaticContent(),
      drawer: Drawer(
        child: MyDrawer(),
      ),
      persistentFooterButtons: Bottom_Buttons,
    );
  }
}
