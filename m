From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 02 Jun 2008 10:32:18 +0000
Subject: Re: [lm-sensors] [Bug?] W83697: Broken readings for fan speed 10%
Message-Id: <20080602123218.0a59895b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080531220339.05dc83fd@neptune.home>
In-Reply-To: <20080531220339.05dc83fd@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Bruno,

On Sat, 31 May 2008 22:03:39 +0200, Bruno Pr=E9mont wrote:
> On a Commell LE-365 I get readings for fan speed that are broken about
> 10% of the time.
> The board has a Winbond W83697 chip (I can't check the exact chip name
> on the board as it's hidden by a heatsink, the photo from Commell, as
> as well as the manual indicate a HG, the kenrel reports:
>   [    3.572831] w83627hf: Found W83697HF chip at 0x290
>   [    3.572831] WDT driver for the Winbond(TM) W83627HF/THF/HG Super I/O=
 chip initialising.
>   [    3.572831] w83627hf/thf/hg WDT: Watchdog already running. Resetting=
 timeout to 60 sec
>   [    3.572831] w83627hf/thf/hg WDT: initialized. timeout` sec (nowayout=
=3D0)
> )
>=20
> Below a sample (reformatted) output of
>   while sleep 1; do
>     date;
>     cat /sys/class/hwmon/hwmon0/device/fan1_input;
>   done
> :
> Sat May 31 21:11:23 CEST 2008    2070
> Sat May 31 21:11:24 CEST 2008    2070
> Sat May 31 21:11:25 CEST 2008    2070
> Sat May 31 21:11:26 CEST 2008    2070
> Sat May 31 21:11:27 CEST 2008    2070
> Sat May 31 21:11:28 CEST 2008    2070
> Sat May 31 21:11:29 CEST 2008    2057
> Sat May 31 21:11:30 CEST 2008    2057
> Sat May 31 21:11:31 CEST 2008    2070
> Sat May 31 21:11:32 CEST 2008    2070
> Sat May 31 21:11:33 CEST 2008      -1
> Sat May 31 21:11:34 CEST 2008      -1
> Sat May 31 21:11:35 CEST 2008      -1
> Sat May 31 21:11:36 CEST 2008      -1
> Sat May 31 21:11:37 CEST 2008    2057
> Sat May 31 21:11:38 CEST 2008    2057
> Sat May 31 21:11:39 CEST 2008    2057
> Sat May 31 21:11:40 CEST 2008    2057
> Sat May 31 21:11:41 CEST 2008    2070
> Sat May 31 21:11:42 CEST 2008    2070
> Sat May 31 21:11:43 CEST 2008    2070
> Sat May 31 21:11:44 CEST 2008    2070
> Sat May 31 21:11:45 CEST 2008    2057
> Sat May 31 21:11:46 CEST 2008    2057
> Sat May 31 21:11:47 CEST 2008      -1
> Sat May 31 21:11:48 CEST 2008      -1
> Sat May 31 21:11:49 CEST 2008    2070
> Sat May 31 21:11:50 CEST 2008    2070
> Sat May 31 21:11:51 CEST 2008    2057
> Sat May 31 21:11:52 CEST 2008    2057
> Sat May 31 21:11:53 CEST 2008    2057
> Sat May 31 21:11:54 CEST 2008    2057
> Sat May 31 21:11:55 CEST 2008    2057
> Sat May 31 21:11:56 CEST 2008    2057
> Sat May 31 21:11:58 CEST 2008    2057
> Sat May 31 21:11:59 CEST 2008    2057
> Sat May 31 21:12:00 CEST 2008    2070
> Sat May 31 21:12:01 CEST 2008    2070
> Sat May 31 21:12:02 CEST 2008    2057
> Sat May 31 21:12:03 CEST 2008    2057
> Sat May 31 21:12:04 CEST 2008    2083
> Sat May 31 21:12:05 CEST 2008    2083
> Sat May 31 21:12:06 CEST 2008    2057
> Sat May 31 21:12:07 CEST 2008    2057
> Sat May 31 21:12:08 CEST 2008    2070
> Sat May 31 21:12:09 CEST 2008    2070
> Sat May 31 21:12:10 CEST 2008    2070
> Sat May 31 21:12:11 CEST 2008    2070
> Sat May 31 21:12:12 CEST 2008  337500
> Sat May 31 21:12:13 CEST 2008  337500
> Sat May 31 21:12:14 CEST 2008  337500
> Sat May 31 21:12:15 CEST 2008  337500
> Sat May 31 21:12:16 CEST 2008  337500
> Sat May 31 21:12:17 CEST 2008  337500
> Sat May 31 21:12:18 CEST 2008    2070
> Sat May 31 21:12:19 CEST 2008    2070
> Sat May 31 21:12:20 CEST 2008    2070
> Sat May 31 21:12:21 CEST 2008    2070
> Sat May 31 21:12:22 CEST 2008    2070
> Sat May 31 21:12:23 CEST 2008    2070
> Sat May 31 21:12:24 CEST 2008    2070
> Sat May 31 21:12:25 CEST 2008    2070
> Sat May 31 21:12:26 CEST 2008    2057
> Sat May 31 21:12:27 CEST 2008    2057
> Sat May 31 21:12:28 CEST 2008    2070
> Sat May 31 21:12:29 CEST 2008    2070
> Sat May 31 21:12:30 CEST 2008    2070
> Sat May 31 21:12:31 CEST 2008    2070
> Sat May 31 21:12:32 CEST 2008      -1
>=20
> The 337k RPM and -1 RPM do not make any sense.
> I can't tell if this is a regression as I just started monitoring
> a few sensor values (with older kernels I just did a few manual
> checks but never noticed broken fan speeds)

I do not think this is a regression, most likely a hardware issue.

Is the fan's speed controlled in any way, either by the W83697HG chip,
or maybe it is a self-regulated fan? Just check if the fan's speed
increases with the temperature (i.e. with CPU load).

If this is the case, then please read this recent discussion the
lm-sensors list:
  http://marc.info/?l=3Dlm-sensors&m=121196069612940&w=3D2
I suspect that your problem is similar.

If the fan is not controlled and is running at full speed, then all I
can think of is defective hardware (either the fan or the monitoring
chip.)

> In case there is more data I can provide, please ask.
> As the board is not in production use I can easily try out patches.

One patch you may want to apply it this one:
  http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023189.html
It will let you switch the W83697HG chip from automatic fan speed
control to manual control and back - might be useful to investigate the
issue you have.

You can also give a try to the following patch, which is the equivalent
of the one I just posted for the it87 driver, but for the w83627hf
driver:

Subject: hwmon: (w83627hf) Filter out unlikely fan speed values

Filter out very large fan speed values. These can be reported by the
chip when a fan is being controlled at low speed. The tachometer
signal gets too weak and the chip fails to monitor the speed properly,
but unfortunately it reports unreasonably high values instead of 0
RPM, which is quite confusing.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83627hf.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.26-rc4.orig/drivers/hwmon/w83627hf.c	2008-06-02 12:14:00.0000=
00000 +0200
+++ linux-2.6.26-rc4/drivers/hwmon/w83627hf.c	2008-06-02 12:20:57.000000000=
 +0200
@@ -259,7 +259,7 @@ static inline u8 FAN_TO_REG(long rpm, in
 	if (rpm =3D 0)
 		return 255;
 	rpm =3D SENSORS_LIMIT(rpm, 1, 1000000);
-	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1,
+	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 2,
 			     254);
 }
=20
@@ -280,7 +280,8 @@ static int TEMP_FROM_REG(u8 reg)
         return (s8)reg * 1000;
 }
=20
-#define FAN_FROM_REG(val,div) ((val)=3D0?-1:(val)=3D255?0:1350000/((val)*(=
div)))
+#define FAN_FROM_REG(val,div)	((val) <=3D 1 || (val) =3D 255 ? 0 : \
+				 1350000 / ((val) * (div)))
=20
 #define PWM_TO_REG(val) (SENSORS_LIMIT((val),0,255))
=20

It will report the missing fan speed values as 0, which is probably
slightly better than -1 and 337500, even though it doesn't really solve
the problem.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
