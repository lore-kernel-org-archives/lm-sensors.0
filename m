From: Andrew Lyon <andrew.lyon@gmail.com>
Date: Sat, 19 Mar 2011 14:04:42 +0000
Subject: [lm-sensors] no sensors on Alix 2D13 with module lm90 and kernel
Message-Id: <AANLkTinPOhCOkZLEfzE9cK2j3rbUTMxmfvLtm1OP7bwq@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

The subject sums it up really, I've just upgraded my Alix 2D13 system
(http://www.pcengines.ch/alix2d13.htm) from 2.6.37 to 2.6.38 and the
sensors have disappeared, lm90 still loads and there are no errors but
no sensors are detected.

What's really strange is that there seem to have been no changes to
the lm90 code between the working and broken versions:

alixbuild src # diff linux-2.6.37-gentoo-r2/drivers/hwmon/lm90.c
linux-2.6.38-gentoo/./drivers/hwmon/lm90.c
alixbuild src # diff
linux-2.6.37-gentoo-r2/./include/config/sensors/lm90.h
linux-2.6.38-gentoo/./include/config/sensors/lm90.h

Very strange, any ideas?

Andy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
