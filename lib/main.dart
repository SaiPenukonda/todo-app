import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/UI/Intray/intray_page.dart';
import 'package:todoapp/UI/Login/loginscreen.dart';
import 'package:todoapp/models/global.dart';
import 'package:http/http.dart' as http; 
import 'package:todoapp/models/classes/user.dart';
import 'package:todoapp/bloc/blocs/user_bloc_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage()
      // home: FutureBuilder(
      // future: getUser(), // a previously-obtained Future<String> or null
      //   builder: (BuildContext context, AsyncSnapshot snapshot) {
      //     switch (snapshot.connectionState) {
      //       case ConnectionState.none:
      //         return Text('Press button to start.');
      //       case ConnectionState.active:
      //       case ConnectionState.waiting:
      //         return Text('Awaiting result...');
      //       case ConnectionState.done:
      //         if (snapshot.hasError)  return Text('Error: ${snapshot.error}');
      //         return Text('Result: ${snapshot.data}');
      //     }
      //     if (snapshot.connectionState == ConnectionState.none && snapshot.hasData == null) {
      //       //print('project snapshot data is: ${projectSnap.data}');
      //       return Container();
      //     }
      //     return ListView.builder(
      //       itemCount: snapshot.data.length,
      //       itemBuilder: (context, index) {
      //         return Column(
      //           children: <Widget>[
      //             // Widget to display the list of project
      //           ],
      //         );
      //       },
      //     ); // unreachable
      //   },
      // ),
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
    return FutureBuilder(
      future: getApiKey(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        String apiKey = "";
        if (snapshot.hasData) {
          apiKey = snapshot.data;
        }
        else {
          print("No Data");
        }
        //  apiKey.length > 0 ? getHomePage() : 
        return apiKey.length > 0 ? getHomePage() : LoginPage(login: login, newUser: false,);
      },
    );
  }

void login() {
  setState(() {
    build(context);
  });
}

  Future getApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString("API_Token");
  }

  Widget getHomePage() {
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
                    child: Center(
                      child: FlatButton(
                        color: Colors.red,
                        child: Text("Log Out"),
                        onPressed: () {
                          logout();
                        },
                      ),
                    ),
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

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('API_Token', "");
    setState(() {
      build(context); 
    });
  }

  @override
  void initState() {
    super.initState();
  }
}
