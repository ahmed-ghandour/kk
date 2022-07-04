class HomeModel
{
  late bool status;
  late HomeDataModel data;
  HomeModel.fromJson(Map<String,dynamic>json)
  {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}
class HomeDataModel
{
  List<BannersModel> banners = [];
  List<ProductsModel> products = [];
  String? ad;
  HomeDataModel.fromJson(Map<String,dynamic>json)
  {
    json['banners'].forEach((element)
    {
      banners.add(BannersModel.fromJson(element));
    });
    json['products'].forEach((element)
    {
      products.add(ProductsModel.fromJson(element));
    });
    ad = json['ad'];
  }

}
class BannersModel
{
  int? id;
  String? image;
  String? category;
  String? product;
  BannersModel.fromJson(Map<String,dynamic>json)
  {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }
}
class ProductsModel
{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  late List<dynamic>images;
  bool? inFavorite;
  late bool inCart;
  ProductsModel.fromJson(Map<String,dynamic>json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    images = json['images'];
    inFavorite = json['in_favorites'];
    inCart = json['in_cart'];
  }
}