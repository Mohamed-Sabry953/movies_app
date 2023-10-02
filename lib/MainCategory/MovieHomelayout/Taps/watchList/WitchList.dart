import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Cubit/MovieCubit.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Cubit/States.dart';
import 'package:movies_app/provider/Myprovider.dart';
import 'package:provider/provider.dart';
import 'WatchListContent.dart';

class WatchList extends StatelessWidget {
   WatchList ({super.key});

  @override

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return  BlocProvider(create: (context) => MovieHomelayoutCubit()..data(),
      child: BlocConsumer<MovieHomelayoutCubit,MovieHomeLayoutStates>(builder: (context, state) {
        return Padding(
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
                    return WatchListContent(MovieHomelayoutCubit.get(context).getData[index],index);
                  },
                  itemCount: MovieHomelayoutCubit.get(context).getData.length,
                ),
              ),
            ],
          ),
        );
      }, listener: (context, state) {
        if(state is GetNowPlayingMovieErrorState){
          Text('error');
        }
        else if(state is GetNowPlayingMovieSucssesState){
        }
        else if(state is MovieHomeLoadingState){
          CircularProgressIndicator();
        }
      },));
  }
}
