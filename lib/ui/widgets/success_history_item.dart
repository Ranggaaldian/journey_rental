import 'package:flutter/material.dart';

class SuccessHistoryItem extends StatelessWidget {
  final String carModel;
  final String color;
  final int capacity;
  final int rentDuration;
  final String imagePath;

  const SuccessHistoryItem({
    super.key,
    required this.carModel,
    required this.color,
    required this.capacity,
    required this.rentDuration,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(17),
          height: MediaQuery.of(context).size.height / 5,
          decoration: BoxDecoration(
            color: const Color(0xFF2C2B34),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      carModel,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "> Warna: $color",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "> Kapasitas : ${capacity.toString()} Orang",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "> Penyewaan : ${rentDuration.toString()} Hari",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Image.asset(
                  imagePath,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 5,
          decoration: BoxDecoration(
            color: const Color(0xFF2C2B34).withOpacity(0.65),
            borderRadius: BorderRadius.circular(8),
          ),
        )
      ],
    );
  }
}
