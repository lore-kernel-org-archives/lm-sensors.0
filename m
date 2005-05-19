From: Claus.Rosenberger@rocnet.de (Claus Rosenberger)
Date: Thu, 19 May 2005 06:23:48 +0000
Subject: sensors with K7S5A
Message-Id: <34986.10.20.2.100.1045593851.squirrel@deathstar.of.rocnet.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

i try to use lm_sensors with my K7S5A Mainboard.

sensors-detect reports following result :

Use driver `i2c-sis645' for device 00:00.0: Silicon Integrated Systems SIS735
Use driver `i2c-sis5595' for device 00:02.0: Silicon Integrated Systems
SIS5595
Use driver `i2c-matroxfb' for device 01:00.0: MGA G200 AGP

While loading this drivers i get failures because no devices deteced.

In the mainboard list you linked too my mainbard has the SIS950 chipset
which is in driver it87 included.

Loading this drivers is ok but sensors reports "No sensors found!"

What to do now ??

Thanks,
   Claus

