
class TodoModel {
  String? id;
  String? title;

  TodoModel({this.id, this.title});

  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["title"] = title;
    return _data;
  }
}