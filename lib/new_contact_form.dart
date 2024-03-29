import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'contact.dart';

class NewContactForm extends StatefulWidget {
  @override
  _NewContactFormState createState() => _NewContactFormState();
}

class _NewContactFormState extends State<NewContactForm> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late String _numberCall;

  void addContact(Contact contact) {
    final contactBox = Hive.box('contacts');
    contactBox.add(contact);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onSaved: (value) => _name = value!,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Call Number'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _numberCall = value!,
                ),
              )
            ],
          ),
          ElevatedButton(
            child: Text('Add new contact'),
            onPressed: () {
              _formKey.currentState?.save();
              final newContact = Contact(_name, int.parse(_numberCall));
              addContact(newContact);
            },
          )
        ],
      ),
    );
  }
}
