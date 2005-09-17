From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 17 Sep 2005 20:50:38 +0000
Subject: [lm-sensors] libsensors / libsysfs patches for review
Message-Id: <20050917205031.78e09415.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050911040600.GB3629@jupiter.solarsys.private>
In-Reply-To: <20050911040600.GB3629@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> http://members.dca.net/mhoffman/sensors/patches/lm_sensors2/20050913/

I finally got around to reviewing your work. Unsurprisingly, I only have
minor comments. The whole idea and your implementation are just right.

I have no comment at all on the first three patches.

4th patch: found_sysfs_libsysfs

> --- /dev/null
> +++ lm_sensors2/lib/sysfs.c
> (...)
> +#include <string.h>

I don't think we actually need it at this point - but this admittedly
doesn't matter, later patches need it anyway.

> --- /dev/null
> +++ lm_sensors2/lib/sysfs.h
> (...)
> +#ifndef SENSORS_LIB_SYSFS_H
> +#define SENSORS_LIB_SYSFS_H
> (...)
> +#endif
> +

I'd suggest a /* !SENSORS_LIB_SYSFS_H */ after the #endif. Also, you
have an extra blank line at the end of this file.

> --- lm_sensors2.orig/lib/init.c
> +++ lm_sensors2/lib/init.c
> (...)
>    sensors_cleanup();
> +  sensors_init_sysfs();

Unrelated with your changes, but why are we calling sensors_cleanup()
here? Looks like a waste of time to me.

> --- lm_sensors2.orig/lib/access.c
> +++ lm_sensors2/lib/access.c
> (...)
> -  if(foundsysfs) {
> +  if(sensors_found_sysfs) {

Please do not hesitate to fix the coding style in these occasions. There
should be a space between the "if" and the opening parenthesis.

5th patch: read_bus_libsysfs

> --- lm_sensors2.orig/lib/sysfs.c
> +++ lm_sensors2/lib/sysfs.c
> (...)
> +int sensors_read_sysfs_bus(void)
> +{
> +       struct sysfs_class *cls = NULL;
> +       struct dlist *clsdevs = NULL;
> +       struct sysfs_class_device *clsdev = NULL;

These initializations look superfluous to me.

> +       dlist_for_each_data(clsdevs, clsdev, struct sysfs_class_device) {
> +               struct sysfs_device *dev = NULL;
> +               struct sysfs_attribute *attr = NULL;

Ditto.

> +               } else if (!sscanf(clsdev->name, "i2c-%d", &entry.number)) {

I'd prefer an explicit != 1 test. sscanf is said to eventually return
EOF.

> +exit:
> +       /* this frees *i2c_class _and_ *cdevs */
> +       if (cls)
> +               sysfs_close_class(cls);
> +       return ret;
> +}

The comment looks out of sync with the variable names.

Why don't you define a second label after the call to
sysfs_close_class()? This would let you get rid of the if (cls) test
unless I'm mistaken.

> --- lm_sensors2.orig/lib/init.c
> +++ lm_sensors2/lib/init.c
> (...)
> +  if ((res = sensors_read_sysfs_bus()) && (res = sensors_read_proc_bus()))

This looks less than optimal to me. Why not rely on the
sensors_found_sysfs variable to call the right function directly?

6th patch: read_chip_libsysfs

> --- lm_sensors2.orig/lib/init.c
> +++ lm_sensors2/lib/init.c
> (...)
>    sensors_init_sysfs();
> -  if ((res = sensors_read_proc_chips()))
> +  if ((res = sensors_read_sysfs_chips()) && (res = sensors_read_proc_chips()))

Ditto.

Maybe you could have sensors_init_sysfs() return the value of
sensors_found_sysfs. This would lead to the following code:

  if (sensors_init_sysfs()) {
    if ((res = sensors_read_sysfs_chips()) || (res = sensors_read_sysfs_bus()))
      return res;
  } else {
    if ((res = sensors_read_proc_chips()) || (res = sensors_read_proc_bus()))
      return res;
  }

I think it's faster and more readble than the current code.

> --- lm_sensors2.orig/lib/sysfs.c
> +++ lm_sensors2/lib/sysfs.c
> (...)
> +#define _GNU_SOURCE

Add a comment explaining why this is needed?

> +static int sensors_read_one_sysfs_chip(struct sysfs_device *dev)
> (...)
> +       if (!entry.name.prefix)
> +               return -SENSORS_ERR_PARSE;
> +
> +       entry.name.busname = strdup(dev->path);
> +       if (!entry.name.busname)
> +               return -SENSORS_ERR_PARSE;

Shouldn't these be out-of-memory fatal errors like you did elsewhere?
Calling these "parse errors" is rather confusing.

> +       if ((bus_attr = sysfs_open_attribute(bus_path))) {
> +

No blank line here please.

Additionally, the same comments I had about patch 5 (useless
initializations, second exit label) apply to this one too.

7th patch: sysfs_support_optional

> --- lm_sensors2.orig/Makefile
> +++ lm_sensors2/Makefile
> (...)
> +# by uncommenting the line after the next endif.  Keep in mind, *iff* you

Typo.

> +ifdef SYSFS_SUPPORT
> +ARCPPFLAGS := $(ARCPPFLAGS) -DSYSFS_SUPPORT
> +endif
>  ARCFLAGS := $(ALL_CFLAGS)
>  LIBCPPFLAGS := $(ALL_CPPFLAGS)
> +ifdef SYSFS_SUPPORT
> +LIBCPPFLAGS := $(LIBCPPFLAGS) -DSYSFS_SUPPORT
> +endif

Why not +=?

> --- lm_sensors2.orig/lib/Module.mk
> +++ lm_sensors2/lib/Module.mk

> +ifdef SYSFS_SUPPORT
> +       LIBCSOURCES := $(LIBCSOURCES) $(MODULE_DIR)/sysfs.c
> +endif

Ditto.

That's about it. Overall it looks just fine, thanks a lot for working on
this :)

-- 
Jean Delvare
