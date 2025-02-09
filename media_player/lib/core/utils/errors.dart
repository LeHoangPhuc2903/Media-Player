class MediaPlayerError {
  final String message;

  MediaPlayerError(this.message);
}

class FileNotFoundError extends MediaPlayerError {
  FileNotFoundError() : super("File not found.");
}

class UnsupportedFormatError extends MediaPlayerError {
  UnsupportedFormatError() : super("Unsupported media format.");
}

class NetworkError extends MediaPlayerError {
  NetworkError() : super("Network error occurred.");
}

class PlaybackError extends MediaPlayerError {
  PlaybackError() : super("Error during media playback.");
}

class PermissionDeniedError extends MediaPlayerError {
  PermissionDeniedError() : super("Permission denied.");
}

class UnknownError extends MediaPlayerError {
  UnknownError() : super("An unknown error occurred.");
}