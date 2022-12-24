import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/newsApp/cubit/cubit.dart';
import 'package:news/layout/newsApp/cubit/states.dart';
import 'package:news/layout/newsApp/news_layout.dart';
import 'package:news/shared/bloc_observer.dart';
import 'package:news/shared/network/local/cache_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';

import 'shared/styles/themes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();

  bool? isDark;
  isDark = CacheHelper.getData(key: 'isDark');
  BlocOverrides.runZoned(
        () {
      runApp(MyApp(isDark: isDark,));
    },
    blocObserver: MyBlocObserver(),
  );}

class MyApp extends StatelessWidget {
  final bool? isDark;
  const MyApp({super.key, this.isDark});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => news()..getBusiness()..getScience()..getSports(),
      child: BlocConsumer<news,NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: isDark == true ? lightTheme : darkTheme,

            home: NewsLayout(),
          );
        },
      ),
    );
  }
}