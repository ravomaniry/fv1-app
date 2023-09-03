import 'package:fv1/models/chapter.dart';
import 'package:fv1/models/chapter_score.dart';
import 'package:fv1/models/progress.dart';
import 'package:fv1/models/quiz_question.dart';
import 'package:fv1/models/section.dart';
import 'package:fv1/models/teaching.dart';
import 'package:fv1/services/data/data_service.dart';

class NativeDataService extends AbstractDataService {
  @override
  Future<void> sync() async {
    // Save the local progress to remote
  }

  @override
  Future<List<ProgressModel>> loadProgresses() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      ProgressModel(teaching: _testTeaching, scores: []),
      ProgressModel(
        teaching: TeachingModel(
          2,
          'Teaching 2',
          _testTeaching.subtitle,
          _testTeaching.chapters,
        ),
        scores: [
          ChapterScore(correctAnswersPercentage: 1),
        ],
      ),
    ];
  }

  @override
  Future<ProgressModel> startTeaching(int id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return ProgressModel(teaching: _testTeaching, scores: []);
  }
}

final List<QuizQuestionModel> _testQuestions = [
  QuizQuestionModel(
    '0',
    'Ny fahasoavana dia:',
    [
      'Valisoa noho ny asa tsara natao',
      'Fanomezana oman\'Andriamanitra izay hitany fa miezaka',
    ],
    'Valisoa noho ny asa tsara natao',
  ),
  QuizQuestionModel(
    '1',
    'Ny famonjena dia:',
    [
      'Valisoa ho an\'izay mitandrina ny lalàna.',
      'Fanomezana omena izay mino an\'i Jesosy',
    ],
    'Fanomezana omena izay mino an\'i Jesosy',
  ),
];

ChapterModel _testChapter(int i) {
  return ChapterModel(
    'A$i. FANOMEZANA MAIMAIM-POANA',
    [
      SectionModel(
        'Efesiana 2:8',
        'Fa fahasoanava\n'
            'No namonjena anareo.',
        1,
      ),
      SectionModel(
        'Romana 5:2',
        'Ao aminy no hananantsika fanatonana\n'
            'amin\'ny finiana izao fahasoavana\n'
            'itoerantsika izao.',
        2,
      ),
    ],
    _testQuestions,
  );
}

final _testTeaching = TeachingModel(
  1,
  'Anto-pisiana vaovao',
  'Inona ny tanjon\'Andriamanitra amin\'ny fiainanao rehefa ao amin\'i Kristy ianao?',
  [_testChapter(1), _testChapter(2)],
);
