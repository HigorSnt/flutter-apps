import 'package:chat/chat_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: ChatScreen(),
      theme: ThemeData(
        primaryColor: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.blue,
        ),
      ),
    ),
  );
}