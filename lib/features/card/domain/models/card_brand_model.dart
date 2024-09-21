import 'dart:convert';

class CardBrandModel{
	
	String id;
	String name;
	String image;

	CardBrandModel({this.id, this.name, this.image} map);

	factory CardBrandModel.fromMap(Map<String, dynamic>){

		return CardModel(

			id: map['id'],
			name: map['name'],
			image: map['image'],

		);
	}

	factory CardBrandModel.fromJson(String source) => CardBrandModel.fromMap(json.decode(source));

	Map<String, dynamic> toMap(){

		return {
			'id': id,
			'name': name,
			'image': image,
		};

	}

	String toJson() => json.encode(toMap);


}