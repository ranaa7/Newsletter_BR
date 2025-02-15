import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newsletter_blueribbon_task/data/local/cache_helper.dart';

import 'package:newsletter_blueribbon_task/modules/authentication/registration/screens/signup_screen.dart';
import 'package:newsletter_blueribbon_task/shared/constants/cached_keys.dart';
import 'package:provider/provider.dart';

import '../../../models/pref_model.dart';
import '../../authentication/registration/providers/auth_provider.dart';
import 'newsletter_screen.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({Key? key,required this.e,required this.p,required this.n,
  }) : super(key: key);

  final form = GlobalKey<FormState>();
  var e = TextEditingController();

  var p = TextEditingController();

  var n = TextEditingController();



  State<CategoriesScreen> createState() => _Preference_screenState();
}

class _Preference_screenState extends State<CategoriesScreen> {


  final allowNotifications = NotificationSetting(title: 'Dietary restrictions all');

  final notifications = [
    NotificationSetting(title: 'Sports'),
    NotificationSetting(title: 'Technology'),
    NotificationSetting(title: 'Health'),
    NotificationSetting(title: 'Other'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: widget.form,
            child: Container(
              child: (Column(
                children: [
                  SizedBox(height: 15,),
                  Text("2/2", style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold,color: Colors.grey
                  ),),
                  SizedBox(height: 10,),
                  Text("Enter your preference", style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black
                  ),),

                  // DropdownButton(value:dropdownvalue,items: items.map((String items){
                  //   return DropdownMenuItem(child: Text(items),value: items);
                  // }).toList(), onChanged: (String? newval){
                  //   setState(() {
                  //     dropdownvalue=newval!;
                  //   });
                  // }),
                  SizedBox(height: 30,),

                  Expanded(
                    child: ListView(
                      children: [
                        buildToggleCheckbox(allowNotifications),
                        Divider(),
                        ...notifications.map(buildSingleCheckbox).toList(),
                      ],
                    ),
                  ),

                  SizedBox(height: 10,),
                  Row(
                    children:[
                      Expanded(
                        child: Container(
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(SignUpPage());
                              },
                              child: Text('Back', style: TextStyle(fontSize: 20)),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ), backgroundColor: Colors.purple[300]
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if(widget.form.currentState!.validate()) {
                                 Provider.of<AuthProvider>(context,listen: false).signup(widget.e.text, widget.p.text, widget.n.text);
                                  CacheHelper.setData(key: CachedKeys.pref, value: names);
                                 // Get.offAll(NewsletterScreen());

                                }
                              },
                              child: Text('Sign up', style: TextStyle(fontSize: 20)),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ), backgroundColor: Colors.purple[300]
                              ),
                            ),
                          ),
                        ),
                      ) ,
                    ] ,

                  )

                ],
              )),
            ),
          ),
        ));

  }
  Widget buildToggleCheckbox(NotificationSetting notification) => buildCheckbox(
      notification: notification,
      onClicked: () {
        final newValue = !notification.value;

        setState(() {
          allowNotifications.value = newValue;

          notifications.forEach((notification) {
            notification.value = newValue;

          });
        });
      });
  List names=[];
  Widget buildSingleCheckbox(NotificationSetting notification) => buildCheckbox(
    notification: notification,
    onClicked: () {
      setState(() {
        final newValue = !notification.value;
        notification.value = newValue;

        if (!newValue) {
          allowNotifications.value = false;
          names.remove(notification.title);
        } else {
          final allow =
          notifications.every((notification) => notification.value);
          allowNotifications.value = allow;

          names.add(notification.title);

          print(names);
        }
      });
    },
  );

  Widget buildCheckbox({
    required NotificationSetting notification,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        onTap: onClicked,
        leading: Checkbox(
          value: notification.value,
          onChanged: (value) => onClicked(),
        ),
        title: Text(
          notification.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
}
