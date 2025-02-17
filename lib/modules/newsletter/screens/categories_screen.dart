import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../authentication/registration/providers/auth_provider.dart';
import '../providers/categories_provider.dart';
import '../providers/preferences_provider.dart';
import 'newsletter_screen.dart';

import '../../../models/pref_model.dart';
import '../../authentication/registration/screens/signup_screen.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key, required this.e, required this.p, required this.n})
      : super(key: key);

  final form = GlobalKey<FormState>();
  final TextEditingController e;
  final TextEditingController p;
  final TextEditingController n;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: form,
          child: Column(
            children: [
              const SizedBox(height: 15),
              const Text(
                "2/2",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              const Text(
                "Enter your preference",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Consumer<CategoriesProvider>(
                  builder: (context, provider, child) {
                    return ListView(
                      children: [
                        buildToggleCheckbox(context, provider.allowNotifications, provider.toggleAllPreferences),
                        const Divider(),
                        ...provider.notifications.map((notification) {
                          return buildSingleCheckbox(context, notification);
                        }).toList(),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.to(SignUpPage()),
                      child: const Text('Back', style: TextStyle(fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                        backgroundColor: Colors.purple[300],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (form.currentState!.validate()) {
                          final authProvider = Provider.of<AuthProvider>(context, listen: false);
                          final preferencesProvider = Provider.of<PreferencesProvider>(context, listen: false);
                          final categoriesProvider = Provider.of<CategoriesProvider>(context, listen: false);

                          authProvider.signup(e.text, p.text, n.text);
                          preferencesProvider.savePreferences(categoriesProvider.selectedPreferences);

                          Get.offAll(NewsletterScreen());
                        }
                      },
                      child: const Text('Sign up', style: TextStyle(fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                        backgroundColor: Colors.purple[300],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildToggleCheckbox(BuildContext context, NotificationSetting notification, VoidCallback onClicked) {
    return buildCheckbox(notification, onClicked);
  }

  Widget buildSingleCheckbox(BuildContext context, NotificationSetting notification) {
    return Consumer<CategoriesProvider>(
      builder: (context, provider, child) {
        return buildCheckbox(notification, () {
          provider.togglePreference(notification);
        });
      },
    );
  }

  Widget buildCheckbox(NotificationSetting notification, VoidCallback onClicked) {
    return ListTile(
      onTap: onClicked,
      leading: Checkbox(value: notification.value, onChanged: (value) => onClicked()),
      title: Text(notification.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}
