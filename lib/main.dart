import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  void showBasicAlert() {
    Alert(
      context: context,
      title: 'Finished',
      desc: 'You are done with the quiz',
    ).show();
  }

  List<Icon> scoreKeeper = [];
  void setScore(bool answer) {
    if (answer == true)
      scoreKeeper.add(Icon(
        Icons.check_circle,
        color: Colors.green,
      ));
    else
      scoreKeeper.add(Icon(
        Icons.cancel,
        color: Colors.red,
      ));
  }

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    if (correctAnswer == userPickedAnswer) {
      print('You got it right');
    } else {
      print('You got it wrong');
    }
    setState(() {
      if (quizBrain.isFinished() == true) {
        showBasicAlert();
        quizBrain.isReset();
        scoreKeeper = [];
      } else {
        setScore(correctAnswer == userPickedAnswer);
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Quiz App'),
        backgroundColor: Colors.white38,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  quizBrain.getQuestionText(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  checkAnswer(true);
                },
                child: Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  checkAnswer(false);
                },
                child: Text(
                  'False',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: scoreKeeper,
            ),
          ),
        ],
      ),
    );
  }
}
