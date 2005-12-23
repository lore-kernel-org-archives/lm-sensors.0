From: jim.cromie@gmail.com (Jim Cromie)
Date: Fri, 23 Dec 2005 02:38:13 +0000
Subject: [lm-sensors] [PATCH]  add SENSOR_ATTR_2 to hwmon-sysfs.h
Message-Id: <43AB6315.1010407@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


add SENSOR_ATTR_2 to complement  SENSOR_ATTR.
This is needed for reworking w83792d.c to use sensor-attr-arrays,
and perhaps others.

Signed-off-by:   Jim Cromie <jim.cromie at gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-sensor-attr-array-2.patch
Type: text/x-patch
Size: 950 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051223/984f08df/hwmon-sensor-attr-array-2.bin
