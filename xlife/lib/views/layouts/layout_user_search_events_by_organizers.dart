import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:xlife/helpers/constants.dart';
import 'package:xlife/helpers/styles.dart';
import 'package:xlife/interfaces/listener_events.dart';
import 'package:xlife/models/event.dart';
import 'package:xlife/views/layouts/item_user_event_by_organizer.dart';
import 'package:xlife/widgets/custom_chips.dart';
import 'package:xlife/widgets/custom_input_field.dart';
import 'package:xlife/widgets/custom_listview_builder.dart';
import 'package:xlife/widgets/not_found.dart';

class LayoutUserSearchEventsByOrganizers extends StatefulWidget {
  LayoutUserSearchEventsByOrganizers({Key? key}) : super(key: key);

  @override
  _LayoutUserSearchEventsByOrganizersState createState() => _LayoutUserSearchEventsByOrganizersState();
}

class _LayoutUserSearchEventsByOrganizersState extends State<LayoutUserSearchEventsByOrganizers> implements ListenerEvents {
  String searchQuery = "";
  TextEditingController searchController = TextEditingController();
  List<Event> allEvents = [];
  List<Event> filteredEvents = [];
  List<String> filtersList = [];
  String searchText = "";
  var selectedIndexes = [];

  @override
  void initState() {
    getAllEvents(this);
    super.initState();
  }

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                      filterEvents(searchController.text);
                    });
                  },
                ),
              ),
              filteredEvents.length > 0
                  ? CustomListviewBuilder(
                      itemCount: filteredEvents.length,
                      scrollable: true,
                      itemBuilder: (context, index) {
                        return ItemUserEventByOrganizer(
                          event: filteredEvents[index],
                        );
                      },
                      scrollDirection: CustomDirection.vertical,
                    )
                  : Container(
                      height: Get.height * 0.6,
                      alignment: Alignment.center,
                      child: NotFound(message: "No results"),
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
        onChange: (value) {
          filterEvents(value.toString().trim());
        },
        prefix: Icon(Icons.search),
        suffix: searchController.text.trim().isNotEmpty ? IconButton(
          onPressed: () {
            Get.defaultDialog(
                title: "Filter",
                content: StatefulBuilder(builder: (_, setState) {
                  return Expanded(
                    child: CustomListviewBuilder(
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          value: selectedIndexes.contains(index),
                          onChanged: (_) {
                            if (selectedIndexes.contains(index)) {
                              selectedIndexes.remove(index);
                            } else {
                              selectedIndexes.add(index);
                            }
                            setState(() {});
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(allEventTags[index]),
                        );
                      },
                      itemCount: allEventTags.length,
                      scrollDirection: CustomDirection.vertical,
                    ),
                  );
                }),
                onConfirm: () {
                  filtersList.clear();
                  selectedIndexes.forEach((element) {
                    filtersList.add(allEventTags[element]);
                  });
                  setState(() {});
                  filterEvents(searchController.text);
                  Get.back();
                },
                textConfirm: "Filter",
                textCancel: "Cancel",
                onCancel: () {
                  Get.back();
                });
          },
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
        ) : SizedBox(),
        controller: searchController,
        keyboardType: TextInputType.text);
  }

  @override
  void onEventAdded(List<Event> events) {
    if (mounted) {
      setState(() {
        allEvents = events;
      });
    }
    filterEvents(searchController.text);
  }

  void filterEvents(String query) {
    query = query.toLowerCase();
    filteredEvents.clear();
    if (query.isEmpty) {
      filteredEvents.addAll(allEvents);
      filtersList.clear();
      if (mounted) {
        setState(() {});
      }
      return;
    }
    print(query);
    allEvents.forEach((element) {
      if (element.title.toLowerCase().startsWith(query) || element.description.toLowerCase().contains(query)) {
        print(element.title);
        var newTagsList = filtersList;
        // selectedIndexes.forEach((index) {
        //   newTagsList.add(allEventTags[index]);
        // });

        if (newTagsList.isNotEmpty) {
          print(newTagsList);

          for (var tag in newTagsList) {
            if (element.tags.contains(tag)) {
              filteredEvents.add(element);
              break;
            }
          }
          if (mounted) {
            setState(() {});
          }
          return;
        }
        filteredEvents.add(element);
      }
    });
    if (mounted) {
      setState(() {});
    }
  }
}
