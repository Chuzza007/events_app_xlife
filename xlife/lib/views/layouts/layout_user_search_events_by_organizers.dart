import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:xlife/helpers/styles.dart';
import 'package:xlife/views/layouts/item_user_event_by_organizer.dart';
import 'package:xlife/widgets/custom_chips.dart';
import 'package:xlife/widgets/custom_input_field.dart';
import 'package:xlife/widgets/custom_listview_builder.dart';

class LayoutUserSearchEventsByOrganizers extends StatefulWidget {
  LayoutUserSearchEventsByOrganizers({Key? key})
      : super(key: key);

  @override
  _LayoutUserSearchEventsByOrganizersState createState() =>
      _LayoutUserSearchEventsByOrganizersState();
}

class _LayoutUserSearchEventsByOrganizersState
    extends State<LayoutUserSearchEventsByOrganizers> {
  String searchQuery = "";
  TextEditingController searchController = TextEditingController();
  List<String> filtersList = [
    "Filter 1",
    "Filter 2",
    "Filter 3",
    "Filter 4",
    "Filter 5",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: _buildSearchField(),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Visibility(
                visible: filtersList.isNotEmpty,
                child: CustomChips(
                  chipNames: filtersList,
                  selectable: false,
                  scrollable: true,
                  onDeleted: (newList) {
                    setState(() {
                      filtersList = newList;
                    });
                  },
                ),
              ),
              CustomListviewBuilder(
                itemCount: 20,
                scrollable: true,
                itemBuilder: (context, index) {
                  return ItemUserEventByOrganizer(
                    favorite: false,
                  );
                },
                scrollDirection: CustomDirection.vertical,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return CustomInputField(
        hint: "Search Event",
        isPasswordField: false,
        prefix: Icon(Icons.search),
        suffix: IconButton(
          onPressed: () {},
          icon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${filtersList.length}",
                style: (GetPlatform.isWeb ? normal_h4Style_web : normal_h4Style).copyWith(
                  color: Colors.grey,
                ),
              ),
              Icon(Icons.filter_list),
            ],
          ),
          splashColor: Colors.transparent,
        ),
        controller: searchController,
        keyboardType: TextInputType.text);
  }
}
