From: Dieter Jurzitza <dieter.jurzitza@t-online.de>
Date: Sat, 07 Apr 2007 20:03:23 +0000
Subject: [lm-sensors] coretemp.ko - progress
Message-Id: <200704072203.23493.dieter.jurzitza@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Dear listmembers,
I found a source package I could build and integrate into my kernel 2.6.18.=
8=20
in the meantime. The only change I had to do was to integrate
#include <linux/cpu.h>=20
into coretemp.c, but maybe this is an openSUSE issue. The source code stems=
=20
from the 29th and 30th of September 2006 (coretemp.c, coretemp.mod.c), I do=
=20
not see release information inside. In addition I switched to=20
lm_sensors-2.10.3 because it's sensors_detect supports the coretemp module.

Many many thanks to Rudolf Marek!

Nevertheless, two comments / questions from my side:

1.) when building lm_sensors-2.10.3 on my machine, I stumbled over the=20
following line in prog/pwm/fancontrol.original:

@@ -88,7 +88,7 @@
                echo "  MAXTEMP=3D${AFCMAXTEMP[$fcvcount]}"
                echo "  MINSTART=3D${AFCMINSTART[$fcvcount]}"
                echo "  MINSTOP=3D${AFCMINSTOP[$fcvcount]}"
                let fcvcount=FCvcount+1

shouldn't that denote "let fcvcount=3D$fcvcount+1" (see the "$")? I am not =
a=20
perl expert, but maybe someone could shade a light on this ....

2.) after integrating & building the version of coretemp I downloaded I get=
=20
the following warning message:

WARNING: drivers/hwmon/coretemp.o - Section mismatch: reference to .init.te=
xt:=20
from .text between 'coretemp_cpu_callback' (at offset 0x1b1) and=20
'msr_smp_rdmsr'
could some friendly person explain this to me an tell me whether or not I=20
should expect issues here?

Thank you very much for all your ongoing support for lm_sensors,
take care


Dieter Jurzitza



--=20
-----------------------------------------------------------

                               |
                                \
                 /\_/\           |
                | ~x~ |/-----\   /
                 \   /-       \_/
  ^^__   _        /  _  ____   /
 <=B0=B0__ \- \_/     |  |/    |  |
  ||  ||         _| _|    _| _|

if you really want to see the pictures above - use some font
with constant spacing like courier! :-)
-----------------------------------------------------------

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
