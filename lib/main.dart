import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'shop.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (c) => Store1()),
          ChangeNotifierProvider(create: (c) => Store2()),
        ],
        child: MaterialApp(
          theme: style.themes,
          home: MyApp(),
        ),
      )
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var tab = 0;
  var date = [];
  var userImage;

  saveData() async{
    var storage = await SharedPreferences.getInstance();
    storage.setString('name', 'jphn');

  }

  addData(a){
    setState(() {
      date.add(a);
    });
  }

  getData() async{
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    var result2 = jsonDecode(result.body);
    setState(() {
      date = result2;
    });
  }
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text("+"),
        onPressed: (){
        },
      ),
      appBar: AppBar(
        title: Text("Instagram",style: TextStyle(color: Colors.black),),
        actions: [
          IconButton(
            onPressed: () async{

              var picker = ImagePicker();
              var image = await picker.pickImage(source: ImageSource.gallery);
              if(image != null){
                userImage = File(image.path);
              }
              // ignore: use_build_context_synchronously
              Navigator.push(context,
                MaterialPageRoute(builder: (c) => Upload(userImage:userImage) )
              );
            },
            icon: Icon(Icons.add_box_outlined),
            iconSize: 30,
          )
        ],
      ),


      body: [Home(data : date), Shop()][tab],

      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        onTap: (i){
          setState(() {
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(
              label : '홈',
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
              label : '샵',
              icon: Icon(Icons.shopping_bag_outlined),
              activeIcon: Icon(Icons.shopping_bag)
          )
        ],
      ),
    );
  }
}


class Home extends StatefulWidget {
  const Home({super.key,this.data});

  final data;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var scorll = ScrollController();

  getMore() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/more1.json'));
    var result2 = jsonDecode(result.body);
  }

  @override
  void initState() {
    super.initState();
    scorll.addListener(() {
      if(scorll.position.pixels == scorll.position.maxScrollExtent){
        getMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(widget.data != null){
      return ListView.builder(itemBuilder: (c,i){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.data[i]['image'].runtimeType == String?
            Image.network(widget.data[i]['image']) : Image.file(widget.data[i]['image']),
            GestureDetector(
              child: Text('좋아요 ${widget.data[i]['likes']}'),
              onTap: (){
                Navigator.push(context,
                  PageRouteBuilder(pageBuilder:
                  (c, a1, a2) => Profile(),
                    transitionsBuilder: (c,a1,a2,child) =>
                        FadeTransition(opacity: a1,child: child)
                ));
              },
            ),
            Text('${widget.data[i]['user']}'),
            Text('${widget.data[i]['content']}'),
          ],
        );
      },itemCount: 3,controller: scorll,);
    }else{
      return Text('로딩중임');
    }
  }
}

class Upload extends StatelessWidget {
  const Upload({super.key, this.userImage,this.setUserContent,this.addMyDate});
  final userImage;
  final setUserContent;
  final addMyDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            addMyDate();
          }, icon: Icon(Icons.send))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file(userImage),
          Text('이미지업로드화면'),
          TextField(onChanged: (text){
            setUserContent(text);
          },),
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.close))
        ],
      ),
    );
  }
}

class Store2 extends ChangeNotifier {
  var name = 'john kim';
}

class Store1 extends ChangeNotifier{
  var follower= 0;
  var check = false;
  var profileImage = [];

  getData() async{
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/profile.json'));
    var result2 = jsonDecode(result.body);
    profileImage = result2;
    notifyListeners();
  }

  changeName(){
    if(check){
      follower = follower -= 1;
      check = false;
    }else{
      follower = follower += 1;
      check = true;
    }
    notifyListeners();
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.watch<Store2>().name),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ProfileHeader(),
          ),
          SliverGrid(
              delegate: SliverChildBuilderDelegate(
                  (c,i) => Image.network(context.watch<Store1>().profileImage[i]),
                childCount: context.watch<Store1>().profileImage.length
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3))
        ],
      )
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(Icons.account_circle,size: 50,),
        Text('팔로워 ${context.watch<Store1>().follower}명'),
        ElevatedButton(onPressed: (){
          context.read<Store1>().changeName();
        }, child: Text('팔로우')),
        ElevatedButton(onPressed: (){
          context.read<Store1>().getData();
        }, child: Text('사진가져오기'))
      ],
    );
  }
}

