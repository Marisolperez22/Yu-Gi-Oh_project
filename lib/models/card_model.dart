import 'dart:convert';

CardResponse cardResponseFromJson(String str) =>
    CardResponse.fromJson(json.decode(str));

String cardResponseToJson(CardResponse data) => json.encode(data.toJson());

class CardResponse {
  final List<CardInfo>? data;

  CardResponse({this.data});

  factory CardResponse.fromJson(Map<String, dynamic> json) => CardResponse(
        data: json["data"] == null
            ? []
            : List<CardInfo>.from(
                json["data"]!.map((x) => CardInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CardInfo {
  final int? id;
  final String? name;
  final String? type;
  final String? attribute;
  final int? level;
  final int? atk;
  final String? race;
  final String? archetype;
  final Map<String, dynamic>? banlistInfo;
  final List<CardImage>? cardImages;

  CardInfo({
    this.id,
    this.name,
    this.type,
    this.attribute,
    this.level,
    this.race,
    this.atk,
    this.archetype,
    this.banlistInfo,
    this.cardImages,
  });

  factory CardInfo.fromJson(Map<String, dynamic> json) => CardInfo(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        attribute: json["attribute"],
        level: json["level"],
        race: json["race"],
        atk: json["atk"],
        archetype: json["archetype"],
        banlistInfo: json["banlist_info"],
        cardImages: json["card_images"] == null
            ? []
            : List<CardImage>.from(
                json["card_images"]!.map((x) => CardImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "attribute": attribute,
        "level": level,
        "race": race,
        "atk": atk,
        "archetype": archetype,
        "banlistInfo": banlistInfo,
        "cardImages": cardImages == null
            ? []
            : List<CardImage>.from(cardImages!.map((x) => x.toJson())),
      };
}

class CardImage {
  int? id;
  String? imageUrl;
  String? imageUrlSmall;
  String? imageUrlCropped;

  CardImage({
    this.id,
    this.imageUrl,
    this.imageUrlSmall,
    this.imageUrlCropped,
  });
  factory CardImage.fromJson(Map<String, dynamic> json) => CardImage(
        id: json["id"],
        imageUrl: json["image_url"],
        imageUrlSmall: json["image_url_small"],
        imageUrlCropped: json["image_url_cropped"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
        "image_url_small": imageUrlSmall,
        "image_url_cropped": imageUrlCropped,
      };
}

class BanListInfo {
  String? banTCG;
  String? banOCG;
  String? banGOAT;

  BanListInfo({
    this.banTCG,
    this.banOCG,
    this.banGOAT,
  });

  factory BanListInfo.fromJson(Map<String, dynamic> json) => BanListInfo(
        banTCG: json["ban_tcg"],
        banOCG: json["ban_ocg"],
        banGOAT: json["ban_goat"],
      );
}
