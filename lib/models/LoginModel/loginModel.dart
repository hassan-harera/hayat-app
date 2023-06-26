class LoginModel{
 late  String status;
 late String timestamp ;
 late String message ;
 late String debugMessage ;
 late String displayMessage ;
 late String code ;
 late String subErrors ;
 late String token ;
 // userData? data;

LoginModel.fromJason(Map<String,dynamic> json){
 status=json['status'];
 timestamp=json['timestamp'];
 message=json['message'];
 debugMessage=json['debugMessage'];
 displayMessage=json['displayMessage'];
 code=json['code'];
 subErrors=json['subErrors'];
 //data= json['data'] !=null ? userData.fromJason(json['data']):null;

}
}
// class userData
// {
//  int? id;
//  String? name;
//  String ?email;
//  String ?phone;
//  String ?image;
//  int ?points;
//  int ?credit;
//  String? token;
// userData({
//  this.id,
//  this.name,
//  this.email,
//  this.credit,
//  this.image,
//  this.phone,
//  this.points,
//  this.token,
// });
//  userData.fromJason(Map<String,dynamic> json){
//   id=json['id'];
//   name=json['name'];
//   email=json['email'];
//   credit=json['credit'];
//   image=json['image'];
//   phone=json['phone'];
//   points=json['points'];
//   token=json['token'];
//  }
// }