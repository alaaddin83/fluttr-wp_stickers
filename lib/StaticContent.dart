import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_whatsapp_stickers/flutter_whatsapp_stickers.dart';
import 'package:whatsapp_sticker/Screens/sticker_pack_detail.dart';
import 'package:whatsapp_sticker/Widgets/AdMob.dart';
import 'package:whatsapp_sticker/constants.dart';
import 'package:whatsapp_sticker/function/process_Response.dart';

class StickrList extends StatefulWidget {
  @override
  _StickrListState createState() => _StickrListState();
}

class _StickrListState extends State<StickrList> {
  final WhatsAppStickers _waStickers = WhatsAppStickers();
  List stickerList = new List();
  List installedStickers = new List();

  void _loadStickers() async {
    String data =
        await rootBundle.loadString("sticker_packs/sticker_packs.json");
    final response = json.decode(data);
    List tempList = new List();

    for (int i = 0; i < response['sticker_packs'].length; i++) {
      tempList.add(response['sticker_packs'][i]);
    }
    setState(() {
      stickerList.addAll(tempList);
    });
    _checkInstallationStatuses();
  }

  void _checkInstallationStatuses() async {
    print("Total Stickers : ${stickerList.length}");
    for (var j = 0; j < stickerList.length; j++) {
      var tempName = stickerList[j]['identifier'];
      bool tempInstall =
          await WhatsAppStickers().isStickerPackInstalled(tempName);

      if (tempInstall == true) {
        if (!installedStickers.contains(tempName)) {
          setState(() {
            installedStickers.add(tempName);
          });
        }
      } else {
        if (installedStickers.contains(tempName)) {
          setState(() {
            installedStickers.remove(tempName);
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadStickers();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: stickerList.length,
        itemBuilder: (context, index) {
          if (stickerList.length == 0) {
            return Container(
              child: CircularProgressIndicator(),
            );
          } else {
            var stickerId = stickerList[index]['identifier'];
            var stickerName = stickerList[index]['name'];
            var stickerPublisher = stickerList[index]['publisher'];
            var stickerTrayIcon = stickerList[index]['tray_image_file'];
            var tempStickerList = List();

            bool stickerInstalled = false;
            if (installedStickers.contains(stickerId)) {
              stickerInstalled = true;
            } else {
              stickerInstalled = false;
            }
            tempStickerList.add(stickerList[index]['identifier']);
            tempStickerList.add(stickerList[index]['name']);
            tempStickerList.add(stickerList[index]['publisher']);
            tempStickerList.add(stickerList[index]['tray_image_file']);
            tempStickerList.add(stickerList[index]['stickers']);
            tempStickerList.add(stickerInstalled);
            tempStickerList.add(installedStickers);

            return stickerPack(
              tempStickerList,
              stickerName,
              stickerPublisher,
              stickerId,
              stickerTrayIcon,
              stickerInstalled,
            );
          }
        });
  }

  Widget stickerPack(List stickerList, String name, String publisher,
      String identifier, String stickerTrayIcon, bool installed) {
    Widget depInstallWidget;
    if (installed == true) {
      depInstallWidget = IconButton(
        icon: Icon(
          Icons.check_circle,
        ),
        color: kPrimaryColor2,
        tooltip: 'Add Sticker to WhatsApp',
        onPressed: () {},
      );
    } else {
      depInstallWidget = IconButton(
        icon: Icon(
          Icons.add_circle,
        ),
        color: kPrimaryColor2,
        tooltip: 'Add Sticker to WhatsApp',
        onPressed: () async {
          bool whatsAppConsumer =
              await WhatsAppStickers.isWhatsAppConsumerAppInstalled;
//          bool whatsAppBusiness =
//              await WhatsAppStickers.isWhatsAppSmbAppInstalled;

          if (whatsAppConsumer) {
            print("whats app is installed :$whatsAppConsumer");
            _waStickers.addStickerPack(
              packageName: WhatsAppPackage.Consumer,
              stickerPackIdentifier: identifier,
              stickerPackName: name,
              listener: (action, result, {error}) => processResponse(
                action: action,
                result: result,
                error: error,
                successCallback: () async {
                  _checkInstallationStatuses();
                },
                context: context,
              ),
            );
          } else {
            print("whatsapp Business is installed :$whatsAppConsumer");
            _waStickers.addStickerPack(
              packageName: WhatsAppPackage.Business,
              stickerPackIdentifier: identifier,
              stickerPackName: name,
              listener: (action, result, {error}) => processResponse(
                action: action,
                result: result,
                error: error,
                successCallback: () async {
                  _checkInstallationStatuses();
                },
                context: context,
              ),
            );
          }
        },
      );
    }

    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              "$name",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            subtitle: Text("$publisher"),
            leading: Image.asset(
              "sticker_packs/$identifier/$stickerTrayIcon",
//          height: MediaQuery.of(context).size.height * 0.5,
//          width: MediaQuery.of(context).size.width * 0.2,
            ),
            trailing: Column(
              children: <Widget>[
                depInstallWidget,
              ],
            ),
            onTap: () {
              AdmobAds.showInterstitialAd()
                ..load()
                ..show();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    StickerPackDetail(stickerList),
              ));
            },
          ),
          Divider(
            height: 10.0,
            color: kPrimaryColor2,
          ),
        ],
      ),
    );
  }
}
