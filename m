From: juergh@gmail.com (Juerg Haefliger)
Date: Sat, 25 Feb 2006 19:27:50 +0000
Subject: [lm-sensors] Question on platform drivers
Message-Id: <191fb4ca0602251127r1189bd56h32f8c205f0f803a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0602191403u1392a3b4hc5d7b93720c57355@mail.gmail.com>
In-Reply-To: <191fb4ca0602191403u1392a3b4hc5d7b93720c57355@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Yes, your patch below works for me. Thanks!

...juerg

-bash-3.00# sensors
vt1211-isa-6000
Adapter: ISA adapter
ERROR: Can't get alarm data!
+3.3V:     +3.31 V  (min =  +3.03 V, max =  +3.17 V)
+2.5V:     +2.42 V  (min =  +2.17 V, max =  +2.27 V)
VCore:     +1.39 V  (min =  +1.36 V, max =  +1.44 V)
+5V:       +4.66 V  (min =  +4.73 V, max =  +5.23 V)
+12V:     +12.07 V  (min = +10.77 V, max = +13.14 V)
+3.3V(i):  +3.27 V  (min =  +3.13 V, max =  +3.46 V)
fan1:        0 RPM  (min = 3006 RPM, div = 2)
fan2:     3877 RPM  (min = 3006 RPM, div = 2)
Int Temp:  +48.0?C  (high =  +204?C, hyst =    +0?C)
CPU Temp:  +98.0?C  (high =   +65?C, hyst =   +60?C)
vid:      +1.250 V  (VRM Version 8.5)


> Hi Mark, Juerg,
>
> On 2006-02-24, Mark M. Hoffman wrote:
>> > Hmmm... I guess it's a libsensors bug - try this patch.
>> >
>> > Jean: comments?
>> >
>> > Index: lib/sysfs.c
>> > =================================>> > RCS file: /home/cvs/lm_sensors2/lib/sysfs.c,v
>> > retrieving revision 1.4
>> > diff -u -r1.4 sysfs.c
>> > --- lib/sysfs.c	9 Jan 2006 19:55:18 -0000	1.4
>> > +++ lib/sysfs.c	24 Feb 2006 05:23:58 -0000
>> > @@ -171,7 +171,7 @@
>> >  	int ret = 0;
>> >
>> >  	if (!(cls = sysfs_open_class("i2c-adapter"))) {
>> > -		ret = -SENSORS_ERR_PROC;
>> > +		/* not an error - sensors completely without I2C is
>> > +                  possible */
>> >  		goto exit0;
>> >  	}
>>
>> Seems so. I could reproduce the bug yesterday evening by removing all
>> i2c
>> stuff from my kernel. I had never tried that before, because even on the
>> system where I can use a totally i2c-free hardware monitoring driver
>> (f71805f), I have other devices which use i2c (my DC10+ grabber).
>>
>> I did not send a patch yesterday as I first wanted to make sure it would
>> work properly, and I was short of time for the additional tests. We need
>> to make sure that nowhere in the libsensors code we assumed that at
>> least one i2c adapter had been found. I'll look into it this evening.
>
> Further investigations reveal that the patch above isn't sufficient. It
> covers the case where no i2c driver at all is loaded, but fails again
> is i2c-core is loaded but no bus driver is. It is also a bit too loose
> with error checking in my opinion.
>
> Here is the patch I have come up with. Juerg, please give it a try and
> report. It works fine for me at least.
>
> Index: lib/sysfs.c
> =================================> RCS file: /home/cvs/lm_sensors2/lib/sysfs.c,v
> retrieving revision 1.4
> diff -u -r1.4 sysfs.c
> --- lib/sysfs.c	9 Jan 2006 19:55:18 -0000	1.4
> +++ lib/sysfs.c	24 Feb 2006 22:49:09 -0000
> @@ -22,6 +22,7 @@
>
>  #include <string.h>
>  #include <limits.h>
> +#include <errno.h>
>  #include <sysfs/libsysfs.h>
>  #include "data.h"
>  #include "error.h"
> @@ -171,12 +172,14 @@
>  	int ret = 0;
>
>  	if (!(cls = sysfs_open_class("i2c-adapter"))) {
> -		ret = -SENSORS_ERR_PROC;
> +		if (errno && errno != ENOENT)
> +			ret = -SENSORS_ERR_PROC;
>  		goto exit0;
>  	}
>
>  	if (!(clsdevs = sysfs_get_class_devices(cls))) {
> -		ret = -SENSORS_ERR_PROC;
> +		if (errno)
> +			ret = -SENSORS_ERR_PROC;
>  		goto exit1;
>  	}
>
>
> Thanks,
> --
> Jean Delvare
>
>

