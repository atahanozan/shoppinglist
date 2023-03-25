import 'package:flutter/material.dart';
import 'package:shopping_list/home.dart';
import 'package:shopping_list/service/shoppinglist_service.dart';

class AddPageView extends StatefulWidget {
  const AddPageView({Key? key}) : super(key: key);

  @override
  State<AddPageView> createState() => _AddPageViewState();
}

class _AddPageViewState extends State<AddPageView> {
  final TextEditingController _malzemecontroller = TextEditingController();
  final ShoppingListService _listService = ShoppingListService();

  int adet = 1;

  void plusOne() {
    setState(() {
      adet++;
    });
  }

  void minusOne() {
    if (adet > 1) {
      setState(() {
        adet--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listeye Ekle"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(flex: 1, child: Text("Malzeme Adı:")),
                Expanded(
                  flex: 2,
                  child: TextField(
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    controller: _malzemecontroller,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  const Expanded(flex: 1, child: Text("Malzeme Adedi:")),
                  Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                minusOne();
                              },
                              child: const Text("-")),
                          Text(
                            adet.toString(),
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                plusOne();
                              },
                              child: const Text("+")),
                        ],
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePageView())),
                      child: const Text("İptal")),
                  ElevatedButton(
                      onPressed: () {
                        _listService.addList(
                            _malzemecontroller.text, adet.toString());
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text(
                                      "$adet adet ${_malzemecontroller.text}, malzeme listesine eklendi."),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _malzemecontroller.clear();
                                      },
                                      child: const Text("Tamam"),
                                    )
                                  ],
                                ));
                      },
                      child: const Text("Ekle"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
