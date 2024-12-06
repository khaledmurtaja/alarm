import 'package:alarm/model/notification_settings.dart';
import 'package:alarm/src/generated/platform_bindings.g.dart';
import 'package:flutter/widgets.dart';

/// [AlarmSettings] is a model that contains all the settings to customize
/// and set an alarm.
@immutable
class AlarmSettings {
  const AlarmSettings({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.assetAudioPath,
    required this.audioName, // New property for audio name.
    required this.notificationSettings,
    this.loopAudio = true,
    this.vibrate = true,
    this.volume,
    this.volumeEnforced = false,
    this.fadeDuration = 0.0,
    this.warningNotificationOnKill = true,
    this.androidFullScreenIntent = true,
    this.repeatingDays = const [],
    this.mission,
    this.snoozeLimit = 5,
    this.changeableSnoozeLimit = 5,
    this.snoozeInterval = 10,
    this.couldBeSnoozed = false,
    this.isEnabled = true,
  });

  /// Converts from wire datatype.
  AlarmSettings.fromWire(
      AlarmSettingsWire wire,
      this.title,
      this.audioName,
      this.repeatingDays,
      this.mission,
      this.snoozeLimit,
      this.changeableSnoozeLimit,
      this.snoozeInterval,
      this.couldBeSnoozed,
      this.isEnabled)
      : id = wire.id,
        dateTime =
            DateTime.fromMillisecondsSinceEpoch(wire.millisecondsSinceEpoch),
        assetAudioPath = wire.assetAudioPath,
        notificationSettings =
            NotificationSettings.fromWire(wire.notificationSettings),
        loopAudio = wire.loopAudio,
        vibrate = wire.vibrate,
        volume = wire.volume,
        volumeEnforced = wire.volumeEnforced,
        fadeDuration = wire.fadeDuration,
        warningNotificationOnKill = wire.warningNotificationOnKill,
        androidFullScreenIntent = wire.androidFullScreenIntent;

  /// Constructs an `AlarmSettings` instance from the given JSON data.
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
      title: json['title'] as String? ?? '',
      dateTime: DateTime.fromMicrosecondsSinceEpoch(json['dateTime'] as int),
      assetAudioPath: json['assetAudioPath'] as String,
      audioName: json['audioName'] as String? ?? '', // Parse new property.
      notificationSettings: notificationSettings,
      loopAudio: json['loopAudio'] as bool? ?? true,
      mission: json['mission'] as int?,
      vibrate: json['vibrate'] as bool? ?? true,
      volume: json['volume'] as double?,
      volumeEnforced: json['volumeEnforced'] as bool? ?? false,
      fadeDuration: json['fadeDuration'] as double? ?? 0.0,
      warningNotificationOnKill: warningNotificationOnKill,
      androidFullScreenIntent: json['androidFullScreenIntent'] as bool? ?? true,
      repeatingDays:
          (json['repeatingDays'] as List<dynamic>?)?.cast<int>() ?? [],
      snoozeLimit: json['snoozeLimit'] as int? ?? 5,
      changeableSnoozeLimit: json['changeableSnoozeLimit'] as int? ?? 5,
      snoozeInterval: json['snoozeInterval'] as int? ?? 10,
      couldBeSnoozed: json['isSnoozed'] as bool? ?? false,
      isEnabled: json['isEnabled'] as bool? ?? true,
    );
  }

  final int id;
  final String title;
  final DateTime dateTime;
  final String assetAudioPath;
  final String audioName; // New property.
  final NotificationSettings notificationSettings;
  final bool loopAudio;
  final bool vibrate;
  final double? volume;
  final bool volumeEnforced;
  final double fadeDuration;
  final bool warningNotificationOnKill;
  final bool androidFullScreenIntent;
  final List<int> repeatingDays;

  ///missions before turning the alarm off
  final int? mission;

  ///this value should not be changed during the application
  final int snoozeLimit;

  /// Converts to wire datatype which is used for host platform communication.
  AlarmSettingsWire toWire() => AlarmSettingsWire(
        id: id,
        millisecondsSinceEpoch: dateTime.millisecondsSinceEpoch,
        assetAudioPath: assetAudioPath,
        notificationSettings: notificationSettings.toWire(),
        loopAudio: loopAudio,
        vibrate: vibrate,
        volume: volume,
        volumeEnforced: volumeEnforced,
        fadeDuration: fadeDuration,
        warningNotificationOnKill: warningNotificationOnKill,
        androidFullScreenIntent: androidFullScreenIntent,
      );

  /// Returns a hash code for this `AlarmSettings` instance using
  /// Jenkins hash function.
  ///this could be changed during processing
  final int changeableSnoozeLimit;
  final int snoozeInterval;
  final bool couldBeSnoozed;
  final bool isEnabled;

  @override
  int get hashCode {
    var hash = 0;

    hash = hash ^ id.hashCode;
    hash = hash ^ title.hashCode;
    hash = hash ^ dateTime.hashCode;
    hash = hash ^ assetAudioPath.hashCode;
    hash = hash ^ audioName.hashCode; // Include new property.
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
    hash = hash ^ couldBeSnoozed.hashCode;
    hash = hash ^ mission.hashCode;
    hash = hash ^ isEnabled.hashCode;
    hash = hash ^ changeableSnoozeLimit.hashCode;
    hash = hash & 0x3fffffff;

    return hash;
  }

  AlarmSettings copyWith({
    int? id,
    String? title,
    DateTime? dateTime,
    String? assetAudioPath,
    String? audioName, // Add copyWith for new property.
    NotificationSettings? notificationSettings,
    bool? loopAudio,
    bool? vibrate,
    double? volume,
    bool? volumeEnforced,
    double? fadeDuration,
    bool? warningNotificationOnKill,
    bool? androidFullScreenIntent,
    List<int>? repeatingDays,
    int? mission,
    int? snoozeLimit,
    int? changeableSnoozeLimit,
    int? snoozeInterval,
    bool? isSnoozed,
    bool? isEnabled,
  }) {
    return AlarmSettings(
      id: id ?? this.id,
      title: title ?? this.title,
      dateTime: dateTime ?? this.dateTime,
      assetAudioPath: assetAudioPath ?? this.assetAudioPath,
      audioName: audioName ?? this.audioName, // Handle new property.
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
      mission: mission ?? this.mission,
      snoozeLimit: snoozeLimit ?? this.snoozeLimit,
      changeableSnoozeLimit:
          changeableSnoozeLimit ?? this.changeableSnoozeLimit,
      snoozeInterval: snoozeInterval ?? this.snoozeInterval,
      couldBeSnoozed: isSnoozed ?? this.couldBeSnoozed,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'dateTime': dateTime.microsecondsSinceEpoch,
        'assetAudioPath': assetAudioPath,
        'audioName': audioName, // Serialize new property.
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
        'changeableSnoozeLimit': changeableSnoozeLimit,
        'mission': mission,
        'snoozeInterval': snoozeInterval,
        'isSnoozed': couldBeSnoozed,
        'isEnabled': isEnabled,
      };
}
