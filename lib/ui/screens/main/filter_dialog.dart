import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../blocs/item_filter/item_filter_bloc.dart';

Future<void> showFilterDialog(BuildContext context) {
  return showDialog(
    builder: (context) {
      return FilterDialog();
    },
    context: context,
  );
}

class FilterDialog extends StatefulWidget {
  const FilterDialog({Key? key}) : super(key: key);

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}


Map<int, String> _cuisineFilter = {
  0: 'salads',
  1: 'italian',
  2: 'sushi',
  3: 'appetizers',
  4: 'desserts',
  5: 'korean',
  6: 'mexican',
};

Map<int, String> _allergenFilter = {
  0: 'eggs',
  1: 'peanuts',
  2: 'fish',
  3: 'milk',
  4: 'wheat',
  5: 'shellfish',
  6: 'soyBeans',
  7: 'treeNuts',
};


class _FilterDialogState extends State<FilterDialog> {
  int cuisineGroupVal = -1;
  int allergenGroupVal = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //_filterSaved() {}
    final itemFilterBloc = BlocProvider.of<ItemFilterBloc>(context);

    _filterSaved() {
      itemFilterBloc.add(ItemFilterChanged(
          _cuisineFilter[cuisineGroupVal] ?? '',
          _allergenFilter[allergenGroupVal] ?? ''));
      Get.back();
    }
    return AlertDialog(
      title:const Text(
          'Filter',
        style: TextStyle(
            color: Color(0xFF143A62),
            fontSize: 36,
            fontWeight: FontWeight.bold,
        ),
      ),
        content: SingleChildScrollView(
            child: Container(
                width: double.maxFinite,
                child: Column(children: [
                  Padding(
                      padding:EdgeInsets.only(bottom:10),
                      child:Text(
                          'Cuisine',
                          style:TextStyle(
                            color: Color(0xFFFCC25E),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ))),
                  LabeledRadio(
                    label: 'Salads',
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    value: false,
                    groupValue: cuisineGroupVal != 0,
                    onChanged: (bool newValue) {
                      setState(() {
                        cuisineGroupVal = 0;
                      });
                    },
                  ),
                  LabeledRadio(
                    label: 'Italian',
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    value: false,
                    groupValue: cuisineGroupVal  != 1,
                    onChanged: (bool newValue) {
                      setState(() {
                        cuisineGroupVal = 1;
                      });
                    },
                  ),
                  LabeledRadio(
                    label: 'Sushi',
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    value: false,
                    groupValue: cuisineGroupVal != 2,
                    onChanged: (bool newValue) {
                      setState(() {
                        cuisineGroupVal = 2;
                      });
                    },
                  ),
                  LabeledRadio(
                    label: 'Appetizers',
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    value: false,
                    groupValue: cuisineGroupVal  != 3,
                    onChanged: (bool newValue) {
                      setState(() {
                        cuisineGroupVal = 3;
                      });
                    },
                  ),
                  LabeledRadio(
                    label: 'Desserts',
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    value: false,
                    groupValue: cuisineGroupVal  != 4,
                    onChanged: (bool newValue) {
                      setState(() {
                        cuisineGroupVal = 4;
                      });
                    },
                  ),
                  LabeledRadio(
                    label: 'Korean',
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    value: false,
                    groupValue: cuisineGroupVal != 5,
                    onChanged: (bool newValue) {
                      setState(() {
                        cuisineGroupVal = 5;
                      });
                    },
                  ),
                  LabeledRadio(
                    label: 'Mexican',
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    value: false,
                    groupValue: cuisineGroupVal != 6,
                    onChanged: (bool newValue) {
                      setState(() {
                        cuisineGroupVal = 6;
                      });
                    },
                  ),

                  Padding(
                      padding:EdgeInsets.only(bottom:10, top: 10),
                      child:Text(
                          'Allergen',
                          style:TextStyle(
                            color: Color(0xFFFCC25E),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ))),
                  LabeledRadio(
                    label: 'Eggs',
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    value: false,
                    groupValue: allergenGroupVal != 0,
                    onChanged: (bool newValue) {
                      setState(() {
                        allergenGroupVal = 0;
                      });
                    },
                  ),
                  LabeledRadio(
                    label: 'Peanuts',
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    value: false,
                    groupValue: allergenGroupVal  !=1 ,
                    onChanged: (bool newValue) {
                      setState(() {
                        allergenGroupVal = 1;
                      });
                    },
                  ),
                  LabeledRadio(
                    label: 'Fish',
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    value: false,
                    groupValue: allergenGroupVal != 2,
                    onChanged: (bool newValue) {
                      setState(() {
                        allergenGroupVal = 2;
                      });
                    },
                  ),
                  LabeledRadio(
                    label: 'Milk',
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    value: false,
                    groupValue: allergenGroupVal  != 3,
                    onChanged: (bool newValue) {
                      setState(() {
                        allergenGroupVal = 3;
                      });
                    },
                  ),
                  LabeledRadio(
                    label: 'Wheat',
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    value: false,
                    groupValue: allergenGroupVal  != 4,
                    onChanged: (bool newValue) {
                      setState(() {
                        allergenGroupVal = 4;
                      });
                    },
                  ),
                  LabeledRadio(
                    label: 'Shellfish',
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    value: false,
                    groupValue: allergenGroupVal  !=5,
                    onChanged: (bool newValue) {
                      setState(() {
                        allergenGroupVal = 5;
                      });
                    },
                  ),
                  LabeledRadio(
                    label: 'Soy Beans',
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    value: false,
                    groupValue: allergenGroupVal != 6,
                    onChanged: (bool newValue) {
                      setState(() {
                        allergenGroupVal = 6;
                      });
                    },
                  ),
                  LabeledRadio(
                    label: 'Tree Nuts',
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    value: false,
                    groupValue: allergenGroupVal != 7,
                    onChanged: (bool newValue) {
                      setState(() {
                        allergenGroupVal = 7;
                      });
                    },
                  ),
                ]))),
        //actions: [TextButton(onPressed: () => _filterSaved(), child: Text('Save', style:TextStyle(color:colorYellow)))]);
        actions: [
          TextButton(
            onPressed: (){ itemFilterBloc.add(const ItemFilterChanged('', ''));
            Get.back();
            },
            child: const Text(
              'Reset',
              style:TextStyle(
                color: Color(0xFFFCC25E),
                fontSize: 18.0,
              ),
            ),
          ),
          TextButton(
              onPressed: () => _filterSaved(),
              child: Text(
                  'Save',
                  style: TextStyle(
                    color: Color(0xFFFCC25E),
                    fontSize: 18.0,
                  )))
        ]);
  }


}

class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    Key? key,
    required this.label,
    required this.padding,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<bool>(
              groupValue: groupValue,
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue!);
              },
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}
