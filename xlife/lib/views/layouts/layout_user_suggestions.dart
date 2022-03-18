import 'package:flutter/material.dart';
import 'package:xlife/views/layouts/item_user_suggestion.dart';

class LayoutUserSuggestions extends StatefulWidget {
  const LayoutUserSuggestions({Key? key}) : super(key: key);

  @override
  _LayoutUserSuggestionsState createState() =>
      _LayoutUserSuggestionsState();
}

class _LayoutUserSuggestionsState
    extends State<LayoutUserSuggestions> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (_, index) {
        return ItemUserSuggestion();
      },
    );
  }
}
