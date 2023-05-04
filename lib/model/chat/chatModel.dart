import 'package:flutter/material.dart';

class ChatModel{
  final String id;
  final String message;
  final bool isMe;

  const ChatModel({required this.id, required this.message, required this.isMe});
}