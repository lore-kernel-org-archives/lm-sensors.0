From: mmbdr5729@yahoo.com (Mohan Mistry)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: Multiple Smart Batteries
Message-Id: <20050117192539.50355.qmail@web30505.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


I am able to load and use the smartbatt.c  module to
monitor ONE battery. So far so good.

I also have a Dual Smart Battery System Manager
(LTC1760) chip which takes care of multiple batteris=20
by switching SMBus's. I wrote the module and it seems
to work pretty well. I can select the battery and then
basically read the values using
/proc/sys/dev/sensosrs/smartbatt-i2c-0-0b/* files


Question 1)

How should I configure so that I can I see multiple
batteries? Should I create files:
=20
/proc/sys/dev/sensors/ltc1760-i2c-0-0a/
/proc/sys/dev/sensors/ltc1760-i2c-0-0a/batt1_i
/proc/sys/dev/sensors/ltc1760-i2c-0-0a/batt1_v
..
/proc/sys/dev/sensors/ltc1760-i2c-0-0a/batt2_i
/proc/sys/dev/sensors/ltc1760-i2c-0-0a/batt2_v

OR
/proc/sys/dev/sensors/ltc1760-i2c-0-0a/
/proc/sys/dev/sensors/ltc1760-i2c-0-0a/batt1/i
/proc/sys/dev/sensors/ltc1760-i2c-0-0a/batt1/v
..
/proc/sys/dev/sensors/ltc1760-i2c-0-0a/batt2/i
/proc/sys/dev/sensors/ltc1760-i2c-0-0a/batt2/v


Question 2)
I could make my ltc1760.o depend on functions of
smartbatt.o.  or should I really be looking at
/proc/sys/dev/sensors/smartbatt-i2c-0-0b/* files.

Any suggestions?

mm


	=09
__________________________________=20
Do you Yahoo!?=20
All your favorites on one personal page =96 Try My Yahoo!
http://my.yahoo.com=20
