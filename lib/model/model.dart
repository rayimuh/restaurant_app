import 'dart:convert';

getList apiRestaurantFromJson(String str) => getList.fromJson(json.decode(str));
String apiRestaurantToJson(getList data) => json.encode(data.toJson());

class getList {
    getList({
       required this.error,
       required this.message,
       required this.count,
       required this.restaurants,
    });

    bool error;
    String message;
    int count;
    List<getListRestaurant> restaurants;

    factory getList.fromJson(Map<String, dynamic> json) => getList(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<getListRestaurant>.from(json["restaurants"].map((x) => getListRestaurant.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
    };
}

class getListRestaurant {
    getListRestaurant({
       required this.id,
       required this.name,
       required this.description,
       required this.pictureId,
       required this.city,
       required this.rating,
    });

    String id;
    String name;
    String description;
    String pictureId;
    String city;
    double rating;

    factory getListRestaurant.fromJson(Map<String, dynamic> json) => getListRestaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
    };
}





getDetail detailRestaurantFromJson(String str) => getDetail.fromJson(json.decode(str));
String detailRestaurantToJson(getDetail data) => json.encode(data.toJson());

class getDetail {
    getDetail({
       required this.error,
       required this.message,
       required this.restaurant,
    });

    bool error;
    String message;
    getDetailRestaurant restaurant;

    factory getDetail.fromJson(Map<String, dynamic> json) => getDetail(
        error: json["error"],
        message: json["message"],
        restaurant: getDetailRestaurant.fromJson(json["restaurant"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
    };
}

class getDetailRestaurant {
    getDetailRestaurant({
       required this.id,
       required this.name,
       required this.description,
       required this.city,
       required this.address,
       required this.pictureId,
       required this.rating,
       required this.categories,
       required this.menus,
       required this.customerReviews,
    });

    String id;
    String name;
    String description;
    String city;
    String address;
    String pictureId;
    double rating;
    List<Category> categories;
    Menus menus;
    List<CustomerReview> customerReviews;

    factory getDetailRestaurant.fromJson(Map<String, dynamic> json) => getDetailRestaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        rating: json["rating"].toDouble(),
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        customerReviews: List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "rating": rating,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "menus": menus.toJson(),
        "customerReviews": List<dynamic>.from(customerReviews.map((x) => x.toJson())),
    };
}

class Category {
    Category({
       required this.name,
    });

    String name;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class CustomerReview {
    CustomerReview({
       required this.name,
       required this.review,
       required this.date,
    });

    String name;
    String review;
    String date;

    factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
    };
}

class Menus {
    Menus({
       required this.foods,
       required this.drinks,
    });

    List<Category> foods;
    List<Category> drinks;

    factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
        drinks: List<Category>.from(json["drinks"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
    };
}





findList findRestaurantFromJson(String str) => findList.fromJson(json.decode(str));
String findRestaurantToJson(findList data) => json.encode(data.toJson());

class findList {
    findList({
       required this.error,
       required this.founded,
       required this.restaurants,
    });

    bool error;
    int founded;
    List<getListRestaurant> restaurants;

    factory findList.fromJson(Map<String, dynamic> json) => findList(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<getListRestaurant>.from(json["restaurants"].map((x) => getListRestaurant.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
    };
}



