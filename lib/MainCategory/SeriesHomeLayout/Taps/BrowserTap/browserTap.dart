import 'package:flutter/material.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Models/MoviePageModel.dart';
import 'package:movies_app/Shared/Constant/constant.dart';
import 'package:movies_app/Shared/Network/remote/API_Manger.dart';
import 'package:movies_app/provider/Myprovider.dart';
import 'package:provider/provider.dart';

import 'MovieByCategory.dart';

class SeriesBrowserTap extends StatelessWidget {
  List<String?> Images = [
    "/4m1Au3YkjqsxF8iwQy0fPYSxE0h.jpg",
    "/sGm09gLVyICQl8lVIHpmHZAgSNq.jpg",
    "/gPbM0MK8CP8A174rmUwGsADNYKD.jpg",
    "/n1hqbSCtyBAxaXEl1Dj3ipXJAJG.jpg",
    "/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg",
    "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
    "/ktejodbcdCPXbMMdnpI9BUxW6O8.jpg",
    "/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
    "/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg",
    "/Af4bXE63pVsb2FtbW8uYIyPBadD.jpg",
    "/5gzzkR7y3hnY8AD1wXjCnVlHba5.jpg",
    "/fiVW06jE7z9YnO4trhaMEdclSiC.jpg",
    "/vB8o2p4ETnrfiWEgVxHmHWP9yRl.jpg",
    "/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg",
    "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
    "/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg",
    "/ktejodbcdCPXbMMdnpI9BUxW6O8.jpg",
    "/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg",
    "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
    "/fiVW06jE7z9YnO4trhaMEdclSiC.jpg",
    "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
    "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
    "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
    "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
    "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
    "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
    "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
    "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
    "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
    "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xff121312),
      body: Container(
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assests/images/bg.jpg'),fit: BoxFit.fill)),
        child: Column(
          children: [
            Container(
                alignment: AlignmentDirectional.topStart,
                margin:
                    EdgeInsetsDirectional.only(top: 35, start: 20, bottom: 20),
                child: Text(
                  'Browse Category',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 23),
                )),
            FutureBuilder(
              future: API_Manager.Category2(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Something went wrong'));
                }
                var Category = snapshot.data?.genres ?? [];
                return Expanded(
                  child: GridView.builder(
                      itemCount: Category.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, SeriesCategory.routeName,
                                arguments: MoviePageModel(
                                  firebaseId: '',
                                    name: Category[index].name,
                                    date: "date",
                                    votecount: 0,
                                    rate: 0,
                                    image: "image",
                                    des: "des",
                                    id: Category[index].id,
                                    fov: false));
                          },
                          child: Container(
                            margin: EdgeInsetsDirectional.only(
                                start: 10, end: 10, bottom: 15, top: 15),
                            child: Stack(
                              children: [
                                Image(
                                  image: NetworkImage(
                                      "${Constant.Image}${Images[index]}"),
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  height: 150,
                                ),
                                Center(
                                    child: Text(
                                  Category[index].name ?? '',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                )),
                              ],
                            ),
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2)),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
