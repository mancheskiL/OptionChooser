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

  Map<String, dynamic> toMap() {
    var temp;
    if (complete) {
      temp = 1;
    } else {
      temp = 0;
    }

    return {
      'id': id,
      'title': title,
      'complete': temp,
    };
  }
}
