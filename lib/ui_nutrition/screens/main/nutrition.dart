import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mealthy/blocs/item_filter/item_filter_bloc.dart';
import 'package:mealthy/blocs/search_bloc/search_bloc.dart';
import 'package:mealthy/ui/components/common/appbar.dart';
import 'package:mealthy/ui_nutrition/components/item_card/itemcard.dart';
import 'package:mealthy/ui_nutrition/components/search/search.dart';




class Nutrition extends StatefulWidget {
  const Nutrition({Key? key}) : super(key: key);

  @override
  State<Nutrition> createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> {
  @override
  Widget build(BuildContext context) {
    final searchTerm = BlocProvider.of<SearchBloc>(context).state.searchTerm;

    CollectionReference<Map<String, dynamic>> future =
    FirebaseFirestore.instance.collection('nutrition');

    Future<List<Map<String, dynamic>>> _onQuery() {
      Future<List<Map<String, dynamic>>> res;
      if (searchTerm.isNotEmpty) {
        res = future.get().then((v) => v.docs
            .map((e) => e.data())
            .where((e) =>
            e['name'].toLowerCase().contains(searchTerm.toLowerCase()))
            .toList());
      } else {
        res = future.get().then((v) => v.docs.map((e) => e.data()).toList());
      }
      setState(() {});
      return res;
    }

    return BlocListener<ItemFilterBloc, ItemFilterState>(
      listener: (context, state) {
        _onQuery();
      },
      child: BlocListener<SearchBloc, SearchState>(
        listener: (BuildContext context, state) {
          _onQuery();
        },
        child: FutureBuilder<List<Map<String, dynamic>>>(
            future: _onQuery(),
            builder: (context, snapshot) {
              return snapshot.data != null ? Scaffold(
                  appBar: MainAppBar(),
                  body: Stack(children: [
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text('Nutrition',
                          style: TextStyle(
                              color: Color(0xFF315796),
                              fontWeight: FontWeight.bold,
                              fontSize: 36)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 75),
                      child: Search(),
                    ),
                    snapshot.connectionState == ConnectionState.done
                        ? searchTerm.isNotEmpty && snapshot.data!.isEmpty
                        ? const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Center(
                            child: Text('No results.',
                                style: TextStyle(fontSize: 20))))
                        : Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 140),
                          child: RefreshIndicator(
                              onRefresh: () => _onQuery(),
                              child: GridView.count(
                                  primary: false,
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 30),
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 2,
                                  children: snapshot.data!.map((data) {
                                      return Itemcard(
                                          docId: data[
                                          'id'
                                          ], data: data, details: future.doc(data['id']).collection('detail').get());
                                  }).toList()))),
                    )
                        : const Center(child: CircularProgressIndicator()),
                  ])) : const Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}