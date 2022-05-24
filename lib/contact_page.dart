import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'contact.dart';
import 'new_contact_form.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Hive'),
      ),
      body: Column(
        children: [
          Expanded(child: _buildListView()),
          NewContactForm(),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ValueListenableBuilder(
        valueListenable: Hive.box('contacts').listenable(),
        builder: (context, Box box, _) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (BuildContext context, int index) {
              final contact = box.getAt(index) as Contact;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(contact.name),
                  Text(contact.numberCall.toString()),
                ],
              );
            },
          );
        });
  }
}
