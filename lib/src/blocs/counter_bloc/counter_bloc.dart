import 'dart:async';
import 'package:rxdart/rxdart.dart';

class CounterBloc {
  int _counter;

  CounterBloc() {
    _counter = 1;
    _actionControllerMinus.stream.listen(_increaseStreamMinus);
    _actionController.stream.listen(_increaseStream);
  }

  final _counterStream = BehaviorSubject<int>.seeded(1);

  Stream get pressedCount => _counterStream.stream;
  Sink get _addValue => _counterStream.sink;

    


  StreamController _actionController = StreamController();
  StreamController _actionControllerMinus = StreamController();

  StreamSink get incrementCounter => _actionController.sink;
  StreamSink get decrementCounter => _actionControllerMinus.sink;


  void _increaseStream(data) {
    _counter += 1;
    _addValue.add(_counter);
  }

  void _increaseStreamMinus(data) {
    _counter -= 1;
    _addValue.add(_counter);
  }

  void dispose() {
    _counterStream.close();
    _actionController.close();
    _actionControllerMinus.close();
  }
}