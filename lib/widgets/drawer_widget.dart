import 'package:flutter/material.dart';
import 'package:life_advice/app_text_styles.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool selected = false;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                  color: Colors.blue
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Text('LA', style: TextStyle(
                        fontSize: 24, color: Colors.blue
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 5),
                    child: Text('Emeka Jideije', style: AppTextStyles.normalTextStyle(
                        color: Colors.white)),
                  ),
                  Text('jideije.emeka@gmail.com', style: AppTextStyles.normalTextStyle(
                      color: Colors.white))
                ],)),
          Padding(
            padding: const EdgeInsets.only(right: 40, top: 10),
            child: ListTile(
              onTap: () {
                setState(() {
                  selected = true;
                  index = 1;
                });
                // Future.delayed(const Duration(minutes: 200), () {
                //   Navigator.pop(context);
                //   Navigator.push(context, MaterialPageRoute(builder: (_)
                //   => const HomeView()));
                // });
              },
              selected: selected,
              selectedTileColor: index == 1 ? Colors.blue : null,
              tileColor: Colors.blue,
              leading: Icon(Icons.favorite_border_outlined,
                color: index == 1 ? Colors.white : Colors.black,),
              title: Text('Favorites', style: AppTextStyles.normalTextStyle(
                  color: index == 1 ? Colors.white : Colors.black)),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(35), bottomRight: Radius.circular(35)
                  )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: ListTile(
              onTap: () {
                setState(() {
                  selected = true;
                  index = 2;
                });
              },
              selected: selected,
              selectedTileColor: index == 2 ? Colors.blue : null,
              leading: Icon(Icons.settings,
                color: index == 2 ? Colors.white : Colors.black,),
              title: Text('Settings', style: AppTextStyles.normalTextStyle(
                  color: index == 2 ? Colors.white : Colors.black)),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(35), bottomRight: Radius.circular(35)
                  )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: ListTile(
              onTap: () {
                setState(() {
                  selected = true;
                  index = 3;
                });
              },
              selected: selected,
              selectedTileColor: index == 3 ? Colors.blue : null,
              leading: Icon(Icons.favorite_border_outlined,
                color: index == 3 ? Colors.white : Colors.black,),
              title: Text('Account', style: AppTextStyles.normalTextStyle(
                  color: index == 3 ? Colors.white : Colors.black)),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(35), bottomRight: Radius.circular(35)
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}
