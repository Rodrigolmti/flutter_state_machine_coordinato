import 'package:coordinator/core/coordinator.dart';
import 'package:coordinator/ui/account_create_screen.dart';
import 'package:coordinator/ui/email_screen.dart';
import 'package:coordinator/ui/name_screen.dart';
import 'package:coordinator/ui/personal_data_screen.dart';
import 'package:flutter/material.dart';

const personalDataScreen = '/personal-data';
const nameScreen = '/name';
const emailScreen = '/email';
const root = '/';

PageRoute routeGeneration(RouteSettings settings) {
  late WidgetBuilder builder;
  switch (settings.name) {
    case root:
      builder = (_) => const AccountCreatedScreen();
      break;
    case personalDataScreen:
      builder = (_) => PersonalDataScreen(
            coordinator: settings.arguments as Coordinator,
          );
      break;
    case nameScreen:
      builder = (_) => const NameScreen();
      break;
    case emailScreen:
      builder = (_) => EmailScreen(
            coordinator: settings.arguments as Coordinator,
          );
      break;
  }

  return MaterialPageRoute(builder: builder, settings: settings);
}
