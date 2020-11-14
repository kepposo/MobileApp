import 'package:flutter/material.dart';
import 'dart:convert';

class ItemList extends StatefulWidget {
  final String type;
  final String listName;
  const ItemList(this.type, this.listName);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
 

  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: 
          Text(widget.listName),
          centerTitle: true,
        ),
      body: itemList(context, widget.type),
      
    );
  }
}

Widget itemList(context, type) {
  return FutureBuilder(
    future: DefaultAssetBundle.of(context).loadString("assets/products.json"),
    builder: (context, snapshot) {
      var showData = jsonDecode(snapshot.data);

      var itemType = [];

      for (int i = 0; i <= showData.length - 1; i++)
      {
        if (showData[i]['type'] == type)
        {
          itemType.add(showData[i]);
        }
      }
      print(type);
      // print(popularItems);

      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasData) {
          // Success case
          return SizedBox(
              height: 1000,
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
                              Image.asset(itemType[index]["img"]),
                              ListTile(
                                title: Text(
                                    itemType[index]["name"].toString(),
                                    style: TextStyle(fontSize: 30)),
                                subtitle: Text(
                                  itemType[index]["price"].toString() +
                                      "\$",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 20),
                                ),
                              ),
                              ButtonBar(
                                children: [
                                  FlatButton(
                                    textColor: const Color(0xFF6200EE),
                                    onPressed: () {
                                      // Perform some action
                                    },
                                    child: const Text('Add to cart',
                                        style: TextStyle(fontSize: 20)),
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
                itemCount: itemType.length,
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
  );
}
