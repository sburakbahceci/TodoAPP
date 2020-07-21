import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:flutter_todos/model/db_wrapper.dart';
import 'package:flutter_todos/utils/utils.dart';
import 'package:flutter_todos/constants.dart';

class Popup extends StatelessWidget {
  Function getTodosAndDones;

  Popup({this.getTodosAndDones});

  @override
  Widget build(BuildContext context) {
    String appUrl = Utils.getPlatformSpecificUrl(
        iOSUrl: kAppPortfolioApple, androidUrl: kGooglePlayUrl);
    String portfolioUrl = Utils.getPlatformSpecificUrl(
        iOSUrl: kAppPortfolioApple, androidUrl: kappPortfolioGoogle);

    return PopupMenuButton<int>(
        elevation: 4,
        icon: Icon(Icons.more_vert),
        onSelected: (value) {
          print('Seçilen değer: $value');
          if (value == kMoreOptionsKeys.clearAll.index) {
            Utils.showCustomDialog(context,
                title: 'Emin misin?',
                msg: 'Tüm yapılacaklar kalıcı olarak silinecek.',
                onConfirm: () {
              DBWrapper.sharedInstance.deleteAllDoneTodos();
              getTodosAndDones();
            });
          } else if (value == kMoreOptionsKeys.moreApps.index) {
            Utils.launchURL(portfolioUrl);
          } else if (value == kMoreOptionsKeys.about.index) {
            Utils.launchURL(kAboutPageUrl);
          } else if (value == kMoreOptionsKeys.writeReview.index) {
            Utils.launchURL(appUrl);
          } else if (value == kMoreOptionsKeys.shareApp.index) {
            Share.share('Bu harika uygulamaya göz atın ' + appUrl);
          } else if (value == kMoreOptionsKeys.followUs.index) {
            Utils.launchURL(kAppTwitterPage);
          }
        },
        itemBuilder: (context) {
          List list = List<PopupMenuEntry<int>>();

          for (int i = 0; i < kMoreOptionsMap.length; ++i) {
            list.add(PopupMenuItem(value: i, child: Text(kMoreOptionsMap[i])));

            if (i == 0) {
              list.add(PopupMenuDivider(
                height: 5,
              ));
            }
          }

          return list;
        });
  }
}
