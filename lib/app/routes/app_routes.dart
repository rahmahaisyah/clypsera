part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const home = _Paths.home;
  static const login = _Paths.login;
  static const splashScreen = _Paths.splashScreen;
  static const bottomnavigation = _Paths.bottomnavigation;
  static const news = _Paths.news;
  static const profile = _Paths.profile;
  static const detailPatient = _Paths.detailPatient;
  static const listPatient = _Paths.listPatient;
  static const FORGET_PASSWORD = _Paths.FORGET_PASSWORD;
}

abstract class _Paths {
  _Paths._();
  static const home = '/home';
  static const login = '/login';
  static const splashScreen = '/splash-screen';
  static const bottomnavigation = '/bottomnavigation';
  static const news = '/news';
  static const profile = '/profile';
  static const detailPatient = '/detail-patient';
  static const listPatient = '/list-patient';
  static const FORGET_PASSWORD = '/forget-password';
}
