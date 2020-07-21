import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:flutter_todos/utils/colors.dart';

enum kMoreOptionsKeys {
  clearAll,
  followUs,
  about,
  moreApps,
  writeReview,
  shareApp,

}

Map<int, String> kMoreOptionsMap = {
  kMoreOptionsKeys.clearAll.index: 'Tamamlananları Temizle',
  kMoreOptionsKeys.followUs.index: 'Takip Et',
  kMoreOptionsKeys.about.index: 'Hakkımda',
  kMoreOptionsKeys.moreApps.index: '',
  kMoreOptionsKeys.writeReview.index: '',
  kMoreOptionsKeys.shareApp.index: ''
  ,
};

class Utils {
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  static String getWelcomeMessage() {
    final hour = DateTime.now().hour;
    String msg;

    if (hour < 12) {
      msg = 'Günaydın';
    } else if (hour < 18) {
      msg = 'İyi Günler';
    } else {
      msg = 'İyi Akşamlar';
    }

    return msg;
  }

  static void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Başlatılamadı $url');
    }
  }

  static String getPlatformSpecificUrl({String iOSUrl, String androidUrl}) {
    if (Platform.isIOS) {
      return iOSUrl;
    } else if (Platform.isAndroid) {
      return androidUrl;
    }
  }

  static void showCustomDialog(BuildContext context,
      {String title,
      String msg,
      String noBtnTitle: 'Kapat',
      Function onConfirm,
      String confirmBtnTitle: 'Evet'}) {
    final dialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: <Widget>[
        if (onConfirm != null)
          RaisedButton(
            color: Color(TodosColor.kPrimaryColorCode),
            onPressed: () {
              onConfirm();
              Navigator.pop(context);
            },
            child: Text(
              confirmBtnTitle,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        RaisedButton(
          color: Color(TodosColor.kSecondaryColorCode),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            noBtnTitle,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
    showDialog(context: context, builder: (x) => dialog);
  }
}
