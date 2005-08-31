From: jim.cromie@gmail.com (Jim Cromie)
Date: Wed, 31 Aug 2005 20:29:25 +0000
Subject: [lm-sensors] [patch-A 0/5] pc87360 SDA (sensor-dev-attr) callbacks
Message-Id: <200508311827.j7VIRZ52006806@harpo.jimc.earth>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch set reworks hwmon/pc87360.c to use the SENSOR_DEVICE_ATTR
idiom by Yani Ioannou, then uses the new member field to distinguish
which device is being accessed, eliminating the need for macro'd
repetition of a bunch of sysfs callback routines.

These patches apply to 2.6.13 + 

http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-02-i2c-2.6.13.patch


The patches, Step-by-Step:

individual patches follow separately, but not in reply to this
(scripted send to avoid MIME attachments).


01	i2c-pc87360-sda-01-yani-callback-form.patch

a) Change DEVICE_ATTR declarations to SENSOR_DEVICE_ATTR declarations,
which have an additional index member

b) Rework sysfs-callbacks (embedded in macros) to use
to_sensor_dev_attr to do a typesefe conversion of a *device_attribute
to a *sensor_device_attribute.  Use the index member instead of the
offset macro-arg to access the right sensor.

c) Change the calls to device_create_file() to dereference the
sensor_device_attribute to pass its device_attribute member

d) added #include <hwmon-sysfs.h>

Note that this change (DA -> SDA) isnt indiscriminate.  Only those
attrs that would benefit from having an index have been converted; ie
those which are macro-repeated.


02	i2c-pc87360-sda-02-fn-renames.patch

Several of the macro-d functions rely on the ##offset## in the name to
disambiguate them from others, this patch alters the names so we can
drop the ##offset## in the next patch.


03.	i2c-pc87360-sda-03-attr-callback-demacro.patch

Convert macro-repeated callback-fns to single declaration.  They're
already using attr->index (patch 1), and are disambiguated (patch 2),
so this is as close as possible to a white-space patch.


04.	i2c-pc87360-sda-04-mv-offset-skew-to-init.patch

The temp, therm, fan, pwm callbacks all have an offset skew in the
code which accommodates attribute numbering conventions under
/sys/bus/i2c/devices/9191-6620/ (ie they start at 1)

This patch moves that skew into the declaration, and out of the
functions (except for therm, where we simplify from 2 skews to 1).
The declarative skew is clearer, less error-prone, and more efficient.


05.	i2c-pc87360-sda-05-consolidate-fan-helper.patch

This patch consolidates the _set_fan_min() helper routine into the 2
line sysfs-callback wrapper that uses it.




[jimc@harpo pset-pc87360-sda]$ diffstat i2c-pc87360-sda-0*
 B-1/drivers/hwmon/pc87360.c |  444 +++++++++++++++++----------------
 B-2/drivers/hwmon/pc87360.c |   30 +-
 B-3/drivers/hwmon/pc87360.c |  586 ++++++++++++++++++++++----------------------
 B-4/drivers/hwmon/pc87360.c |  112 ++++----
 B-5/drivers/hwmon/pc87360.c |   56 +---
 5 files changed, 630 insertions(+), 598 deletions(-)

and cumulative:

[jimc@harpo i2c-stuff]$ diffstat diff.SDA.20050831.113244
 pc87360.c |  792 ++++++++++++++++++++++++++++++++------------------------------
 1 files changed, 412 insertions(+), 380 deletions(-)


heres ko size with debug on:

[jimc@harpo i2c-stuff]$ ll B-*/drivers/hwmon/pc87360.ko
-rw-rw-r--  1 jimc jimc 254091 Aug 31 10:27 B-1/drivers/hwmon/pc87360.ko
-rw-rw-r--  1 jimc jimc 254140 Aug 31 10:29 B-2/drivers/hwmon/pc87360.ko
-rw-rw-r--  1 jimc jimc 161933 Aug 31 10:31 B-3/drivers/hwmon/pc87360.ko
-rw-rw-r--  1 jimc jimc 161933 Aug 31 10:31 B-4/drivers/hwmon/pc87360.ko
-rw-rw-r--  1 jimc jimc 161740 Aug 31 10:32 B-5/drivers/hwmon/pc87360.ko

and with all i2c & hwmon debug off:  (small difference)

[jimc@harpo i2c-stuff]$ ll C-*/drivers/hwmon/pc87360.ko
-rw-rw-r--  1 jimc jimc 250211 Aug 31 11:50 C-1/drivers/hwmon/pc87360.ko
-rw-rw-r--  1 jimc jimc 250260 Aug 31 11:50 C-2/drivers/hwmon/pc87360.ko
-rw-rw-r--  1 jimc jimc 158053 Aug 31 11:51 C-3/drivers/hwmon/pc87360.ko
-rw-rw-r--  1 jimc jimc 158053 Aug 31 11:51 C-4/drivers/hwmon/pc87360.ko
-rw-rw-r--  1 jimc jimc 157856 Aug 31 11:52 C-5/drivers/hwmon/pc87360.ko



The 5 patches each incrementally; apply and compile clean, and pass
this cursory test: 
	rmmod pc87360; 
	make modules_install; 
	modprobe pc87360;
	sensors -s; 
	sensors;
	ls /sys/bus/i2c/devices/9191-6620/


Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>

