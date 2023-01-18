import 'package:provider/provider.dart';
import 'package:restaurant_api/page/bookmark_page.dart';
import 'package:restaurant_api/page/setting_page.dart';
import '../api/api_service.dart';
import 'search_page.dart';
import '../widgets/card_list.dart';
import '../utils/result_state.dart';
import 'package:flutter/material.dart';
import '../providers/list_provider.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key? key}) : super(key: key);
  

  Widget _buildList(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant List"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RestaurantSearchPage.routeName);
              },
              icon: const Icon(Icons.search)),          
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.pushNamed(context, BookmarksPage.routeName);
        },
        child: const Icon(Icons.bookmark),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Consumer<ListRestaurantProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.loading) {
                      return Center(
                        child: Column(
                          children: const [
                            SizedBox(height: 10),
                            CircularProgressIndicator()
                          ],
                        ),
                      );
                    } else if (state.state == ResultState.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: state.result.restaurants.length,
                        itemBuilder: (context, index) {
                          var listRestaurant = state.result.restaurants[index];
                          return CardListRestaurant(
                              listRestaurant: listRestaurant);
                        },
                      );
                    } else if (state.state == ResultState.noData) {
                      return Center(
                        child: Material(
                          child: Text(state.message),
                        ),
                      );
                    } else if (state.state == ResultState.error) {
                      return Center(
                        child: Material(
                          child: Text(state.message),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Material(
                          child: Text(''),
                        ),
                      );
                    }
                  },
              )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }
}
