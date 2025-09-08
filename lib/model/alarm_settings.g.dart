// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlarmSettings _$AlarmSettingsFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'AlarmSettings',
      json,
      ($checkedConvert) {
        final val = AlarmSettings(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          title: $checkedConvert('title', (v) => v as String),
          dateTime:
              $checkedConvert('dateTime', (v) => DateTime.parse(v as String)),
          assetAudioPath: $checkedConvert('assetAudioPath', (v) => v as String),
          audioName: $checkedConvert('audioName', (v) => v as String),
          volumeSettings: $checkedConvert('volumeSettings',
              (v) => VolumeSettings.fromJson(v as Map<String, dynamic>)),
          notificationSettings: $checkedConvert('notificationSettings',
              (v) => NotificationSettings.fromJson(v as Map<String, dynamic>)),
          loopAudio: $checkedConvert('loopAudio', (v) => v as bool? ?? true),
          vibrate: $checkedConvert('vibrate', (v) => v as bool? ?? true),
          warningNotificationOnKill: $checkedConvert(
              'warningNotificationOnKill', (v) => v as bool? ?? true),
          androidFullScreenIntent: $checkedConvert(
              'androidFullScreenIntent', (v) => v as bool? ?? true),
          allowAlarmOverlap:
              $checkedConvert('allowAlarmOverlap', (v) => v as bool? ?? false),
          iOSBackgroundAudio:
              $checkedConvert('iOSBackgroundAudio', (v) => v as bool? ?? true),
          androidStopAlarmOnTermination: $checkedConvert(
              'androidStopAlarmOnTermination', (v) => v as bool? ?? true),
          payload: $checkedConvert('payload', (v) => v as String?),
          repeatingDays: $checkedConvert(
              'repeatingDays',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => (e as num).toInt())
                      .toList() ??
                  const []),
          mission: $checkedConvert('mission', (v) => (v as num?)?.toInt()),
          snoozeLimit:
              $checkedConvert('snoozeLimit', (v) => (v as num?)?.toInt() ?? 5),
          changeableSnoozeLimit: $checkedConvert(
              'changeableSnoozeLimit', (v) => (v as num?)?.toInt() ?? 5),
          snoozeInterval: $checkedConvert(
              'snoozeInterval', (v) => (v as num?)?.toInt() ?? 10),
          couldBeSnoozed:
              $checkedConvert('couldBeSnoozed', (v) => v as bool? ?? false),
          isEnabled: $checkedConvert('isEnabled', (v) => v as bool? ?? true),
        );
        return val;
      },
    );

Map<String, dynamic> _$AlarmSettingsToJson(AlarmSettings instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dateTime': instance.dateTime.toIso8601String(),
      'assetAudioPath': instance.assetAudioPath,
      'volumeSettings': instance.volumeSettings.toJson(),
      'notificationSettings': instance.notificationSettings.toJson(),
      'loopAudio': instance.loopAudio,
      'vibrate': instance.vibrate,
      'warningNotificationOnKill': instance.warningNotificationOnKill,
      'androidFullScreenIntent': instance.androidFullScreenIntent,
      'allowAlarmOverlap': instance.allowAlarmOverlap,
      'iOSBackgroundAudio': instance.iOSBackgroundAudio,
      'androidStopAlarmOnTermination': instance.androidStopAlarmOnTermination,
      if (instance.payload case final value?) 'payload': value,
      'repeatingDays': instance.repeatingDays,
      if (instance.mission case final value?) 'mission': value,
      'snoozeLimit': instance.snoozeLimit,
      'audioName': instance.audioName,
      'title': instance.title,
      'changeableSnoozeLimit': instance.changeableSnoozeLimit,
      'snoozeInterval': instance.snoozeInterval,
      'couldBeSnoozed': instance.couldBeSnoozed,
      'isEnabled': instance.isEnabled,
    };
