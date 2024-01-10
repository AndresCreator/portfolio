import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:go_router/go_router.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  List<Contact>? _contacts;
  bool _permissionDenied = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts(withProperties: true);
      setState(() => _contacts = contacts);
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                title: TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search contacts',
                    border: InputBorder.none,
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.go('/friend-list'),
                ),
              ),
              body: _body()),
        ),
      );

  Widget _body() {
    if (_permissionDenied) {
      return const Center(child: Text('Permission denied'));
    }
    if (_contacts == null) {
      return const Center(child: CircularProgressIndicator());
    }
    final filteredContacts = _contacts!.where(
      (contact) {
        return contact.displayName
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) &&
            contact.phones.isNotEmpty;
      },
    ).toList();

    return ListView.builder(
      itemCount: filteredContacts.length,
      itemBuilder: (context, i) => ListTile(
        title: Text(filteredContacts[i].displayName),
        onTap: () {
          final fullContact = filteredContacts[i];
          if (fullContact.phones.length == 1) {
            context.go('/new-expense?phone=${fullContact.phones[0].number}');
          } else {
            if (Platform.isIOS) {
              showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return CupertinoActionSheet(
                    title: const Text('Select a phone number'),
                    actions: fullContact.phones
                        .map((phone) => CupertinoActionSheetAction(
                              onPressed: () => context
                                  .go('/new-expense?phone=${phone.number}'),
                              child: Text(phone.number),
                            ))
                        .toList(),
                    cancelButton: CupertinoActionSheetAction(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  );
                },
              );
            } else if (Platform.isAndroid) {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ListView(
                    shrinkWrap: true,
                    children: fullContact.phones
                        .map((phone) => ListTile(
                              title: Text(phone.number),
                              onTap: () => context
                                  .go('/new-expense?phone=${phone.number}'),
                            ))
                        .toList(),
                  );
                },
              );
            } else {
              throw Exception('Unsupported platform');
            }
          }
        },
      ),
    );
  }
}
