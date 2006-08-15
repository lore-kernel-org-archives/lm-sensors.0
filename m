From: hans@steegers.nl (Hans Steegers)
Date: Tue, 15 Aug 2006 18:11:31 +0000
Subject: [lm-sensors] error in mkpatch.pl of lm_sensors 2.10.0
Message-Id: <002301c6c096$3cb72220$d620a8c0@pcw_hans.hnsasd.lan>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
I found an error in the mkpatch.pl script of lm_sensors 2.10.0,
causing the build of a patched 2.4.32/33 kernel to fail.
The following mini-patch corrects the error:
%<---------------------------------------------->%
--- mkpatch.pl.orig     2006-02-15 02:46:48.000000000 +0100
+++ mkpatch.pl  2006-08-15 19:51:34.000000000 +0200
@@ -1027,7 +1027,7 @@
 obj-$(CONFIG_SENSORS_DDCMON)   += ddcmon.o
 obj-$(CONFIG_SENSORS_DS1621)   += ds1621.o
 obj-$(CONFIG_SENSORS_EEPROM)   += eeprom.o
-obj-$(CONFIG_SENSORS_FSCHER)   += f71085f.o
+obj-$(CONFIG_SENSORS_F71805F)  += f71805f.o
 obj-$(CONFIG_SENSORS_FSCHER)   += fscher.o
 obj-$(CONFIG_SENSORS_FSCPOS)   += fscpos.o
 obj-$(CONFIG_SENSORS_FSCSCY)   += fscscy.o
%<---------------------------------------------->%

cheers,
Hans Steegers



