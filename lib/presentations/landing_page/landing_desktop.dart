import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nike_landing_page/utils/size_config.dart';

import '../../env.dart';
import '../../widget/blur_circle_widget.dart';
import '../../widget/gradient_button.dart';

import 'package:http/http.dart' as http;

class LandingDesktop extends StatefulWidget {
  const LandingDesktop({Key? key}) : super(key: key);

  @override
  State<LandingDesktop> createState() => _LandingDesktopState();
}

class _LandingDesktopState extends State<LandingDesktop> {
  late String title;
  late String subtitle;
  late String desc;
  late String image;

  late String image2;

  @override
  void initState() {
    super.initState();
    title = "";
    desc = "";
    image = "";
    subtitle = "";

    image2 = "";
  }

  List<bool> _hover = [false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
            SizeConfig.height_1_5,
          ) +
          EdgeInsets.only(left: SizeConfig.width_1),
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appBar(),
          SizedBox(
            height: SizeConfig.height_2,
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  right: SizeConfig.width_35,
                  top: SizeConfig.height_3,
                  child: BlurCircleWidget(
                    size: SizeConfig.imgSize_25 + SizeConfig.imgSize_2_5,
                  ),
                ),
                detailsColumn(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Image.network(
                    "$image",
                  ),
                  // height: SizeConfig.imgSize_80,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: BlurCircleWidget(
                      size: SizeConfig.imgSize_20 + SizeConfig.imgSize_2_5,
                    )),
                Positioned(
                  right: SizeConfig.width_40,
                  bottom: SizeConfig.height_3,
                  child: BlurCircleWidget(
                    size: SizeConfig.imgSize_20,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Product List",
                style: TextStyle(
                  fontSize: 50,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          "$image2",
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: 200,
                    color: Colors.black,
                  ),
                  Container(
                    height: 200,
                    width: 200,
                    color: Colors.black,
                  ),
                  Container(
                    height: 200,
                    width: 200,
                    color: Colors.black,
                  ),
                  Container(
                    height: 200,
                    width: 200,
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column detailsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          //default = belum ada data
          "HARTI",
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: SizeConfig.fs_05,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          "$subtitle",
          style: GoogleFonts.roboto(
            color: Color.fromARGB(255, 41, 36, 36),
            fontSize: 15,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(
          height: SizeConfig.height_1_5,
        ),
        // Container(
        //   width: SizeConfig.width_70,
        //   child: Text(
        //     "$desc",
        //     overflow: TextOverflow.ellipsis,
        //     style: GoogleFonts.roboto(
        //       color: AppBase.descTextColor,
        //       fontSize: SizeConfig.fs_03,
        //       fontWeight: FontWeight.w600,
        //       height: 1.3,
        //     ),
        //   ),
        // ),
        SizedBox(
          height: SizeConfig.height_2_5,
        ),
        GradiantButton(
          text: AppBase.addToCart,
          height: SizeConfig.height_3_5,
          onPressed: () async {
            var myresponse = await http.get(
              Uri.parse(
                "https://api.harti.xetia.io/product/v1/nft/collection/mime-earth",
              ),
            );
            if (myresponse.statusCode == 200) {
              //berhasil
              print('berhasil get data');

              Map<String, dynamic> data =
                  json.decode(myresponse.body) as Map<String, dynamic>;

              // print(data['response']);

              //===============================
              var myrespapi = await http.get(
                Uri.parse(
                  "https://api.harti.xetia.io/product/v1/nft/assets/?collection_slug=mime-earth&randoms=false&is_hide=true&limit=15&page=1",
                ),
              );

              if (myrespapi.statusCode == 200) {
                print('===============================================');
                print('berhasil get data 2');

                Map<String, dynamic> data2 =
                    json.decode(myrespapi.body) as Map<String, dynamic>;

                print(data2['response']);
              }
              //===============================

              setState(() {
                title = data['response']['name'].toString();
                subtitle = data['response']['collection_info']['collection']
                        ['name']
                    .toString();
                desc = data['response']['collection_info']['collection']
                        ['created_date']
                    .toString();
                image = data['response']['image'].toString();
                // print(image);
                image2 = data['response']['image_path'].toString();
                print(image2);
              });
            } else {
              //gagal
              print("ERROR ${myresponse.statusCode}");
            }

            // print(myresponse.statusCode);
            print('===============');
            print('===============');
          },
        )
      ],
    );
  }

  Row appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(),
        for (var i = 0; i < AppBase.headings.length; i++)
          InkWell(
            onTap: () {
              debugPrint('Tapped Desktop');
            },
            onHover: (bool value) {
              setState(() {
                _hover[i] = value;
              });
            },
            child: Text(
              AppBase.headings[i],
              style: GoogleFonts.roboto(
                color: _hover[i] ? Colors.pink : Colors.white,
                fontSize: SizeConfig.fs_1_2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        SizedBox(),
      ],
    );
  }
}
