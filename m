From: jim.cromie@gmail.com (Jim Cromie)
Date: Sun, 08 Oct 2006 16:30:01 +0000
Subject: [lm-sensors] [patch] hwmon-sysfs.h: add _RO and _RW versions of
Message-Id: <45292789.5000003@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi Jean,

1st attachment adds _RO and _RW versions to the following macros:
SENSOR_ATTR, SENSOR_DEVICE_ATTR,
SENSOR_ATTR_2, SENSOR_DEVICE_ATTR_2,

with these defined, the script (2nd attachment) will convert ~800 uses
(in 17 files) to the correct _RO/_RW version, and remove the linewraps.
The results compile cleanly (all modules in hwmon).

Is this something you'd consider applying ? If so, when ?
Theres obvious timing issues - since this patch touches many drivers, 
which may have
work in-queue (yours or other hackers').  Its also why I sent the script 
- the patch
it yields is 94KB, so the script is far more inspectable, and with the 
script, you
can chose the optimal time(s) w/o synchronization hassles.
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: diff.ro-rw.20061008.094436
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061008/b684751b/attachment.pl 
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: ro-rw-change
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061008/b684751b/attachment-0001.pl 
