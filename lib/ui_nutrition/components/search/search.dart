import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/search_bloc/search_bloc.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Color(0xFFF2F6FC),
        elevation: 5,
        borderRadius: BorderRadius.circular(6.0),
        child: InkWell(
            key: const Key('search'),
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [_searchBarContent(context)],
            )));
  }
}

void _submitSearch(String s, SearchBloc searchBloc) {
  searchBloc.add(SearchTextAdded(searchText: s));
}

Widget _searchBarContent(BuildContext context) {
  final textEditingController = TextEditingController();
  final searchBloc = BlocProvider.of<SearchBloc>(context);

  return MediaQuery(
    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
    child: Expanded(
      child: Row(
        children: <Widget>[
          Flexible(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search, color: Color(0xFF8C8C8C))),

                    const SizedBox(width: 6),
                    Expanded(
                      child: TextField(
                          onChanged: (s) => searchBloc.add(SearchTextChanged(searchText: s)),
                          onSubmitted: (String s) => _submitSearch(s, searchBloc),
                          controller: textEditingController,
                          style: TextStyle(color: Color(0xFF4A4A4A)),
                          decoration: InputDecoration(
                              hintText: 'Search nutrition fact',
                              hintStyle: TextStyle(color: Color(0xFF8C8C8C)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)))),
                    ),

                    const SizedBox(
                      width: 5,
                    ),
                  ],
                )),
          ),
        ],
      ),
    ),
  );
}
