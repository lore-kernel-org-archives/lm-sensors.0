From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 03 Aug 2006 19:01:02 +0000
Subject: [lm-sensors] Adding userspace support for ipmisensors
Message-Id: <253818670608031201l3e101782r5d1012900ddecdf8@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean & all,

I have a stablish working ipmisensors driver (the bmcsensors re-write
for kernel 2.6/hwmon - see
http://bmcsensors-26.sourceforge.net/ipmisensors/ for patches), and
I'm tyring to add support to libsensors and sensors for testing. As
far as I can tell the following patch should work, however after
applying it I still can't see the sensors (yet the entries do appear
in /sys/class/hwmon/hwmon0/*). Any help would be appreciated (as you
can tell I'm new to the userspace side ;)

I do have some other concerns/ideas on support ipmisensors would be
looking for in libsensors, and considering a possible re-write I feel
I should list these now.

- fixed number of sensors
ipmisensors has a dynamic ("hotplug" sensors not supported at runtime
at the moment) and unknown number of sensors. As far as I can tell
libsensors needs to know a fixed number.
- labels given
ipmisensors gives the BMC's labels for each sensors in a "label"
entry. This should be easy to add support for (perhaps defaulting to
these labels without user configured labels).
- binary sensors
IPMI supports "non-threshold sensors" for things like power status,
chassis intrusion, etc, which are basically binary valued. I plan to
add support for these to the driver, but do these belong in lm-sensors
and how hard would it be to add support for them to libsensors?

Thanks,
Yani



------------------------------------------------
+++ lib/chips.c	(working copy)
@@ -5919,6 +5919,7 @@
  { SENSORS_LM92_PREFIX, lm92_features },
  { SENSORS_VT8231_PREFIX, vt8231_features },
  { SENSORS_BMC_PREFIX, bmc_features },
+ { SENSORS_IPMI_PREFIX, bmc_features },
  { SENSORS_LM85_PREFIX, lm85_features },
  { SENSORS_LM85B_PREFIX, lm85_features },
  { SENSORS_LM85C_PREFIX, lm85_features },
Index: lib/chips.h
=================================--- lib/chips.h	(revision 4081)
+++ lib/chips.h	(working copy)
@@ -1969,6 +1969,7 @@
  #define SENSORS_VT8231_VRM 83 /* RW */
  #define SENSORS_VT8231_UCH 84 /* RW */

+#define SENSORS_IPMI_PREFIX "ipmi"
  #define SENSORS_BMC_PREFIX "bmc"

 /* quantity of each sensor is unknown, so just define the
Index: prog/sensors/main.c
=================================--- prog/sensors/main.c	(revision 4081)
+++ prog/sensors/main.c	(working copy)
@@ -398,6 +398,7 @@
 	{ "lm92", print_lm92 },
 	{ "vt8231", print_vt8231 },
  	{ "bmc", print_bmc },
+	{ "ipmi", print_bmc },
 	{ "adm1026", print_adm1026 },
 	{ "lm83", print_lm83 },
 	{ "lm90", print_lm90 },

