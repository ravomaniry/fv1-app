class AppTexts {
  final String appSlogan;
  final String continueButton;
  final String login;
  final String loginTitle;
  final String createAccount;
  final String continueAsGuest;
  final String noAccountYet;
  final String score;
  final String quizHelp;
  final String requiredFieldMessage;
  final String explorerHelp;
  final String errorInternet;
  final String errorUnknown;
  final String errorAudioPlayer;
  final String errorInvalidCredentials;
  final String loadingAudio;
  final String errorNotConnected;
  final String errorDuplicateUsername;
  final String errorWeakPassword;
  final String noNewTeaching;
  final String username;
  final String password;
  final String or;
  final String logOut;
  final String close;
  final String teachingsInProgress;
  final String teachingsAvailable;
  final String helpTitle;
  final String helpLoginTitle;
  final String helpLoginDescription;
  final String helpHomeTitle;
  final String helpHomeDescription;
  final String helpTeachingSummaryTitle;
  final String helpTeachingSummaryDescription;
  final String helpChapterTitle;
  final String helpChapterDescription;
  final String helpQuizTitle;
  final String helpQuizDescription;

  AppTexts({
    required this.appSlogan,
    required this.continueButton,
    required this.login,
    required this.loginTitle,
    required this.score,
    required this.quizHelp,
    required this.requiredFieldMessage,
    required this.explorerHelp,
    required this.errorInternet,
    required this.errorUnknown,
    required this.errorAudioPlayer,
    required this.errorNotConnected,
    required this.errorInvalidCredentials,
    required this.errorDuplicateUsername,
    required this.errorWeakPassword,
    required this.loadingAudio,
    required this.noNewTeaching,
    required this.username,
    required this.password,
    required this.continueAsGuest,
    required this.createAccount,
    required this.noAccountYet,
    required this.or,
    required this.logOut,
    required this.close,
    required this.teachingsInProgress,
    required this.teachingsAvailable,
    required this.helpTitle,
    required this.helpLoginTitle,
    required this.helpLoginDescription,
    required this.helpHomeTitle,
    required this.helpHomeDescription,
    required this.helpTeachingSummaryTitle,
    required this.helpTeachingSummaryDescription,
    required this.helpChapterTitle,
    required this.helpChapterDescription,
    required this.helpQuizTitle,
    required this.helpQuizDescription,
  });
}

final mgTexts = AppTexts(
  appSlogan:
      "... fa ny fahasoavana sy ny fahamarinana kosa dia tonga tamin’ ny alalan’ i Jesosy Kristy - Jaona 1:17",
  continueButton: 'TOHIZANA',
  login: 'HIDITRA',
  loginTitle: "Hiditra amin'ny kaontinao:",
  score: 'Isa',
  quizHelp: 'Valio ireto fanontaniana manaraka ireto '
      'araka ny fahazoanao ny fampianarana:',
  requiredFieldMessage: 'Valio ity fanontaniana ity azafady.',
  explorerHelp: 'Mbola tsy manaraka fampianarana ianao.\n'
      '- Tsindrio ny bokotra 🔍 hahitanao ireo fampianarana azo arahina.',
  errorInternet: 'Misy olana ny internet.',
  errorUnknown: 'Misy olana. '
      'Akatony ary avereno akatona ny application azafady.',
  errorAudioPlayer: 'Tsy afaka henoina ny audio. Avereno vakiana azafady.',
  loadingAudio: 'Eo am-panokafana ny "audio". Mandrasa kely azafady.',
  noNewTeaching: 'Mbola tsy misy fampianarana vaovao. '
      'Raha hijery ireo fampianarana efa natombokao dia '
      'jereo ny pejy voalohany azafady.',
  errorInvalidCredentials: 'Diso ny anarana na ny teny miafina. '
      'Avereno azafady, na manokafa kaonty vaovao raha mbola tsy manana kaonty ianao.',
  errorNotConnected:
      'Misy olana ny kaontinao fa akatony ary miverena miditra azafady.',
  errorDuplicateUsername: 'Efa misy io anarana io. Soloy hafa azafady.',
  errorWeakPassword: 'Tsotra loatra ily teny miafina nataonao. '
      'Ataovy lavalava azafady.',
  username: 'Anarana',
  password: 'Teny miafina',
  continueAsGuest: 'HAMPIASA KAONTY TSY MISY ANARANA',
  createAccount: 'HANOKATRA KAONTY VAOVAO',
  noAccountYet: 'Mbola tsy manana kaonty ve ianao?',
  or: 'na',
  logOut: 'HIALA',
  close: 'Akatona',
  teachingsInProgress: 'Ireo fampianarana arahinao:',
  teachingsAvailable: 'Fampianarana vaovao:',
  helpTitle: 'Torolalana',
  helpLoginTitle: '1. Miditra ao amin\'ny kaonty',
  helpLoginDescription: '**Raha efa manana kaonty ianao**:\n'
      '- **(1)** Fenoy ny anarana sy ny teny mifina\n'
      '- **(2)** Tsindrio ny bokotra "Hiditra"\n\n'
      '**Raha mbola tsy manana kanonty ianao dia afaka manao ny iray amin\'ireto:**\n'
      '- **(3)** Manokatra kaonty vaovao misy anarana:'
      '\\\nafaka sokafanao amin\'ny smartphone na ordinateur hafa ny kaonty misy anarana.\n'
      '- **(4)** Manokatra kaonty **tsy misy** anarana:'
      '\\\nafaka mampiasa ny appilcation manontolo ianao fa tsy afaka manokatra ilay kaonty '
      'amin\'ny smarphone na ordinateur hafa satria tsy fantatrao ny anarana sy ny teny miafina.',
  helpHomeTitle: '2. Lisitry ny fampianarana',
  helpHomeDescription: '**(1)** Ny lisitry ny fampianarana efa natombokao. '
      'Tsindrio izay tianao hotohizan.\n\n'
      '**(2)** Tsindrio ity bokotra ity raha te hijery ireo fampianarana vaovao mbola tsy natombokao ianao.',
  helpTeachingSummaryTitle: '3. Fampianarana',
  helpTeachingSummaryDescription:
      'Rehefa manokatra fampianarana ianao dia hitanao hoe taiza ianao no nijanona tamin\'ny farany.'
      'Tsindrio ny lohahevitra tianao hotohizana.',
  helpChapterTitle: '4. Lohahevitra',
  helpChapterDescription:
      'Ny fampianarana iray dia mizara lohahaevitra maromaro. Ny lohahevitra tsirairay dia misy audio miaraka aminy.\n\n'
      '**(1)** Ny hevitra: Tsindrio eo raha te hihaino ny fampianarana ianao.\\\n'
      '**(2)** Ny tenin\'Andriamanitra,\\\n'
      '**(3)** Fanazavana fohy',
  helpQuizTitle: '5. Fanontainana',
  helpQuizDescription:
      'Isaky ny mahavita lohahevitra iray ianao dia misy fanontaniana vitsivitsy valiana '
      'ahafahanao manamafy ny zavatra nianarana.',
);
