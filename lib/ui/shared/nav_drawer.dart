import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pickappuser/config/locator.dart';
import 'package:pickappuser/constants/app_constants.dart';
import 'package:pickappuser/constants/images.dart';
import 'package:pickappuser/constants/local_storage_name.dart';
import 'package:pickappuser/models/drawer_item.dart';
import 'package:pickappuser/providers/drawer.provider.dart';
import 'package:pickappuser/services/data.service.dart';

import 'package:pickappuser/services/router.service.dart';
import 'package:provider/provider.dart';


class NavDrawer extends StatelessWidget {
  final List<DrawerItem> drawerItems = AppConstants.drawerItems();

  final router = locator<RouterService>();
 // final localStorage = locator<MyStorageService>();
  double device_width;

  @override
  Widget build(BuildContext context) {
    device_width = MediaQuery.of(context).size.width;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: _buildDrawerItems(context),
      ),
    );
  }

  List<Widget> _buildDrawerItems(BuildContext context) {




    final header2 = Container(
      width: device_width,
      padding: EdgeInsets.only(top:20),
      height: 200,
      color: Colors.purple[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            child: FutureBuilder(
              future: DataService().getPref(LocalStorageName.userAvatar),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                ImageProvider imageProvider = AssetImage(AppImages.userAvatar);
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    imageProvider = CachedNetworkImageProvider(snapshot.data);
                  }
                }


                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          FutureBuilder(
            future: DataService().getPref(LocalStorageName.userName),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              String name = "";
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  name = snapshot.data;
                }
              }
              return Text(
                  name,
                style: TextStyle(
                  color: Colors.white
                ),
              );
            },
          )
          /*Text(
              "Emmanuel Ashie",
            style: TextStyle(
              color:Colors.white
            ),
          ) */
        ],
      ),
    );
    //Drawer footer

    List<Widget> widgets = [];
    widgets.add(header2);

    for (int i = 0; i < drawerItems.length; i++) {
      widgets.add(_buildDrawerItem(
        drawerItem: drawerItems[i],
        context: context,
        index: i,
      ));
    }

    return widgets;
  }

  Widget _buildDrawerItem({
    DrawerItem drawerItem,
    BuildContext context,
    int index,
  }) {
    var currentDrawerIndex =
        Provider.of<DrawerStateInfo>(context).getCurrentDrawerIndex;

    bool isActive = currentDrawerIndex == index;

    Color color = isActive ? Colors.white : Colors.black;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
      child: MaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        color: isActive ? Colors.purple[900] : null,
        onPressed: () {
          if (drawerItem.route != null) {
            // Clear Selected Board from LocalStorage
            //localStorage.setSelectedBoardId(null);

            Provider.of<DrawerStateInfo>(context, listen: false)
                .setCurrentDrawer(
              drawerItem: drawerItem,
              index: index,
            );
            router.navigateToAndReplace(
              drawerItem.route,
            );
          }
        },
        child: ListTile(
          leading: Icon(
            drawerItem.icon,
            color: color,
          ),
          title: Text(
            drawerItem.title,
            style: TextStyle(
              color: color,
            ),
          ),
          // onTap: () {

          // },
        ),
      ),
    );
  }
}
