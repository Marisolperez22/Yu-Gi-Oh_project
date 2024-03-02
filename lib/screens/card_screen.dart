import 'package:flutter/material.dart';

import '../models/card_model.dart';

class CardScreen extends StatefulWidget {
  final CardInfo card;

  const CardScreen({Key? key, required this.card}) : super(key: key);

  @override
  CardScreenState createState() => CardScreenState();
}

class CardScreenState extends State<CardScreen> {
  late String translatedName = '';
  late String translatedType = '';
  late String translatedAttribute = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final card = widget.card;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Id: ${card.id}',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/17547.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  height: size.height * 0.35,
                  width: double.infinity,
                  child: Hero(
                    tag: card.id!,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white, width: 10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          card.cardImages![0].imageUrlCropped.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Text('Datos de la carta',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    if (card.name != null) cardData('Name: ', card.name!),
                    const SizedBox(height: 10),
                    if (card.type != null) cardData('Type: ', card.type!),
                    const SizedBox(height: 10),
                    if (card.attribute != null)
                      cardData('Atributte: ', card.attribute!),
                    const SizedBox(height: 10),
                    if (card.level != null)
                      cardData('Level: ', card.level.toString()),
                    const SizedBox(height: 10),
                    if (card.race != null) cardData('Race: ', card.race!),
                    const SizedBox(height: 10),
                    if (card.atk != null)
                      cardData('ATK: ', card.atk.toString()),
                    const SizedBox(height: 10),
                    if (card.archetype != null)
                      cardData('Archetype: ', card.archetype!),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget cardData(String text1, String text2) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.859),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(
            text1,
            style: const TextStyle(fontSize: 20),
            overflow:
                TextOverflow.ellipsis, // Truncar el texto si es demasiado largo
            maxLines: 1, // Número máximo de líneas que el texto ocupará
          ),
          Flexible(
            child: Text(
              text2,
              style: const TextStyle(fontSize: 20),
              overflow: TextOverflow
                  .ellipsis, // Truncar el texto si es demasiado largo
              maxLines: 2, // Número máximo de líneas que el texto ocupará
            ),
          ),
        ],
      ),
    );
  }
}
