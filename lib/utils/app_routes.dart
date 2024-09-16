import 'package:flutter/material.dart';
import 'package:untitled5/screen/account/account_screen.dart';
import 'package:untitled5/screen/chat/view/chat_screen.dart';
import 'package:untitled5/screen/home/view/home_screen.dart';
import 'package:untitled5/screen/login/view/signin_screen.dart';
import 'package:untitled5/screen/login/view/signup_screen.dart';
import 'package:untitled5/screen/profile/view/profile_screen.dart';
import 'package:untitled5/screen/splash/view/splash_screen.dart';
import 'package:untitled5/screen/user/view/user_screen.dart';

Map<String,WidgetBuilder>app_routes = {
  '/':(c1)=> const SplashScreen(),
  'signin':(c1)=> const SignInScreen(),
  'signup':(c1)=> const SignUpScreen(),
  'home':(c1)=> const HomeScreen(),
  'profile':(c1)=> const ProfileScreen(),
  'user':(c1)=> const UserScreen(),
  'chat':(c1)=> const ChatScreen(),
};