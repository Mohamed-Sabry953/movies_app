import 'package:flutter/material.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Models/MoviePageModel.dart';
import 'package:movies_app/Shared/Constant/constant.dart';
import 'package:movies_app/Shared/Network/remote/API_Manger.dart';

class Movepage extends StatelessWidget {
  static const String routeName = 'MovePage';

  const Movepage({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as MoviePageModel;
    return Scaffold(
      backgroundColor: Color(0xff121312),
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Color(0xff1D1E1D),
        title: Text(
          args.name ?? "",
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
        ),
        iconTheme: IconThemeData(size: 35, color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assests/images/bg.jpg'),
                fit: BoxFit.fill)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image(
                  image: NetworkImage("${Constant.Image}${args.image}"),
                  fit: BoxFit.fill,
                  height: 175,
                  width: double.infinity,
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 50, right: 10),
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Center(
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.black,
                        size: 33,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        backgroundColor: Colors.white54,
                        fixedSize: Size(60, 60),
                        elevation: 0),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10),
              child: Text(
                args.name ?? '',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue.shade300),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 3),
              child: Text(
                args.date?.substring(0, 4) ?? '',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white54),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 30, top: 8),
              child: Row(
                children: [
                  Container(
                    width: 125,
                    height: 170,
                    decoration: BoxDecoration(color: Colors.grey),
                    child: Stack(
                      children: [
                        Image.network(
                          "${Constant.Image}${args.image}",
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          width: 40,
                          height: 40,
                          child: Stack(
                            alignment: AlignmentDirectional.topStart,
                            children: [
                              Icon(
                                Icons.bookmark_outlined,
                                color: Color(0xff514F4F),
                                size: 40,
                                weight: .5,
                              ),
                              Center(
                                  child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 15,
                              )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: .5,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              width: 80,
                              height: 40,
                              alignment: Alignment.center,
                              margin: EdgeInsetsDirectional.only(
                                  start: 15, bottom: 10),
                              child: Text(
                                'Adverture',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: .5,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              width: 80,
                              height: 40,
                              alignment: Alignment.center,
                              margin: EdgeInsetsDirectional.only(bottom: 10),
                              child: Text(
                                'funny',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            args.des ?? "",
                            maxLines: 4,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withAlpha(1000)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.star,
                                color: Color(0xffFFBB3B),
                                size: 30,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                "${args.rate}",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                " (${args.votecount})",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(thickness: 2,color: Colors.white,),
            FutureBuilder(
              future: API_Manager.SamularMovie(args.id ?? 0),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('something went error'));
                }
                var SamelurMovies = snapshot.data?.results ?? [];
                if (SamelurMovies.length == 0) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 35.0, right: 50, top: 100),
                    child: Center(
                        child: Text(
                      'no more like for this movie',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                          color: Colors.white),
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
                            'More like this',
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
                              return SizedBox(
                                width: 10,
                              );
                            },
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, Movepage.routeName,
                                      arguments: MoviePageModel(
                                        firebaseId: '',
                                        name:
                                            SamelurMovies[index].originalTitle ??
                                                "",
                                        date: SamelurMovies[index].releaseDate ??
                                            "",
                                        votecount:
                                            SamelurMovies[index].voteCount ?? 0,
                                        rate:
                                            SamelurMovies[index].voteAverage ?? 0,
                                        image:
                                            SamelurMovies[index].posterPath ?? "",
                                        des: SamelurMovies[index].overview ?? '',
                                        id: SamelurMovies[index].id ?? 0,
                                        fov: false,
                                      ));
                                },
                                child: Container(
                                  width: 110,
                                  decoration:
                                      BoxDecoration(color: Color(0xff1A1A1A)),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Image.network(
                                              "${Constant.Image}${SamelurMovies[index].posterPath ?? SamelurMovies[0].posterPath}",
                                              filterQuality: FilterQuality.high,
                                              fit: BoxFit.cover,
                                              width: 110,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            " ${SamelurMovies[index].originalTitle}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            " ${SamelurMovies[index].releaseDate}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        width: 40,
                                        height: 40,
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional.topStart,
                                          children: [
                                            Icon(
                                              Icons.bookmark_outlined,
                                              color: Color(0xff514F4F),
                                              size: 40,
                                              weight: .5,
                                            ),
                                            Center(
                                                child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 15,
                                            )),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: SamelurMovies.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 12,
            )
          ],
        ),
      ),
    );
  }
}
