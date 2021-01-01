import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:multicamp_flutter_app_prototype/rss/anadolu_ajansi_rss.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:webfeed/webfeed.dart';
part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  // SharedPreferences prefs;
  TextEditingController searchController;

  @observable
  String query = "";

  RssFeed feed;

  @observable
  List<RssItem> items = [];

  @observable
  bool loading = true;

  @observable
  bool filterApplied = false;

  void init() async {
    // prefs = await SharedPreferences.getInstance();
    searchController = TextEditingController();
    feed = await AnadoluAjansiRss.getFeed();
    items = feed.items;
    loading = false;
  }

  @action
  void applyFilter() {
    final query = searchController.value.text;
    if (query.trim().length > 1) {
      loading = true;
      items = feed.items
          .where((element) =>
              element.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
      loading = false;
      filterApplied = true;
    } else {
      clearFilter();
    }
  }

  @action
  void clearFilter() {
    loading = true;
    items = feed.items;
    searchController.clear();
    loading = false;
    filterApplied = false;
  }
}
