From: mgreer@mvista.com (Mark A. Greer)
Date: Fri, 02 Sep 2005 03:10:03 +0000
Subject: [lm-sensors] [PATCH 2.6.13-mm1] i2c: chips/m41t00.c fixup
Message-Id: <20050902010954.GE10106@mag.az.mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The 'new_time' variable should be static.

Signed-off-by: Mark A. Greer
--

diff -Nur linux-2.6.13-mm1/drivers/i2c/chips/m41t00.c linux-2.6.13-mm1-mag/drivers/i2c/chips/m41t00.c
--- linux-2.6.13-mm1/drivers/i2c/chips/m41t00.c	2005-09-01 16:26:21.000000000 -0700
+++ linux-2.6.13-mm1-mag/drivers/i2c/chips/m41t00.c	2005-09-01 17:01:13.000000000 -0700
@@ -144,7 +144,7 @@
 	return;
 }
 
-ulong	new_time;
+static ulong	new_time;
 
 DECLARE_TASKLET_DISABLED(m41t00_tasklet, m41t00_set_tlet, (ulong)&new_time);
 
