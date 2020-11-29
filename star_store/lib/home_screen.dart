import 'package:flutter/material.dart';
import 'dart:convert';
import 'item_list.dart';



class HomeScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HomeScreen> {

 


  int photoIndex = 0;

  List<String> photos = [
    'assets/PC/PC.jpg',
    'assets/ps4/ps4Pro.jpg',
    'assets/xbox/xboxone.jpg'
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
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Image.asset('assets/logo/logoWhite.png')),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Sign In'),
              onTap: () => Navigator.pushNamed(context, '/login'),
            ),
            ListTile(
                leading: Image.asset('assets/ps4/ps_icon.ico',
                    color: Colors.grey, height: 27),
                title: Text('Playstation'),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ItemList("PS4", "Playstation Items")))),
            ListTile(
                leading: Image.asset('assets/Xbox/Xbox_icon.ico',
                    color: Colors.grey, height: 27),
                title: Text('Xbox'),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ItemList("Xbox", "Xbox Items")))),
            ListTile(
                leading: Icon(Icons.computer),
                title: Text('PC'),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ItemList("PC", "PC Items")))),
                ListTile(
              leading: Icon(Icons.phone,),
              title: Text('Contact Us'),
              onTap: () => Navigator.pushNamed(context, '/contact-us'),
            ),
                ListTile(
              leading: Icon(Icons.campaign,),
              title: Text('About Us'),
              onTap: () => Navigator.pushNamed(context, '/about-us'),
            ),
             ListTile(
              leading: Icon(Icons.qr_code_sharp),
              title: Text('Scan Item'),
              onTap: () => Navigator.pushNamed(context, '/cam'),
            ),
            ListTile(
              leading: Icon(Icons.account_balance),
              title: Text('See Sellers'),
              onTap: () => Navigator.pushNamed(context, '/sellers'),
            ),
          ],
        ),
      ),
      body:
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
              future: DefaultAssetBundle.of(context)
                  .loadString("assets/products.json"),
              builder: (context, snapshot) {
                var showData = jsonDecode(snapshot.data);

                var popularItems = [];
                var temp = [];

                for (int j = 0; j <= showData.length - 1; j++) {
                  temp.add(showData[j]['boughtNum']);
                  temp.sort();
                }
                for (int i = 0; i <= showData.length - 1; i++) {
                  if (showData[i]['boughtNum'] == temp.last) {
                    popularItems.add(showData[i]);
                    temp.remove(temp.last);
                    i = 0;
                  }
                  if (popularItems.length == 8) {
                    break;
                  }
                }

                // print(popularItems);

                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    // Success case
                    return SizedBox(
                        height: 400,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GridView.count(
                              childAspectRatio: 1,
                              shrinkWrap: true,
                              primary: false,
                              crossAxisCount: 1,
                              children: <Widget>[
                                Container(
                                  child:
                                      //item card start
                                      Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      children: [
                                        Image.asset(popularItems[index]["img"]),
                                        ListTile(
                                          title: Text(
                                              popularItems[index]["name"]
                                                  .toString(),
                                              style: TextStyle(fontSize: 30)),
                                          subtitle: Text(
                                            popularItems[index]["price"]
                                                    .toString() +
                                                "\$",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 20),
                                          ),
                                        ),
                                        ButtonBar(
                                          children: [
                                            FlatButton(
                                              textColor:
                                                  const Color(0xFF6200EE),
                                              onPressed: () {
                                                // Perform some action
                                              },
                                              child: const Text('Add to cart',
                                                  style:
                                                      TextStyle(fontSize: 20)),
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
                          itemCount: popularItems.length,
                        ));
                  }
                  // Error case
                  return Text('Something went wrong');
                } else {
                  // Loading data
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),

            //item card end
          ],
        ),
      ),
    );
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