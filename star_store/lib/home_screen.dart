import 'products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:star_store/register.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HomeScreen> {
  Future<String> getJson() {
    var products = rootBundle.loadString('assets/json/products.json');
    return products;
  }

  int photoIndex = 0;

  //var my_data = json.decode(await getJson());

  List<String> photos = [
    'assets/PC/PC.jpg',
    'assets/PS4/ps4Pro.jpg',
    'assets/XBOX/xboxone.jpg'
  ];

  void _previousImage() {
    setState(() {
      photoIndex = photoIndex > 0 ? photoIndex - 1 : 2;
    });
  }

  void _nextImage() {
    setState(() {
      photoIndex = photoIndex < photos.length - 1 ? photoIndex + 1 : 0;
    });
  }

  bool typing = false;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: typing
              ? TextBox()
              : Image.asset('assets/logo/logoWhite.png',
                  height: 50, fit: BoxFit.cover),
          leading: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                typing = !typing;
              });
            },
          ),
        ),
        endDrawer: Drawer(
          child: Column(children: [
            Padding(padding: EdgeInsets.only(top: 50)),
            Image.asset(
              'assets/logo/logoBlue.png',
              height: 100,
            ),
          ]),
        ),
        body:
            //carousel start
            SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 5, left: 6, right: 2),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            image: DecorationImage(
                                image: AssetImage(photos[photoIndex]),
                                fit: BoxFit.cover)),
                        height: 200.0,
                        width: 400.0,
                      ),
                    ),
                    Positioned(
                      //dots position
                      top: 175.0,
                      left: 25.0,
                      right: 25.0,
                      child: SelectedPhoto(
                          numberOfDots: photos.length, photoIndex: photoIndex),
                    ),
                    Row(
                      //carousel buttons
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ButtonTheme(
                          height: 205,
                          child: RaisedButton(
                            child: Text('<'),
                            textColor: Colors.white,
                            onPressed: _previousImage,
                            elevation: 5.0,
                            color: Colors.grey.withOpacity(0.05),
                          ),
                        ),
                        SizedBox(width: 210.0), //space between buttons
                        ButtonTheme(
                            height: 205.0,
                            child: RaisedButton(
                              child: Text('>'),
                              textColor: Colors.white,
                              onPressed: _nextImage,
                              elevation: 5.0,
                              color: Colors.grey.withOpacity(0.05),
                            )),
                      ],
                    )
                  ],
                ),
              ),
              //carousel end

              Padding(padding: EdgeInsets.only(top: 20)),

              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 6)),
                  Text('Popular Items:',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),

              Padding(padding: EdgeInsets.only(top: 10)),

              FutureBuilder(
                builder: (context, snapshot) {
                  var showData = json.decode(snapshot.data.toString());
                  return Expanded(
                    flex: 0,
                    child: SizedBox( height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return GridView.count(
                            childAspectRatio: 0.8,
                            shrinkWrap: true,
                            primary: false,
                            crossAxisSpacing: 00,
                            mainAxisSpacing: 00,
                            crossAxisCount: 2,
                            children: <Widget>[
                              Container(
                                child:
                                    //item card start
                                    Card(
                                  clipBehavior: Clip.antiAlias,
                                  child: Column(
                                    children: [
                                      Image.asset(showData[0]["ayshy"][index]["img"]),
                                      ListTile(
                                        title: Text(
                                            showData[0]["ayshy"][index]["name"].toString(),
                                            style: TextStyle(fontSize: 15)),
                                        subtitle: Text(
                                          showData[0]["ayshy"][index]["price"].toString(),
                                          style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                              fontSize: 17),
                                        ),
                                      ),
                                      ButtonBar(
                                        children: [
                                          FlatButton(
                                            textColor: const Color(0xFF6200EE),
                                            onPressed: () {
                                              // Perform some action
                                            },
                                            child: const Text('Add to cart'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: showData[0]["ayshy"].length,
                      ),
                    ),
                  );
                },
                future: DefaultAssetBundle.of(context).loadString("assets/json/products.json"),
              ),

              //item card end
            ],
          ),
        ));
  }
}

//carousel dots
class SelectedPhoto extends StatelessWidget {
  final int numberOfDots;
  final int photoIndex;

  SelectedPhoto({this.numberOfDots, this.photoIndex});

  Widget _inactivePhoto() {
    return new Container(
        child: new Padding(
      padding: const EdgeInsets.only(left: 3.0, right: 3.0),
      child: Container(
        height: 8.0,
        width: 8.0,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(4.0)),
      ),
    ));
  }

  Widget _activePhoto() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
          height: 10.0,
          width: 10.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, spreadRadius: 0.0, blurRadius: 2.0)
              ]),
        ),
      ),
    );
  }

//dots count
  List<Widget> _buildDots() {
    List<Widget> dots = [];

    for (int i = 0; i < numberOfDots; ++i) {
      dots.add(i == photoIndex ? _activePhoto() : _inactivePhoto());
    }
    return dots;
  }

//creating dots
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildDots(),
      ),
    );
  }
}

//search bar
class TextBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: TextField(
        decoration:
            InputDecoration(border: InputBorder.none, hintText: 'Search'),
      ),
    );
  }
}
