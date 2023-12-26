class PaymentModel {
  int id;
  int senderId;
  String senderName;
  int receiverId;
  String receiverName;
  bool maCreditCard;
  bool maBankSlip;
  bool maPicPay;
  String dateSession;
  String valueSession;
  String descriptionArt;
  bool status;

  PaymentModel(
      //this.id,
      this.senderId,
      this.senderName,
      this.receiverId,
      this.receiverName,
      this.maCreditCard,
      this.maBankSlip,
      this.maPicPay,
      this.dateSession,
      this.valueSession,
      this.descriptionArt,
      this.status);

  @override
  String toString() {
    return 'PaymentModel{id: $id, senderId: $senderId, senderName: $senderName, receiverId: $receiverId, receiverName: $receiverName, maCreditCard: $maCreditCard, maBankSlip: $maBankSlip, maPicPay: $maPicPay, dateSession: $dateSession, valueSession: $valueSession, descriptionArt: $descriptionArt, status: $status}';
  }
}
