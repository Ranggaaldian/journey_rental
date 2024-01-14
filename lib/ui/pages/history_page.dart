import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:journeyrental/ui/widgets/canceled_history_item.dart';
import 'package:journeyrental/ui/widgets/history_item.dart';
import 'package:journeyrental/ui/widgets/success_history_item.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with AutomaticKeepAliveClientMixin {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> activeCarList = [];
  List<Map<String, dynamic>> successCarList = [];
  List<Map<String, dynamic>> cancelCarList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    subscribeActiveCarListData();
  }

  Stream<List<Map<String, dynamic>>> subscribeActiveCarListData() {
    return firestore
        .collection('history')
        .where('status', isEqualTo: 'active')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<Map<String, dynamic>> data = [];
      for (final itemData in querySnapshot.docs) {
        data.add(itemData.data() as Map<String, dynamic>);
      }
      return data;
    });
  }

  Stream<List<Map<String, dynamic>>> subscribeSuccessCarListData() {
    return firestore
        .collection('history')
        .where('status', isEqualTo: 'success')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<Map<String, dynamic>> data = [];
      for (final itemData in querySnapshot.docs) {
        data.add(itemData.data() as Map<String, dynamic>);
      }
      return data;
    });
  }

  Stream<List<Map<String, dynamic>>> subscribeCancelCarListData() {
    return firestore
        .collection('history')
        .where('status', isEqualTo: 'cancel')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<Map<String, dynamic>> data = [];
      for (final itemData in querySnapshot.docs) {
        data.add(itemData.data() as Map<String, dynamic>);
      }
      return data;
    });
  }

  void cancelOrder(int id) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      print("Clicked with $id cancel");
      QuerySnapshot querySnapshot = await firestore
          .collection('history')
          .where('id', isEqualTo: id)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference documentReference =
            querySnapshot.docs.first.reference;

        await documentReference.update({
          'status': 'cancel',
        });
      } else {
        print('No order found with id $id');
      }
    } catch (e) {
      print(e);
      print('Error canceling order: $e');
    }
  }

  void completeOrder(int id) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      print("Clicked with $id");
      QuerySnapshot querySnapshot = await firestore
          .collection('history')
          .where('id', isEqualTo: id)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference documentReference =
            querySnapshot.docs.first.reference;

        await documentReference.update({
          'status': 'success',
        });
      } else {
        print('No order found with id $id');
      }
    } catch (e) {
      print('Error completing order: $e');
    }
  }

  void deleteOrder(int id) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('history')
          .where('id', isEqualTo: id)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference documentReference =
            querySnapshot.docs.first.reference;

        await documentReference.delete();
      } else {
        print('No order found with id $id');
      }
    } catch (e) {
      print('Error deleting order: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const SizedBox(height: 16),
            TabBar(
              labelColor: const Color(0xFF2C2B34),
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              tabs: [
                Tab(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Aktif'),
                  ),
                ),
                Tab(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Selesai'),
                  ),
                ),
                Tab(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Batal'),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // ! Content for Aktif Tab
                  StreamBuilder(
                    stream: subscribeActiveCarListData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Container(
                          padding: const EdgeInsets.all(42),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  HistoryItem(
                                    onCancelPressed: cancelOrder,
                                    onCompletePressed: completeOrder,
                                    id: snapshot.data![index]['id'],
                                    carModel: snapshot.data![index]
                                        ['car_model'],
                                    color: snapshot.data![index]['color'],
                                    capacity: snapshot.data![index]['capacity'],
                                    rentDuration: snapshot.data![index]
                                        ['rent_duration'],
                                    imagePath: snapshot.data![index]
                                        ['image_path'],
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),

                  // ? Content for Selesai Tab
                  StreamBuilder(
                    stream: subscribeSuccessCarListData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Container(
                          padding: const EdgeInsets.all(42),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  SuccessHistoryItem(
                                    carModel: snapshot.data![index]
                                        ['car_model'],
                                    color: snapshot.data![index]['color'],
                                    capacity: snapshot.data![index]['capacity'],
                                    rentDuration: snapshot.data![index]
                                        ['rent_duration'],
                                    imagePath: snapshot.data![index]
                                        ['image_path'],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),

                  // ? Content for Batal Tab
                  StreamBuilder(
                    stream: subscribeCancelCarListData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Container(
                          padding: const EdgeInsets.all(42),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  CanceledHistoryItem(
                                    onDeletePressed: deleteOrder,
                                    id: snapshot.data![index]['id'],
                                    carModel: snapshot.data![index]['car_model'],
                                    color: snapshot.data![index]['color'],
                                    capacity: snapshot.data![index]['capacity'],
                                    rentDuration: snapshot.data![index]
                                        ['rent_duration'],
                                    imagePath: snapshot.data![index]['image_path'],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
