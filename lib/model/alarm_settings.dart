import 'package:alarm/model/notification_settings.dart';
import 'package:flutter/widgets.dart';

@immutable

/// [AlarmSettings] is a model that contains all the settings to customize
/// and set an alarm.
class AlarmSettings {
  /// Constructs an instance of `AlarmSettings`.
  const AlarmSettings({
    required this.id,
    required this.dateTime,
    required this.assetAudioPath,
    required this.notificationSettings,
    this.loopAudio = true,
    this.vibrate = true,
    this.volume,
    this.volumeEnforced = false,
    this.fadeDuration = 0.0,
    this.warningNotificationOnKill = true,
    this.androidFullScreenIntent = true,
    this.repeatingDays = const [], // New: Added repeatingDays with default empty list.
    this.snoozeLimit = 5, // New: Added snoozeLimit with a default value of 5.
    this.snoozeInterval = 10, // New: Added snoozeInterval with a default value of 10 (in minutes).
    this.isSnoozed = false, // New: Added isSnoozed to track snooze state.
  });

  /// Constructs an `AlarmSettings` instance from the given JSON data.
  factory AlarmSettings.fromJson(Map<String, dynamic> json) {
    NotificationSettings notificationSettings;

    // Ensure compatibility with plugin versions below 4.0.0.
    if (json.containsKey('notificationSettings') &&
        json['notificationSettings'] != null) {
      notificationSettings = NotificationSettings.fromJson(
        json['notificationSettings'] as Map<String, dynamic>,
      );
    } else {
      final notificationTitle = json['notificationTitle'] as String? ?? '';
      final notificationBody = json['notificationBody'] as String? ?? '';

      notificationSettings = NotificationSettings(
        title: notificationTitle,
        body: notificationBody,
      );
    }

    final warningNotificationOnKill =
    json.containsKey('warningNotificationOnKill')
        ? json['warningNotificationOnKill'] as bool
        : json['enableNotificationOnKill'] as bool? ?? true;

    return AlarmSettings(
      id: json['id'] as int,
      dateTime: DateTime.fromMicrosecondsSinceEpoch(json['dateTime'] as int),
      assetAudioPath: json['assetAudioPath'] as String,
      notificationSettings: notificationSettings,
      loopAudio: json['loopAudio'] as bool? ?? true,
      vibrate: json['vibrate'] as bool? ?? true,
      volume: json['volume'] as double?,
      volumeEnforced: json['volumeEnforced'] as bool? ?? false,
      fadeDuration: json['fadeDuration'] as double? ?? 0.0,
      warningNotificationOnKill: warningNotificationOnKill,
      androidFullScreenIntent: json['androidFullScreenIntent'] as bool? ?? true,
      repeatingDays:
      (json['repeatingDays'] as List<dynamic>?)?.cast<int>() ?? [], // New: Parse repeatingDays from JSON.
      snoozeLimit: json['snoozeLimit'] as int? ?? 5, // New: Parse snoozeLimit from JSON.
      snoozeInterval: json['snoozeInterval'] as int? ?? 10, // New: Parse snoozeInterval from JSON.
      isSnoozed: json['isSnoozed'] as bool? ?? false, // New: Parse isSnoozed from JSON.
    );
  }

  /// Unique identifier associated with the alarm. Cannot be 0 or -1.
  final int id;

  /// Date and time when the alarm will be triggered.
  final DateTime dateTime;

  /// Path to audio asset to be used as the alarm ringtone.
  final String assetAudioPath;

  /// Settings for the notification.
  final NotificationSettings notificationSettings;

  /// If true, [assetAudioPath] will repeat indefinitely until alarm is stopped.
  final bool loopAudio;

  /// If true, device will vibrate for 500ms, pause for 500ms and repeat until
  /// alarm is stopped.
  final bool vibrate;

  /// Specifies the system volume level to be set at the designated [dateTime].
  final double? volume;

  /// If true, the alarm volume is enforced, automatically resetting to the
  /// original alarm [volume] if the user attempts to adjust it.
  final bool volumeEnforced;

  /// Duration, in seconds, over which to fade the alarm ringtone.
  final double fadeDuration;

  /// Whether to show a warning notification when application is killed by user.
  final bool warningNotificationOnKill;

  /// Whether to turn screen on and display full-screen notification
  /// when Android alarm notification is triggered.
  final bool androidFullScreenIntent;

  /// List of days (represented by integers) when the alarm should repeat.
  /// 0: Sunday, 1: Monday, ..., 6: Saturday.
  final List<int> repeatingDays;

