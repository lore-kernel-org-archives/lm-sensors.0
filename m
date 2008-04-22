From: Zhang Rui <rui.zhang@intel.com>
Date: Tue, 22 Apr 2008 00:50:09 +0000
Subject: Re: [lm-sensors] [PATCH 4/6] thermal: update the documentation
Message-Id: <1208825410.3550.14.camel@rzhang-1.sh.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1207815421.27304.42.camel@acpi-hp-zz.sh.intel.com>
	 <20080416223517.1ca7d2df@hyperion.delvare>
	 <1208765230.3550.4.camel@rzhang-1.sh.intel.com>
	 <20080421113328.294b4fc3@hyperion.delvare>
In-Reply-To: <20080421113328.294b4fc3@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Len Brown <lenb@kernel.org>, Hans de Goede <j.w.r.degoede@hhs.nl>, linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>


On Mon, 2008-04-21 at 17:33 +0800, Jean Delvare wrote:
> Hi Rui,
> 
> On Mon, 21 Apr 2008 16:07:10 +0800, Zhang Rui wrote:
> > Update the documentation for the thermal driver hwmon sys I/F.
> >
> > Change the ACPI thermal zone type to be consistent with hwmon.
> >
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  Documentation/thermal/sysfs-api.txt |   33
> > +++++++++++++++++++++++++++------
> >  drivers/acpi/thermal.c              |    2 +-
> >  2 files changed, 28 insertions(+), 7 deletions(-)
> >
> > Index: old-git/Documentation/thermal/sysfs-api.txt
> > =================================> > --- old-git.orig/Documentation/thermal/sysfs-api.txt  2008-04-21
> > 15:16:05.000000000 +0800
> > +++ old-git/Documentation/thermal/sysfs-api.txt       2008-04-21
> > 15:20:59.000000000 +0800
> > @@ -108,10 +108,12 @@
> >  RO   read only value
> >  RW   read/write value
> > 
> > -All thermal sysfs attributes will be represented
> > under /sys/class/thermal
> 
> For some reason your mailer wrapped long lines on this patch, so it
> doesn't apply. I guess you'll have to fix that and resend so that Len
> can pick your patch.
> 
> > +Thermal sysfs attributes will be represented
> under /sys/class/thermal.
> > +Hwmon sysfs I/F extension is also available under /sys/class/hwmon
> > +if hwmon is compiled in or built as a module.
> > 
> >  Thermal zone device sys I/F, created once it's registered:
> > -|thermal_zone[0-*]:
> > +/sys/class/thermal/thermal_zone[0-*]:
> >       |-----type:                     Type of the thermal zone
> >       |-----temp:                     Current temperature
> >       |-----mode:                     Working mode of the thermal
> zone
> > @@ -119,7 +121,7 @@
> >       |-----trip_point_[0-*]_type:    Trip point type
> > 
> >  Thermal cooling device sys I/F, created once it's registered:
> > -|cooling_device[0-*]:
> > +/sys/class/thermal/cooling_device[0-*]:
> >       |-----type :                    Type of the cooling
> device(processor/fan/...)
> >       |-----max_state:                Maximum cooling state of the
> cooling device
> >       |-----cur_state:                Current cooling state of the
> cooling device
> > @@ -130,10 +132,19 @@
> >  They are created/removed for each
> >  thermal_zone_bind_cooling_device/thermal_zone_unbind_cooling_device
> > successful execution.
> > 
> > -|thermal_zone[0-*]
> > +/sys/class/thermal/thermal_zone[0-*]
> >       |-----cdev[0-*]:                The [0-*]th cooling device in
> the current thermal
> > zone
> >       |-----cdev[0-*]_trip_point:     Trip point that cdev[0-*] is
> associated
> > with
> > 
> > +Besides the thermal zone device sysfs I/F and cooling device sysfs
> I/F,
> > +the generic thermal driver also creates a hwmon sysfs I/F for each
> > _type_ of
> > +thermal zone device. E.g. the generic thermal driver registers one
> > hwmon class device
> > +and build the associated hwmon sysfs I/F for all the registered
> ACPI
> > thermal zones.
> > +/sys/class/hwmon/hwmon[0-*]:
> > +     |-----name:                     The type of the thermal zone
> devices.
> > +     |-----temp[1-*]_input:          The current temperature of
> thermal zone [1-*].
> > +     |-----temp[1-*]_critical:       The critical trip point of
> thermal zone
> > [1-*].
> > +Please read Documentation/hwmon/sysfs-interface for additional
> > information.
> > 
> >  ***************************
> >  * Thermal zone attributes *
> > @@ -141,7 +152,10 @@
> > 
> >  type                         Strings which represent the thermal
> zone type.
> >                               This is given by thermal zone driver
> as part of registration.
> > -                             Eg: "ACPI thermal zone" indicates it's
> a ACPI thermal device
> > +                             Eg: "acpitz" indicates it's an ACPI
> thermal device.
> > +                             In order to keep it consistent with
> hwmon sys attribute,
> > +                             this should be a short, lowercase
> string,
> > +                             not containing spaces nor dashes.
> >                               RO
> >                               Required
> > 
> > @@ -218,7 +232,7 @@
> >  /sys/class/thermal:
> > 
> >  |thermal_zone1:
> > -     |-----type:                     ACPI thermal zone
> > +     |-----type:                     acpitz
> >       |-----temp:                     37000
> >       |-----mode:                     kernel
> >       |-----trip_point_0_temp:        100000
> > @@ -243,3 +257,10 @@
> >       |-----type:                     Fan
> >       |-----max_state:                2
> >       |-----cur_state:                0
> > +
> > +/sys/class/hwmon:
> > +
> > +|hwmon0:
> > +     |-----name:                     acpitz
> > +     |-----temp1_input:              37000
> > +     |-----temp1_crit:               100000
> > Index: old-git/drivers/acpi/thermal.c
> > =================================> > --- old-git.orig/drivers/acpi/thermal.c       2008-04-21
> 15:16:05.000000000
> > +0800
> > +++ old-git/drivers/acpi/thermal.c    2008-04-21 15:20:14.000000000
> +0800
> > @@ -1136,7 +1136,7 @@
> > 
> >       for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
> >                       tz->trips.active[i].flags.valid; i++, trips
> ++);
> > -     tz->thermal_zone = thermal_zone_device_register("ACPI thermal
> zone",
> > +     tz->thermal_zone = thermal_zone_device_register("acpitz",
> >                                       trips, tz,
> &acpi_thermal_zone_ops);
> >       if (!tz->thermal_zone)
> >               return -ENODEV;
> >
> 
> This last chunk applies with fuzz 2 here. If this is because I'm
> missing other acpi patches, that's OK, but if not you should refresh
> the patch so that Len has no problem pushing it in git.
> 
> Other than that, this patch now looks fine to me.
Hi, Jean,
thanks for reviewing. :)


