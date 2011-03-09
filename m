From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 09 Mar 2011 19:57:09 +0000
Subject: [lm-sensors] [PATCH 03/10] hwmon/f71882fg: Only allow negative auto
Message-Id: <1299700636-9699-4-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/f71882fg.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 5ad05d7..2b45af9 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -84,6 +84,9 @@
 
 #define F71882FG_REG_FAN_HYST(nr)	(0x98 + (nr))
 
+#define F71882FG_REG_FAN_FAULT_T	0x9F
+#define F71882FG_FAN_NEG_TEMP_EN	0x20
+
 #define F71882FG_REG_POINT_PWM(pwm, point)	(0xAA + (point) + (16 * (pwm)))
 #define F71882FG_REG_POINT_TEMP(pwm, point)	(0xA6 + (point) + (16 * (pwm)))
 #define F71882FG_REG_POINT_MAPPING(nr)		(0xAF + 16 * (nr))
@@ -127,6 +130,7 @@ struct f71882fg_data {
 	struct mutex update_lock;
 	int temp_start;			/* temp numbering start (0 or 1) */
 	char valid;			/* !=0 if following fields are valid */
+	char auto_point_temp_signed;
 	unsigned long last_updated;	/* In jiffies */
 	unsigned long last_limits;	/* In jiffies */
 
@@ -1851,7 +1855,7 @@ static ssize_t store_pwm_auto_point_temp(struct device *dev,
 
 	val /= 1000;
 
-	if (data->type = f71889fg)
+	if (data->auto_point_temp_signed)
 		val = SENSORS_LIMIT(val, -128, 127);
 	else
 		val = SENSORS_LIMIT(val, 0, 127);
@@ -1898,7 +1902,7 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 	struct f71882fg_data *data;
 	struct f71882fg_sio_data *sio_data = pdev->dev.platform_data;
 	int err, i, nr_fans = (sio_data->type = f71882fg) ? 4 : 3;
-	u8 start_reg;
+	u8 start_reg, reg;
 
 	data = kzalloc(sizeof(struct f71882fg_data), GFP_KERNEL);
 	if (!data)
@@ -1968,6 +1972,16 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 	}
 
 	if (start_reg & 0x02) {
+		switch (data->type) {
+		case f71889fg:
+			reg = f71882fg_read8(data, F71882FG_REG_FAN_FAULT_T);
+			if (reg & F71882FG_FAN_NEG_TEMP_EN)
+				data->auto_point_temp_signed = 1;
+			break;
+		default:
+			break;
+		}
+
 		data->pwm_enable  			f71882fg_read8(data, F71882FG_REG_PWM_ENABLE);
 
-- 
1.7.3.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
