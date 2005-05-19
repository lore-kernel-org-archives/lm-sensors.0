From: s0mbre@vocord.com (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: [PC87366] A bit different design for it's SuperIO.
Message-Id: <1092648290.12729.471.camel@uganda>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Although lm_sensors already has driver for it's fan, voltage and
temperature sensors, it does not have driver for is's GPIO, which allows
anyone to create i2c and w1 adapters over it.
Design is simple as 5 pennies:

	SuperIO main driver
		|
+----+----+-----+-----+-----+---
|    |    |     |     |     |

	Logical devices space...

Where each logical device may be registered and deregistered to/from
main driver. Theoretically master device may have some kind of ioctl or
any other communication mechanism with userspace/kernelspace which will
allow any kind of slave manipulations.

Since you have "monitoring" driver already, I've created one only for
GPIO.

Since I do not know where it should live(at my private trees it lives in
drivers/w1/) I post here files itself.

Anyone using GNU/Arch may access it through public mirror at:
http://tservice.net.ru/~s0mbre/2004/ branch "soekris--main--0".

Please review and comment.

-- 
	Evgeniy Polyakov ( s0mbre )

Crash is better than data corruption. -- Art Grabowski
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Makefile
Type: text/x-makefile
Size: 254 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040816/9a2f13db/Makefile.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sc.c
Type: text/x-csrc
Size: 8462 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040816/9a2f13db/sc.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sc_gpio.c
Type: text/x-csrc
Size: 4357 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040816/9a2f13db/sc_gpio.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sc_gpio.h
Type: text/x-chdr
Size: 1940 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040816/9a2f13db/sc_gpio-0001.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sc.h
Type: text/x-chdr
Size: 2538 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040816/9a2f13db/sc-0001.bin
