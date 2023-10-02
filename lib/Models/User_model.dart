class UserModel{
  String id;
  String name;
  int phoneNum;
  String Email;
  String subscribtionDate;

  UserModel({required this.subscribtionDate,this.id='', required this.name, required this.phoneNum,required this.Email});

  UserModel.fromjson(Map<String,dynamic>json):this(
    subscribtionDate: json["subscribtionDate"] ,
    Email: json["Email"],
    name: json["name"],
    phoneNum: json["phoneNum"],
    id: json["id"]
  );
  Map<String,dynamic>Tojson(){
    return{
      "subscribtionDate":subscribtionDate,
      "id":id,
      "name":name,
      "phoneNum":phoneNum,
      "Email":Email,
    };

}
}