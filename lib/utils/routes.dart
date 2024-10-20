import 'package:bezzie_app/pages/chat_page.dart';
import 'package:bezzie_app/pages/home_page.dart';
import 'package:bezzie_app/pages/sign_in_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = {
  '/': (context) => const SignInPage(),
  '/home': (context) => const HomePage(),
  'home/chat': (context) => const ChatPage(),
};