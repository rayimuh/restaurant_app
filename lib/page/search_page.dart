import 'package:flutter/material.dart';
import 'search_page_result.dart';


class RestaurantSearchPage extends StatefulWidget {
  static const routeName = '/restaurant_search';

  const RestaurantSearchPage({Key? key}) : super(key: key);
  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageNew();
}

class _RestaurantSearchPageNew extends State<RestaurantSearchPage> {
  final TextEditingController inputName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Restaurant'),
      ),
      body: SingleChildScrollView(
        child:SafeArea(
        child: Align(
          alignment: Alignment.center,
          child:Column(             
          children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
            child:TextField(
              controller: inputName,
              decoration: const InputDecoration(
                labelText: 'Cari Restoran',
              ),
            ),
            ),
            const SizedBox(height: 10),
              ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
               Navigator.pushNamed(context, RestaurantSearchPageResult.routeName,arguments: inputName.text);
              },
            )            
          ],
        ),
        ),
      ),
      ),
    );
  }
  @override
void dispose() {
  inputName.dispose();
  super.dispose();
}
}
