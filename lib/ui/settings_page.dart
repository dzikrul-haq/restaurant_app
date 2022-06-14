import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common.dart';
import 'package:restaurant_app/commons/theme.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/utils/custom_dialog.dart';
import 'package:restaurant_app/widgets/flag_icon_widget.dart';
import 'package:restaurant_app/widgets/toast.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const _padding = EdgeInsets.only(top: 40, left: 20, right: 20);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Consumer<PreferenceProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: _padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.settingsPage_title,
                    style: titleStyle),
                ListTile(
                  title: Text(AppLocalizations.of(context)!
                      .settingsPage_ChangeLanguage),
                  trailing: const FlagIconWidget(),
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.settingsPage_dark),
                  trailing: Semantics(
                    label: provider.isDarkTheme
                        ? AppLocalizations.of(context)!
                            .settingsPage_darkThemeDisable
                        : AppLocalizations.of(context)!
                            .settingsPage_darkThemeEnable,
                    child: CupertinoSwitch(
                      activeColor: secondaryColor,
                      value: provider.isDarkTheme,
                      onChanged: (value) {
                        provider.enableDarkTheme(value);
                      },
                    ),
                  ),
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!
                      .settingsPage_reminderToggle),
                  subtitle: Text(AppLocalizations.of(context)!
                      .settingsPage_scheduling_time),
                  trailing: Consumer<SchedulingProvider>(
                    builder: (context, scheduled, _) {
                      return Semantics(
                        label: provider.isDailyReminderActive
                            ? AppLocalizations.of(context)!
                                .settingsPage_reminderDisable
                            : AppLocalizations.of(context)!
                                .settingsPage_reminderEnable,
                        child: CupertinoSwitch(
                          activeColor: secondaryColor,
                          value: provider.isDailyReminderActive,
                          onChanged: (value) async {
                            if (Platform.isIOS) {
                              customDialog(context);
                            } else {
                              scheduled.shceduledNews(value);
                              provider.enableDailyReminderActive(value);

                              value
                                  ? toast(AppLocalizations.of(context)!
                                      .settingsPage_reminder_activated)
                                  : toast(AppLocalizations.of(context)!
                                      .settingsPage_reminder_deactivated);
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