Update the documentation for the thermal driver hwmon sys I/F.

Change the ACPI thermal zone type to be consistent with hwmon.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/thermal/sysfs-api.txt |   33 +++++++++++++++++++++++++++------
 drivers/acpi/thermal.c              |    2 +-
 2 files changed, 28 insertions(+), 7 deletions(-)

Index: linux-2.6/Documentation/thermal/sysfs-api.txt
=================================--- linux-2.6.orig/Documentation/thermal/sysfs-api.txt	2008-04-22 08:43:59.000000000 +0800
+++ linux-2.6/Documentation/thermal/sysfs-api.txt	2008-04-22 08:44:38.000000000 +0800
@@ -108,10 +108,12 @@
 RO	read only value
 RW	read/write value
 
-All thermal sysfs attributes will be represented under /sys/class/thermal
+Thermal sysfs attributes will be represented under /sys/class/thermal.
+Hwmon sysfs I/F extension is also available under /sys/class/hwmon
+if hwmon is compiled in or built as a module.
 
 Thermal zone device sys I/F, created once it's registered:
-|thermal_zone[0-*]:
+/sys/class/thermal/thermal_zone[0-*]:
 	|-----type:			Type of the thermal zone
 	|-----temp:			Current temperature
 	|-----mode:			Working mode of the thermal zone
