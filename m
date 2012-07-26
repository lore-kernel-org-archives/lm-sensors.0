From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 Jul 2012 20:13:47 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (jc42) Simplify hysteresis mask
Message-Id: <20120726221347.478d4cd7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Define JC42_CFG_HYST_MASK as the mask _before_ shifting instead of
after shifting. This simplifies the current code slightly, and will
simplify the code to come even more.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/jc42.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- linux-3.5.orig/drivers/hwmon/jc42.c	2012-07-26 22:02:32.000000000 +0200
+++ linux-3.5/drivers/hwmon/jc42.c	2012-07-26 22:04:46.911073234 +0200
@@ -57,7 +57,7 @@ static const unsigned short normal_i2c[]
 #define JC42_CFG_EVENT_LOCK	(1 << 7)
 #define JC42_CFG_SHUTDOWN	(1 << 8)
 #define JC42_CFG_HYST_SHIFT	9
-#define JC42_CFG_HYST_MASK	0x03
+#define JC42_CFG_HYST_MASK	(0x03 << 9)
 
 /* Capabilities */
 #define JC42_CAP_RANGE		(1 << 2)
@@ -287,8 +287,8 @@ static ssize_t show_temp_crit_hyst(struc
 		return PTR_ERR(data);
 
 	temp = jc42_temp_from_reg(data->temp_crit);
-	hyst = jc42_hysteresis[(data->config >> JC42_CFG_HYST_SHIFT)
-			       & JC42_CFG_HYST_MASK];
+	hyst = jc42_hysteresis[(data->config & JC42_CFG_HYST_MASK)
+			       >> JC42_CFG_HYST_SHIFT];
 	return sprintf(buf, "%d\n", temp - hyst);
 }
 
@@ -302,8 +302,8 @@ static ssize_t show_temp_max_hyst(struct
 		return PTR_ERR(data);
 
 	temp = jc42_temp_from_reg(data->temp_max);
-	hyst = jc42_hysteresis[(data->config >> JC42_CFG_HYST_SHIFT)
-			       & JC42_CFG_HYST_MASK];
+	hyst = jc42_hysteresis[(data->config & JC42_CFG_HYST_MASK)
+			       >> JC42_CFG_HYST_SHIFT];
 	return sprintf(buf, "%d\n", temp - hyst);
 }
 
@@ -362,8 +362,7 @@ static ssize_t set_temp_crit_hyst(struct
 	}
 
 	mutex_lock(&data->update_lock);
-	data->config = (data->config
-			& ~(JC42_CFG_HYST_MASK << JC42_CFG_HYST_SHIFT))
+	data->config = (data->config & ~JC42_CFG_HYST_MASK)
 	  | (hyst << JC42_CFG_HYST_SHIFT);
 	err = i2c_smbus_write_word_swapped(client, JC42_REG_CONFIG,
 					   data->config);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
