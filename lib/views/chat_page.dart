import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'dart:convert';

void main() => runApp(ChatPage());

class Message {
  final String sender;
  final String content;
  final bool isUser;

  Message(this.sender, this.content, this.isUser);
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> messages = [
    Message('User', '오늘 가슴 운동할 건데 운동 만들어줘!', true),
    Message(
        'ChatBot', '당신에게 가슴 운동으로 플랫 벤치 프레스를 추천합니다. 3세트에 각각 10회씩 해보세요!', false),
  ];

  final messageInputController = TextEditingController();
  List<String> msgArr = [];
  Future<void> generateText() async {
    print(1);
    String prompt = messageInputController.text;
    String msg = '{"role": "user", "content": $prompt}';
    msgArr.add(msg);
    String model = "gpt-3.5-turbo";
    String apiKey = "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";
    print("$apiKey");
    try {
      var response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'messages': msgArr,
          'model': model,
          'temperature': 0.5,
          'n': 1,
          'stop': '.'
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> result = jsonDecode(response.body);
        String generatedMessage =
            result['choices'][0]['message']['content'].trim();
        print(generatedMessage);
        setState(() {
          messages.add(Message('User', prompt, true));
          messages.add(Message('ChatBot', generatedMessage, false));
        });
      }
    } on Exception catch (e) {
      print("e : $e");
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatBot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: messages[index].isUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Material(
                        color: messages[index].isUser
                            ? Colors.blueAccent
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Text(messages[index].content,
                              style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          TextField(
            controller: messageInputController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: '메시지를 입력하세요',
            ),
          ),
          ElevatedButton(
            onPressed: generateText,
            child: Text('전송'),
          ),
        ],
      ),
    );
  }
}
