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
);
