import 'package:flutter/material.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Models/MoviePageModel.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Taps/Home/Movepage.dart';
import 'package:movies_app/Shared/Constant/constant.dart';
import 'package:movies_app/Shared/Network/Firebase/FirebaseFunction.dart';

class WatchListContent extends StatefulWidget {
  MoviePageModel moviePageModel;
   WatchListContent(this.moviePageModel,{super.key});

  @override
  State<WatchListContent> createState() => _WatchListContentState();
}

class _WatchListContentState extends State<WatchListContent> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Movepage.routeName,
            arguments: MoviePageModel(
              firebaseId: '',
              name: widget.moviePageModel.name ?? "",
              date: widget.moviePageModel.date ?? "",
              votecount:
              widget.moviePageModel.votecount ?? 0,
              rate: widget.moviePageModel.rate ?? 0,
              image: widget.moviePageModel.image ?? "",
              des: widget.moviePageModel.des ?? '',
              id: widget.moviePageModel.id ?? 0,
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
                  '${Constant.Image}${widget.moviePageModel.image ?? widget.moviePageModel.image}',
                  fit: BoxFit.fill,
                  width: 170,
                  height: 105,
                  filterQuality: FilterQuality.high,
                ),
              ),
              InkWell(
                onTap: () {
                  FirebaseFunction.DeleteData(widget.moviePageModel.firebaseId);
                },
                child: Container(
                  alignment:
                  AlignmentDirectional.center,
                  width: 45,
                  height: 40,
                  child: Stack(
                    children: [
                      Icon(
                        Icons.bookmark_outlined,
                        color: Color(0xffF7B539),
                        size: 45,
                        weight: .5,
                      ),
                      Center(
                          child: Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 18,
                          )),
                    ],
                  ),
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
                  Text(widget.moviePageModel.name ?? '',
                      style: TextStyle(
                          color: Colors.yellow,
                          fontWeight: FontWeight.w600,
                          fontSize: 18)),
                  SizedBox(height: 2,),
                  Text(widget.moviePageModel.date ?? '',style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),),
                  SizedBox(height: 2,),
                  Text(
                    "${widget.moviePageModel.des ?? ''}...",
                    maxLines: 2,style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                  ),
                  SizedBox(height: 2,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
