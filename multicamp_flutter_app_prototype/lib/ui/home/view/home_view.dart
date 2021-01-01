import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webfeed/webfeed.dart';
import 'package:multicamp_flutter_app_prototype/ui/home/view_model/home_view_model.dart';
import 'package:multicamp_flutter_app_prototype/ui/news_detail/view/news_detail_view.dart';
import 'package:multicamp_flutter_app_prototype/ui/settings/view/settings_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = getHomeViewModelInstance();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextField(
            controller: viewModel.searchController,
            decoration: InputDecoration(
                hintText: "Başlıklarda ara...", border: InputBorder.none),
            onSubmitted: (String query) => viewModel.applyFilter(),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  viewModel.filterApplied ? Icons.backspace : Icons.search,
                  color: Colors.black54,
                ),
                onPressed: () => viewModel.filterApplied
                    ? viewModel.clearFilter()
                    : viewModel.applyFilter()),
            IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
                onPressed: () =>
                    Navigator.push(context, _routeToSettingsView()))
          ],
        ),
        body: Observer(builder: (_) {
          return viewModel.loading
              ? Center(child: CircularProgressIndicator())
              : Container(
                  // padding: EdgeInsets.symmetric(horizontal: 12),
                  child: viewModel.items.length > 0
                      ? ListView.builder(
                          itemCount: 30,
                          itemBuilder: (BuildContext context, int index) {
                            if (viewModel.items.length > index) {
                              return _buildNewsCard(index);
                            } else {
                              return Container();
                            }
                          })
                      : Center(
                          child: Column(children: [
                            Container(
                              margin: EdgeInsets.only(top: 32, bottom: 16),
                              child: Image.asset(
                                "assets/news.png",
                                height: 100,
                              ),
                            ),
                            Text(
                              "Sonuç yok",
                              style: TextStyle(fontSize: 32),
                            )
                          ]),
                        ));
        }));
  }

  HomeViewModel getHomeViewModelInstance() {
    if (viewModel == null) {
      viewModel = HomeViewModel();
      viewModel.init();
    }
    return viewModel;
  }

  Widget _buildNewsCard(int index) {
    final RssItem newsItem = viewModel.items[index];
    final cornerRadius = Radius.circular(6);

    var cardMargin;
    if (index == 0) {
      cardMargin = EdgeInsets.only(top: 12, bottom: 4, left: 12, right: 12);
    } else if (index == viewModel.items.length - 1) {
      cardMargin = EdgeInsets.only(top: 4, bottom: 12, left: 12, right: 12);
    } else {
      cardMargin = EdgeInsets.symmetric(vertical: 4, horizontal: 12);
    }

    return InkWell(
        onTap: () => Navigator.push(
            context, _routeToNewsDetailView(newsItem.title, newsItem.link)),
        child: Card(
          // elevation: 2,
          margin: cardMargin,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(cornerRadius)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: cornerRadius, topRight: cornerRadius),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 24,
                    child: Image.network(
                      newsItem.imageUrl,
                      fit: BoxFit.cover,
                      frameBuilder: (arg1, image, frame, arg4) => Container(
                          height: 200,
                          color: Colors.black12,
                          child: AnimatedOpacity(
                            child: image,
                            opacity: frame == null ? 0 : 1,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeOut,
                          )),
                    ),
                  )),
              Container(
                  margin: EdgeInsets.all(12),
                  child: Text(
                    newsItem.title,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ))
            ],
          ),
        ));
  }

  Route _routeToNewsDetailView(String title, String url) {
    return MaterialPageRoute(builder: (context) => NewsDetailView(title, url));
  }

  Route _routeToSettingsView() {
    return MaterialPageRoute(builder: (context) => SettingsView());
  }
}
