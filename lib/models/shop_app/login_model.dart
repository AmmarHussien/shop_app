class ShopLoginModel
{
  late bool status;
  late String message;
  late UserDate data;

  ShopLoginModel.fromJson(Map<String , dynamic> json)
  {
    status =json['status'];
    message =json['message'];
    data =(json['data'] != null ? UserDate.fromJson(json['data']):null)! ;

  }

}
class UserDate
{
  late int id ;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credit;
  late String token;

//   UserDate({
//     // required this.id,
//     // required this.name,
//     // required this.email,
//     // required this.phone,
//     // required this.image,
//     // required this.points,
//     // required this.credit,
//     // required this.token,
// });

  UserDate.fromJson(Map<String , dynamic> json)
  {
    id =json['id'];
    name =json['name'];
    email =json['email'];
    phone =json['phone'];
    image =json['image'];
    points =json['points'];
    credit =json['credit'];
    token =json['token'];
  }
}