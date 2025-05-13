import 'dart:math';

import 'package:flutter/material.dart';

class AppConstant {
  static final List<Map<String, dynamic>> defaultQues = [
    {
      "title": "Most Popular",
      "question": [
        {
          "icon": Icons.computer,
          "color": Colors.primaries[Random().nextInt(Colors.primaries.length)],
          "ques": "What is the difference between AI and ML?"
        },
        {
          "icon": Icons.code,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "Explain Big O Notation with examples."
        },
        {
          "icon": Icons.memory,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "What are time complexity and space complexity?"
        },
        {
          "icon": Icons.settings_applications,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "What is an algorithm? Give real-life examples."
        },
        {
          "icon": Icons.desktop_windows,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "What is the difference between stack and queue?"
        },
        {
          "icon": Icons.graphic_eq,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "Explain Binary Search and its advantages."
        },
        {
          "icon": Icons.data_usage,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "What is the difference between SQL and NoSQL databases?"
        },
        {
          "icon": Icons.link,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "What is REST API and how does it work?"
        }
      ]
    },
    {
      "title": "Trending",
      "question": [
        {
          "icon": Icons.auto_graph,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "What is LLM and how does it work?"
        },
        {
          "icon": Icons.security,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "Explain public-key cryptography in simple terms."
        },
        {
          "icon": Icons.mobile_screen_share,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques":
              "What are microservices and how do they differ from monolithic architecture?"
        },
        {
          "icon": Icons.cloud_circle,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "What is DevOps and why is it important?"
        },
        {
          "icon": Icons.bug_report,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "Explain debugging and common debugging strategies."
        },
        {
          "icon": Icons.build,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "What is CI/CD pipeline and how does it work?"
        },
      ]
    },
    {
      "title": "Interview Prep",
      "question": [
        {
          "icon": Icons.question_answer,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "Explain Object-Oriented Programming principles."
        },
        {
          "icon": Icons.account_tree,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "What is a binary tree and how is it used?"
        },
        {
          "icon": Icons.sort,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "Compare Merge Sort and Quick Sort algorithms."
        },
        {
          "icon": Icons.linked_camera,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "What is a linked list and how is it different from array?"
        },
        {
          "icon": Icons.verified_user,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "Explain authentication vs authorization."
        },
        {
          "icon": Icons.developer_board,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "What is polymorphism in OOPs?"
        },
        {
          "icon": Icons.change_circle,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "Differentiate between mutable and immutable objects."
        },
        {
          "icon": Icons.router,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "ques": "What is HTTP vs HTTPS?"
        },
      ]
    }
  ];
}
