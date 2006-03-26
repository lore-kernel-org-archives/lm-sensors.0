From: jim.cromie@gmail.com (Jim Cromie)
Date: Sun, 26 Mar 2006 22:47:13 +0000
Subject: [lm-sensors] [patch 0/2] hwmon/pc87360 shrink object size by
Message-Id: <442719F1.8020408@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jim Cromie <jim.cromie at gmail.com>

Heres 2 patches to shrink object size of hwmon/pc87360 driver


1. hwmon-pc87360-use-sensor-attr-2.patch

Converts SENSOR_ATTRs to SENSOR_ATTR_2s for all sysfs-callbacks.
Also adds a number of #defines which provide values used to
initialize the sensor_device_attr_2.nr field for each sensor.



2. hwmon-pc87360-sysfs-combo-callbacks.patch

This combines individual  (show|set)_Sensor_Attr callbacks into
(show|set)_Sensor callbacks that handle all that Sensor's Attrs.
The callback routines use the .nr field to determine what attribute
they were called for.


Combining callbacks results in a non-trivial size reduction (b4, after)
14588    3224      16   17828    45a4 A-2/drivers/hwmon/pc87360.ko
13124    3224      16   16364    3fec A-3/drivers/hwmon/pc87360.ko
ie about 9%


Combining all show_X (for all X) together is possible, but would 
compromise clarity, and would save only ~ 1/5 th additional space.


These were tested against 2.6.16 + 4 patches from -mm1
(-mm1 is panic'g at boot on this NFS-root box)


Id like to see these get into -mm2

