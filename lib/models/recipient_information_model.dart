
class RecipientInformationModel{
  String recipientName;
  String recipientPhone;
  String recipientDeliveryLocation;
  String recipientDeliveryLongitude;
  String recipientDeliveryLatitude;
  String recipientDeliveryInstruction;
  bool recipientCardExpanded;

  RecipientInformationModel(
  {
    this.recipientName,
    this.recipientPhone,
    this.recipientDeliveryLocation,
    this.recipientDeliveryLongitude,
    this.recipientDeliveryLatitude,
    this.recipientDeliveryInstruction,
    this.recipientCardExpanded
  }
      ){
    this.recipientName = recipientName;
    this.recipientPhone = recipientPhone;
    this.recipientDeliveryLocation = recipientDeliveryLocation;
    this.recipientDeliveryLongitude = recipientDeliveryLongitude;
    this.recipientDeliveryLatitude = recipientDeliveryLatitude;
    this.recipientDeliveryInstruction = recipientDeliveryInstruction;
    this.recipientCardExpanded = recipientCardExpanded;
  }
}