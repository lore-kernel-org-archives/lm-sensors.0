From: Ralph Krimmel <thirsty@milk-and-cookies.net>
Date: Mon, 23 Jun 2008 18:42:34 +0000
Subject: [lm-sensors] Bug with driver lm78
Message-Id: <485FEE9A.40704@milk-and-cookies.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello, i was trying to run lm-sensors version 3.0.0 with libsensors
version 3.0.0 on a celeron 400 on an Abit BH6 mainboard. The system i am
using is a Ubuntu Hardy command line system with Kernel Version 2.6.24-16.

sensors-detect brought me one success:

`National Semiconductor LM79' at 0x290...       Success! (confidence 6,
          driver `lm78')

But after modprobing the module, sensors still kept saying that there
could no sensors been found.

There was no /sys/devices/platform/lm78.656 directory created

There was one entry in /proc/ioports that was near the 0x290 adress and
that was: 0294-0297 : pnp 00:02 which, as it was told me, is a well
known problem. which was fixed in w83781d but not in lm78.


I hope this report helps to fix it.

Regards, leche



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
