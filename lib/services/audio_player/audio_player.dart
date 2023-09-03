abstract class AppAudioPlayer {
  Future<void> init();
  Future<void> load(String url);
  void play();
  void pause();
  void seek(Duration position);
  Stream<Duration> get position;
  Stream<Duration> get totalDuration;
  Future<void> dispose();
}
