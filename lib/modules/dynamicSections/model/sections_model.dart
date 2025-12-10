// To parse this JSON data, do
//
//     final sectionsmodel = sectionsmodelFromJson(jsonString);

import 'dart:convert';

Sectionsmodel sectionsmodelFromJson(String str) => Sectionsmodel.fromJson(json.decode(str));

String sectionsmodelToJson(Sectionsmodel data) => json.encode(data.toJson());

class Sectionsmodel {
    bool success;
    List<Section> sections;

    Sectionsmodel({
        required this.success,
        required this.sections,
    });

    factory Sectionsmodel.fromJson(Map<String, dynamic> json) => Sectionsmodel(
        success: json["success"],
        sections: List<Section>.from(json["sections"].map((x) => Section.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "sections": List<dynamic>.from(sections.map((x) => x.toJson())),
    };
}

class Section {
    String id;
    String title;
    String key;
    int v;
    String? subtitle;

    Section({
        required this.id,
        required this.title,
        required this.key,
        required this.v,
        this.subtitle,
    });

    factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["_id"],
        title: json["title"],
        key: json["key"],
        v: json["__v"],
        subtitle: json["subtitle"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "key": key,
        "__v": v,
        "subtitle": subtitle,
    };
}
