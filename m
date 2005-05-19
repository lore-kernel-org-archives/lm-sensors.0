From: eharrison@tampabay.rr.com (Ed Harrison)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: No readings on SuSE 9.1
Message-Id: <200405191735.i4JHZI4F004970@ms-smtp-05.tampabay.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

kernel 	2.6.4-52
i2c	modules from kernel
lm_sensors 2.8.3 (modules from kernel)  user space tools from 2.8.5

Sensors-detect works and identifies my asb100.  modules load without complaint.
sensors -s gives no error message.

When I do sensors or sensors -f, I get the message:

asb100-i2c-2-2d
Adapter: SMBus Via Pro adapter at e800
Algorithm: Unavailable from sysfs
ERROR: Can't get IN data! (0x0001)
ERROR: Can't get IN data! (0x0002)
ERROR: Can't get IN data! (0x0003)
ERROR: Can't get IN data! (0x0004)
ERROR: Can't get IN data! (0x0005)
ERROR: Can't get IN data! (0x0006)
ERROR: Can't get IN data! (0x0007)
ERROR: Can't get FAN data! (0x0031)
ERROR: Can't get FAN data! (0x0032)
ERROR: Can't get FAN data! (0x0033)
ERROR: Can't get TEMP data! (0x0051)
ERROR: Can't get TEMP data! (0x0054)
ERROR: Can't get TEMP data! (0x0057)
ERROR: Can't get TEMP data! (0x005a)
ERROR: Can't get VID data!
alarms:

Temic PAL-i2c-0-60
Adapter: bt878 #0 [sw]
Algorithm: Unavailable from sysfs


What am I missing about "from sysfs"?  What is it?  How do I load or activate
it?

Ed Harrison
SuSE 9.1, Kernel 2.6.4
PolarBar Mailer 1.25a
