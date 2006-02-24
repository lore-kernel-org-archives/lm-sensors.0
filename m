From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 24 Feb 2006 22:01:25 +0000
Subject: [lm-sensors] Question on platform drivers
Message-Id: <20060224230125.5afbf92d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0602191403u1392a3b4hc5d7b93720c57355@mail.gmail.com>
In-Reply-To: <191fb4ca0602191403u1392a3b4hc5d7b93720c57355@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark, Juerg,

On 2006-02-24, Mark M. Hoffman wrote:
> > Hmmm... I guess it's a libsensors bug - try this patch.
> >
> > Jean: comments?
> >
> > Index: lib/sysfs.c
> > =================================> > RCS file: /home/cvs/lm_sensors2/lib/sysfs.c,v
> > retrieving revision 1.4
> > diff -u -r1.4 sysfs.c
> > --- lib/sysfs.c	9 Jan 2006 19:55:18 -0000	1.4
> > +++ lib/sysfs.c	24 Feb 2006 05:23:58 -0000
> > @@ -171,7 +171,7 @@
> >  	int ret = 0;
> > 
> >  	if (!(cls = sysfs_open_class("i2c-adapter"))) {
> > -		ret = -SENSORS_ERR_PROC;
> > +		/* not an error - sensors completely without I2C is
> > +                  possible */
> >  		goto exit0;
> >  	}
> 
> Seems so. I could reproduce the bug yesterday evening by removing all i2c
> stuff from my kernel. I had never tried that before, because even on the
> system where I can use a totally i2c-free hardware monitoring driver
> (f71805f), I have other devices which use i2c (my DC10+ grabber).
> 
> I did not send a patch yesterday as I first wanted to make sure it would
> work properly, and I was short of time for the additional tests. We need
> to make sure that nowhere in the libsensors code we assumed that at
> least one i2c adapter had been found. I'll look into it this evening.

Further investigations reveal that the patch above isn't sufficient. It
covers the case where no i2c driver at all is loaded, but fails again
is i2c-core is loaded but no bus driver is. It is also a bit too loose
with error checking in my opinion.

Here is the patch I have come up with. Juerg, please give it a try and
report. It works fine for me at least.

Index: lib/sysfs.c
=================================RCS file: /home/cvs/lm_sensors2/lib/sysfs.c,v
retrieving revision 1.4
diff -u -r1.4 sysfs.c
--- lib/sysfs.c	9 Jan 2006 19:55:18 -0000	1.4
+++ lib/sysfs.c	24 Feb 2006 22:49:09 -0000
@@ -22,6 +22,7 @@
 
 #include <string.h>
 #include <limits.h>
+#include <errno.h>
 #include <sysfs/libsysfs.h>
 #include "data.h"
 #include "error.h"
@@ -171,12 +172,14 @@
 	int ret = 0;
 
 	if (!(cls = sysfs_open_class("i2c-adapter"))) {
-		ret = -SENSORS_ERR_PROC;
+		if (errno && errno != ENOENT)
+			ret = -SENSORS_ERR_PROC;
 		goto exit0;
 	}
 
 	if (!(clsdevs = sysfs_get_class_devices(cls))) {
-		ret = -SENSORS_ERR_PROC;
+		if (errno)
+			ret = -SENSORS_ERR_PROC;
 		goto exit1;
 	}
 

Thanks,
-- 
Jean Delvare

