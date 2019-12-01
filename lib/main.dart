import 'package:flutter/material.dart';
import 'package:todoapp/UI/Intray/intray_page.dart';
import 'package:todoapp/models/global.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Todo App Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.yellow,
      home: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: new Scaffold(
            body: Stack(children: <Widget>[
              TabBarView(
                children: [
                  IntrayPage(),
                  new Container(
                    color: Colors.black12,
                  ),
                  new Container(
                    color: Colors.deepPurpleAccent,
                  ),
                  new Container(
                    color: Colors.pink,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 50),
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)
                    ),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Intray", style: intrayTitleStyle,),
                    Container()
                  ],
                ),
              ),
              Container(
                height: 75,
                width: 75,
                margin: EdgeInsets.only(top: 112, left: MediaQuery.of(context).size.width*0.5 - 37.5,),
                child: FloatingActionButton(
                  child: Icon(Icons.add, size: 70,),
                  backgroundColor: Colors.red,
                  onPressed: () {},
                ),
              )
            ]),
            appBar: AppBar(
              elevation: 0,
              title: new TabBar(
                tabs: [
                  Tab(
                    icon: new Icon(Icons.home),
                  ),
                  Tab(
                    icon: new Icon(Icons.share),
                  ),
                  Tab(
                    icon: new Icon(Icons.perm_identity),
                  ),
                  Tab(
                    icon: new Icon(Icons.settings),
                  )
                ],
                labelColor: Colors.white,
                unselectedLabelColor: Colors.red,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.all(5.0),
                indicatorColor: Colors.red,
              ),
              backgroundColor: Colors.black,
            ),
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
