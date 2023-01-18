import 'package:provider/provider.dart';
import 'package:restaurant_api/providers/search_provider.dart';
import '../api/api_service.dart';
import 'package:flutter/material.dart';
import '../widgets/card_find.dart';
import '../utils/result_state.dart';
class RestaurantSearchPageResult extends StatelessWidget {
  static const routeName = '/restaurant_search_result';
  final String query;

  const RestaurantSearchPageResult({Key? key,required this.query}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Restaurant'),
      ),
      body: SingleChildScrollView(
        child:SafeArea(
        child: ChangeNotifierProvider(
              create: (_) => SearchRestaurantProvider(
                  apiService: ApiService(), query: query),
              child: Consumer<SearchRestaurantProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.loading) {
                    return Center(                      
                      child: Column(
                        children: const [
                          SizedBox(height: 15),
                          CircularProgressIndicator()
                        ],
                      ),
                    );
                  } else if (state.state == ResultState.hasData) {
                    return SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.result.restaurants.length,
                        itemBuilder: (context, index) {
                          var restaurantBuild = state.result.restaurants[index];
                          return CardFindRestaurant(
                              findRestaurant: restaurantBuild);
                        },
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
                          const SizedBox(height: 15),
                          Text(state.message),
                          const SizedBox(height: 10),
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
      ),
    );
  }
 
}
