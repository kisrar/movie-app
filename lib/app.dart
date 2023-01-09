import 'package:flutter/material.dart';
import 'locator.dart';
import 'package:provider/provider.dart';
import 'repo/home_repo.dart';
import 'view_models/view_models.dart';
import 'views/views.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                HomeViewModel(homeRepository: locator<HomeRepository>()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: const HomeScreen(),
      ),
    );
  }
}
