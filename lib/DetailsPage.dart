import 'package:flutter/material.dart';
import 'package:saman/Models/Services.dart';

class DetailsPage extends StatefulWidget {
  final Services service;
  DetailsPage(this.service);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: ,
      body: _customScrollView(),
      // Column(
      //   children: [
      //     Padding(padding: EdgeInsets.all(20.0)),
      //   ],
      // ),
    );
  }

  Widget headerContainer() {
    return Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 70.0),
              child: Text(
                '${this.widget.service.title} includes:',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff0E1235),
                fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
  }

  Widget descList() {
    return ListView.builder(
          scrollDirection: Axis.vertical,
    shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
              itemCount: this.widget.service.desc.length,
              itemExtent: 40,
              itemBuilder: (BuildContext context, int index){
                return ListTile(
                  leading: Icon(
                      Icons.check_circle_outline,
                      size: 23,
                      color: Color(0xff22CE29),
                      ),
                  title:  Text(
                      this.widget.service.desc[index].toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff484848)
                      ),
                      ),
                );
              }
          );
  }

  
  Widget bookingButton() {
    return  Container(
                height: 40.0,
                width: 256.0,
              //  margin: EdgeInsets.all(29.0),
                child: new RaisedButton(
                  color: Color(0xff22CE29),
      child: Text("       Book This Service       ",
      style: TextStyle(
        fontSize: 16.0,
        color: Color(0xffFFFFFF),
                              fontWeight: FontWeight.w500,
      ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      onPressed: () {},
    ),
    );
  }
    Widget _customScrollView() {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
                    SliverPersistentHeader(
              delegate: MySliverAppBar(expandedHeight: 250, service: this.widget.service),
              //pinned: true,
            ),
        // SliverAppBar(
        //   actions: [
        //     Image.asset(
        //      'Assets/Images/bell.png',
        //      width: 18,
        //      height: 20,
        //     ),
        //     Padding(padding: EdgeInsets.all(7.5)),

        //   ],
        //   expandedHeight: 275,
        //   floating: false,
        //   pinned: false,
          //backgroundColor: Colors.transparent,
          // flexibleSpace: FlexibleSpaceBar(
          //     centerTitle: true,
          //   //  title: _searchBox(),
          //     // Text("Collapsing Toolbar",
          //     //     style: TextStyle(
          //     //       color: Colors.white,
          //     //       fontSize: 15.0,
          //     //     )),
          //     background: Image.network(
          //       'https://wedo-api.technationme.com${this.widget.service.coverimagelink}',
          //         fit: BoxFit.cover,
          //       ),
          //     )
             // )
        SliverList(
          delegate: SliverChildListDelegate(
             [
               headerContainer(),
               descList(),
            ]
          
          ),
        ),
        SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                    bookingButton(),
                        ]
                        ),
                    ),
                  ]
                )
                ),
      ],
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Services service;

  MySliverAppBar({@required this.expandedHeight, this.service});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Image.network(
       'https://wedo-api.technationme.com${service.coverimagelink}',
          fit: BoxFit.cover,
        ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                                      child: Icon(Icons.arrow_back,
                    
                    color: Color(0xffFFFFFF),
                    ),
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
          top: expandedHeight / 1.4 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 3,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: serviceCard(),
            // Card(
            //   elevation: 10,
            //   child: SizedBox(
            //     height: expandedHeight/2,
            //     width: MediaQuery.of(context).size.width / 3,
            //     child: FlutterLogo(),
            //   ),
            // ),
          ),
        ),
      ],
    );
  }

 Widget serviceCard() {
       return Container(
                              height: 135,
                              width: 165,
                              child: Hero(
                                tag: 'heroService',
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
                                          'https://wedo-api.technationme.com${service.imagelink}',
                                          height: 60,
                                          width: 50,
                                          ),
                                                                   // Text(allServices[index].imagelink),
                                       Text(
                                         service.title,
                                         style: TextStyle(
                                           fontSize: 16.0,
                                                                 fontWeight: FontWeight.w500,
                                           color: Color(0xff757575)
                                         ),
                                       ),
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