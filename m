From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 08 Nov 2005 11:19:05 +0000
Subject: [lm-sensors] Re: adm1027 on 2.6.9-5.EL
Message-Id: <XVkq04oM.1131444138.7357880.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Paul,

First of all, you really shouldn't send mails with a subject line which
reads "Hello". Unless you like the idea that it'll end up in my spam
folder, of course, which is exactly what happened to this one.

Second, please send your requests for help to the lm-sensors mailing list
rather than me directly. This increases your chances to actually get
help.

> 2.6.9-5.EL kernel what is the "Can't get alarm mask data" error? and also,
> I get an alarm on in4 but I already have that ignored in the sensors.conf.
> Some of the min and max values are not looking right, maybe this is part
> of the mark data but google it and found nothing to go by. More
> importantly I downloaded i2c and lm_sensors 2.9.2 but the doc inside
> states:
>
> "FOR 2.5/2.6 KERNELS, do not attempt to compile the modules in this
> package. Use the drivers already in the 2.5/2.6 kernel tree."
>
> so.. I am confused. No need to compile then? Centos comes with 2.8.7 and
> I thought some updates will be on 2.9.2

The above warning is about kernel modules only. There still is the
user-space library and tools which both 2.4 and 2.6 kernels need. You
can compile these with "make user" and install them in /usr/local by
default with "make user_install".

If you do install it on your own, I suggest that you uninstall the
package that comes with your distribution so as to avoid library version
conflicts.

> Also, I used to be able to see /proc/sys/dev/sensors with 2.4 kernels and
> now nothing.... I am not versed on the main differences of kernels or
> their changes.

In Linux 2.6, the same data is available, although in a slightly
different form, under /sys/bus/i2c. On the latest versions you
additionally have /sys/class/hwmon, which is more or less a set of
pointers to the former. In the long run, /sys/class/hwmon will become
the right place to look at.

> My conf stuff is below.
> (...)
> adm1027-i2c-0-2e
> Adapter: SMBus I801 adapter at 1480
> ERROR: Can't get alarm mask data!
> (...)
> ***********************************
> # cat sensors.conf
>
> chip "lm85-*" "adt7463-*"

First problem, your chip is an adm1027, so you should add "adm1027-*"
here, else your configuration file is useless. This explains why your
"ignore in4" did not work.

The alarm mask error can be safely ignored. The feature is simply not
implemented in the Linux 2.6 version of the lm85 driver. Starting with
lm_sensors 2.8.8, "sensors" conveniently hides this error message. In
the meanwhile, you may try to add an "ignore alarm_mask" statement in
the configuration file, but I wouldn't swear it'll work.

--
Jean Delvare
