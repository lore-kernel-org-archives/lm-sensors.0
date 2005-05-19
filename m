From: m.c.p@gmx.de (Marc-Christian Petersen)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: lmsensors2 cvs broken
Message-Id: <200301141804.48861.m.c.p@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,

since yesterday:

root@codeman:[/usr/src/SENSORS/cvs/lm_sensors2] # mkpatch/mkpatch.pl . 
/usr/src/linux > /tmp/sensors-patch
Automatic patch generation for `drivers/i2c/i2c-core.c' failed.
See our home page http://www.lm-sensors.nu for assistance! at 
mkpatch/mkpatch.pl line 1509.

i2c cvs is applied first, sure. Applied to kernel 2.4.20.

ciao, Marc
