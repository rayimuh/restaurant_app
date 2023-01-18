import 'package:restaurant_api/data/database_helper.dart';
import '../utils/result_state.dart';
import '../providers/database_provider.dart';
import '../widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarksPage extends StatelessWidget {
  static const routeName = '/bookmark_page';
  static const String bookmarksTitle = 'Bookmarks';

  const BookmarksPage({Key? key}) : super(key: key);

  Widget _buildList(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bookmark")),
      body: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: provider.bookmarks.length,
              itemBuilder: (context, index) {
                return CardListRestaurant(
                    listRestaurant: provider.bookmarks[index]);
              },
            );
          } else {
            return Center(
              child: Material(
                child: Text(provider.message),
              ),
            );
          }
        },
      ),
    
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }
}
