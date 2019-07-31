//use to define the various different pure functions
//which we're going to apply to our application state to make
//the changes happen

import 'package:flutter_redux_todo_eg/model/model.dart';
import 'package:flutter_redux_todo_eg/redux/actions.dart';

//overarching function that gets called every single time we want to commit
//a change to our store
AppState appStateReducer(AppState state, action) {
  return AppState(
    items: itemReducer(state.items, action),
  );
}

//allow us to manipulate the actual list of item which is inside of our app state
List<Item> itemReducer(List<Item> state, action) {
  if (action is AddItemAction) {
    return []
      ..addAll(state)
      ..add(Item(id: action.id, body: action.item));
  }

  if (action is RemoveItemAction) {
    return List.unmodifiable(List.from(state)..remove(action.item));
  }

  if (action is RemoveItemsAction) {
    return List.unmodifiable([]);
  }

  if (action is LoadedItemsAction) {
    return action.items;
  }

  return state;
}
