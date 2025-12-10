// To parse this JSON data, do
//
//     final dynamicSection = dynamicSectionFromJson(jsonString);

import 'dart:convert';

DynamicSection dynamicSectionFromJson(String str) => DynamicSection.fromJson(json.decode(str));

String dynamicSectionToJson(DynamicSection data) => json.encode(data.toJson());

class DynamicSection {
    bool success;
    List<Product> products;

    DynamicSection({
        required this.success,
        required this.products,
    });

    factory DynamicSection.fromJson(Map<String, dynamic> json) => DynamicSection(
        success: json["success"],
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
    };
}

class Product {
    Map<String, bool> categories;
    String id;
    String title;
    String brand;
    String brandName;
    String manufacturer;
    String genericName;
    String sku;
    String hsn;
    String batchNumber;
    String shortDescription;
    String fullDescription;
    String disclaimer;
    String category;
    int mrp;
    int amp;
    int price;
    double ptr;
    int totalCostOfStores;
    int discountPercent;
    int discountB2C;
    int discountB2B;
    int discountHospital;
    double totalSaleValue;
    int totalBusinessSaleValue;
    int totalWholesaleValue;
    int wsr;
    double hpsr;
    int gstIgst;
    int gstCgst;
    int gstSgst;
    String gstDateEffect;
    String offerText;
    String additionalOffers;
    String scheme1;
    String scheme2;
    int stock;
    int stocks;
    String packagingType;
    String caseBoxPackage;
    int casePackPrice;
    DateTime dateOfEffect;
    DateTime expiryDate;
    List<String> tags;
    String franchiseCode;
    int franchiseMoq;
    int franchiseRate;
    String franchiseTerms;
    String statusActive;
    String statusAppear;
    bool isOtc;
    int rating;
    String doctorFeedback;
    List<dynamic> variants;
    List<Specification> specifications;
    List<dynamic> faqs;
    List<Image> images;
    int primaryImageIndex;
    List<dynamic> sections;
    List<dynamic> reviews;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Product({
        required this.categories,
        required this.id,
        required this.title,
        required this.brand,
        required this.brandName,
        required this.manufacturer,
        required this.genericName,
        required this.sku,
        required this.hsn,
        required this.batchNumber,
        required this.shortDescription,
        required this.fullDescription,
        required this.disclaimer,
        required this.category,
        required this.mrp,
        required this.amp,
        required this.price,
        required this.ptr,
        required this.totalCostOfStores,
        required this.discountPercent,
        required this.discountB2C,
        required this.discountB2B,
        required this.discountHospital,
        required this.totalSaleValue,
        required this.totalBusinessSaleValue,
        required this.totalWholesaleValue,
        required this.wsr,
        required this.hpsr,
        required this.gstIgst,
        required this.gstCgst,
        required this.gstSgst,
        required this.gstDateEffect,
        required this.offerText,
        required this.additionalOffers,
        required this.scheme1,
        required this.scheme2,
        required this.stock,
        required this.stocks,
        required this.packagingType,
        required this.caseBoxPackage,
        required this.casePackPrice,
        required this.dateOfEffect,
        required this.expiryDate,
        required this.tags,
        required this.franchiseCode,
        required this.franchiseMoq,
        required this.franchiseRate,
        required this.franchiseTerms,
        required this.statusActive,
        required this.statusAppear,
        required this.isOtc,
        required this.rating,
        required this.doctorFeedback,
        required this.variants,
        required this.specifications,
        required this.faqs,
        required this.images,
        required this.primaryImageIndex,
        required this.sections,
        required this.reviews,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        categories: Map.from(json["categories"]).map((k, v) => MapEntry<String, bool>(k, v)),
        id: json["_id"],
        title: json["title"],
        brand: json["brand"],
        brandName: json["brandName"],
        manufacturer: json["manufacturer"],
        genericName: json["genericName"],
        sku: json["sku"],
        hsn: json["hsn"],
        batchNumber: json["batchNumber"],
        shortDescription: json["shortDescription"],
        fullDescription: json["fullDescription"],
        disclaimer: json["disclaimer"],
        category: json["category"],
        mrp: json["mrp"],
        amp: json["amp"],
        price: json["price"],
        ptr: json["ptr"]?.toDouble(),
        totalCostOfStores: json["totalCostOfStores"],
        discountPercent: json["discountPercent"],
        discountB2C: json["discountB2C"],
        discountB2B: json["discountB2B"],
        discountHospital: json["discountHospital"],
        totalSaleValue: json["totalSaleValue"]?.toDouble(),
        totalBusinessSaleValue: json["totalBusinessSaleValue"],
        totalWholesaleValue: json["totalWholesaleValue"],
        wsr: json["wsr"],
        hpsr: json["hpsr"]?.toDouble(),
        gstIgst: json["gst_igst"],
        gstCgst: json["gst_cgst"],
        gstSgst: json["gst_sgst"],
        gstDateEffect: json["gstDateEffect"],
        offerText: json["offerText"],
        additionalOffers: json["additionalOffers"],
        scheme1: json["scheme1"],
        scheme2: json["scheme2"],
        stock: json["stock"],
        stocks: json["stocks"],
        packagingType: json["packagingType"],
        caseBoxPackage: json["caseBoxPackage"],
        casePackPrice: json["casePackPrice"],
        dateOfEffect: DateTime.parse(json["dateOfEffect"]),
        expiryDate: DateTime.parse(json["expiryDate"]),
        tags: List<String>.from(json["tags"].map((x) => x)),
        franchiseCode: json["franchiseCode"],
        franchiseMoq: json["franchiseMoq"],
        franchiseRate: json["franchiseRate"],
        franchiseTerms: json["franchiseTerms"],
        statusActive: json["statusActive"],
        statusAppear: json["statusAppear"],
        isOtc: json["isOTC"],
        rating: json["rating"],
        doctorFeedback: json["doctorFeedback"],
        variants: List<dynamic>.from(json["variants"].map((x) => x)),
        specifications: List<Specification>.from(json["specifications"].map((x) => Specification.fromJson(x))),
        faqs: List<dynamic>.from(json["faqs"].map((x) => x)),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        primaryImageIndex: json["primaryImageIndex"],
        sections: List<dynamic>.from(json["sections"].map((x) => x)),
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "categories": Map.from(categories).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "_id": id,
        "title": title,
        "brand": brand,
        "brandName": brandName,
        "manufacturer": manufacturer,
        "genericName": genericName,
        "sku": sku,
        "hsn": hsn,
        "batchNumber": batchNumber,
        "shortDescription": shortDescription,
        "fullDescription": fullDescription,
        "disclaimer": disclaimer,
        "category": category,
        "mrp": mrp,
        "amp": amp,
        "price": price,
        "ptr": ptr,
        "totalCostOfStores": totalCostOfStores,
        "discountPercent": discountPercent,
        "discountB2C": discountB2C,
        "discountB2B": discountB2B,
        "discountHospital": discountHospital,
        "totalSaleValue": totalSaleValue,
        "totalBusinessSaleValue": totalBusinessSaleValue,
        "totalWholesaleValue": totalWholesaleValue,
        "wsr": wsr,
        "hpsr": hpsr,
        "gst_igst": gstIgst,
        "gst_cgst": gstCgst,
        "gst_sgst": gstSgst,
        "gstDateEffect": gstDateEffect,
        "offerText": offerText,
        "additionalOffers": additionalOffers,
        "scheme1": scheme1,
        "scheme2": scheme2,
        "stock": stock,
        "stocks": stocks,
        "packagingType": packagingType,
        "caseBoxPackage": caseBoxPackage,
        "casePackPrice": casePackPrice,
        "dateOfEffect": "${dateOfEffect.year.toString().padLeft(4, '0')}-${dateOfEffect.month.toString().padLeft(2, '0')}-${dateOfEffect.day.toString().padLeft(2, '0')}",
        "expiryDate": "${expiryDate.year.toString().padLeft(4, '0')}-${expiryDate.month.toString().padLeft(2, '0')}-${expiryDate.day.toString().padLeft(2, '0')}",
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "franchiseCode": franchiseCode,
        "franchiseMoq": franchiseMoq,
        "franchiseRate": franchiseRate,
        "franchiseTerms": franchiseTerms,
        "statusActive": statusActive,
        "statusAppear": statusAppear,
        "isOTC": isOtc,
        "rating": rating,
        "doctorFeedback": doctorFeedback,
        "variants": List<dynamic>.from(variants.map((x) => x)),
        "specifications": List<dynamic>.from(specifications.map((x) => x.toJson())),
        "faqs": List<dynamic>.from(faqs.map((x) => x)),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "primaryImageIndex": primaryImageIndex,
        "sections": List<dynamic>.from(sections.map((x) => x)),
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class Image {
    String url;
    String publicId;

    Image({
        required this.url,
        required this.publicId,
    });

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json["url"],
        publicId: json["public_id"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "public_id": publicId,
    };
}

class Specification {
    String key;
    String value;

    Specification({
        required this.key,
        required this.value,
    });

    factory Specification.fromJson(Map<String, dynamic> json) => Specification(
        key: json["key"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
    };
}
