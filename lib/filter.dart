import 'package:flutter/material.dart';
import 'package:mealthy/reuse.dart';
import 'package:mealthy/filter_stats.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<String> localChoosenCuisine = [];

  List<bool> localChoose = [
    cuisineCheck[0],
    cuisineCheck[1],
    cuisineCheck[2],
    cuisineCheck[3],
    cuisineCheck[4],
    cuisineCheck[5],
    cuisineCheck[6],
    cuisineCheck[7],
    cuisineCheck[8],
    cuisineCheck[9],
    cuisineCheck[10],
    cuisineCheck[11],
    cuisineCheck[12],
    cuisineCheck[13],
    cuisineCheck[14],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
          width: double.infinity,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  backToPrevious(context),
                  SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Expanded(
                        child: Text(
                          "Filter",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(0xFF143A62),
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton.icon(
                            onPressed: () {
                              for (int index = 0;
                                  index < cuisineChoose.length;
                                  index++) {
                                cuisineCheck[index] = false;
                                localChoose[index] = false;
                              }
                              choosenCuisine = [];
                              localChoosenCuisine = [];
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                duration: const Duration(seconds: 2),
                                content: Text('Filter reset success'),
                              ));
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.refresh,
                              size: 24.0,
                              color: Color(0xFFFCC25E),
                            ),
                            label: Text(
                              'Clear all',
                              style: TextStyle(
                                  color: Color(0xFFFCC25E),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.all(0.0),
                              primary: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        for (int index = 0;
                            index < cuisineChoose.length;
                            index++)
                          Column(
                            children: <Widget>[
                              Theme(
                                data: ThemeData(
                                  unselectedWidgetColor: Color(0xFF143A62),
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                ),
                                child: CheckboxListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    cuisineChoose[index],
                                    style: TextStyle(
                                      color: Color(0xFF4A4A4A),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  activeColor: Color(0xFF143A62),
                                  checkColor: Colors.white,
                                  autofocus: false,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  selected: localChoose[index],
                                  value: localChoose[index],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        localChoosenCuisine
                                            .add(cuisineChoose[index]);
                                      } else {
                                        localChoosenCuisine
                                            .remove(cuisineChoose[index]);
                                      }
                                      localChoose[index] = value;
                                    });
                                  },
                                ),
                              ),
                              index < cuisineChoose.length - 1
                                  ? Divider(
                                      height: 18,
                                      thickness: 1,
                                      color: Color(0xFFC4C4C4),
                                    )
                                  : SizedBox(
                                      height: 0,
                                    )
                            ],
                          ),
                      ],
                    ),
                  ),
                  UIButton(context, 'Apply', () {
                    print(choosenCuisine);
                    cuisineCheck = [];
                    cuisineCheck.addAll(localChoose);
                    choosenCuisine = [];
                    choosenCuisine.addAll(localChoosenCuisine);
                    Navigator.pop(context);
                  })
                ],
              ),
            ),
          )),
    );
  }
}
