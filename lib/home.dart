import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/addpage.dart';
import 'package:shopping_list/service/shoppinglist_service.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final ShoppingListService _listService = ShoppingListService();
  bool modeicon = false;

  IconData _iconLight = Icons.wb_sunny;
  IconData _iconDark = Icons.nights_stay;

  ThemeData _darkTheme = ThemeData(
    primarySwatch: Colors.yellow,
    brightness: Brightness.dark,
  );

  ThemeData _lightTheme = ThemeData(
    primarySwatch: Colors.amber,
    brightness: Brightness.light,
  );

  void switchMode() {
    modeicon = !modeicon;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alış-Veriş Listesi"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_rounded),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddPageView())),
      ),
      body: SizedBox(
        width: 500,
        child: StreamBuilder(
          stream: _listService.getList(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? const CircularProgressIndicator()
                : ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot myPost = snapshot.data!.docs[index];

                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                          left: 15,
                          right: 15,
                        ),
                        child: Card(
                          color: Colors.amber.shade100,
                          child: ListTile(
                            leading: Text(
                              myPost['adet'],
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.amber.shade800,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            title: Text(myPost['malzeme']),
                            trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            content: const Text(
                                                "Bu malzemeyi alış-veriş listesinden silmek istediğinize emin misiniz?"),
                                            actions: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          _listService
                                                              .removeList(
                                                                  myPost.id);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child:
                                                            const Text("Evet")),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            "Hayır")),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ));
                                },
                                icon: const Icon(
                                  Icons.delete_rounded,
                                  color: Colors.red,
                                )),
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
