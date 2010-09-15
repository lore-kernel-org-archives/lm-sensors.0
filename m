From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 13:57:23 +0000
Subject: [lm-sensors] [patch 16/36] hwmon: (w83795) Fix LSB reading of fan
Message-Id: <20100915155723.27054313@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Misplaced parentheses caused the wrong register value to be read,
resulting in random LSB for fan speed values and limits.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:12:53.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:12:56.000000000 +0200
@@ -272,7 +272,7 @@ static inline u16 in_to_reg(u8 index, u1
 
 static inline unsigned long fan_from_reg(u16 val)
 {
-	if ((val >= 0xff0) || (val = 0))
+	if ((val = 0xfff) || (val = 0))
 		return 0;
 	return 1350000UL / val;
 }
@@ -456,7 +456,7 @@ static struct w83795_data *w83795_update
 			continue;
 		data->fan[i] = w83795_read(client, W83795_REG_FAN(i)) << 4;
 		data->fan[i] |-		  (w83795_read(client, W83795_REG_VRLSB >> 4)) & 0x0F;
+		  (w83795_read(client, W83795_REG_VRLSB) >> 4) & 0x0F;
 	}
 
 	/* Update temperature */
@@ -1940,11 +1940,11 @@ static int w83795_probe(struct i2c_clien
 		data->fan_min[i]  			w83795_read(client, W83795_REG_FAN_MIN_HL(i)) << 4;
 		data->fan_min[i] |-		  (w83795_read(client, W83795_REG_FAN_MIN_LSB(i) >>
-			W83795_REG_FAN_MIN_LSB_SHIFT(i))) & 0x0F;
+		  (w83795_read(client, W83795_REG_FAN_MIN_LSB(i)) >>
+			W83795_REG_FAN_MIN_LSB_SHIFT(i)) & 0x0F;
 		data->fan[i] = w83795_read(client, W83795_REG_FAN(i)) << 4;
 		data->fan[i] |-		  (w83795_read(client, W83795_REG_VRLSB >> 4)) & 0x0F;
+		  (w83795_read(client, W83795_REG_VRLSB) >> 4) & 0x0F;
 	}
 
 	/* temperature and limits */


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
