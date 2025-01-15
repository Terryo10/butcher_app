// To parse this JSON data, do
//
//     final categoriesResponse = categoriesResponseFromMap(jsonString);

import 'dart:convert';

CategoriesResponse categoriesResponseFromMap(String str) =>
    CategoriesResponse.fromMap(json.decode(str));

String categoriesResponseToMap(CategoriesResponse data) =>
    json.encode(data.toMap());

class CategoriesResponse {
  bool? success;
  String? message;
  Categories? categories;

  CategoriesResponse({
    this.success,
    this.message,
    this.categories,
  });

  factory CategoriesResponse.fromMap(Map<String, dynamic> json) =>
      CategoriesResponse(
        success: json["success"],
        message: json["message"],
        categories: json["Categories"] == null
            ? null
            : Categories.fromMap(json["Categories"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "Categories": categories?.toMap(),
      };
}

class Categories {
  CategoriesClass? categories;

  Categories({
    this.categories,
  });

  factory Categories.fromMap(Map<String, dynamic> json) => Categories(
        categories: json["categories"] == null
            ? null
            : CategoriesClass.fromMap(json["categories"]),
      );

  Map<String, dynamic> toMap() => {
        "categories": categories?.toMap(),
      };
}

class CategoriesClass {
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  CategoriesClass({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory CategoriesClass.fromMap(Map<String, dynamic> json) => CategoriesClass(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromMap(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toMap() => {
        "current_page": currentPage,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toMap())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Subcategory>? subcategories;

  Datum({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.subcategories,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        subcategories: json["subcategories"] == null
            ? []
            : List<Subcategory>.from(
                json["subcategories"]!.map((x) => Subcategory.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "subcategories": subcategories == null
            ? []
            : List<dynamic>.from(subcategories!.map((x) => x.toMap())),
      };
}

class Subcategory {
  int? id;
  String? name;
  dynamic image;
  int? categoryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Product>? products;

  Subcategory({
    this.id,
    this.name,
    this.image,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  factory Subcategory.fromMap(Map<String, dynamic> json) => Subcategory(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        categoryId: json["category_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "image": image,
        "category_id": categoryId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toMap())),
      };
}

class Product {
  int? id;
  String? name;
  String? price;
  int? stock;
  String? image;
  String? description;
  int? subcategoryId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Product({
    this.id,
    this.name,
    this.price,
    this.stock,
    this.image,
    this.description,
    this.subcategoryId,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        stock: json["stock"],
        image: json["image"],
        description: json["description"],
        subcategoryId: json["subcategory_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "price": price,
        "stock": stock,
        "image": image,
        "description": description,
        "subcategory_id": subcategoryId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromMap(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toMap() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
