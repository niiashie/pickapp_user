import 'package:pickappuser/providers/dashBoardProvider.dart';
import 'package:pickappuser/providers/loginProvider.dart';
import 'package:pickappuser/providers/newOrder.provider.dart';
import 'package:pickappuser/providers/registrationProvider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:pickappuser/providers/emailVerificationProvider.dart';
import 'package:pickappuser/providers/drawer.provider.dart';

List<SingleChildWidget>providers = [
  ChangeNotifierProvider<LoginProvider>.value(value: LoginProvider()),
  ChangeNotifierProvider<RegistrationProvider>.value(value: RegistrationProvider()),
  ChangeNotifierProvider<EmailVerificationProvider>.value(value: EmailVerificationProvider()),
  ChangeNotifierProvider<DrawerStateInfo>.value(value: DrawerStateInfo()),
  ChangeNotifierProvider<NewOrderProvider>.value(value: NewOrderProvider()),
  ChangeNotifierProvider<DashBoardProvider>.value(value: DashBoardProvider())
];
