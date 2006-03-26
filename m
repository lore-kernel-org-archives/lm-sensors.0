From: jim.cromie@gmail.com (Jim Cromie)
Date: Sun, 26 Mar 2006 22:49:00 +0000
Subject: [lm-sensors] [patch 1/2] hwmon/pc87360 use SENSOR_ATTR_2 for all
Message-Id: <44271A5C.4080705@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


1. hwmon-pc87360-use-sensor-attr-2.patch

Converts SENSOR_ATTRs to SENSOR_ATTR_2s for all sysfs-callbacks.
Also adds a number of #defines which provide values used to
initialize the sensor_device_attribute_2.nr field for each sensor.

Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>
---
$ diffstat pc-set-uc/hwmon-pc87360-use-sensor-attr-2.patch
 pc87360.c |  492 
++++++++++++++++++++++++++++++++++----------------------------
 1 files changed, 277 insertions(+), 215 deletions(-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-pc87360-use-sensor-attr-2.patch
Type: text/x-patch
Size: 36103 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060327/172b61f3/hwmon-pc87360-use-sensor-attr-2-0001.bin
