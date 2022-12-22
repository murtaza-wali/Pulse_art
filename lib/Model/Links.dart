class Links {
  Links({
      this.rel, 
      this.href,});

  Links.fromJson(dynamic json) {
    rel = json['rel'];
    href = json['href'];
  }
  String rel;
  String href;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rel'] = rel;
    map['href'] = href;
    return map;
  }

}