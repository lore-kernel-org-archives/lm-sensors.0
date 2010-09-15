From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 14:00:48 +0000
Subject: [lm-sensors] [patch 23/36] hwmon: (w83795) Avoid reading the same
Message-Id: <20100915160048.7c348bfe@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Shorten driver load time by avoiding duplicate register access during
initialization. This saves 112 ms on modprobe on my test system.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:13:57.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:13:59.000000000 +0200
@@ -1986,6 +1986,9 @@ static int w83795_probe(struct i2c_clien
 		data->in[i][IN_READ] = tmp;
 	}
 	for (i = 0; i < IN_LSB_REG_NUM; i++) {
+		if ((i = 2 && data->chip_type = w83795adg) ||
+		    (i >= 4 && !(data->has_in & (1 << (i + 11)))))
+			continue;
 		data->in_lsb[i][IN_MAX]  			w83795_read(client, IN_LSB_REG(i, IN_MAX));
 		data->in_lsb[i][IN_LOW] @@ -1995,13 +1998,17 @@ static int w83795_probe(struct i2c_clien
 
 	/* First update fan and limits */
 	for (i = 0; i < ARRAY_SIZE(data->fan); i++) {
+		/* Each register contains LSB for 2 fans, but we want to
+		 * read it only once to save time */
+		if ((i & 1) = 0 && (data->has_fan & (3 << i)))
+			tmp = w83795_read(client, W83795_REG_FAN_MIN_LSB(i));
+
 		if (!(data->has_fan & (1 << i)))
 			continue;
 		data->fan_min[i]  			w83795_read(client, W83795_REG_FAN_MIN_HL(i)) << 4;
 		data->fan_min[i] |-		  (w83795_read(client, W83795_REG_FAN_MIN_LSB(i)) >>
-			W83795_REG_FAN_MIN_LSB_SHIFT(i)) & 0x0F;
+			(tmp >> W83795_REG_FAN_MIN_LSB_SHIFT(i)) & 0x0F;
 		data->fan[i] = w83795_read(client, W83795_REG_FAN(i)) << 4;
 		data->fan[i] | 		  (w83795_read(client, W83795_REG_VRLSB) >> 4) & 0x0F;


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
