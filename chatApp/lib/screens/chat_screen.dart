import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('chats/1DRF384LNipDHeerdCsj/messages')
            .snapshots(),
        builder: (ctx, streamSnapshot) =>
            streamSnapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: streamSnapshot.data.documents.length,
                    itemBuilder: (ctx, index) => Container(
                      padding: EdgeInsets.all(8),
                      child: Text(streamSnapshot.data.documents[index]['text']),
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
