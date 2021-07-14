
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/providers/carrierInformationProvider.dart';
import 'package:pickappuser/providers/createOrderProvider.dart';
import 'package:pickappuser/providers/senderInformationProvider.dart';
import 'package:pickappuser/ui/createOrder2/widgets/carrierInformation.screen.dart';
import 'package:pickappuser/ui/createOrder2/widgets/recipientInformation.screen.dart';
import 'package:pickappuser/ui/createOrder2/widgets/senderInformation.screen.dart';
import 'package:provider/provider.dart';

class CreateOrderScreen extends StatefulWidget{
  @override
  CreateOrderScreenState createState() => CreateOrderScreenState();
}

class CreateOrderScreenState extends State<CreateOrderScreen> with TickerProviderStateMixin{

  CreateOrderProvider vm;
  CarrierInformationProvider vm2;
  SenderInformationProvider vm3;


  @override
  void initState() {
    vm = context.read<CreateOrderProvider>();
    vm2 = context.read<CarrierInformationProvider>();
    vm3 = context.read<SenderInformationProvider>();
    vm.tabController = TabController(
      vsync: this,
      length: 3,
    );
    vm2.initProvider();
    vm3.initializeProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Order",
          style: TextStyle(
              color: Colors.white
          ),),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.purple[900],
      ),
      body: Container(
        width: deviceWidth,
        height: deviceHeight,
        margin: EdgeInsets.only(left:20,right: 20),
        color: Colors.white,
        child:  TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: vm.tabController,
          children: [
            CarrierInformationScreen(),
            SenderInformationScreen(),
            RecipientInformationScreen()
          ],
        ),
      ),
    );
  }

}