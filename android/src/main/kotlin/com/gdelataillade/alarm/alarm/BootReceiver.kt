package com.gdelataillade.alarm.alarm

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import com.gdelataillade.alarm.services.AlarmStorage
import com.gdelataillade.alarm.api.AlarmApiImpl
import com.gdelataillade.alarm.models.AlarmSettings
import java.util.Calendar
import java.util.Date

class BootReceiver : BroadcastReceiver() {
    companion object {
        private const val TAG = "BootReceiver"
    }

    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == Intent.ACTION_BOOT_COMPLETED) {
            Log.d(TAG, "Device rebooted, rescheduling alarms")

            rescheduleAlarms(context)
        }
    }

    private fun rescheduleAlarms(context: Context) {
        val alarmStorage = AlarmStorage(context)
        val storedAlarms = alarmStorage.getSavedAlarms()

        Log.i(TAG, "Rescheduling ${storedAlarms.size} alarms")

        for (alarm in storedAlarms) {
            try {
                val now = Date()
                val alarmToSchedule = if (alarm.dateTime.before(now) && alarm.repeatingDays.isNotEmpty()) {
                    // Repeating alarm with past dateTime: compute next occurrence
                    val nextDate = computeNextRepeatingDateTime(alarm.dateTime, alarm.repeatingDays)
                    Log.d(TAG, "Repeating alarm ${alarm.id}: rescheduling from ${alarm.dateTime} to $nextDate")
                    alarm.copy(dateTime = nextDate)
                } else {
                    alarm
                }

                if (alarmToSchedule.dateTime.after(now)) {
                    Log.d(TAG, "Rescheduling alarm with ID: ${alarmToSchedule.id}")
                    val alarmApi = AlarmApiImpl(context)
                    alarmApi.setAlarm(alarmToSchedule)
                    // Save the updated alarm so Dart side sees the new dateTime
                    alarmStorage.saveAlarm(alarmToSchedule)
                    Log.d(TAG, "Alarm rescheduled successfully for ID: ${alarmToSchedule.id}")
                } else {
                    Log.d(TAG, "Skipping alarm ${alarm.id}: dateTime is in the past and not repeating")
                }
            } catch (e: Exception) {
                Log.e(TAG, "Exception while rescheduling alarm: $alarm", e)
            }
        }
    }

    /**
     * Computes the next valid DateTime for a repeating alarm.
     * Uses ISO weekday numbering: Mon=1 ... Sun=7.
     */
    private fun computeNextRepeatingDateTime(alarmDate: Date, repeatingDays: List<Int>): Date {
        val now = Calendar.getInstance()
        val alarmCal = Calendar.getInstance().apply { time = alarmDate }

        // Start from today at the alarm's hour:minute
        val candidate = Calendar.getInstance().apply {
            set(Calendar.HOUR_OF_DAY, alarmCal.get(Calendar.HOUR_OF_DAY))
            set(Calendar.MINUTE, alarmCal.get(Calendar.MINUTE))
            set(Calendar.SECOND, 0)
            set(Calendar.MILLISECOND, 0)
        }

        for (i in 0..7) {
            val check = (candidate.clone() as Calendar).apply {
                add(Calendar.DAY_OF_YEAR, i)
            }
            // Convert Calendar DAY_OF_WEEK (Sun=1..Sat=7) to ISO (Mon=1..Sun=7)
            val calDow = check.get(Calendar.DAY_OF_WEEK)
            val isoDow = if (calDow == Calendar.SUNDAY) 7 else calDow - 1

            if (repeatingDays.contains(isoDow) && check.time.after(now.time)) {
                return check.time
            }
        }

        // Fallback: tomorrow same time
        candidate.add(Calendar.DAY_OF_YEAR, 1)
        return candidate.time
    }
}