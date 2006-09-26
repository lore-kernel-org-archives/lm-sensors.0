From: jim.cromie@gmail.com (Jim Cromie)
Date: Tue, 26 Sep 2006 17:30:23 +0000
Subject: [lm-sensors] issue with clearing alarms
Message-Id: <451963AF.6050403@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <450312F6.4030500@gmail.com>
In-Reply-To: <450312F6.4030500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Jim,
>
>   
> To me, "new data not yet read" simply means that at least one sampling
> cycle was completed since our last read. There's nothing wrong with
> that, as the chip samples its inputs continuously and we only read the
> values from times to times.
>
>   


Looking again, I see a point of confusion at least, and a possible problem.
It may be one of interpretation, but is worth checking, and possibly 
documenting.

The *not-yet-read* property pertains to the scan done by update_device(),
since thats what reads all sensors the driver supports.
But its easy to misconstrue not-yet-read as a property on the individual 
alarms.

More importantly, any single read of any property will clear unrelated 
alarms.
Let me demonstrate:

1- raise then lower the min setting, then check the alarm,
    which is (properly) on.  A 2nd read shows it cleared. (also proper)

soekris:/sys/devices/platform/i2c-9191/9191-6620# echo 1500 > in8_min
soekris:/sys/devices/platform/i2c-9191/9191-6620# echo 1400 > in8_min
soekris:/sys/devices/platform/i2c-9191/9191-6620# cat in8_min_alarm
2
soekris:/sys/devices/platform/i2c-9191/9191-6620# cat in8_min_alarm
0

2- repeat raise & lower, then read an *unrelated* attr
    now 1st read of in8_min_alarm shows 0, the alarm state has been *missed*

soekris:/sys/devices/platform/i2c-9191/9191-6620# echo 1500 > in8_min
soekris:/sys/devices/platform/i2c-9191/9191-6620# echo 1400 > in8_min
soekris:/sys/devices/platform/i2c-9191/9191-6620# cat in2_min_alarm
0
soekris:/sys/devices/platform/i2c-9191/9191-6620# cat in8_min_alarm
0

3- redo test 2, this time reading a setting, then reading alarm.  its 
off, should be on.
    this time, its a readback of config value, which doensnt *need* to 
trigger a scan,
    but does cuz its simpler (I guess)

soekris:/sys/devices/platform/i2c-9191/9191-6620# echo 1500 > in8_min
soekris:/sys/devices/platform/i2c-9191/9191-6620# echo 1400 > in8_min
soekris:/sys/devices/platform/i2c-9191/9191-6620# cat in8_min
1394
soekris:/sys/devices/platform/i2c-9191/9191-6620# cat in8_min_alarm
0




IOW, 2 reads of any 2 sysfs-files, separated by this much time, will 
reset the alarm,
even though userspace has never seen the alarm.

    if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
        dev_dbg(&client->dev, "Data update\n");




So, with the usual caveats (Ive done something wrong, immature code, etc)
I see a few possibilities:

1 - Document the fact - tell users not to do that.
    this isnt unreasonable, and far simpler..
2 - sensors-deamon locks the directory to preclude loss of alarms (is 
this possible ? bad idea ?)
3 - dunno

