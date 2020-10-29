class Item {
  String title;
  int id;
  bool complete;
  var finishedDate;

  Item(String title, int id) {
    this.title = title;
    this.id = id;
    this.complete = false;
  }

  Item.fromMap(Map<String, dynamic> map) {
    this.title = map['title'];
    this.id = map['id'];
    this.complete = false;
  }

  Item.fromMapRecords(Map<String, dynamic> map) {
    this.title = map['title'];
    this.id = map['id'];
    this.complete = true;
    this.finishedDate = map['date'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }

  Map<String, dynamic> toMapRecords() {
    return {
      'id': id,
      'title': title,
      'date': finishedDate,
    };
  }
}
