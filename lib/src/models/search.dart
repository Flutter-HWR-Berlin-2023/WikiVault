class Search{
  String title;
  int pageID;
  int size;
  int wordCount;
  String? snippet;
  String? description;
  String? extract;
  String timeStamp;

  Search({
    required this.title,
    required this.pageID,
    required this.size,
    required this.wordCount,
    this.snippet,
    this.description,
    this.extract,
    required this.timeStamp,
  });

  factory Search.fromJson(Map<String, dynamic> json){
    return Search(
      title: json['title'],
      pageID : json['pageid'],
      size : json ['size'],
      wordCount : json['wordcount'],
      snippet : json['snippet'],
      description : json['description'],
      extract : json['extract'],
      timeStamp : json['timestamp'],
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
      size: size ?? this.size,
      wordCount: wordCount ?? this.wordCount,
      snippet: snippet ?? this.snippet,
      description: description ?? this.description,
      extract: extract ?? this.extract,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }
}