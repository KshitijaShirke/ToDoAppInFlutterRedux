import 'package:flutter/foundation.dart'; //we can use the required meta keyword

//this will be just be a model of one of the items that we want to add & remove from our application
class Item {
  final int id; //will just specify which item is which
  final String body; //will show inside of the list
  final bool completed;

  Item({
    @required this.id,
    @required this.body,
    this.completed = false,
  });

  Item copyWith({int id, String body, bool completed}) {
    return Item(
      id: id ?? this.id,
      //we check to see if the id we're passing into the function is valid & not a null & if it is a null
      //then we grab the id thats already in the original item
      body: body ?? this.body,
      completed: completed ?? this.completed,
    );
  }

  //create functions that will allow us to take our data and convert it to and from JSON

  //from json constructor which takes in map and then takes that map and assigns the body key to body &  id key to id
  Item.fromJson(Map json)
      : body = json['body'],
        id = json['id'],
        completed = json['completed'];

  Map toJson() => {
        'id': (id as int),
        'body': body,
        'completed': completed,
      };

  @override
  String toString() {
    // TODO: implement toString
    return toJson().toString();
  }
}

class AppState {
  final List<Item> items;

  const AppState({
    @required this.items,
  });

  //named constructor to make a new initial state which is just an empty list of item which is immutable
  //or unmodifiable
  AppState.initialState() : items = List.unmodifiable(<Item>[]);

  //named constructor - take items & we want to take items out of the map that we're passing through here with
  //the key being items & we want to convert that into a list & then map over it & we take each item out of this list
  //& we convert those items into json individually & put back into a list  then that will allow us to then use it inside our app state
  AppState.fromJson(Map json)
      : items = (json['items'] as List).map((i) => Item.fromJson(i)).toList();

  Map toJson() => {'items': items};

  @override
  String toString() {
    // TODO: implement toString
    return toJson().toString();
  }
}
