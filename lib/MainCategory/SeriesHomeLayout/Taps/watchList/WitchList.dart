import 'package:flutter/material.dart';
import 'package:movies_app/Shared/Network/Firebase/FirebaseFunction.dart';
import 'package:movies_app/provider/Myprovider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'WatchListContent.dart';

class SeriesWatchList extends StatefulWidget {
   SeriesWatchList ({super.key});

  @override
  State<SeriesWatchList> createState() => _SeriesWatchListState();
}

class _SeriesWatchListState extends State<SeriesWatchList> {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xff121312),
      body: Container(
        decoration:BoxDecoration(
            image: provider.mode==ThemeMode.light?DecorationImage(
                image: AssetImage('assests/images/bg.jpg'),
                fit: BoxFit.fill):DecorationImage(
                image: AssetImage('assests/images/blackbg.jpg'),
                fit: BoxFit.fill)),
        child: Column(
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
                              AppLocalizations.of(context)!.nomoviesadd,
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
      ),
    );
  }
}
