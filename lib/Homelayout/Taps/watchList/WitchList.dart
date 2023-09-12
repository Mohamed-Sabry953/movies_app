import 'package:flutter/material.dart';
import 'package:movies_app/Shared/Network/Firebase/FirebaseFunction.dart';
import 'package:movies_app/provider/Myprovider.dart';
import 'package:provider/provider.dart';

import 'WatchListContent.dart';

class WatchList extends StatefulWidget {
   WatchList ({super.key});

  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  @override
  Widget build(BuildContext context) {
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
                            'No movies add',
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
                          'Your WatchList',
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
                            return WatchListContent(SearchMovies[index]);
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