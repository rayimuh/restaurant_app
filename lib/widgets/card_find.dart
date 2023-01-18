import 'package:provider/provider.dart';
import '../model/model.dart';
import '../page/detail_page.dart';
import 'package:flutter/material.dart';
import '../providers/database_provider.dart';
import 'package:restaurant_api/common/navigation.dart';


class CardFindRestaurant extends StatelessWidget {
  final getListRestaurant findRestaurant;

  const CardFindRestaurant({Key? key, required this.findRestaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<bool>(
            future: provider.isBookmarked(findRestaurant.id),
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
                          "https://restaurant-api.dicoding.dev/images/medium/${findRestaurant.pictureId}"),
                      child: Image.network(
                        "https://restaurant-api.dicoding.dev/images/medium/${findRestaurant.pictureId}",
                        width: 100,
                      ),
                    ),
                    title: Text(
                      findRestaurant.name,
                    ),
                    subtitle: Text(findRestaurant.city),
                    onTap: () =>Navigation.intentWithData(RestaurantDetailPage.routeName, findRestaurant.id),
                    trailing: isBookmarked
                        ? IconButton(
                            icon: const Icon(Icons.bookmark),
                            color: Colors.blue,
                            onPressed: () =>
                                provider.removeBookmark(findRestaurant.id),
                          )
                        : IconButton(
                            icon: const Icon(Icons.bookmark_border),
                            color: Colors.blue,
                            onPressed: () =>
                                provider.addBookmark(findRestaurant),
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
