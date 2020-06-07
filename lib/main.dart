import 'package:flutter/material.dart';
import 'package:flutter_soular_app/src/pages/login_page.dart';
import 'package:flutter_soular_app/src/pages/main_page.dart';
import 'dart:io';
import 'package:flutter_soular_app/src/utils/routes.dart';

import 'package:mongo_dart/mongo_dart.dart';


// import 'package:flutter_soular_app/src/newspage/newsListPage.dart';
// import 'package:flutter_soular_app/src/viewmodels/newsArticleListViewModel.dart';
// import 'package:provider/provider.dart';

void main() => runApp(MyApp());

// main(List<String> arguments) async{
//   // making db connection
//   Db db = Db('mongodb://localhost:27017/test');

//   // open connection to db
//   await db.open();

//   print('Connected to database');

//   DbCollection coll = db.collection('people');

//   // read people from collection 
//   var people = await coll.find().toList();
//   print(people);
// }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // theme: AppTheme.lightTheme,
        home: LoginPage(),
        debugShowCheckedModeBanner: false,
        // routes: routes
        );
  }
}

//       title: "Fresh News",
//       home:
//       ChangeNotifierProvider(
//         builder: (_) => NewsArticleListViewModel(),
//         create: (BuildContext context) {  },
//         child: NewsListPage()
//       )
//     );

//   }

// }
