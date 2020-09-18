class Services {
  final String title;
  final String imagelink;
  final String coverimagelink;
  final List<dynamic> desc;
  
  Services({this.title, this.imagelink, this.coverimagelink, this.desc});

  factory Services.fromJson(Map<String, dynamic> json){
    return Services(
      title: json['title'],
      imagelink: json['image'],
      coverimagelink: json['coverImage'],
      desc: json['description']
    );
  }
}