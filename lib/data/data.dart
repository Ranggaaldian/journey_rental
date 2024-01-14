import 'package:flutter/material.dart';

class NavigationItem {
  IconData iconData;

  NavigationItem(this.iconData);
}

List<NavigationItem> getNavigationItemList() {
  return <NavigationItem>[
    NavigationItem(Icons.home),
    NavigationItem(Icons.calendar_today),
    NavigationItem(Icons.person),
  ];
}

class Car {
  int id;
  String brand;
  String model;
  double price;
  String condition;
  List<String> images;

  Car(
    this.id,
    this.brand,
    this.model,
    this.price,
    this.condition,
    this.images,
  );
}

List<Car> getCarList() {
  return <Car>[
    Car(
      1,
      "Avanza",
      "Toyota",
      2580,
      "Bali",
      [
        ""
            "assets/images/avanza.png",
        "assets/images/avanza3.png",
        "assets/images/avanza2.png",
      ],
    ),
    Car(
      2,
      "Innova",
      "Toyota",
      3580,
      "Bandung",
      [
        "assets/images/innova.png",
      ],
    ),
    Car(
      3,
      "Brio",
      "Honda",
      1100,
      "Jogja",
      [
        "assets/images/brio.png",
        "assets/images/brio2.png",
      ],
    ),
    Car(
      4,
      "Ayla",
      "Daihatsu",
      2200,
      "Pati",
      [
        "assets/images/ayla.png",
        "assets/images/ayla2.png",
      ],
    ),
    Car(
      5,
      "Yaris",
      "Toyota",
      3400,
      "Kudus",
      [
        "assets/images/yaris.png",
        "assets/images/yaris2.png",
      ],
    ),
    Car(
      6,
      "Agya",
      "Daihatsu",
      4200,
      "Rembang",
      [
        "assets/images/agya2.png",
        "assets/images/agya.png",
      ],
    ),
    Car(
      7,
      "Xenia",
      "Daihatsu",
      2300,
      "Rembang",
      [
        "assets/images/xenia.png",
        "assets/images/xenia2.png",
      ],
    ),
    Car(
      8,
      "Hrv",
      "Honda",
      1450,
      "Semarang",
      [
        "assets/images/hrv2.png",
        "assets/images/hrv.png",
      ],
    ),
    Car(
      9,
      "Alphard",
      "Toyota",
      900,
      "Solo",
      [
        "assets/images/alphard.png",
      ],
    ),
    Car(
      10,
      "Almaz",
      "SGMW",
      1200,
      "Surakarta",
      [
        "assets/images/almaz.png",
        "assets/images/almaz2.png",
      ],
    ),
  ];
}

class Dealer {
  String name;
  int offers;
  String image;

  Dealer(this.name, this.offers, this.image);
}

List<Dealer> getDealerList() {
  return <Dealer>[
    Dealer(
      "Honda",
      174,
      "assets/images/honda.png",
    ),
    Dealer(
      "Yamaha",
      126,
      "assets/images/yamaha.png",
    ),
    Dealer(
      "Toyota",
      89,
      "assets/images/toyota.png",
    ),
  ];
}

class Filter {
  String name;

  Filter(this.name);
}

List<Filter> getFilterList() {
  return <Filter>[
    Filter("Best Match"),
    Filter("Highest Price"),
    Filter("Lowest Price"),
  ];
}