@@ -119,7 +121,7 @@
 	|-----trip_point_[0-*]_type:	Trip point type
 
 Thermal cooling device sys I/F, created once it's registered:
-|cooling_device[0-*]:
+/sys/class/thermal/cooling_device[0-*]:
 	|-----type :			Type of the cooling device(processor/fan/...)
 	|-----max_state:		Maximum cooling state of the cooling device
 	|-----cur_state:		Current cooling state of the cooling device
@@ -130,10 +132,19 @@
 They are created/removed for each
 thermal_zone_bind_cooling_device/thermal_zone_unbind_cooling_device successful execution.
 
-|thermal_zone[0-*]
+/sys/class/thermal/thermal_zone[0-*]
 	|-----cdev[0-*]:		The [0-*]th cooling device in the current thermal zone
 	|-----cdev[0-*]_trip_point:	Trip point that cdev[0-*] is associated with
 
+Besides the thermal zone device sysfs I/F and cooling device sysfs I/F,
+the generic thermal driver also creates a hwmon sysfs I/F for each _type_ of
+thermal zone device. E.g. the generic thermal driver registers one hwmon class device
+and build the associated hwmon sysfs I/F for all the registered ACPI thermal zones.
+/sys/class/hwmon/hwmon[0-*]:
+	|-----name:			The type of the thermal zone devices.
+	|-----temp[1-*]_input:		The current temperature of thermal zone [1-*].
+	|-----temp[1-*]_critical:	The critical trip point of thermal zone [1-*].
+Please read Documentation/hwmon/sysfs-interface for additional information.
 
 ***************************
 * Thermal zone attributes *
@@ -141,7 +152,10 @@
 
 type				Strings which represent the thermal zone type.
 				This is given by thermal zone driver as part of registration.
-				Eg: "ACPI thermal zone" indicates it's a ACPI thermal device
+				Eg: "acpitz" indicates it's an ACPI thermal device.
+				In order to keep it consistent with hwmon sys attribute,
+				this should be a short, lowercase string,
+				not containing spaces nor dashes.
 				RO
 				Required
 
@@ -218,7 +232,7 @@
 /sys/class/thermal:
 
 |thermal_zone1:
-	|-----type:			ACPI thermal zone
+	|-----type:			acpitz
 	|-----temp:			37000
 	|-----mode:			kernel
 	|-----trip_point_0_temp:	100000
@@ -243,3 +257,10 @@
 	|-----type:			Fan
 	|-----max_state:		2
 	|-----cur_state:		0
+
+/sys/class/hwmon:
+
+|hwmon0:
+	|-----name:			acpitz
+	|-----temp1_input:		37000
+	|-----temp1_crit:		100000
Index: linux-2.6/drivers/acpi/thermal.c
=================================--- linux-2.6.orig/drivers/acpi/thermal.c	2008-04-22 08:43:59.000000000 +0800
+++ linux-2.6/drivers/acpi/thermal.c	2008-04-22 08:44:38.000000000 +0800
@@ -1136,7 +1136,7 @@
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
 			tz->trips.active[i].flags.valid; i++, trips++);
-	tz->thermal_zone = thermal_zone_device_register("ACPI thermal zone",
+	tz->thermal_zone = thermal_zone_device_register("acpitz",
 					trips, tz, &acpi_thermal_zone_ops);
 	if (IS_ERR(tz->thermal_zone))
 		return -ENODEV;



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
