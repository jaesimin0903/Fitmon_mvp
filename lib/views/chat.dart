import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../models/avatar_data.dart';
import '../models/excercise.dart';

class Message {
  final String sender;
  final String content;
  final bool isUser;
  final bool isRoutine;

  Message(this.sender, this.content, this.isUser, this.isRoutine);
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> messages = [];

  final messageInputController = TextEditingController();
  List<dynamic> msgArr = [
    {
      "role": "system",
      "content": "운동루틴 추천 챗봇. 아래 출력예시대로 대답. 운동은 사용자가 원하는 부위의 운동을 출력."
    },
    {
      "role": "system",
      "content": "벤치프레스,10,4 \n덤벨벤치프레스,10,4 \n인클라인벤치플레스,10,4 \n딥스,10,4"
    },
    {"role": "user", "content": "가슴루틴"},
    {
      "role": "assistant",
      "content": "벤치프레스,10,4 \n덤벨벤치프레스,10,4 \n인클라인벤치플레스,10,4 \n딥스,10,4"
    },
    {
      "role": "system",
      "content": "벤치프레스,10,4 \n덤벨벤치프레스,10,4 \n인클라인벤치플레스,10,4 \n딥스,10,4"
    },
    {"role": "user", "content": "가슴루틴"},
    {
      "role": "assistant",
      "content": "벤치프레스,10,4 \n덤벨벤치프레스,10,4 \n인클라인벤치플레스,10,4 \n딥스,10,4"
    },
  ];
  Future<String> generateResponse(String userInput) async {
    var userData = {"role": "user", "content": userInput};
    dynamic map = Map<dynamic, dynamic>.from(userData);

    msgArr.add(map);
    String token = "Bearer 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";
    print("prompt : $msgArr");
    var response =
        await http.post(Uri.parse("https://api.openai.com/v1/chat/completions"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": token,
            },
            body: jsonEncode({
              "model": "gpt-3.5-turbo",
              "messages": msgArr,
              "temperature": 1,
              "max_tokens": 200,
            }));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data["choices"][0]["message"]["content"]);

      dynamic map = Map<dynamic, dynamic>.from(data["choices"][0]["message"]);
      msgArr.add(map);

      String text = data["choices"][0]["message"]["content"];
      print(text);
      return text;
    } else {
      throw Exception("Failed to generate response: ${response.statusCode}");
    }
  }

  Future<void> sendMessage() async {
    String userInput = messageInputController.text;
    if (userInput.isEmpty) {
      return;
    }
    setState(() {
      if (userInput == "가슴루틴" ||
          userInput == "등루틴" ||
          userInput == "어깨루틴" ||
          userInput == "하체루틴")
        messages.add(Message('User', userInput, true, true));
      else {
        messages.add(Message('User', userInput, true, false));
      }
    });
    messageInputController.clear();
    try {
      String botResponse = await generateResponse(userInput);
      setState(() {
        if (messages.last.isRoutine == true)
          messages.add(Message('ChatBot', botResponse, false, true));
        else {
          messages.add(Message('ChatBot', botResponse, false, false));
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final avatarData = Provider.of<AvatarData>(context);
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
                      (!messages[index].isUser && messages[index].isRoutine)
                          ? Container(
                              child: ElevatedButton(
                                child: Text("루틴추가"),
                                onPressed: () {
                                  List<String> workArr =
                                      messages[index].content.split('\n');
                                  List<List<String>> work = [];
                                  workArr.forEach((element) =>
                                      {work.add(element.split(','))});
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('루틴 추가'),
                                        content: SingleChildScrollView(
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxHeight: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.2, // Set the max height here
                                            ),
                                            child: Column(
                                              children: [
                                                ...work
                                                    .asMap()
                                                    .entries
                                                    .map((entry) {
                                                  var index = entry.key;
                                                  var element = entry.value;
                                                  var workout = element[0];
                                                  var laps = element[1];
                                                  var sets = element[2];
                                                  return Text(
                                                      "$workout $laps회 $sets세트");
                                                }).toList(),
                                                Text('해당 운동을 추가하시겠습니까?'),
                                              ],
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text('확인'),
                                            onPressed: () {
                                              print("111111111111");
                                              print(work);
                                              work.forEach((element) {
                                                Exercise ex = Exercise(
                                                    name: element[0],
                                                    weight: 0,
                                                    reps: element[1],
                                                    sets: element[2]);
                                                avatarData.addExc(ex);
                                              });
                                              print('${avatarData.myEx}');
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('취소'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            )
                          : SizedBox.shrink(),
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
            onPressed: sendMessage,
            child: Text('전송'),
          ),
        ],
      ),
    );
  }
}
