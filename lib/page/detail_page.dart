import 'package:provider/provider.dart';
import 'package:restaurant_api/providers/detail_provider.dart';
import '../api/api_service.dart';
import 'package:flutter/material.dart';
import '../utils/result_state.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  final String id;

  const RestaurantDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text("Restaurant App")),
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (_) =>
              DetailRestaurantProvider(apiService: ApiService(), id: id),
          child: Consumer<DetailRestaurantProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.state == ResultState.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Hero(
                        tag: Image.network(
                            "https://restaurant-api.dicoding.dev/images/medium/${state.result.restaurant.pictureId}"),
                        child: Image.network(
                            "https://restaurant-api.dicoding.dev/images/medium/${state.result.restaurant.pictureId}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.result.restaurant.name,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              state.result.restaurant.city,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Rating: ${state.result.restaurant.rating}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const Divider(color: Colors.black),
                            Text(
                              state.result.restaurant.description,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const Divider(color: Colors.black),
                            Text("Makanan"),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 30,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: state.result.restaurant.menus.foods
                                    .map((food) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Card(child: Text(food.name)),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text("Minuman"),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 30,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: state.result.restaurant.menus.drinks
                                    .map((drink) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Card(child: Text(drink.name)),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text("Review"),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 50,
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: state
                                    .result.restaurant.customerReviews
                                    .map((name) {
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Card(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(name.name),
                                          Text('"${name.review}"')
                                        ],
                                      )));
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state.state == ResultState.noData ||
                  state.state == ResultState.error ||
                  state.state == ResultState.noConnection) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(height: 8),
                      Text(state.message),
                      const SizedBox(height: 8),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Back'))
                    ],
                  ),
                );
              } else {
                return const Center(child: Text(''));
              }
            },
          ),
        ),
      ),
    );
  }
}
