import 'dart:convert';

import 'package:ride_sharing/src/models/drivers.dart';
import 'package:ride_sharing/src/models/riders.dart';
import 'package:ride_sharing/src/models/user.dart';

TripsModel tripsModelFromJson(Map<String, dynamic>? data) =>
    TripsModel.fromJson(data!);

String tripsModelToJson(TripsModel data) => json.encode(data.toJson());

class TripsModel {
  TripsModel({
    required this.driver,
    required this.riders,
    required this.rideOtp,
  });

  final Driver driver;
  final List<Rider> riders;
  String rideOtp;

  factory TripsModel.fromJson(Map<String, dynamic> json) => TripsModel(
        driver: Driver.fromJson(json["driver"]),
        riders: List<Rider>.from(json["riders"].map((x) => Rider.fromJson(x))),
        rideOtp: json["rideOtp"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "driver": driver.toJson(),
        "riders": List<dynamic>.from(riders.map((x) => x.toJson())),
      };
}

class Driver {
  Driver({
    required this.driveId,
    required this.driverUid,
    required this.status,
  });

  final String driveId;
  final String driverUid;
  final String status;
  UserProfileModel? driverProfile;
  DriverModel? driveData;

  set setDriverProfile(UserProfileModel userProfile) {
    driverProfile = userProfile;
  }

  set setDriveData(DriverModel driveData) {
    this.driveData = driveData;
  }

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        driveId: json["driveId"],
        driverUid: json["driverUid"],
        status: json["driverStatus"],
      );

  Map<String, dynamic> toJson() => {
        "driveId": driveId,
        "driverUid": driverUid,
        "status": status,
      };
}

class Rider {
  Rider({
    required this.riderUid,
    required this.rideId,
    required this.status,
  });

  final String riderUid;
  final String rideId;
  final String status;
  UserProfileModel? riderProfile;
  RiderModel? rideData;

  set setRiderProfile(UserProfileModel riderProfile) {
    this.riderProfile = riderProfile;
  }

  set setRideData(RiderModel rideData) {
    this.rideData = rideData;
  }

  factory Rider.fromJson(Map<String, dynamic> json) => Rider(
        riderUid: json["riderUid"],
        rideId: json["rideId"],
        status: json["riderStatus"],
      );

  Map<String, dynamic> toJson() => {
        "riderUid": riderUid,
        "rideId": rideId,
        "status": status,
      };
}
