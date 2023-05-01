import 'package:flutter/material.dart';

import 'dart:developer';

import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {
  final void Function({String? message, XFile? imageFile}) sendMessage;

  const TextComposer({
    super.key,
    required this.sendMessage,
  });

  @override
  State<TextComposer> createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool _isMessageEmpty = true;
  final TextEditingController _controller = TextEditingController();

  void _submitMessage(String text) {
    widget.sendMessage(message: text);
    setState(() {
      _controller.clear();
      _isMessageEmpty = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.photo_camera),
            onPressed: () async {
              final ImagePicker picker = ImagePicker();

              final XFile? photo = await picker.pickImage(
                source: ImageSource.camera,
              );

              if (photo == null) return;

              widget.sendMessage(imageFile: photo);
            },
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration.collapsed(
                hintText: 'Message',
              ),
              onChanged: (value) {
                setState(() {
                  _isMessageEmpty = value.isEmpty;
                });
              },
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _submitMessage(value);
                }
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _isMessageEmpty
                ? null
                : () {
                    _submitMessage(_controller.text);
                  },
          ),
        ],
      ),
    );
  }
}
