import 'package:flutter/foundation.dart'; //we can use the required meta keyword

//this will be just be a model of one of the items that we want to add & remove from our application
class Item {
  final int id; //will just specify which item is which
  final String body; //will show inside of the list

  Item({
    @required this.id,
    @required this.body,
  });

  Item copyWith({int id, String body}) {
    return Item(
      id: id ?? this.id,
      //we check to see if the id we're passing into the function is valid & not a null & if it is a null
      //then we grab the id thats already in the original item
      body: body ?? this.body,
    );
  }
}

class AppState {
  final List<Item> items;

  AppState({
    @required this.items,
  });

  //name constructor to make a new initial state which is just an empty list of item which is immutable
  //or unmodifiable
  AppState.initialState() : items = List.unmodifiable(<Item>[]);
}
