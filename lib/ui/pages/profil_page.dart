import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  // ! Add controllers to handle textfield
  TextEditingController usernameController = TextEditingController();

  String username = 'Loading...';
  String email = 'Loading...';

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    firestore
        .collection('user')
        .where('uid', isEqualTo: auth.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        username = value.docs.first['username'];
        email = value.docs.first['email'];
        usernameController.text = value.docs.first['username'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/rangga.jpg'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Edit Profil',
                                      ),
                                      TextField(
                                        controller: usernameController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          firestore
                                              .collection('user')
                                              .doc(auth.currentUser!.uid)
                                              .update({
                                            'username':
                                                usernameController.text,
                                          }).then((value) {
                                            getUserData();
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: const Text(
                                          'Simpan',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: const Icon(
                          Icons.edit,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                username,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C2B34),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 2),
              Text(
                email,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF2C2B34),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.stretch, // Align text to the left
                  children: [
                    Text(
                      '\nProfil',
                      style: GoogleFonts.montserrat(
                        color: const Color(0xFF2C2B34),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      'Profil, Account, dan Tentang Anda\n',
                      style: TextStyle(
                        color: Color(0xFF2C2B34),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/history',
                  );
                  // Code for History button
                  print('History pressed');
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft, // Align text to the left
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\nHistory',
                        style: TextStyle(
                          color: Color(0xFF2C2B34),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Berbagai Pemesanan Anda\n',
                        style: TextStyle(
                          color: Color(0xFF2C2B34),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Code for Account and About Me button
                  print('Account and About Me pressed');
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft, // Align text to the left
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\nCustomer Service',
                        style: TextStyle(
                          color: Color(0xFF2C2B34),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Jika Ada Pertanyaan Tentang App Ini\n',
                        style: TextStyle(
                          color: Color(0xFF2C2B34),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 0),
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('isLogin', false);

                    Navigator.pushReplacementNamed(
                      context,
                      '/login',
                    );

                    // Code for Logout button
                    print('Logout pressed');
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF2C2B34),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
