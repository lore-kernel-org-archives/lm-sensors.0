From: Andre Prendel <andre.prendel@gmx.de>
Date: Mon, 06 Jul 2009 20:28:46 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Update Texas Instruments
Message-Id: <20090706202845.GA4415@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Support for TI's TMP411 sensor chip is in mainline since
2.6.31-rc1. So now we can refer to the tmp401 driver.
---

Index: sensors/prog/detect/sensors-detect
=================================--- sensors.orig/prog/detect/sensors-detect	2009-07-06 22:12:13.000000000 +0200
+++ sensors/prog/detect/sensors-detect	2009-07-06 22:12:23.000000000 +0200
@@ -904,7 +904,7 @@
 		i2c_detect => sub { lm90_detect(@_, 9); },
 	}, {
 		name => "Texas Instruments TMP411",
-		driver => "to-be-written",
+		driver => "tmp401",
 		i2c_addrs => [0x4c..0x4e],
 		i2c_detect => sub { lm90_detect(@_, 10); },
 	}, {

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
