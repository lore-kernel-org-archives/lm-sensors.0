From: "Andrew Lyon" <andrew.lyon@gmail.com>
Date: Sat, 04 Oct 2008 17:27:04 +0000
Subject: [lm-sensors] kernel 2.6.27-rc8-git6 system lockup possibly caused
Message-Id: <f4527be0810041027r490a27e5u44575bcf6af92a7e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I am running kernel 2.6.27-rc8-git6 on a supermicro x7dwa-n system, I
have w83793, coretemp, and i5k_amb sensor modules loaded, occasionally
the system locks up hard requiring reset button to reboot it, this
usually happens after a few days of uptime and has never happened less
than 24 hours after bootup,  I have sensord running and noticed today
that the log output changes just before it locks up, which makes me
wonder if reading the sensors is the cause...

The board has 8 fan connections of which 5 are currently used, the
w83793 sensors show 10 fan outputs, I plan to add 2 more fans next
week as the hot swap drive bay has slots for 4 but only comes with 2,
I have not disabled any of the fan sensors in the config file so every
minute sensord logs alarms for the unused fans:

Oct  4 16:34:06 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan9: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:34:06 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan10: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:35:07 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan1: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:35:07 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan4: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:35:07 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan5: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:35:07 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan9: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:35:07 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan10: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:36:07 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan1: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:36:07 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan4: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:36:07 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan5: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:36:07 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan9: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:36:07 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan10: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:37:07 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan1: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:37:07 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan4: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:37:07 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan5: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:37:07 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan9: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:37:07 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan10: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:38:08 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan1: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:38:08 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan4: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:38:08 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan5: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:38:08 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan9: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:38:08 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan10: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:39:10 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan1: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:39:10 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan4: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:39:10 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan5: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:39:10 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan9: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:39:10 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan10: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:40:10 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan1: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:40:10 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan4: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:40:10 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan5: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:40:10 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan9: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:40:10 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan10: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:41:11 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan1: 0 RPM (min = 712 RPM) [ALARM]
Oct  4 16:41:11 supermicro sensord: Sensor alarm: Chip
w83793-i2c-0-2f: fan4: 0 RPM (min = 712 RPM) [ALARM]

right in the middle of a batch of alarm events the log output changes,
and these were the last events logged to the serial console before the
system locked up:


Oct  4 16:41:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan5: 0
Oct  4 16:41:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan9: 0
Oct  4 16:41:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan10: 0
Oct  4 16:42:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan1: 0
Oct  4 16:42:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan4: 0
Oct  4 16:42:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan5: 0
Oct  4 16:42:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan9: 0
Oct  4 16:42:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan10: 0
Oct  4 16:43:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan1: 0
Oct  4 16:43:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan4: 0
Oct  4 16:43:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan5: 0
Oct  4 16:43:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan9: 0
Oct  4 16:43:11 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan10: 0
Oct  4 16:44:13 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan1: 0
Oct  4 16:44:13 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan4: 0
Oct  4 16:44:13 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan5: 0
Oct  4 16:44:13 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan9: 0
Oct  4 16:44:13 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan10: 0
Oct  4 16:45:14 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan1: 0
Oct  4 16:45:14 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan4: 0
Oct  4 16:45:14 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan5: 0
Oct  4 16:45:14 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan9: 0
Oct  4 16:45:14 supermicro sensord: Sensor alarm: Chip w83793-i2c-0-2f: fan10: 0

as you can see part of the usual event is missing, the "RPM (min = 712
RPM) [ALARM]" that was visible on previous events has gone, very
strange.

i will try running the system with these modules unloaded but I
wondered if this was a known issue that has already been fixed?

Andy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
