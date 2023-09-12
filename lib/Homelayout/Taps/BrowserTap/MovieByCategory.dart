import 'package:flutter/material.dart';
import 'package:movies_app/Models/MoviePageModel.dart';
import 'package:movies_app/Shared/Constant/constant.dart';
import 'package:movies_app/Shared/Network/Firebase/FirebaseFunction.dart';
import 'package:movies_app/Shared/Network/remote/API_Manger.dart';

import '../Home/Movepage.dart';

class MovieCategory extends StatelessWidget {
  static const String routeName = "MovieByCategory";

  const MovieCategory({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as MoviePageModel;
    return Scaffold(
      backgroundColor: Color(0xff121312),
      body: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFunction.getMovie(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('something went error'));
              }
              var SearchMovies =
                  snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
              if (SearchMovies.length == 0) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 35.0, right: 50, top: 250),
                  child: Center(
                      child: Column(
                    children: [
                      Image(image: AssetImage('assests/images/movieFound.png')),
                      Text(
                        'No movies found',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            color: Colors.white),
                      ),
                    ],
                  )),
                );
              }
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 12, bottom: 12),
                        child: Text(
                          'Your Search',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 10),
                              child: Divider(
                                thickness: 1.5,
                                endIndent: 15,
                                color: Colors.white,
                              ),
                            );
                          },
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, Movepage.routeName,
                                    arguments: MoviePageModel(
                                      firebaseId: '',
                                      name: SearchMovies[index].name ?? "",
                                      date: SearchMovies[index].date ?? "",
                                      votecount:
                                          SearchMovies[index].votecount ?? 0,
                                      rate: SearchMovies[index].rate ?? 0,
                                      image: SearchMovies[index].image ?? "",
                                      des: SearchMovies[index].des ?? '',
                                      id: SearchMovies[index].id ?? 0,
                                      fov: false,
                                    ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          '${Constant.Image}${SearchMovies[index].image ?? SearchMovies[0].image}',
                                          fit: BoxFit.fill,
                                          width: 170,
                                          height: 105,
                                          filterQuality: FilterQuality.high,
                                        ),
                                      ),
                                      Container(
                                        alignment:
                                            AlignmentDirectional.topStart,
                                        width: 30,
                                        height: 30,
                                        child: Stack(
                                          children: [
                                            Icon(
                                              Icons.bookmark_outlined,
                                              color: Color(0xff514F4F),
                                              size: 30,
                                              weight: .5,
                                            ),
                                            Center(
                                                child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 12,
                                            )),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.only(left: 50, top: 25),
                                        alignment: Alignment.center,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Center(
                                            child: Icon(
                                              Icons.play_arrow,
                                              color: Colors.black,
                                              size: 25,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              shape: CircleBorder(),
                                              backgroundColor: Colors.white54,
                                              fixedSize: Size(40, 40),
                                              elevation: 0),
                                        ),
                                      ),
                                    ]),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(SearchMovies[index].name ?? '',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                              fontSize: 16)),
                                          Text(SearchMovies[index].date ?? '',style: TextStyle(
                                              color: Colors.white70,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),),
                                          Text(
                                            SearchMovies[index].des ?? '',
                                            maxLines: 2,style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: SearchMovies.length,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
