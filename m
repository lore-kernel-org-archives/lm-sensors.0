From: jim.cromie@gmail.com (Jim Cromie)
Date: Thu, 26 Jan 2006 19:57:31 +0000
Subject: [lm-sensors] [patch 2/2] hwmon/pc87360: combine sysfs callbacks
Message-Id: <43D929AB.9060508@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jim Cromie <jim.cromie at gmail.com>

2. hwmon-pc87360-sysfs-combo-callbacks.patch

This combines individual  (show|set)_Sensor_Attr callbacks into
(show|set)_Sensor callbacks that handle all that Sensor's Attrs,
based upon value in sensor_device_attribute_2.nr

Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>
---

diffstat hwmon-pc87360-sysfs-combo-callbacks.patch
 pc87360.c |  545 
+++++++++++++++++++++++++++-----------------------------------
 1 files changed, 246 insertions(+), 299 deletions(-)

patch yields a non-trivial size reduction (b4, after)
 14588    3224      16   17828    45a4 A-2/drivers/hwmon/pc87360.ko
 13124    3224      16   16364    3fec A-3/drivers/hwmon/pc87360.ko
ie about 10%

Combining all show_X (for all X) together is possible, but would 
compromise clarity,
(ie the separation of the sensor code) and would save only ~ 1/5 th 
additional space.


-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-pc87360-sysfs-combo-callbacks.patch
Type: text/x-patch
Size: 31627 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060126/ff45db23/hwmon-pc87360-sysfs-combo-callbacks-0001.bin
