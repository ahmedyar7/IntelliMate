import 'package:intellimate/screen/chat_screen.dart';
import 'package:intellimate/utils/app_constant.dart';
import 'package:intellimate/utils/util_helper.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// -------------- AppBar --------------------------///
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text.rich(
          TextSpan(
            text: "Intelli",
            style: mTextStyle25(fontColor: Colors.white),
            children: [
              TextSpan(
                text: "Mate",
                style: mTextStyle25(fontColor: Colors.blue),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(100),
              ),
              child: IconButton(
                icon: const Icon(Icons.face),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),

      /// ----------------------------- BODY -----------------------------------///
      body: Container(
        color: Colors.grey[900],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.chat_bubble_outline,
                          color: Colors.white60),
                      const SizedBox(width: 4),
                      Text(
                        "New chat",
                        style: mTextStyle18(fontColor: Colors.white70),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.history, color: Colors.white60),
                      const SizedBox(width: 4),
                      Text(
                        "History",
                        style: mTextStyle18(fontColor: Colors.white70),
                      )
                    ],
                  )
                ],
              ),
            ),

            /// Search Text Field
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(9),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: searchController,
                    style: mTextStyle18(fontColor: Colors.white),
                    onSubmitted: (value) {
                      if (searchController.text.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChatScreen(query: searchController.text),
                          ),
                        );
                      }
                    },
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: "Ask me anything...",
                      hintStyle: mTextStyle18(fontColor: Colors.white60),
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.mic,
                              color: Colors.blue,
                              size: 30,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (searchController.text.trim().isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChatScreen(query: searchController.text),
                                ),
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Tab Bar
            SizedBox(
              height: 40,
              child: ListView.builder(
                itemCount: AppConstant.defaultQues.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: index == selectedIndex
                            ? Border.all(width: 1, color: Colors.white10)
                            : null,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9),
                        child: Center(
                          child: Text(
                            AppConstant.defaultQues[index]["title"],
                            style: index == selectedIndex
                                ? mTextStyle18(fontColor: Colors.white)
                                : mTextStyle18(fontColor: Colors.white60),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            /// Quick Questions Grid
            Expanded(
              child: GridView.builder(
                itemCount:
                    AppConstant.defaultQues[selectedIndex]['question'].length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                      AppConstant.defaultQues[selectedIndex]['question'][index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(query: data['ques']),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: data['color'],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Icon(
                                    data['icon'],
                                    size: 28,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                data['ques'],
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: mTextStyle15(
                                    fontColor: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
