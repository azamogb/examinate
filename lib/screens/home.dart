import 'package:examinate/constants.dart';
import 'package:examinate/widgets/next_button.dart';
import 'package:examinate/widgets/options_card.dart';
import 'package:examinate/widgets/result_box.dart';
import 'package:flutter/material.dart';
import 'package:examinate/models/question_model.dart';
import 'package:examinate/widgets/questions.dart';
import 'package:examinate/models/firebase.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var db = DBconnect();
  late Future _questions;
  Future<List<Question>> getData()async{
    return db.fetchQuestions();
  }

  @override
  void initState(){
    _questions = getData();
    super.initState();
  }
  // final List<Question> _questions = [
  //   Question(id: '10', title: '2x2=', options: {
  //     '5': false,
  //     '6': false,
  //     '4': true,
  //     '7': false,
  //   }),
  //   Question(id: '11', title: '20x3=', options: {
  //     '50': false,
  //     '60': true,
  //     '40': false,
  //     '70': false,
  //   })
  // ];

  int index = 0;

  int score = 0;

  bool isPressed = false;

  bool isAlreadySelected = false;

  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => ResultBox(
                result: score,
                questionLength: questionLength,
            onPressed: startOver,
              ));
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please select at least one option'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20.0),
        ));
      }
    }
  }

  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
        setState(() {
          isPressed = true;
          isAlreadySelected = true;
        });
    }
  }

  void startOver(){
    setState(() {
      index = 0;
          score = 0;
          isPressed = false;
          isAlreadySelected = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _questions as Future<List<Question>>,
      builder: (ctx, snapshot){
        if (snapshot.connectionState == ConnectionState.done){
          if (snapshot.hasError){
            return Center(child: Text('${snapshot.error}'),);
          }else if (snapshot.hasData){
            var extractedData = snapshot.data as List<Question>;
            return Scaffold(
              backgroundColor: background,
              appBar: AppBar(
                title: const Text('EXAMINATE', style: TextStyle(color: neutral)),
                backgroundColor: background,
                shadowColor: Colors.transparent,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Score: $score',
                      style: const TextStyle(fontSize: 18.0, color: neutral),
                    ),
                  ),
                ],
              ),
              body: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Column(
                  children: [
                    QuestionsWidget(
                      question: extractedData[index].title,
                      totalQuestions: extractedData.length,
                      indexAction: index,
                    ),
                    const Divider(
                      color: neutral,
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    for (int i = 0; i < extractedData[index].options.length; i++)
                      GestureDetector(
                        onTap: () => checkAnswerAndUpdate(
                            extractedData[index].options.values.toList()[i]),
                        child: OptionCard(
                          option: extractedData[index].options.keys.toList()[i],
                          color: isPressed
                              ? extractedData[index].options.values.toList()[i] == true
                              ? correct
                              : incorrect
                              : neutral,
                        ),
                      ),
                  ],
                ),
              ),
              floatingActionButton: GestureDetector(
                onTap: () => nextQuestion(extractedData.length),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: NextButton(
                    //nextQuestion: nextQuestion,
                  ),
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            );
          }
        }
        else {
          return const Center(
          child: CircularProgressIndicator(),
        );
        }
        return const Center(child: Text('NO DATA'),);
      },
    );
  }
}
