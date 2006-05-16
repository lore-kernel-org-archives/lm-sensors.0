From: jim.cromie@gmail.com (Jim Cromie)
Date: Tue, 16 May 2006 17:40:33 +0000
Subject: [lm-sensors] [ patch 0/3 ]  hwmon/pc87360 maintainership,
Message-Id: <446A0E91.5020207@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


heres 3 patches to pc87360 driver, to;

- take maintainership.  I missed Jean's drop.
- switch to use SENSOR_ATTR_2
- switch to use combo-callbacks that key on the new .nr field.

the 2nd, 3rd were previously sent, on 1/26/06, and not
commented-upon ^H changed since then.
Ive revalidated them against 17-rc3-mm1.
Will resend ;-)

1. hwmon-pc87360-maintainer.patch
    the bribe, as it were.
    thanks for authoring this driver Jean.

2. hwmon-pc87360-use-sensor-attr-2.patch

Converts SENSOR_ATTRs to SENSOR_ATTR_2s for all sysfs-callbacks.
Also adds a number of #define FN_$(SENSOR)_($ATTR)s which provide
symbolic values used in the sensor array initializations.

3. hwmon-pc87360-sysfs-combo-callbacks.patch

This combines individual  (show|set)_Sensor_Attr callbacks into
(show|set)_Sensor callbacks that handle all that Sensor's Attrs.
The callback routines use the .nr field to determine what attribute
they were called for.


Combining callbacks results in a non-trivial size reduction (b4, after)
14588    3224      16   17828    45a4 A-2/drivers/hwmon/pc87360.ko
13124    3224      16   16364    3fec A-3/drivers/hwmon/pc87360.ko
ie about 9%

I also, like Juerg Haefliger, think theyre clearer, which is why Ive
ccd Rudolf.  I hope he'll agree ;-)


