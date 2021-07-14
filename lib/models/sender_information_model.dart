


class SenderInformationModel{
  String senderName;
  String senderPhone;
  String pickUpDescription;
  String pickUpLongitude;
  String pickUpLatitude;
  String pickUpInstruction;
  String pickUpTime;
  bool iAmSender;

  SenderInformationModel(
  {
    this.senderName,
    this.senderPhone,
    this.pickUpDescription,
    this.pickUpLongitude,
    this.pickUpLatitude,
    this.pickUpInstruction,
    this.iAmSender,
    this.pickUpTime
  }){
    this.senderName = senderName;
    this.senderPhone = senderPhone;
    this.pickUpDescription = pickUpDescription;
    this.pickUpLongitude = pickUpLongitude;
    this.pickUpLatitude = pickUpLatitude;
    this.pickUpInstruction = pickUpInstruction;
    this.iAmSender = iAmSender;
    this.pickUpTime = pickUpTime;
  }
}