import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:saman/DetailsPage.dart';
import 'package:saman/Models/Services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

    String _selectedCity = '5e1f78e9b17e82216f81ed16';
    List cities = List(); 
    List sliders = List();

  void _getcities() async {
      final String url = "https://wedo-api.technationme.com/api/cities";
    final response = await http.get(url);
   if (response.statusCode == 200) {
      var finalResponse = json.decode(response.body);
    var data = finalResponse['cities'];
    setState(() {
      cities = data;
    });
    print(data.toString());
   } else {
   }
  }

    void _getsliders() async {
      final String url = "https://wedo-api.technationme.com/api/sliders";
    final response = await http.get(url);
   if (response.statusCode == 200) {
      var finalResponse = json.decode(response.body);
    var data = finalResponse['sliders'];
    setState(() {
      sliders = data;
    });
    print(data.toString());
   } else {
   }
  }


  Future<List<Services>> _getServices() async {
    final jobsListAPIUrl = 'https://wedo-api.technationme.com/api/categories';
    final response = await http.get(jobsListAPIUrl);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List data = jsonResponse['categories'];
      return data.map((service) => new Services.fromJson(service)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  @override
  void initState() {
    super.initState();
    _getcities();
    _getsliders();
    // _getServices();
  }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      backgroundColor: Color(0xffE9E9E9),
      //  appBar:
      body: 
      _customScrollView()
    );
  }

  // Widget mainColumn() {
  //   return Container(
  //     height: MediaQuery.of(context).size.height*3,
  //     child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //         child: Column(
  //           children: [
  //             Padding(padding: EdgeInsets.all(20.0)),
  //             _searchBox(),
  //             _topContainer(),
  //             Expanded(
  //               child:
  //                _servicesGrid()
  //             )
  //           ],
  //         ),
  //       ),
  //   );
  // }

    Widget _topContainer() {
      return Container(
              height: 34.0,
              margin: EdgeInsets.only(top: 50.0),
             // width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Services',
                    style: TextStyle(
                      color: Color(0xff0E1235),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                      size: 20,
                      color: Color(0xff22CE29),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                    'Location',
                    style: TextStyle(
                      color: Color(0xffB1ADAD),
                      fontSize: 10.0,
                                            fontWeight: FontWeight.w500,
                    )
                          ),
                          Container(
                            height: 19.0,
                          //  width: 65,
                            child: DropdownButtonHideUnderline(
                                                        child: new DropdownButton(
                                                          icon: Icon(Icons.keyboard_arrow_down,
                                                          ),
            items: cities.map((item) {
              return new DropdownMenuItem(
                child: new Text(
                  item['name'],
                  style: TextStyle(
                    fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                    color: Color(0xff363636)
                  ),
                ),
                value: item['_id'].toString(),
              );
            }).toList(),
            onChanged: (newVal) {
              print(newVal.toString());
              setState(() {
                _selectedCity = newVal;
              });
            },
            value: _selectedCity,
          ),
                            ),
                          ),
                        ]
                      )
                    ],
                  )
                ],
              ),
            );
    }

    
    Widget _servicesGrid() {
      return FutureBuilder(
                  future: _getServices(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Services> allServices = snapshot.data;
                      return GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                       shrinkWrap: true,
                        itemCount: allServices.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.5,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 6.0
                            ),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => DetailsPage(allServices[index])
                                ));
                            },
                            // height: 135,
                            // width: 165,
                            child: new Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0)
                                ),
                              ),
                              elevation: 6.0,
                              shadowColor: Color(0xff54545473),
                            color: Color(0xffFFFFFF),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      'https://wedo-api.technationme.com${allServices[index].imagelink}',
                                      height: 60,
                                      width: 50,
                                      ),
                                                               // Text(allServices[index].imagelink),
                                   Text(
                                     allServices[index].title,
                                     style: TextStyle(
                                       fontSize: 16.0,
                                                             fontWeight: FontWeight.w500,
                                       color: Color(0xff757575)
                                     ),
                                   ),
                                  ],
                                ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Text('Loading');
                    }
                  });
    }

    Widget _customScrollView() {
    return CustomScrollView(
      slivers: <Widget>[
              SliverPersistentHeader(
              delegate: MySliverAppBar(expandedHeight: 400, sliders: sliders),
              //pinned: true,
            ),
    //     SliverAppBar(
    //       leading:     Container(
    //   alignment: Alignment.center, 
    //   child: Image.asset(
    //   'Assets/Images/menu.png',
    //     fit: BoxFit.contain,
    //     width: 20,
    //     height: 14,
    //   ),
    // ),
            
    //       actions: [
    //         Image.asset(
    //          'Assets/Images/bell.png',
    //          width: 18,
    //          height: 20,
    //         ),
    //         Padding(padding: EdgeInsets.all(7.5)),

    //       ],
    //       expandedHeight: 400,
    //       floating: false,
    //       pinned: false,
    //       //backgroundColor: Colors.transparent,
    //       flexibleSpace: FlexibleSpaceBar(
    //           centerTitle: true,
    //         //  title: _searchBox(),
    //           // Text("Collapsing Toolbar",
    //           //     style: TextStyle(
    //           //       color: Colors.white,
    //           //       fontSize: 15.0,
    //           //     )),
    //           background: Swiper(
    //             itemCount: sliders.length,
    //             itemBuilder: (BuildContext context, int index) => Image.network(
    //             'https://wedo-api.technationme.com${sliders[index]['image']}',
    //               fit: BoxFit.cover,
    //             ),
    //             autoplay: true,
    //           )),
    //     ),
        SliverList(
          delegate: SliverChildListDelegate(
             [
        //       Padding(
        // padding: const EdgeInsets.only(left: 12.0),
        //         child: _searchBox(),
        //       ),
              Padding(
        padding: const EdgeInsets.all(12.0),
                child: _topContainer(),
              ),
               Padding(
        padding: const EdgeInsets.only(bottom: 12.0, left: 12.0, right: 12.0),
                 child: _servicesGrid(),
               )
            ]
          
          ),
          // delegate: SliverChildBuilderDelegate(
          //     (context, index) => Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Container(
          //             height: 75,
          //             color: Colors.black12,
          //           ),
          //         ),
          //     childCount: 10),
        )
      ],
    );
  }
  
}


