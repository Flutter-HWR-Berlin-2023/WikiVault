/// Class for search result with methods for copying Entity and parsing JSON data.
class Search{
  String title;
  int pageID;
  String? description;
  String? extract;

  Search({
    required this.title,
    required this.pageID,
    this.description,
    this.extract,
  });

  factory Search.fromJson(Map<String, dynamic> json){
    return Search(
      title: json['title'],
      pageID : json['pageid'],
      description : json['description'],
      extract : json['extract'],
    );
  }

  Search copyWith({
    String? title,
    int? pageID,
    int? size,
    int? wordCount,
    String? snippet,
    String? description,
    String? extract,
    String? timeStamp,
  }) {
    return Search(
      title: title ?? this.title,
      pageID: pageID ?? this.pageID,
      description: description ?? this.description,
      extract: extract ?? this.extract,
    );
  }
}