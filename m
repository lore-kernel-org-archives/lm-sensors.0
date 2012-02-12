From: Chris <silverchris@gmail.com>
Date: Sun, 12 Feb 2012 03:00:39 +0000
Subject: [lm-sensors] [Patch] hwmon: (max6639) Set Pulse per revolution loop for both channels
Message-Id: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Moved Fan Pulse per revolution into a loop so that both channel 1 and
channel 2 get set, instead of just channel 1


Signed-off-by: Chris D Schimp <silverchris@gmail.com>

---
diff -uprN -X vanilla/linux-3.2.5/Documentation/dontdiff
vanilla/linux-3.2.5/drivers/hwmon/max6639.c
devel/linux-3.2.5/drivers/hwmon/max6639.c
--- vanilla/linux-3.2.5/drivers/hwmon/max6639.c	2012-02-06
12:47:00.000000000 -0500
+++ devel/linux-3.2.5/drivers/hwmon/max6639.c	2012-02-11
21:40:02.399127171 -0500
@@ -439,25 +439,24 @@ static int max6639_init_client(struct i2
 	if (err)
 		goto exit;

-	/* Fans pulse per revolution is 2 by default */
-	if (max6639_info && max6639_info->ppr > 0 &&
-			max6639_info->ppr < 5)
-		data->ppr = max6639_info->ppr;
-	else
-		data->ppr = 2;
-	data->ppr -= 1;
-	err = i2c_smbus_write_byte_data(client,
-			MAX6639_REG_FAN_PPR(i),
-			data->ppr << 5);
-	if (err)
-		goto exit;
-
 	if (max6639_info)
 		rpm_range = rpm_range_to_reg(max6639_info->rpm_range);
 	data->rpm_range = rpm_range;

 	for (i = 0; i < 2; i++) {

+		/* Fans pulse per revolution is 2 by default */
+		if (max6639_info && max6639_info->ppr > 0 &&
+				max6639_info->ppr < 5)
+			data->ppr = max6639_info->ppr;
+		else
+			data->ppr = 2;
+		data->ppr -= 1;
+		err = i2c_smbus_write_byte_data(client,
+			MAX6639_REG_FAN_PPR(i),
+			data->ppr << 5);
+		if (err)
+			goto exit;
 		/* Fans config PWM, RPM */
 		err = i2c_smbus_write_byte_data(client,
 			MAX6639_REG_FAN_CONFIG1(i),

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
