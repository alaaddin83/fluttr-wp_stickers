import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_sticker/constants.dart';

import '../function/app_Localizations.dart';
//import 'package:whatsapp_sticker/function/app_Localizations.dart';

class MyDrawer extends StatelessWidget {
  static const TextStyle _drawerTextColor = TextStyle(
    color: kPrimaryColor2,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );

  static const IconThemeData _iconColor = IconThemeData(
    color: kPrimaryColor2,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              "Stickers",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            accountEmail: Text(
                AppLocalization.of(context).TranslationValue('fifth_string')),
            //currentAccountPicture: Image.asset('assets/images/aladdinapps.png'),
          ),
          //share
          ListTile(
            leading: IconTheme(
              data: _iconColor,
              child: Icon(Icons.share),
            ),
            title: Text(
                AppLocalization.of(context).TranslationValue('second_string'),
                style: _drawerTextColor),
            onTap: () {
              Share.share(kLinkOfApp);
//             Share.text(
//                  "Download Best WhatsApp Stickers ",
//                  "Download Best WhatsApp Stickers \n\n 👇👇👇👇👇 \nDownload Now\nhttps://play.google.com/store/apps/details?id=com.aladdinapps.stickerforwhats",
//                  "text/plain");
            },
          ),

          //rate
          ListTile(
            leading: IconTheme(
              data: _iconColor,
              child: Icon(Icons.rate_review),
            ),
            title: Text(
                AppLocalization.of(context).TranslationValue('third_string'),
                style: _drawerTextColor),
            onTap: () async {
              Navigator.of(context).pop();
              const url = kLinkOfApp;
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not open App';
              }
            },
          ),

          ListTile(
            leading: IconTheme(
              data: _iconColor,
              child: Icon(Icons.more),
            ),
            title: Text(
                AppLocalization.of(context).TranslationValue('siven_string'),
                style: _drawerTextColor),
            onTap: () async {
              Navigator.of(context).pop();
              const url =
                  "https://play.google.com/store/apps/dev?id=5007331887298406329";
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not open App';
              }
            },
          ),

          //private policy
          ListTile(
            leading: IconTheme(
              data: _iconColor,
              child: Icon(Icons.security),
            ),
            title: Text(
                AppLocalization.of(context).TranslationValue('forth_string'),
                style: _drawerTextColor),
            onTap: () async {
              Navigator.of(context).pop();
              const url =
                  "https://sites.google.com/view/aladinapps/%D8%A7%D9%84%D8%B5%D9%81%D8%AD%D8%A9-%D8%A7%D9%84%D8%B1%D8%A6%D9%8A%D8%B3%D9%8A%D8%A9";
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not open App';
              }
            },
          ),
        ],
      ),
    );
  }
}
