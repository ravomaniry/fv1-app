import 'package:fv1/models/chapter.dart';
import 'package:fv1/models/quiz_question.dart';
import 'package:fv1/models/section.dart';
import 'package:fv1/models/teaching.dart';

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

final testTeaching = TeachingModel(
  1,
  'Anto-pisiana vaovao',
  'Inona ny tanjon\'Andriamanitra amin\'ny fiainanao rehefa ao amin\'i Kristy ianao?',
  [_testChapter(1), _testChapter(2)],
);
