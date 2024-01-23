import 'package:flutter/material.dart';

class TypingTextBar extends StatelessWidget {
  const TypingTextBar({
    super.key,
    required this.onSend,
    required this.messageController,
  });

  final Function() onSend;
  final TextEditingController messageController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding:
            const EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 10),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.multiline,
                controller: messageController,
                minLines: 1,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: "Type a message",
                  hintStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none,
                ),
                // onChanged: chat.onTextChange,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            InkWell(
              onTap: () => onSend(),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.lightBlue,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(10),
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
