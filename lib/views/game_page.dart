import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/avatar_data.dart';

// Model
class GameModel {
  int score = 0;
  int points = 0;
  int remainingTime = 30;

  void incrementScore() {
    score += 1;
    if (score >= 30) {
      points = 500;
    }
  }

  void decrementTime() {
    remainingTime -= 1;
  }

  void resetGame() {
    score = 0;
    points = 0;
    remainingTime = 30;
  }
}

// Presenter
class GamePresenter {
  GameView _view;
  late GameModel _model;
  Timer? _gameTimer;
  Timer? _countdownTimer;

  GamePresenter(this._view) {
    _model = GameModel();
  }

  void buttonClicked(AvatarData avatarData) {
    _model.incrementScore();
    _view.refreshScore(_model.score);
    _view.refreshPoints(_model.points);
    if (_model.score >= 30) {
      clearGame(avatarData);
    }
  }

  void startGame() {
    _model.resetGame();
    _view.refreshScore(_model.score);
    _view.refreshPoints(_model.points);
    _view.refreshRemainingTime(_model.remainingTime);
    _gameTimer = Timer(Duration(seconds: 30), endGame);
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _model.decrementTime();
      _view.refreshRemainingTime(_model.remainingTime);
    });
  }

  void endGame() {
    _gameTimer?.cancel();
    _countdownTimer?.cancel();
    _view.showEndGame(_model.score, _model.points);
  }

  void clearGame(AvatarData avatarData) {
    _gameTimer?.cancel();
    _countdownTimer?.cancel();
    _view.showClearGame(_model.score, _model.points, avatarData);
  }
}

// View
abstract class GameView {
  void refreshScore(int score);
  void refreshPoints(int points);
  void refreshRemainingTime(int remainingTime);
  void showEndGame(int finalScore, int points);
  void showClearGame(int finalScore, int points, AvatarData avatarData);
  void exitPage();
}

class GamePage extends StatefulWidget {
  GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> implements GameView {
  late GamePresenter _presenter;
  int _counter = 0;
  int _points = 0;
  int _remainingTime = 30;

  _GamePageState() {
    _presenter = GamePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _presenter.startGame();
  }

  @override
  Widget build(BuildContext context) {
    final avatarData = Provider.of<AvatarData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("미니 게임"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '제한시간 30초 동안 \n30번 클릭하기 시작!',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '남은 시간: $_remainingTime 초',
              style: TextStyle(fontSize: 20),
            ),
            Text('얼마나 클릭했을 까요? : '),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'Points: $_points',
              style: Theme.of(context).textTheme.headline6,
            ),
            FloatingActionButton(
              onPressed: () => _presenter.buttonClicked(avatarData),
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void refreshScore(int score) {
    setState(() {
      _counter = score;
    });
  }

  @override
  void refreshPoints(int points) {
    setState(() {
      _points = points;
    });
  }

  @override
  void refreshRemainingTime(int remainingTime) {
    setState(() {
      _remainingTime = remainingTime;
    });
  }

  @override
  void showEndGame(int finalScore, int points) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('당신은 $finalScore 번 클릭했습니다! $points 경험치 획득!'),
          actions: <Widget>[
            TextButton(
              child: Text('다시하기'),
              onPressed: () {
                Navigator.of(context).pop();
                _presenter.startGame();
              },
            ),
          ],
        );
      },
    ).then((_) => exitPage());
  }

  @override
  void showClearGame(int finalScore, int points, AvatarData avatarData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('게임 클리어!'),
          content: Text('축하합니다! 총 $finalScore 번 누르셨습니다! $points 경험치 획득!'),
          actions: <Widget>[
            TextButton(
              child: Text('다시하기'),
              onPressed: () {
                avatarData.addExp(500);
                Navigator.of(context).pop();
                _presenter.startGame();
              },
            ),
            TextButton(
              child: Text('나가기'),
              onPressed: () {
                avatarData.addExp(500);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void exitPage() {
    Navigator.of(context).pop(); // Close the page
  }
}
