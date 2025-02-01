import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:stockaxis_flutter_app/viewmodels/pricing_view_provider.dart';
import 'package:stockaxis_flutter_app/views/shared/constants/size_config.dart';
import 'package:stockaxis_flutter_app/views/shared/utils/app_theam.dart';
import 'package:stockaxis_flutter_app/views/ui/screens/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig.init;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PricingViewProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: appTheme,
        home: const SplashScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
