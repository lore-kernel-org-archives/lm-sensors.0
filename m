From: amalysh@web.de (Alexander Malysh)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: Latest cvs -> Compile Errors
Message-Id: <200211161710.26342.amalysh@web.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,

if I try to compile latest cvs version, then i got errors :

gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.19/build/include  -O2   -c prog/sensors/chips.c -o prog/sensors/chips.ro
prog/sensors/chips.c: In function `print_bmc':
prog/sensors/chips.c:3669: `SENSORS_BMC_IN1' undeclared (first use in this function)
prog/sensors/chips.c:3669: (Each undeclared identifier is reported only once
prog/sensors/chips.c:3669: for each function it appears in.)
prog/sensors/chips.c:3671: `SENSORS_BMC_IN1_MIN' undeclared (first use in this function)
prog/sensors/chips.c:3672: `SENSORS_BMC_IN1_MAX' undeclared (first use in this function)
prog/sensors/chips.c:3683: `SENSORS_BMC_FAN1' undeclared (first use in this function)
prog/sensors/chips.c:3688: `SENSORS_BMC_FAN1_MIN' undeclared (first use in this function)
prog/sensors/chips.c:3699: `SENSORS_BMC_TEMP1' undeclared (first use in this function)
prog/sensors/chips.c:3701: `SENSORS_BMC_TEMP1_MIN' undeclared (first use in this function)
prog/sensors/chips.c:3702: `SENSORS_BMC_TEMP1_MAX' undeclared (first use in this function)
make: *** [prog/sensors/chips.ro] Fehler 1

What going wrong ?
Mark, I believe you have forgot some defines ?

-- 
Thanks,
Alexander Malysh
