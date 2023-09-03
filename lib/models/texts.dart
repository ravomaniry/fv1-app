class AppTexts {
  final String continueButton;
  final String score;
  final String quizHelp;
  final String requiredFieldMessage;
  final String explorerHelp;
  final String internetError;
  final String unknownError;
  final String playerError;
  final String loadingAudio;

  AppTexts({
    required this.continueButton,
    required this.score,
    required this.quizHelp,
    required this.requiredFieldMessage,
    required this.explorerHelp,
    required this.internetError,
    required this.unknownError,
    required this.playerError,
    required this.loadingAudio,
  });
}

final mgTexts = AppTexts(
  continueButton: 'TOHIZANA',
  score: 'Isa',
  quizHelp: 'Valio ireto fanontaniana manaraka ireto '
      'araka ny fahazoanao ny fampianarana:',
  requiredFieldMessage: 'Valio ity fanontaniana ity azafady.',
  explorerHelp: 'Mbola tsy manaraka fampianarana ianao.\n'
      '- Tsindrio ny bokotra 🔍 hahitanao ireo fampianarana azo arahina.',
  internetError: 'Misy olana ny internet.',
  unknownError: 'Misy olana. '
      'Akatony ary avereno akatona ny application azafady.',
  playerError: 'Tsy afaka henoina ny audio. '
      'Avereno akatona sy sokafana ny application azafady.',
  loadingAudio: 'Eo am-panokafana ny "audio". Mandrasa kely azafady.',
);
