import 'dart:convert';
import 'dart:developer';

import 'package:find_cook/common/widgets/custom_appbar.dart';
import 'package:find_cook/common/widgets/filled_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
class AskAiScreen extends StatefulWidget {
  const AskAiScreen({super.key});

  @override
  State<AskAiScreen> createState() => _AskAiScreenState();
}

class _AskAiScreenState extends State<AskAiScreen> {
  final Aicontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(child: Column()),
            FilledTextField(hint: "ask ai",
                controller: Aicontroller,suffix: InkWell(
              onTap: (){
                askAi();
              },
                child: Icon(Icons.send,color: Colors.blue,)),),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }

  Future<void> askAi() async {
    Aicontroller.clear();

    final uri="sk-69c621a2e97d4569b6830e2bfa610821";

    final response=await http.post(Uri.parse("https://api.deepseek.com/chat/completions"),
    headers: {
      "Content-Type" : "application/json",
      "Accept":"application/json",
      "Authorization" : "Bearer sk-5d7a00b806184813a23423867324bd9b"
    },
    body: jsonEncode({
      "model":"deepseek-chat",
      "messages": [
        {
          "content": "You are a helpful assistant",
          "role": "system"
        },
        {
          "content": "Hi",
          "role": "user"
        }
      ]
    }));

    print(response);
    log(response.body);


  }
}
