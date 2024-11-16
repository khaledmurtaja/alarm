import 'package:alarm/model/notification_settings.dart';
import 'package:flutter/widgets.dart';

@immutable
class AlarmSettings {
  const AlarmSettings({
    required this.id,
    required this.title, // Added title.
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
    this.repeatingDays = const [],
    this.snoozeLimit = 5,
    this.snoozeInterval = 10,
    this.isSnoozed = false,
  });

  factory AlarmSettings.fromJson(Map<String, dynamic> json) {
    NotificationSettings notificationSettings;

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
      title: json['title'] as String? ?? 'Untitled', // Parse title with default.
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
      repeatingDays: (json['repeatingDays'] as List<dynamic>?)?.cast<int>() ?? [],
      snoozeLimit: json['snoozeLimit'] as int? ?? 5,
      snoozeInterval: json['snoozeInterval'] as int? ?? 10,
      isSnoozed: json['isSnoozed'] as bool? ?? false,
    );
  }

  final int id;
  final String title; // Added title.
  final DateTime dateTime;
  final String assetAudioPath;
  final NotificationSettings notificationSettings;
  final bool loopAudio;
  final bool vibrate;
  final double? volume;
  final bool volumeEnforced;
  final double fadeDuration;
  final bool warningNotificationOnKill;
  final bool androidFullScreenIntent;
  final List<int> repeatingDays;
  final int snoozeLimit;
  final int snoozeInterval;
  final bool isSnoozed;

  @override
  int get hashCode {
    var hash = 0;

    hash = hash ^ id.hashCode;
    hash = hash ^ title.hashCode; // Include title in hashCode.
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
    hash = hash ^ repeatingDays.hashCode;
    hash = hash ^ snoozeLimit.hashCode;
    hash = hash ^ snoozeInterval.hashCode;
    hash = hash ^ isSnoozed.hashCode;
    hash = hash & 0x3fffffff;

    return hash;
  }

  AlarmSettings copyWith({
    int? id,
    String? title, // Added title to copyWith.
    DateTime? dateTime,
    String? assetAudioPath,
    NotificationSettings? notificationSettings,
    bool? loopAudio,
    bool? vibrate,
    double? volume,
    bool? volumeEnforced,
    double? fadeDuration,
    bool? warningNotificationOnKill,
    bool? androidFullScreenIntent,
    List<int>? repeatingDays,
    int? snoozeLimit,
    int? snoozeInterval,
    bool? isSnoozed,
  }) {
    return AlarmSettings(
      id: id ?? this.id,
      title: title ?? this.title, // Use new or existing title.
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
      repeatingDays: repeatingDays ?? this.repeatingDays,
      snoozeLimit: snoozeLimit ?? this.snoozeLimit,
      snoozeInterval: snoozeInterval ?? this.snoozeInterval,
      isSnoozed: isSnoozed ?? this.isSnoozed,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title, // Add title to JSON serialization.
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
    'repeatingDays': repeatingDays,
    'snoozeLimit': snoozeLimit,
    'snoozeInterval': snoozeInterval,
    'isSnoozed': isSnoozed,
  };
}
