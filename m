From: jim.cromie@gmail.com (Jim Cromie)
Date: Thu, 26 Jan 2006 19:17:59 +0000
Subject: [lm-sensors] [patch 0/2] hwmon/pc87360: combine sysfs callbacks
Message-Id: <43D92067.9010109@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jim Cromie <jim.cromie at gmail.com>

1. hwmon-pc87360-use-sensor-attr-2.patch

This converts SENSOR_ATTRs to SENSOR_ATTR_2s,
and add a bunch of #defines for the new member's values. 

2. hwmon-pc87360-sysfs-combo-callbacks.patch

This combines individual  (show|set)_Sensor_Attr callbacks into
(show|set)_Sensor callbacks that handle all that Sensor's Attrs.

this results in a non-trivial size reduction (b4, after)
 14588    3224      16   17828    45a4 A-2/drivers/hwmon/pc87360.ko
 13124    3224      16   16364    3fec A-3/drivers/hwmon/pc87360.ko
ie about 10%

Combining all show_X (for all X) together is possible, but would 
compromise clarity,
and would save only ~ 1/5 th additional space.


Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>
---


