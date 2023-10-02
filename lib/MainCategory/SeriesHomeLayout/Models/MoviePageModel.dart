class SeriesPageModel{
  String? name;
  String? date;
  String? image;
  String? des;
  int? votecount;
  double? rate;
  int? id;
  String firebaseId;
  bool fov=false;

  SeriesPageModel(
      {required this.name,
      required this.date,
      required this.votecount,
      required this.rate,
      required this.image,
      required this.des,
      required this.id,
        required this.firebaseId,
      required this.fov});
  SeriesPageModel.fromjson(Map<String,dynamic>json):this(
    name:json["name"],
    id:json["id"],
    image:json["image"],
    date:json["date"],
    des:json["des"],
    votecount:json["votecount"],
    rate:json["rate"],
    fov:json["fov"],
    firebaseId: json["firebaseId"],
  );
  Map<String,dynamic>Tojson(){
    return{
      "name":name,
      "id":id,
      "image":image,
      "date":date,
      "des":des,
      "votecount":votecount,
      "rate":rate,
      "fov":fov,
      "firebaseId":firebaseId
    };
  }

  static SeriesPageModel movie = SeriesPageModel(
      firebaseId: '',
      name: "",
      date:'',
      votecount:
      0,
      rate:
      0,
      image:'',
      des: "",
      id: 0,
      fov: false);
}