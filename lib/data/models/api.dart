class ApiModel {
  final String name;
  final String color;
  final String style;

  ApiModel({
    required this.name, 
    required this.color,
    required this.style, 
    });

  factory ApiModel.fromMap(Map<String, dynamic> map){
    return ApiModel(
      name: map['name'] as String, 
      color: map['color'] as String,
      style: map['style'] as String) 
      ;
  }

}