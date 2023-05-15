import 'package:dvm_task_2/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

Future<bool> checkIfFriendExists(int friendID) async {
  final docSnapshot = await _friendsCollection.doc('$friendID').get();
  return docSnapshot.exists;
}




final CollectionReference _friendsCollection = FirebaseFirestore.instance.collection('friends');


class MyApp extends StatefulWidget{
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double sliderValue = 0.0;
  int noOfUsers = 0;
  List <dynamic> _users = [];
  List<String> _friendIds = [];

  @override
  void initState() {
    super.initState();
    fetchFriendIds();
    UserService.fetchUsers().then((users) {
      setState(() {
        _users = users;
      });
    });

  }


  Future<void> fetchFriendIds() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('friends').get();
    _friendIds = querySnapshot.docs.map((doc) => doc.id).toList();
  }



  bool status = false;

  Color getColor(bool status) {
    switch (status) {
      case true:
        return Colors.amber;
      case false:
        return Colors.white;
      default:
        return Colors.black;
    }
  }


  Future<void> _handleFriendAction(int friendID, int index) async {
    bool isFriend = await checkIfFriendExists(friendID);
    if (isFriend) {
      await _friendsCollection.doc(friendID.toString()).delete();
      setState(() {
        _friendIds.remove(friendID.toString());
      });
    } else {
      setState(() {
        _friendIds.add(friendID.toString());
      });
      await _friendsCollection.doc(friendID.toString()).set({
        'id': friendID,
        'name': _users[index].name,
      });
    }
  }

  int countUsersInRange(List<dynamic> users, double sliderValue) {
    int count = 0;
    for (int i = 0; i < users.length; i++) {
      double longitude = double.parse(users[i].address.geo.lng);
      if (longitude >= -200.0 && longitude <= sliderValue) {
        count++;
      }
    }
    return count;
  }





  Widget build(BuildContext context)
  {


    return MaterialApp(

      home:Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/vectors.png"),
                alignment: Alignment.topRight,
                fit: BoxFit.fitWidth,
              ),
            ),
            padding: EdgeInsets.only(top: 72,left: 28),
            child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text("Users",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.white,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.normal,
                   ),
                ),
                  SizedBox(height: 48,),
                  Container(
                    padding: EdgeInsets.only(),
                    height: 40,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all
                        (color: Color.fromRGBO(248, 216, 72, 1),
                        width: 0.20000000298023224,),
                      gradient: LinearGradient(
                          colors: [Color(0xffA46C00).withOpacity(0.2),Color(0xffD19A08),Color(0xffF8D848)],
                          stops: [1,0,0]
                      ),

                    ),
                    child: TextField(decoration: InputDecoration(

                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          hintText: 'Search for name...',
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.only(),
                          suffixIcon: Icon(CupertinoIcons.xmark,
                          color: Color(0xffC0C0C0)),
                          prefixIcon: Icon(CupertinoIcons.search,
                          color: Color(0xffC0C0C0)),
                          hintStyle: TextStyle(color: Color(0xffC0C0C0)
                          ),
                          ),
                         style: TextStyle(color: Colors.white),
                      ),

                    ),
                  SizedBox(height: 36),
                  Container(
                    height: 20,
                    width: 356,
                    child: Slider(

                      value: sliderValue,
                      min: -200,
                      max: 200,
                      onChanged: (newValue) {
                        setState(() {
                          sliderValue = newValue;
                        });
                      },
                      label: sliderValue.toStringAsFixed(0),
                      divisions: 5,
                    ),
                  ),

                  SizedBox(height: 5),

                  Container(
                    height: 425,
                    width: 388,
                    padding: EdgeInsets.only(left: 4,right: 20),

                    child: ListView.builder(

                        itemCount: countUsersInRange(_users, sliderValue),
                        itemBuilder: (BuildContext context, int index)
                        {
                          int friendID = _users[index].id;
                          if (_users[index] != null && double.parse(_users[index].address.geo.lng) >= -200 && double.parse(_users[index].address.geo.lng) <= sliderValue)

                          {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 17),
                                child: Container(
                                  height: 192,
                                  width: 388,
                                  decoration: BoxDecoration(
                                    gradient: RadialGradient(
                                        center: Alignment.bottomRight,
                                        radius: 2.5,
                                        stops: [0.0,0.01,1.0],
                                        colors: [Color(0xffFFA800),Color(0xffC0E79900).withOpacity(0.5),Color(0xff009E6900).withOpacity(0.1)],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                   child: Column(

                                     children: [
                                       GestureDetector(
                                         onTap: () async {
                                           _handleFriendAction(friendID, index);
                                         },
                                         child: Container(
                                           width: 600,
                                           height: 70,
                                           padding: EdgeInsets.only(top: 26, right: 170, left: 10, bottom: 2),
                                           child: Text(
                                             "${_users[index].name}",
                                               style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: _friendIds.contains(friendID.toString()) ? Colors.amber :Colors.white,
                                                fontSize: 20,
                                             ),
                                           ),
                                         ),
                                       ),

                                       Container(
                                         width: 600,
                                         height: 20,
                                         padding: EdgeInsets.only(left: 10,top: 9),
                                         child: Text("${_users[index].email}",
                                         style: TextStyle(
                                           fontSize: 12,
                                           fontFamily: 'Open Sans',
                                           fontStyle: FontStyle.normal,
                                           color: Colors.yellow,
                                         ),
                                         ),
                                       ),
                                       Container(
                                         width: 600,
                                         height: 31,
                                         padding: EdgeInsets.only(top:10,left: 10,right: 220,bottom: 0),
                                         alignment: Alignment.topLeft,
                                         child: Text("${_users[index].address.street} - ${_users[index].address.suite} ${_users[index].address.city} - ${_users[index].address.zipcode}",
                                             style: TextStyle(
                                             fontWeight: FontWeight.normal,
                                             color: Colors.white,
                                             fontSize: 10,
                                         )
                                         ),
                                       ),
                                     SizedBox(height: 7),
                                       Row(
                                         children: [
                                           Padding(
                                             padding: EdgeInsets.only(left: 10,top: 5,bottom: 10),
                                               child: Icon(Icons.location_pin,color: Colors.white)
                                           ),
                                           SizedBox(width:8.22),
                                           Padding(
                                             padding: EdgeInsets.only(top: 5,bottom: 5),
                                             child: Text("${_users[index].address.geo.lat}",
                                               style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                               ),
                                           ),
                                           SizedBox(width: 120),
                                           Padding(
                                               padding: EdgeInsets.only(right: 20,top: 5,bottom: 5),
                                               child: Icon(Icons.access_time_filled,color: Colors.white)),

                                           Padding(
                                             padding: EdgeInsets.only(top: 5,bottom: 5,right:10),
                                             child: Text("${_users[index].address.geo.lng}",
                                               style: TextStyle(
                                                 fontWeight: FontWeight.normal,
                                                 color: Colors.white,
                                                 fontSize: 12,
                                               ),
                                             ),
                                           ),


                                         ],
                                       ),
                                     ],
                                   ),
                                ),
                              );
                            }
                          else {return SizedBox.shrink();}
                        }
                    ),

                  ),





            ],
              ),



          ),
      ),
    );
  }
}