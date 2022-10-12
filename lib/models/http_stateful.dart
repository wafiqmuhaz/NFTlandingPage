// import 'dart:convert';

// import 'package:http/http.dart' as http;

// class HttpStateful {
//   String name, owner, image_url, description;

//   HttpStateful ({required this.name,required this.owner,required this.image_url,required this.description})

//   Future<HttpStateful> connectAPI (String name) async {

//     Uri url = Uri.parse("https://api.harti.xetia.io/product/v1/nft/collection/mime-earth");

//     var hasilResponse = await http.get(url);

//     var data = json..decode(hasilResponse.body);

//   }

// }
