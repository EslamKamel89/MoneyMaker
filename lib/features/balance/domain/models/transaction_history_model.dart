// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:trading/core/api/end_points.dart';

class TransactionHistoryModel {
  final int? id;
  final int? amount;
  final int? userId;
  final String? imageOne;
  final String? accepted;
  final String? process;
  final String? refuseReason;
  final String? createdAt;
  final String? updatedAt;
  final String? firstName;
  final String? profileImage;
  final String? name;
  final String? imageTwo;
  TransactionHistoryModel({
    required this.id,
    required this.amount,
    required this.userId,
    required this.imageOne,
    required this.accepted,
    required this.process,
    required this.refuseReason,
    required this.createdAt,
    required this.updatedAt,
    required this.firstName,
    required this.profileImage,
    required this.name,
    required this.imageTwo,
  });
  factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryModel(
      id: json[ApiKey.paymentId],
      amount: json[ApiKey.paymentAmount],
      userId: json[ApiKey.paymentUserId],
      imageOne: json[ApiKey.paymentImageOne],
      accepted: json[ApiKey.paymentAccepted],
      process: json[ApiKey.depositPaymentProcess],
      refuseReason: json[ApiKey.paymentRefuseReason],
      createdAt: json[ApiKey.paymentCreatedAt],
      updatedAt: json[ApiKey.paymentUpdatedAt],
      firstName: json[ApiKey.paymentFirstName],
      profileImage: json[ApiKey.paymentProfileImage],
      name: json[ApiKey.paymentName],
      imageTwo: json[ApiKey.paymentImageTwo],
    );
  }
  @override
  String toString() {
    return 'DepositHistoryModel(id: $id, amount: $amount, userId: $userId, imageOne: $imageOne, accepted: $accepted, process: $process, refuseReason: $refuseReason, createdAt: $createdAt, updatedAt: $updatedAt, firstName: $firstName, profileImage: $profileImage, name: $name, imageTwo: $imageTwo)';
  }
}



/*
! Success
{
  "data": [
    {
      "id": 23,
      "amount": 1500,
      "user_id": 5,
      "image": "1715366838.png",  receite image 
      "accepted": "0",
      "payment_id": 1,
      "process": "150147",
      "refuse_reason": null,
      "created_at": "2024-05-10 15:47:18",
      "updated_at": "2024-05-10 15:47:18",
      "first_name": "mohamed",
      "profile": "1714492772.png",
      "name": "Osama Mohamed Elmahdy",
      "payments_image": "1715369290.jpg"
    },
    {
      "id": 24,
      "amount": 1500,
      "user_id": 5,
      "image": "1715368596.png",
      "accepted": "0",
      "payment_id": 1,
      "process": "150147",
      "refuse_reason": null,
      "created_at": "2024-05-10 19:16:36",
      "updated_at": "2024-05-10 19:16:36",
      "first_name": "mohamed",
      "profile": "1714492772.png",
      "name": "Osama Mohamed Elmahdy",
      "payments_image": "1715369290.jpg"
    },
    {
      "id": 25,
      "amount": 1500,
      "user_id": 5,
      "image": "1715369464.png",
      "accepted": "0",
      "payment_id": 1,
      "process": "150147",
      "refuse_reason": null,
      "created_at": "2024-05-10 19:31:04",
      "updated_at": "2024-05-10 19:31:04",
      "first_name": "mohamed",
      "profile": "1714492772.png",
      "name": "Osama Mohamed Elmahdy",
      "payments_image": "1715369290.jpg"
    },
    {
      "id": 26,
      "amount": 1500,
      "user_id": 5,
      "image": "1715369468.png",
      "accepted": "0",
      "payment_id": 1,
      "process": "150147",
      "refuse_reason": null,
      "created_at": "2024-05-10 19:31:08",
      "updated_at": "2024-05-10 19:31:08",
      "first_name": "mohamed",
      "profile": "1714492772.png",
      "name": "Osama Mohamed Elmahdy",
      "payments_image": "1715369290.jpg"
    }
  ],
  "status": "success",
  "error": false
}
! Failure 
if the user not found then it fetches empty data
{
  "data": [],
  "status": "success",
  "error": false
}
 */


