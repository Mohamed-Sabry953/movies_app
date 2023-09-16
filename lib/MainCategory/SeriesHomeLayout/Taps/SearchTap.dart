import 'package:flutter/material.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Models/MoviePageModel.dart';
import 'package:provider/provider.dart';
import '../../../Shared/Constant/constant.dart';
import '../../../Shared/Network/remote/API_Manger.dart';
import '../../../provider/Myprovider.dart';
import 'Home/seriespage.dart';

class SeriesSearchTap extends StatefulWidget {
  const SeriesSearchTap({super.key});

  @override
  State<SeriesSearchTap> createState() => _SeriesSearchTapState();
}

class _SeriesSearchTapState extends State<SeriesSearchTap> {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xff121312),
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assests/images/bg.jpg'),fit: BoxFit.fill)),
        child: Column(
          children: [
            Container(
              height: 50,
              margin: EdgeInsetsDirectional.only(start: 20,end: 20,top: 15),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              color: Color(0xff514F4F),

              ),
              child: TextFormField(
                initialValue: provider.parm,
                onChanged: (value) {
                  provider.Search(value);
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search,color: Colors.white,),
                  fillColor: Color(0xff514F4F),
                  enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                color: Colors.blue.shade300,

                ),
                  borderRadius: BorderRadius.circular(20)
              ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue.shade300,

                      ),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  hintText: "Search",
                  hintStyle:TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),
                  contentPadding: EdgeInsetsDirectional.only(
                    top: 14
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: API_Manager.SearchSeries(provider.parm??""),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('something went error'));
                }
                var SearchMovies = snapshot.data?.results ?? [];
                if(SearchMovies.length==0){
                  return Padding(
                    padding: const EdgeInsets.only(left: 35.0,right: 50,top: 250),
                    child: Center(child: Column(
                      children: [
                        Image(image: AssetImage('assests/images/movieFound.png')),
                        Text('No movies found',style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,color: Colors.white
                        ),),
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
                          padding: const EdgeInsets.only(left: 8.0,top: 12,bottom: 12),
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
                                padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                                child: Divider(color: Colors.white,thickness: 2),
                              );
                            },
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, Movepage.routeName,
                                      arguments: MoviePageModel(
                                        firebaseId: '',
                                        name: SearchMovies[index].name??"",
                                         date: SearchMovies[index].firstAirDate??"",
                                        votecount: SearchMovies[index].voteCount??0,
                                        rate: SearchMovies[index].voteAverage??0,
                                        image: SearchMovies[index].posterPath??"",
                                        des: SearchMovies[index].overview??'',
                                        id: SearchMovies[index].id??0, fov: false,));
                                },
                                child: Container(
                                  padding: EdgeInsetsDirectional.all(5),
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  height: 260,
                                  child: Stack(children: [
                                    Image.network(
                                      '${Constant.Image}${SearchMovies[index].posterPath??SearchMovies[0].posterPath}',
                                      fit: BoxFit.fill,
                                      width: double.infinity,
                                      height: 180,
                                      filterQuality: FilterQuality.high,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 70, left: 10),
                                          child: Container(
                                            decoration: BoxDecoration(color: Colors.grey),
                                            child: Stack(
                                              children: [
                                                Image.network(
                                                  "${Constant.Image}${SearchMovies[index].posterPath??SearchMovies[0].posterPath}",
                                                  filterQuality: FilterQuality.high,
                                                ),
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  child: Stack(
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
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          child: Expanded(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "${SearchMovies[index].name}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.yellowAccent),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${SearchMovies[index].firstAirDate}",
                                                  style: TextStyle(color: Colors.white70),
                                                ),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(bottom: 50, right: 10),
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        onPressed: () {
                                        },
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
                                  ]),
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
      ),
    );
  }
}
