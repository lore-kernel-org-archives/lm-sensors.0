From: mgreer@mvista.com (Mark A. Greer)
Date: Fri, 02 Sep 2005 03:12:12 +0000
Subject: [lm-sensors] [PATCH 2.6.13-mm1] i2c: chips/ds1374.c fixup
Message-Id: <20050902011204.GF10106@mag.az.mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The 'new_time' variable should be static.

Signed-off-by: Mark A. Greer
--

diff -Nur linux-2.6.13-mm1/drivers/i2c/chips/ds1374.c linux-2.6.13-mm1-mag/drivers/i2c/chips/ds1374.c
--- linux-2.6.13-mm1/drivers/i2c/chips/ds1374.c	2005-09-01 16:26:21.000000000 -0700
+++ linux-2.6.13-mm1-mag/drivers/i2c/chips/ds1374.c	2005-09-01 17:01:06.000000000 -0700
@@ -165,7 +165,7 @@
 			 "can't confirm time set from rtc chip\n");
 }
 
-ulong new_time;
+static ulong new_time;
 
 DECLARE_TASKLET_DISABLED(ds1374_tasklet, ds1374_set_tlet, (ulong) & new_time);
 
