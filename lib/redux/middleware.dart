import 'dart:async';
import 'dart:convert';

import 'package:flutter_redux_todo_eg/model/model.dart';
import 'package:flutter_redux_todo_eg/redux/actions.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Middleware<AppState>> appStateMiddleware([
  AppState state = const AppState(items: []),
]) {
  final loadItems = _loadFromPrefs(state);
  final saveItems = _saveToPrefs(state);

  return [
    TypedMiddleware<AppState, AddItemAction>(saveItems),
    TypedMiddleware<AppState, RemoveItemAction>(saveItems),
    TypedMiddleware<AppState, RemoveItemsAction>(saveItems),
    TypedMiddleware<AppState, GetItemsAction>(loadItems),
  ];
}

//return middleware closures of type app state
Middleware<AppState> _loadFromPrefs(AppState state) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    loadFromPrefs()
        .then((state) => store.dispatch(LoadedItemsAction(state.items)));
  };
}

Middleware<AppState> _saveToPrefs(AppState state) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    saveToPrefs(store.state);
  };
}

//helper functions
void saveToPrefs(AppState state) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = json.encode(state.toJson());
  await preferences.setString('itemsState', string);
}

Future<AppState> loadFromPrefs() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = preferences.getString('itemsState');
  if (string != null) {
    Map map = json.decode(string);
    return AppState.fromJson(map);
  }
  return AppState.initialState();
}

//void appStateMiddleware(Store<AppState>store,action,NextDispatcher next) async {
//  next(action);
//
//  if(action is AddItemAction ||
//  action is RemoveItemAction ||
//  action is RemoveItemsAction){
//    saveToPrefs(store.state);
//  }
//
//  if(action is GetItemsAction){
//    await loadFromPrefs().then((state)=>store.dispatch(LoadedItemsAction(state.items)));
//  }
//}// it allow us to execute side effects which interact with items outside of our control or do things
//that are outside of our application like reading & writing or reading from database or reading from an api
//& then allows us to keep our reducers pure

//typed middleware is preety userful becoz it allows us to essentially take
//the concerns of middleware & tie then ti individual pieces of middleware &
//then chain all this middleware together the advantages of this are that it makes
//our middleware much more readable
