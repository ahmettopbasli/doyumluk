import 'package:doyumluk/cubit/sepet_sayfa_cubit.dart';
import 'package:doyumluk/entity/sepet_yemekler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetSayfa extends StatefulWidget {
  String kullaniciAdi;

  SepetSayfa(this.kullaniciAdi);

  @override
  _SepetSayfaState createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {

  @override
  void initState() {
    super.initState();
    context.read<SepetSayfaCubit>().sepettekiYemekleriYukle(widget.kullaniciAdi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Sepet",style: TextStyle(fontSize: 20),)
      ),
      body: BlocBuilder<SepetSayfaCubit,List<SepetYemekler>>(
        builder: (context,sepettekiYemeklerListesi){
          if(sepettekiYemeklerListesi.isNotEmpty){
            return Column(
              children : [ Expanded(
                child: ListView.builder(
                  itemCount: sepettekiYemeklerListesi.length,
                  itemBuilder: (context,indeks){
                    var sepettekiYemek = sepettekiYemeklerListesi[indeks];
                    return Card(
                      child: SizedBox(height: 80,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Text("${sepettekiYemek.yemek_siparis_adet}"),
                            ),
                            Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${sepettekiYemek.yemek_resim_adi}"),
                            Padding(
                              padding: const EdgeInsets.only(left: 40.0,top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${sepettekiYemek.yemek_adi}"),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Text("${int.parse(sepettekiYemek.yemek_fiyat)*int.parse(sepettekiYemek.yemek_siparis_adet)}₺",
                                      style: TextStyle(color: Colors.redAccent),),
                                  )
                                ],
                              ),
                            ),
                            Spacer(),
                            IconButton(onPressed: (){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("${sepettekiYemek.yemek_adi} sepetten silinsin mi ?"),
                                  action: SnackBarAction(
                                    label: "Evet",
                                    onPressed: (){
                                      context.read<SepetSayfaCubit>().sepettenYemekSil(sepettekiYemek.sepet_yemek_id, widget.kullaniciAdi);
                                    },
                                  ),));
                            }, icon: Icon(Icons.delete_outline,color: Colors.red,))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(onPressed: (){}, child: Text("Sipariş Ver"),style: ElevatedButton.styleFrom(primary: Colors.redAccent),)]
            );
          }else{
            return Center(
              child: Text("Sepet Boş"),
            );
          }
        },
      ),
    );
  }
}
