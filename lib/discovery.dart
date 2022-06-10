import 'package:flutter/material.dart';

class Discovery extends StatefulWidget {
  const Discovery({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DiscoveryState createState() => _DiscoveryState();
}

class _DiscoveryState extends State<Discovery> {
  double? screenWidth;

  @override
  Widget build(BuildContext context) {
    screenWidth ??= MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MyTheme.backgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          MyTheme.largeVerticalPadding,
          const Text(
            "Discovery",
            style: TextStyle(
                color: Color(0xFF0D47A1),
                fontSize: 36,
                fontWeight: FontWeight.bold),
          ),

          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(
              height: 50,
              child: Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search Recipe",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none),
                    fillColor: Colors.blue.shade50,
                    filled: true,
                  ),
                ),
              ),
            ),
          ),

          GridView.count(
            childAspectRatio: 0.9, //0.75
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              courseCard(
                courseImage: const AssetImage('assets/broccoli.png'),
                courseName: "broccoli",
              ),
              courseCard(
                courseImage: const AssetImage('assets/carrots.png'),
                courseName: "carrots",
              ),
              courseCard(
                courseImage: const AssetImage('assets/chicken.png'),
                courseName: "chicken",
              ),
              courseCard(
                courseImage: const AssetImage('assets/flour.png'),
                courseName: "flour",
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget courseCard(
      {required AssetImage courseImage,
        required String courseName,
      }) {
    return GestureDetector(
      onTap: () {
        // TODO: uncomment if you wish to navigato to course screen avaialble at FlutterBricks
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => CourseScreen(
        //             courseName: courseName,
        //             courseImage: courseImage,
        //             courseInfo: courseInfo,
        //             coursePrice: coursePrice,
        //           )),
        // );
      },
      child: Card(
          color: MyTheme.courseCardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: screenWidth! < 400 ? 3 : 5,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: courseImage,
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(courseName,
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}

class MyTheme {
  static Color get backgroundColor => Colors.white;//const Color(0xFFF7F7F7);
  static Color get courseCardColor => Colors.blue.shade50;
  static Padding get largeVerticalPadding =>
      const Padding(padding: EdgeInsets.only(top: 32.0));

  static ThemeData get theme => ThemeData(
    fontFamily: 'Poppins',
    primarySwatch: Colors.blueGrey,
  ).copyWith(
    cardTheme: const CardTheme(
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)))),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0.0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        // Button color
        foregroundColor: MaterialStateProperty.all<Color>(
            Colors.white), // Text and icon color
      ),
    ),
  );
}
