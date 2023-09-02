class AppTexts {
  final String continueButton;
  final String score;
  final String quizHelp;
  final String requiredFieldMessage;
  final String explorerHelp;

  AppTexts({
    required this.continueButton,
    required this.score,
    required this.quizHelp,
    required this.requiredFieldMessage,
    required this.explorerHelp,
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
);
