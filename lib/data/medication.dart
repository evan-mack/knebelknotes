import 'dart:convert';

List<Medication> medicationFromJson(String str) => List<Medication>.from(json.decode(str).map((x) => Medication.fromMap(x)));
class Medication {
  int id;

  final String cat;
  final String subCat;
  final String medName;
  final List<Indication> indications;
  final String indicationsComment;
  final List<SideEffect> sideEffects;
  final List<SevereEffect> severeEffects;
  final String frequency;
  final String doseInit;
  final String doseInitComment;
  final String doseRange;
  final String doseRangeComment;
  final String maxDose;
  final String maxDoseForKids;
  final String blackBoxWarning;
  final String misc;
  final String miscComment;
  final String equiv;
  final String amphWorkUp;
  final String mphWorkUp;

  Medication({
    this.cat,
    this.subCat,
    this.medName,
    this.indications,
    this.indicationsComment,
    this.sideEffects,
    this.severeEffects,
    this.frequency,
    this.doseInit,
    this.doseInitComment,
    this.doseRange,
    this.doseRangeComment,
    this.maxDose,
    this.maxDoseForKids,
    this.blackBoxWarning,
    this.misc,
    this.miscComment,
    this.equiv,
    this.amphWorkUp,
    this.mphWorkUp,
  });

  static Medication fromMap(Map<String, dynamic> json) => Medication(
        cat: json["cat"],
        subCat: json["subCat"],
        medName: json["medName"],
        indications: List<Indication>.from(
            json["indications"].map((x) => Indication.fromMap(x))),
        indicationsComment: json["indicationsComment"],
        sideEffects: List<SideEffect>.from(
            json["sideEffects"].map((x) => SideEffect.fromMap(x))),
        severeEffects: List<SevereEffect>.from(
            json["severeEffects"].map((x) => SevereEffect.fromMap(x))),
        frequency: json["frequency"],
        doseInit: json["doseInit"],
        doseInitComment: json["doseInitComment"],
        doseRange: json["doseRange"],
        doseRangeComment: json["doseRangeComment"],
        maxDose: json["maxDose"],
        maxDoseForKids: json["maxDoseForKids"],
        blackBoxWarning: json["blackBoxWarning"],
        misc: json["misc"],
        miscComment: json["miscComment"],
        equiv: json["equiv"],
        amphWorkUp: json["amphWorkUp"],
        mphWorkUp: json["mphWorkUp"],
      );

  Map<String, dynamic> toMap() => {
        "cat": cat,
        "subCat": subCat,
        "medName": medName,
        "indications": List<dynamic>.from(indications.map((x) => x.toMap())),
        "indicationsComment": indicationsComment,
        "sideEffects": List<dynamic>.from(sideEffects.map((x) => x.toMap())),
        "severeEffects":
            List<dynamic>.from(severeEffects.map((x) => x.toMap())),
        "frequency": frequency,
        "doseInit": doseInit,
        "doseInitComment": doseInitComment,
        "doseRange": doseRange,
        "doseRangeComment": doseRangeComment,
        "maxDose": maxDose,
        "maxDoseForKids": maxDoseForKids,
        "blackBoxWarning": blackBoxWarning,
        "misc": misc,
        "miscComment": miscComment,
        "equiv": equiv,
        "amphWorkUp": amphWorkUp,
        "mphWorkUp": mphWorkUp,
      };
}

class Indication {
  Indication({
    this.indication,
    this.modifier,
  });

  String indication;
  int modifier;

  static Indication fromMap(Map<String, dynamic> json) {
    return Indication(
      indication: json["indication"],
      modifier: json["modifier"],
    );
  }

  Map<String, dynamic> toMap() => {
        "indication": indication,
        "modifier": modifier,
      };
}

class SevereEffect {
  SevereEffect({
    this.severeEffect,
    this.modifier,
  });

  String severeEffect;
  int modifier;

  static SevereEffect fromMap(Map<String, dynamic> json) => SevereEffect(
        severeEffect: json["severeEffect"],
        modifier: json["modifier"],
      );

  Map<String, dynamic> toMap() => {
        "severeEffect": severeEffect,
        "modifier": modifier,
      };
}

class SideEffect {
  SideEffect({
    this.sideEffect,
    this.modifier,
  });

  String sideEffect;
  int modifier;

  static SideEffect fromMap(Map<String, dynamic> json) => SideEffect(
        sideEffect: json["sideEffect"],
        modifier: json["modifier"],
      );

  Map<String, dynamic> toMap() => {
        "sideEffect": sideEffect,
        "modifier": modifier,
      };
}