  /// New: Maximum number of times the alarm can be snoozed.
  final int snoozeLimit;

  /// New: Interval (in minutes) between snoozes.
  final int snoozeInterval;

  /// New: Tracks whether the alarm is currently snoozed.
  final bool isSnoozed;

  /// Returns a hash code for this `AlarmSettings` instance using Jenkins hash function.
  @override
  int get hashCode {
    var hash = 0;

    hash = hash ^ id.hashCode;
    hash = hash ^ dateTime.hashCode;
    hash = hash ^ assetAudioPath.hashCode;
    hash = hash ^ notificationSettings.hashCode;
    hash = hash ^ loopAudio.hashCode;
    hash = hash ^ vibrate.hashCode;
    hash = hash ^ volume.hashCode;
    hash = hash ^ volumeEnforced.hashCode;
    hash = hash ^ fadeDuration.hashCode;
    hash = hash ^ warningNotificationOnKill.hashCode;
    hash = hash ^ androidFullScreenIntent.hashCode;
    hash = hash ^ repeatingDays.hashCode; // New: Include repeatingDays in hashCode.
    hash = hash ^ snoozeLimit.hashCode; // New: Include snoozeLimit in hashCode.
    hash = hash ^ snoozeInterval.hashCode; // New: Include snoozeInterval in hashCode.
    hash = hash ^ isSnoozed.hashCode; // New: Include isSnoozed in hashCode.
    hash = hash & 0x3fffffff;

    return hash;
  }

  /// Creates a copy of `AlarmSettings` but with the given fields replaced with
  /// the new values.
  AlarmSettings copyWith({
    int? id,
    DateTime? dateTime,
    String? assetAudioPath,
    NotificationSettings? notificationSettings,
    bool? loopAudio,
    bool? vibrate,
    double? volume,
    bool? volumeEnforced,
    double? fadeDuration,
    String? notificationTitle,
    String? notificationBody,
    bool? warningNotificationOnKill,
    bool? androidFullScreenIntent,
    List<int>? repeatingDays, // New: Add repeatingDays to copyWith method.
    int? snoozeLimit, // New: Add snoozeLimit to copyWith method.
    int? snoozeInterval, // New: Add snoozeInterval to copyWith method.
    bool? isSnoozed, // New: Add isSnoozed to copyWith method.
  }) {
    return AlarmSettings(
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      assetAudioPath: assetAudioPath ?? this.assetAudioPath,
      notificationSettings: notificationSettings ?? this.notificationSettings,
      loopAudio: loopAudio ?? this.loopAudio,
      vibrate: vibrate ?? this.vibrate,
      volume: volume ?? this.volume,
      volumeEnforced: volumeEnforced ?? this.volumeEnforced,
      fadeDuration: fadeDuration ?? this.fadeDuration,
      warningNotificationOnKill:
      warningNotificationOnKill ?? this.warningNotificationOnKill,
      androidFullScreenIntent:
      androidFullScreenIntent ?? this.androidFullScreenIntent,
      repeatingDays: repeatingDays ?? this.repeatingDays, // New: Use repeatingDays.
      snoozeLimit: snoozeLimit ?? this.snoozeLimit, // New: Use snoozeLimit.
      snoozeInterval: snoozeInterval ?? this.snoozeInterval, // New: Use snoozeInterval.
      isSnoozed: isSnoozed ?? this.isSnoozed, // New: Use isSnoozed.
    );
  }

  /// Converts this `AlarmSettings` instance to JSON data.
  Map<String, dynamic> toJson() => {
    'id': id,
    'dateTime': dateTime.microsecondsSinceEpoch,
    'assetAudioPath': assetAudioPath,
    'notificationSettings': notificationSettings.toJson(),
    'loopAudio': loopAudio,
    'vibrate': vibrate,
    'volume': volume,
    'volumeEnforced': volumeEnforced,
    'fadeDuration': fadeDuration,
    'warningNotificationOnKill': warningNotificationOnKill,
    'androidFullScreenIntent': androidFullScreenIntent,
    'repeatingDays': repeatingDays, // New: Add repeatingDays to JSON serialization.
    'snoozeLimit': snoozeLimit, // New: Add snoozeLimit to JSON serialization.
    'snoozeInterval': snoozeInterval, // New: Add snoozeInterval to JSON serialization.
    'isSnoozed': isSnoozed, // New: Add isSnoozed to JSON serialization.
  };
}
