//this will contain all the actions that our application is allowed to take
//to mutate the state inside of our model
import 'package:flutter_redux_todo_eg/model/model.dart';

class AddItemAction {
  static int _id = 0;
  final String item;

  AddItemAction(this.item) {
    _id++;
  }

  int get id => _id;
}

class RemoveItemAction {
  final Item item;

  RemoveItemAction(this.item);
} //remove one wsingle item

class RemoveItemsAction {} //remove all the items

class GetItemsAction {
} //gets dispatched from the user interface to the middleware..doesnt need any additional data attached to it
//becoz it's just  initiating a function

class LoadedItemsAction {
  final List<Item> items;

  LoadedItemsAction(this.items);
} //gets dispatched from the middleware to our reducer

class ItemCompletedAction {
  final Item item;

  ItemCompletedAction(this.item);
}
