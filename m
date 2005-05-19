From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: [PATCH] I2C update for 2.6.8-rc1
Message-Id: <1089850035501@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10898500321009@kroah.com>
References: <10898500251206@kroah.com>
In-Reply-To: <10898500251206@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1784.13.13, 2004/07/14 11:50:09-07:00, mhoffman@lightlink.com

[PATCH] I2C: Remove extra inits from lm78 driver

This patch is from the lm_sensors project CVS, from this revision:

	1.63 (mds) remove initialization of limits by driver

It is better to set these limits by a combination of /etc/sensors.conf
and 'sensors -s'; "mechanism not policy."  Please apply.

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/lm78.c |   88 -----------------------------------------------
 1 files changed, 88 deletions(-)


diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	2004-07-14 16:59:07 -07:00
+++ b/drivers/i2c/chips/lm78.c	2004-07-14 16:59:07 -07:00
@@ -123,55 +123,6 @@
 }
 #define DIV_FROM_REG(val) (1 << (val))
 
-/* Initial limits. To keep them sane, we use the 'standard' translation as
-   specified in the LM78 sheet. Use the config file to set better limits. */
-#define LM78_INIT_IN_0(vid) ((vid)=3500 ? 2800 : (vid))
-#define LM78_INIT_IN_1(vid) ((vid)=3500 ? 2800 : (vid))
-#define LM78_INIT_IN_2 3300
-#define LM78_INIT_IN_3 (((5000)   * 100)/168)
-#define LM78_INIT_IN_4 (((12000)  * 10)/38)
-#define LM78_INIT_IN_5 (((-12000) * -604)/2100)
-#define LM78_INIT_IN_6 (((-5000)  * -604)/909)
-
-#define LM78_INIT_IN_PERCENTAGE 10
-
-#define LM78_INIT_IN_MIN_0(vid) (LM78_INIT_IN_0(vid) - \
-	LM78_INIT_IN_0(vid) * LM78_INIT_IN_PERCENTAGE / 100)
-#define LM78_INIT_IN_MAX_0(vid) (LM78_INIT_IN_0(vid) + \
-	LM78_INIT_IN_0(vid) * LM78_INIT_IN_PERCENTAGE / 100)
-#define LM78_INIT_IN_MIN_1(vid) (LM78_INIT_IN_1(vid) - \
-	LM78_INIT_IN_1(vid) * LM78_INIT_IN_PERCENTAGE / 100)
-#define LM78_INIT_IN_MAX_1(vid) (LM78_INIT_IN_1(vid) + \
-	LM78_INIT_IN_1(vid) * LM78_INIT_IN_PERCENTAGE / 100)
-
-#define LM78_INIT_IN_MIN_2 \
-        (LM78_INIT_IN_2 - LM78_INIT_IN_2 * LM78_INIT_IN_PERCENTAGE / 100)
-#define LM78_INIT_IN_MAX_2 \
-        (LM78_INIT_IN_2 + LM78_INIT_IN_2 * LM78_INIT_IN_PERCENTAGE / 100)
-#define LM78_INIT_IN_MIN_3 \
-        (LM78_INIT_IN_3 - LM78_INIT_IN_3 * LM78_INIT_IN_PERCENTAGE / 100)
-#define LM78_INIT_IN_MAX_3 \
-        (LM78_INIT_IN_3 + LM78_INIT_IN_3 * LM78_INIT_IN_PERCENTAGE / 100)
-#define LM78_INIT_IN_MIN_4 \
-        (LM78_INIT_IN_4 - LM78_INIT_IN_4 * LM78_INIT_IN_PERCENTAGE / 100)
-#define LM78_INIT_IN_MAX_4 \
-        (LM78_INIT_IN_4 + LM78_INIT_IN_4 * LM78_INIT_IN_PERCENTAGE / 100)
-#define LM78_INIT_IN_MIN_5 \
-        (LM78_INIT_IN_5 - LM78_INIT_IN_5 * LM78_INIT_IN_PERCENTAGE / 100)
-#define LM78_INIT_IN_MAX_5 \
-        (LM78_INIT_IN_5 + LM78_INIT_IN_5 * LM78_INIT_IN_PERCENTAGE / 100)
-#define LM78_INIT_IN_MIN_6 \
-        (LM78_INIT_IN_6 - LM78_INIT_IN_6 * LM78_INIT_IN_PERCENTAGE / 100)
-#define LM78_INIT_IN_MAX_6 \
-        (LM78_INIT_IN_6 + LM78_INIT_IN_6 * LM78_INIT_IN_PERCENTAGE / 100)
-
-#define LM78_INIT_FAN_MIN_1 3000
-#define LM78_INIT_FAN_MIN_2 3000
-#define LM78_INIT_FAN_MIN_3 3000
-
-#define LM78_INIT_TEMP_OVER 60000
-#define LM78_INIT_TEMP_HYST 50000
-
 /* There are some complications in a module like this. First off, LM78 chips
    may be both present on the SMBus and the ISA bus, and we have to handle
    those cases separately at some places. Second, there might be several
@@ -755,45 +706,6 @@
 	else
 		vid |= 0x10;
 	vid = VID_FROM_REG(vid);
-
-	lm78_write_value(client, LM78_REG_IN_MIN(0),
-			 IN_TO_REG(LM78_INIT_IN_MIN_0(vid)));
-	lm78_write_value(client, LM78_REG_IN_MAX(0),
-			 IN_TO_REG(LM78_INIT_IN_MAX_0(vid)));
-	lm78_write_value(client, LM78_REG_IN_MIN(1),
-			 IN_TO_REG(LM78_INIT_IN_MIN_1(vid)));
-	lm78_write_value(client, LM78_REG_IN_MAX(1),
-			 IN_TO_REG(LM78_INIT_IN_MAX_1(vid)));
-	lm78_write_value(client, LM78_REG_IN_MIN(2),
-			 IN_TO_REG(LM78_INIT_IN_MIN_2));
-	lm78_write_value(client, LM78_REG_IN_MAX(2),
-			 IN_TO_REG(LM78_INIT_IN_MAX_2));
-	lm78_write_value(client, LM78_REG_IN_MIN(3),
-			 IN_TO_REG(LM78_INIT_IN_MIN_3));
-	lm78_write_value(client, LM78_REG_IN_MAX(3),
-			 IN_TO_REG(LM78_INIT_IN_MAX_3));
-	lm78_write_value(client, LM78_REG_IN_MIN(4),
-			 IN_TO_REG(LM78_INIT_IN_MIN_4));
-	lm78_write_value(client, LM78_REG_IN_MAX(4),
-			 IN_TO_REG(LM78_INIT_IN_MAX_4));
-	lm78_write_value(client, LM78_REG_IN_MIN(5),
-			 IN_TO_REG(LM78_INIT_IN_MIN_5));
-	lm78_write_value(client, LM78_REG_IN_MAX(5),
-			 IN_TO_REG(LM78_INIT_IN_MAX_5));
-	lm78_write_value(client, LM78_REG_IN_MIN(6),
-			 IN_TO_REG(LM78_INIT_IN_MIN_6));
-	lm78_write_value(client, LM78_REG_IN_MAX(6),
-			 IN_TO_REG(LM78_INIT_IN_MAX_6));
-	lm78_write_value(client, LM78_REG_FAN_MIN(0),
-			 FAN_TO_REG(LM78_INIT_FAN_MIN_1, 2));
-	lm78_write_value(client, LM78_REG_FAN_MIN(1),
-			 FAN_TO_REG(LM78_INIT_FAN_MIN_2, 2));
-	lm78_write_value(client, LM78_REG_FAN_MIN(2),
-			 FAN_TO_REG(LM78_INIT_FAN_MIN_3, 2));
-	lm78_write_value(client, LM78_REG_TEMP_OVER,
-			 TEMP_TO_REG(LM78_INIT_TEMP_OVER));
-	lm78_write_value(client, LM78_REG_TEMP_HYST,
-			 TEMP_TO_REG(LM78_INIT_TEMP_HYST));
 
 	/* Start monitoring */
 	lm78_write_value(client, LM78_REG_CONFIG,

