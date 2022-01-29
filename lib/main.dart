import 'package:doyumluk/cubit/anasayfa_cubit.dart';
import 'package:doyumluk/cubit/sepet_sayfa_cubit.dart';
import 'package:doyumluk/cubit/yemek_detay_sayfa_cubit.dart';
import 'package:doyumluk/views/giris_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AnasayfaCubit()),
        BlocProvider(create: (context) => YemekDetaySayfaCubit()),
        BlocProvider(create: (context) => SepetSayfaCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: GirisSayfa(),
      ),
    );
  }
}
