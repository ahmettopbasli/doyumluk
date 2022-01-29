import 'package:doyumluk/cubit/anasayfa_cubit.dart';
import 'package:doyumluk/entity/yemekler.dart';
import 'package:doyumluk/views/giris_sayfa.dart';
import 'package:doyumluk/views/sepet_sayfa.dart';
import 'package:doyumluk/views/yemek_detay_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Anasayfa extends StatefulWidget {
  String kullaniciAdi;

  Anasayfa(this.kullaniciAdi);

  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.redAccent,
          leading: IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GirisSayfa()));
          }, icon: Icon(Icons.account_circle)),
          title: Text("Doyumluk",style: TextStyle(fontFamily: "Baslik",fontSize: 30),),
          actions: [IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SepetSayfa(widget.kullaniciAdi)));
          }, icon: Icon(Icons.shopping_basket))],
        ),
        body: BlocBuilder<AnasayfaCubit,List<Yemekler>>(
          builder: (context,yemeklerListesi){
            if(yemeklerListesi.isNotEmpty){
              return ListView.builder(
                itemCount: yemeklerListesi.length,
                itemBuilder: (context,indeks){
                  var yemek = yemeklerListesi[indeks];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => YemekDetaySayfa(yemek: yemek,kullaniciAdi: widget.kullaniciAdi,)));
                    },
                    child: Card(
                      child: SizedBox(height: 100,
                        child: Row(
                          children: [
                            Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
                            Padding(
                              padding: const EdgeInsets.only(left: 40.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("${yemek.yemek_adi}",style: TextStyle(fontSize: 20),),
                                  Text("${yemek.yemek_fiyat}₺",style: TextStyle(fontSize: 20),)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }else{
              return Center();
            }
          },
        )
    );
  }
}
