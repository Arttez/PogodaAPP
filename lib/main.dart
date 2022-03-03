import 'package:PogodaApp/delegates/SearchDelegate.dart';
import 'package:PogodaApp/events/PogodaEvent.dart';
import 'package:PogodaApp/states/PogodaState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/PogodaBloc.dart';
import 'components/MainScreenWrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColorDark: Colors.white,
        primaryColor: Colors.white,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PogodaBloc(),
      child: BlocBuilder<PogodaBloc, PogodaState>(
        builder: (context, state) {
          if (state is PogodaLoadSuccess) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Color.fromRGBO(255, 25, 0, 0),
                actions: [
                  IconButton(
                    icon: Icon(Icons.my_location),
                    onPressed: () {
                      BlocProvider.of<PogodaBloc>(context).add(PogodaCurrentPositionRequested());
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                          context: context,
                          delegate: MySearchDelegate((query) {
                            BlocProvider.of<PogodaBloc>(context).add(PogodaRequested(city: query));
                          }));
                    },
                  )
                ],
              ),
              body: Padding(
                padding: EdgeInsets.only(top: 64),
                child: MainScreenWrapper(weather: state.weather, hourlyWeather: state.hourlyWeather),
              ),
            );
          }
          return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Color.fromRGBO(0, 0, 0, 0),
                actions: [
                  IconButton(
                    icon: Icon(Icons.my_location),
                    onPressed: () {
                      BlocProvider.of<PogodaBloc>(context).add(PogodaCurrentPositionRequested());
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                          context: context,
                          delegate: MySearchDelegate((query) {
                            BlocProvider.of<PogodaBloc>(context).add(PogodaRequested(city: query));
                          }));
                    },
                  )
                ],
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ));
        },
      ),
    );
  }
}
