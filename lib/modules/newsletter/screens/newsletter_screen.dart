import 'package:newsletter_blueribbon_task/modules/newsletter/providers/preferences_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class NewsletterScreen extends StatefulWidget {
  @override
  _NewsletterScreenState createState() => _NewsletterScreenState();
}

class _NewsletterScreenState extends State<NewsletterScreen> {


  @override
  void initState() {
    super.initState();
    _loadInterests();
  }

  // Load preferences when the screen is initialized
  void _loadInterests() async {
    Provider.of<PreferencesProvider>(context,listen: false).loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Newsletter')),
      body: Consumer<PreferencesProvider>(
        builder: (BuildContext context, value, Widget? child) {
         return ListView.builder(
            itemCount: value.selectedInterests.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(value.selectedInterests[index]),
              );
            },
          );
        },
      ),
    );
  }
}
