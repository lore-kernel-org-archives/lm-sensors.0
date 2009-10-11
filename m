From: Adam Nielsen <a.nielsen@shikadi.net>
Date: Sun, 11 Oct 2009 13:44:43 +0000
Subject: [lm-sensors] How do you make lm_sensors see a hwmon device?
Message-Id: <4AD1E14B.90604@shikadi.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I've written a driver for a USB device that has a number of sensors on it
(it's a PC power supply with a USB cable for voltage/current monitoring) and
the device appears in the hwmon class.

Unfortunately I can't figure out how to make lm_sensors "see" it (when I run
"sensors" it isn't displayed, and programs like gkrellm that use lm_sensors
don't see the device or its sensors.)  The files all seem to be in the same
place as other devices which work, and I'm running a fairly recent version of
lm_sensors (3.0.3.)

Any ideas how to make my device appear to lm_sensors?

$ ls /sys/class/hwmon/hwmon[45]/device/name
-r--r--r-- 1 root root 4.0K 2009-10-11 22:55 /sys/class/hwmon/hwmon4/device/name
-r--r--r-- 1 root root 4.0K 2009-10-11 23:24 /sys/class/hwmon/hwmon5/device/name

$ cat /sys/class/hwmon/hwmon[45]/device/name
coretemp
odin

$ cat /sys/class/hwmon/hwmon[45]/device/temp1_input
50000
39000

Many thanks,
Adam.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
