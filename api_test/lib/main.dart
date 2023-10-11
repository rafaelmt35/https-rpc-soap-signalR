import 'package:catapi_test/catScreen.dart';
import 'package:catapi_test/postClass.dart';
import 'package:catapi_test/remoteFunction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'API TEST',
      home: MyHomePage(title: 'API TEST'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Post?>? post;
  var isLoaded = false;

  void clickGet() {
    setState(() {
      post = RemoteService().getPost();
    });
  }

  void clickdelete() {
    setState(() {
      post = RemoteService().deletePost();
    });
  }

  void clickPost() {
    setState(() {
      post = RemoteService().postFunct('test title', 'TEST EXAMPLE POST');
    });
  }

  void clickUpdate() {
    setState(() {
      post = RemoteService().updatePost('TEST UPDATE', 'UPDATE TEXT EXAMPLE');
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 15.0),
                  height: 60.0,
                  width: 150.0,
                  decoration: const BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const catScreen();
                        }));
                      },
                      child: const Text("GO TO CAT API")),
                ),
                FutureBuilder<Post?>(
                    future: post,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.connectionState ==
                          ConnectionState.none) {
                        return Container();
                      } else {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                    'user id : ${snapshot.data!.userId.toString()}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text('title : ${snapshot.data!.title}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                    'desc : ${snapshot.data!.description}'),
                              )
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        } else {
                          return Container();
                        }
                      }
                    }),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  height: 60.0,
                  width: 150.0,
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: ElevatedButton(
                      onPressed: () => clickGet(), child: const Text("GET")),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  height: 60.0,
                  width: 150.0,
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: ElevatedButton(
                      onPressed: () => clickPost(), child: const Text("POST")),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  height: 60.0,
                  width: 150.0,
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: ElevatedButton(
                      onPressed: () => clickUpdate(),
                      child: const Text("UPDATE")),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  height: 60.0,
                  width: 150.0,
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: ElevatedButton(
                      onPressed: () => clickdelete(),
                      child: const Text("DELETE")),
                ),
              ],
            ),
          ),
        ));
  }
}
