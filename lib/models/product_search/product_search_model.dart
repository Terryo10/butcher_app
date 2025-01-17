// To parse this JSON data, do
//
//     final searchProductsResponse = searchProductsResponseFromMap(jsonString);

import 'dart:convert';

SearchProductsResponse searchProductsResponseFromMap(String str) =>
    SearchProductsResponse.fromMap(json.decode(str));

String searchProductsResponseToMap(SearchProductsResponse data) =>
    json.encode(data.toMap());

class SearchProductsResponse {
  bool? success;
  String? message;
  Products? products;

  SearchProductsResponse({
    this.success,
    this.message,
    this.products,
  });

  factory SearchProductsResponse.fromMap(Map<String, dynamic> json) =>
      SearchProductsResponse(
        success: json["success"],
        message: json["message"],
        products: json["Products"] == null
            ? null
            : Products.fromMap(json["Products"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "Products": products?.toMap(),
      };
}

class Products {
  ProductsClass? products;

  Products({
    this.products,
  });

  factory Products.fromMap(Map<String, dynamic> json) => Products(
        products: json["products"] == null
            ? null
            : ProductsClass.fromMap(json["products"]),
      );

  Map<String, dynamic> toMap() => {
        "products": products?.toMap(),
      };
}

class ProductsClass {
  int? currentPage;
  List<ProductSearchDatum>? data;
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

  ProductsClass({
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

  factory ProductsClass.fromMap(Map<String, dynamic> json) => ProductsClass(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<ProductSearchDatum>.from(
                json["data"]!.map((x) => ProductSearchDatum.fromMap(x))),
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

class ProductSearchDatum {
  int? id;
  String? name;
  String? price;
  int? stock;
  String? image;
  String? description;
  int? subcategoryId;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProductSearchDatum({
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

  factory ProductSearchDatum.fromMap(Map<String, dynamic> json) =>
      ProductSearchDatum(
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
