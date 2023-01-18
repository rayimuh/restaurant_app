import 'package:provider/provider.dart';
import '../common/navigation.dart';
import '../model/model.dart';
import '../page/detail_page.dart';
import 'package:flutter/material.dart';
import '../providers/database_provider.dart';
import '../data/database_helper.dart';

class CardListRestaurant extends StatelessWidget {
  final getListRestaurant listRestaurant;

  const CardListRestaurant({Key? key, required this.listRestaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<bool>(
            future: provider.isBookmarked(listRestaurant.id),
            builder: (context, snapshot) {
              var isBookmarked = snapshot.data ?? false;
              return Material(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    leading: Hero(
                      tag: Image.network(
                          "https://restaurant-api.dicoding.dev/images/medium/${listRestaurant.pictureId}"),
                      child: Image.network(
                        "https://restaurant-api.dicoding.dev/images/medium/${listRestaurant.pictureId}",
                        width: 100,
                      ),
                    ),
                    title: Text(
                      listRestaurant.name,
                    ),
                    subtitle: Text(listRestaurant.city),
                    onTap: () => Navigation.intentWithData(RestaurantDetailPage.routeName, listRestaurant.id),
                    trailing: isBookmarked
                        ? IconButton(
                            icon: const Icon(Icons.bookmark),
                            color: Colors.blue,
                            onPressed: () =>
                                provider.removeBookmark(listRestaurant.id),
                          )
                        : IconButton(
                            icon: const Icon(Icons.bookmark_border),
                            color: Colors.blue,
                            onPressed: () =>
                                provider.addBookmark(listRestaurant),
                          ),
                  ),
                ),
              );
            },
          );
        },
      );
    
  }
}