class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final sliders;

  MySliverAppBar({@required this.expandedHeight, this.sliders});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
                      Swiper(
                itemCount: sliders.length,
                itemBuilder: (BuildContext context, int index) => Image.network(
                'https://wedo-api.technationme.com${sliders[index]['image']}',
                  fit: BoxFit.cover,
                ),
                autoplay: true,
              ),
      //   Image.network(
      //  'https://wedo-api.technationme.com${service.coverimagelink}',
      //     fit: BoxFit.cover,
      //   ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
               'Assets/Images/menu.png',
               width: 20,
               height: 14,
              ),

              Image.asset(
               'Assets/Images/bell.png',
               width: 18,
               height: 20,
              ),
                            ],
              ),
          ),
        Positioned(
          top: expandedHeight / 1.13 - shrinkOffset,
         // left: MediaQuery.of(context).size.width / 3,
          child:  _searchBox(context),
            // Card(
            //   elevation: 10,
            //   child: SizedBox(
            //     height: expandedHeight/2,
            //     width: MediaQuery.of(context).size.width / 3,
            //     child: FlutterLogo(),
            //   ),
            // ),
        ),
      ],
    );
  }


Widget _searchBox(context) {
      return Container(
        height: 83,
        width: MediaQuery.of(context).size.width,
              child: Card(
                color: Color(0xffFFFFFF),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0)
                                ),
                              ),
          //color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5.0),
                      width: MediaQuery.of(context).size.width*.6,
                      child: Text('Can\'t Find What You Are Looking For?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xffBFC2D0),
                        fontSize: 14.0,
                      ),
                      )
                      ),
                      Padding(padding: EdgeInsets.all(3.0)),
                    SizedBox(
                      height: 30,
                   width: MediaQuery.of(context).size.width*0.6,
                                  child: TextField(
                        //autofocus: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'submit your request',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 20.0,
                            color: Color(0xff0E1235),
                            
                          )
                        ),
                      ),
                    ),
                  ],
                ),

              Container(
                height: 44.0,
                width: 70,
                child: new RaisedButton(
                  elevation: 5.0,
                  color: Color(0xff22CE29),
      child: Text("GO",
      style: TextStyle(
        fontSize: 20.0,
        color: Color(0xffFFFFFF),
         fontWeight: FontWeight.bold,
      ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onPressed: () {},
    ),
           )
              ],
            ),
          ),
        ),
      );
    }


 
  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}