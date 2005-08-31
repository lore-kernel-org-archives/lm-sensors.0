From: jim.cromie@gmail.com (jim.cromie@gmail.com)
Date: Wed, 31 Aug 2005 00:42:32 +0000
Subject: [lm-sensors] [patch 0/6] pc87360 SDA (sensor-dev-attr) callbacks -
Message-Id: <200508302241.j7UMfQjF007933@harpo.jimc.earth>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch set reworks hwmon/pc87360.c to use the SENSOR_DEVICE_ATTR
idiom by Yani Iannou, then uses the new member field to distinguish
which device is being accessed, eliminating the need for macro'd
repetition of a bunch of sysfs callback routines.

These patches are updated for 2.6.13 release, with minor header
adjustments.

The patches, Step-by-Step:

individual patches follow separately, but not in reply to this
(scripted send to avoid MIME attachments).  Also pls tolerate the
X-spam headers, the scripts Ive seen dont handle TLS, so I cant send
thru my normal mail-service.


01	i2c-pc87360-01-yani-callback-form.patch

a) Change DEVICE_ATTR declarations to SENSOR_DEVICE_ATTR declarations,
which have an additional index member

b) Rework sysfs-callbacks (embedded in macros) to use
to_sensor_dev_attr to do a typesefe conversion of a *device_attribute
to a *sensor_device_attribute.  Use the index member instead of the
offset macro-arg to access the right sensor.

c) Change the calls to device_create_file() to dereference the
sensor_device_attribute to pass its device_attribute member

d) added includes

Note that this change (DA -> SDA) isnt indiscriminate.  Only those
attrs that would benefit from having an index have been converted; ie
those which are macro-repeated.

 pc87360.c |  432 +++++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 231 insertions(+), 201 deletions(-)


02	i2c-pc87360-02-fn-renames.patch

Several of the macro-d functions rely on the ##offset## in the name to
disambiguate them from others, this patch alters the names so we can
drop the ##offset## in the next patch.

 pc87360.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)


03.	i2c-pc87360-03-attr-callback-demacro.patch

Convert macro-repeated callback-fns to single declaration.  They're
already using attr->index (patch 1), and are disambiguated (patch 2),
so this is as close as possible to a white-space patch.

 pc87360.c |  586 +++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 296 insertions(+), 290 deletions(-)


04.	i2c-pc87360-04-mv-offset-skew-2-init.patch

The temp, therm, fan, pwm callbacks all have an offset skew in the
code which accommodates attribute numbering conventions under
/sys/bus/i2c/devices/9191-6620/ (ie they start at 1)

This patch moves that skew into the declaration, and out of the
functions (except for therm, where we simplify from 2 skews to 1).
The declarative skew is clearer, less error-prone, and more efficient.

 pc87360.c |  104 +++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 52 insertions(+), 52 deletions(-)


05.	i2c-pc87360-05-hwmon-sysfs-array-init.patch

This patch refactors SENSOR_DEVICE_ATTR macro.  1st it creates a new
macro __SENSOR_DEVICE_ATTR() which expands to an initialization
expression, then it uses that in SENSOR_DEVICE_ATTR, which declares
and initializes a struct sensor_device_attribute.

__SENSOR_DEVICE_ATTR() imitates __ATTR in include/linux/device.h

 hwmon-sysfs.h |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)


06.	i2c-pc87360-06-array-init-loop.patch

With __SENSOR_DEVICE_ATTR's defined by 05, we now use them to
initialize a whole array of struct sensor_device_attributes.  This
allows us to loop over the array, and call device_create_file() for
each element.

 pc87360.c |  349 ++++++++++++++++++++++++++++----------------------------------
 1 files changed, 162 insertions(+), 187 deletions(-)


The 6 patches each incrementally; apply and compile clean, and pass
this cursory test: 
	rmmod pc87360; 
	make modules_install; 
	modprobe pc87360;
	sensors -s; 
	sensors

sets on alarm thresholds also change alarm state.

Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>
