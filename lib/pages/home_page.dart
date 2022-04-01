import 'package:flutter/material.dart';
import 'package:network/models/post.dart';
import 'package:network/services/http_service.dart';
import 'package:network/services/log_service.dart';

class HomePage extends StatefulWidget {
  static String id = "home_page";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Post> posts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiPostList();
    // var post = Post(id: 1,title: "PDP",body: "Online",userId: 1);
    // _apiPostCreate(post);
    // _apiPostUpdate(post);
    //_apiPostDelete(post);
  }

  void _apiPostList() {
    setState(() {
      isLoading = true;
    });
    Network.GET(Network.API_LIST, Network.paramsEmpty()).then((response) => {
      Log.d(response!),
      _resPostList(response),
    });
  }

  void _resPostList(String response) {
    List<Post> list = Network.parsePostList(response);
    setState(() {
      isLoading = false;
      posts = list;
    });
  }

  void _apiPostCreate(Post post) {
    Network.POST(Network.API_CREATE, Network.paramsCreate(post))
        .then((response) => {
      print(response!),
      //_showResponse(response),
    });
  }

  void _apiPostUpdate(Post post) {
    Network.PUT(
        Network.API_UPDATE + post.id.toString(), Network.paramsUpdate(post))
        .then((response) => {
      print(response!),
      //_showResponse(response),
    });
  }

  void _apiPostDelete(Post post) {
    setState(() {
      isLoading = true;
    });
    Network.DEL(Network.API_DELETE + post.id.toString(), Network.paramsEmpty())
        .then((response) => {
      _resPostDelete(response),
    });
  }

  void _resPostDelete(String? response) {
    setState(() {
      isLoading = false;
    });
    if (response != null) _apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("HTTP Networking"),
        ),
        body: Stack(
          children: [
            ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, position) {
                return itemOfPost(posts[position]);
              },
            ),
            isLoading?
            Center(
              child: CircularProgressIndicator(),
            ): SizedBox.shrink(),
          ],
        )
    );
  }

  Widget itemOfPost(Post post) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title!.toUpperCase(),
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            post.body!,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ],
      ),
    );
  }
}










////////////////////////////////updated

