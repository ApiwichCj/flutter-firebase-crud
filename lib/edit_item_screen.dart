import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'item_service.dart';

class EditItemScreen extends StatefulWidget {
  const EditItemScreen(
      {super.key,
      required this.itemName,
      required this.itemDesc,
      required this.documentid});
  final String documentid;
  final String itemName;
  final String itemDesc;

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final ItemService _itemService = ItemService();
  final _itemName = TextEditingController();
  final _itemDesc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _itemName.text = widget.itemName;
    _itemDesc.text = widget.itemDesc;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _itemName,
              decoration: const InputDecoration(label: Text("Item name")),
            ),
            TextField(
              controller: _itemDesc,
              decoration:
                  const InputDecoration(label: Text("Item Description")),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  _deleteItem(context, widget.documentid);
                },
                child: const Text("Delete")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  _editItem(context, widget.documentid);
                },
                child: const Text("Edit"))
          ],
        ),
      ),
    );
  }

  void _editItem(BuildContext context, documentid) {
    _itemService.editItem(context, documentid, {
      "name": _itemName.text,
      "desc": _itemDesc.text
    }).then((value) => Navigator.pop(context));
  }

  void _deleteItem(BuildContext context, documentid) {
    _itemService
        .deleteItem(context, {"name": _itemName.text, "desc": _itemDesc.text},
            documentid)
        .then((value) => Navigator.pop(context));
    _itemName.text = "";
    _itemDesc.text = "";
  }
}
