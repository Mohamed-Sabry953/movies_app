import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_app/MainCategory/MovieHomelayout/Homelayout.dart';
import 'package:movies_app/MainCategory/SeriesHomeLayout/Homelayout.dart';

class CategoryHome extends StatelessWidget {
  static const routeName="CategoryHome";
  const CategoryHome({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight
    ]);
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assests/images/bg.jpg"),fit: BoxFit.fill,)
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.search,color: Colors.white,size: 40,),
                    SizedBox(width: 5,),
                    Text(DateTime.now().toString().substring(0,16),style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                    ),),
                    Spacer(),
                    ImageIcon(AssetImage('assests/images/movies.png'),size: 45,)
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(context, MovieHomelayout.routeName,(route) => false,arguments: Text('movies'));
                    },
                    child: Container(
                      height: 220,
                      width: 170,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white,width: 2,),
                        borderRadius: BorderRadiusDirectional.circular(12),
                        image: DecorationImage(image: AssetImage("assests/images/moviesCatgory.png"),fit: BoxFit.cover,)
                      ),
                      child: Center(
                        child: Text('Movies',style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(context, SeriesHomelayout.routeName,(route) => false,arguments: Text('Series'));
                    },
                    child: Container(
                      height: 220,
                      width: 170,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white,width: 2,),
                          borderRadius: BorderRadiusDirectional.circular(12),
                          image: DecorationImage(image: AssetImage("assests/images/seriesCategory.jpg"),fit: BoxFit.fill,)
                      ),
                      child: Center(
                        child: Text('Series',style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    height: 220,
                    width: 170,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white,width: 4,),
                        borderRadius: BorderRadiusDirectional.circular(12),
                        image: DecorationImage(image: AssetImage("assests/images/sportsCategory.jpg"),fit: BoxFit.fill,)
                    ),
                    child: Center(
                      child: Text('Sports',style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('your subscribtion date : 20xx/xx/xx',style:TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700)
                    ) ,
                    Spacer(),
                    Icon(Icons.power_settings_new_outlined,color: Colors.white,size: 30,),
                    SizedBox(width: 12,),
                    Icon(Icons.settings_outlined,color: Colors.white,size: 30,),
                    SizedBox(width: 12,),
                    Icon(Icons.mic_none_rounded,color: Colors.white,size: 30,),
                    SizedBox(width: 12,),
                    Icon(Icons.person,color: Colors.white,size: 30,),
                    SizedBox(width: 12,),
                    Icon(Icons.radio,color: Colors.white,size: 30,),
                    SizedBox(width: 20,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
