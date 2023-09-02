import 'package:flutter/widgets.dart';
import 'package:fv1/models/chapter.dart';
import 'package:fv1/models/playing_audio.dart';
import 'package:fv1/models/progress.dart';
import 'package:fv1/models/teaching_summary.dart';
import 'package:fv1/models/wrong_answer.dart';
import 'package:fv1/services/audio_player/audio_player.dart';
import 'package:fv1/services/data/data_service.dart';

class BrowserState extends ChangeNotifier {
  final AbstractDataService _dataService;
  final AppAudioPlayer audioPlayer;

  List<ProgressModel>? _localProgresses;
  List<ProgressModel>? get localProgresses => _localProgresses;

  ProgressModel? _activeProgress;
  ProgressModel? get activeProgress => _activeProgress;

  Map<String, dynamic> _formValue = {};

  List<WrongAnswer>? _wrongAnswers;
  List<WrongAnswer>? get wrongAnswers => _wrongAnswers;

  List<TeachingSummaryModel>? _teachingsList;
  List<TeachingSummaryModel>? get teachingsList => _teachingsList;

  PlayingAudio? _playingAudio;
  PlayingAudio? get playingAudio => _playingAudio;

  BrowserState(this._dataService, this.audioPlayer) {
    _loadInitialData();
  }

  void _loadInitialData() async {
    await _dataService.sync();
    _localProgresses = await _dataService.loadProgresses();
    notifyListeners();
  }

  Future<void> startTeaching(int id) async {
    _activeProgress = null;
    // display loader on explorer screen
    _teachingsList = null;
    notifyListeners();
    _localProgresses = _localProgresses ?? [];
    if (_localProgresses!.where((e) => e.teaching.id == id).isEmpty) {
      final newProgress = await _dataService.startTeaching(id);
      _localProgresses!.add(newProgress);
    }
  }

  void loadLocalTeaching(int id) async {
    _activeProgress = null;
    // wait to avoid flutter setState error message
    await Future.delayed(const Duration(milliseconds: 250));
    _activeProgress = _localProgresses!.where((t) => t.teaching.id == id).first;
    notifyListeners();
  }

  void resetFormValue() {
    _formValue = {};
  }

  void onFormValueChanged(String key, dynamic value) {
    _formValue[key] = value;
    notifyListeners();
  }

  dynamic getFormValue(String key) {
    return _formValue[key];
  }

  void submitQuiz(int chapterIndex, Map<String, dynamic> value) {
    final questions =
        _activeProgress!.teaching.chapters[chapterIndex].questions;
    _wrongAnswers = [];
    for (final q in questions) {
      final given = value[q.key];
      if (given != q.response) {
        _wrongAnswers!.add(WrongAnswer(q.question, given, q.response));
      }
    }
    _formValue = {};
  }

  // The index is from the url so it must be checked
  ChapterModel? getActiveChapter(int index) {
    return _activeProgress == null ||
            _activeProgress!.teaching.chapters.length <= index
        ? null
        : _activeProgress!.teaching.chapters[index];
  }

  Future<void> loadTeachingsList() async {
    _teachingsList = null;
    _teachingsList = await _dataService.loadNewTeachings();
    notifyListeners();
  }

  void playAudio(int chapterIndex, int sectionIndex) async {
    final teaching = _activeProgress!.teaching;
    _playingAudio = PlayingAudio(
      teachingId: teaching.id,
      chapterIndex: chapterIndex,
      sectionIndex: sectionIndex,
    );
    notifyListeners();
    await audioPlayer.init();
    final url = await _dataService.getAudioUrl(
      teaching.chapters[chapterIndex].sections[sectionIndex].audioId,
    );
    audioPlayer.load(url);
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }
}
