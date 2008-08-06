From: Marc Hulsman <m.hulsman@tudelft.nl>
Date: Wed, 06 Aug 2008 07:05:05 +0000
Subject: [lm-sensors] Fwd: [PATCH 0/4] hwmon: (w83791d) refresh fandiv patch
Message-Id: <200808060905.06044.m.hulsman@tudelft.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_i0UmIwBZcUnDJe9"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--Boundary-00=_i0UmIwBZcUnDJe9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Andrew,

I understand hwmon patches have to be send directly to you for inclusion. The 
following bug-fix patch has been Acked-by Jean back in May: 
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023178.html
hereby a refresh (just chunk positions) so that it applies clean to the 
new-style version of the driver. 

Regards,
Marc


---
Update w83791d with fan bits in vbat mon register (7.48 of the
datasheet). This change allows all fans to have a divisor of 128, 
and fixes a problem with incorrectly reported fan speeds. 

Signed-off-by: Marc Hulsman <m.hulsman@tudelft.nl>
Acked-by: Jean Delvare <khali@linux-fr.org>
---

 Documentation/hwmon/w83791d |    6 +++---
 drivers/hwmon/w83791d.c     |   24 ++++++++++++++++++++----
 2 files changed, 23 insertions(+), 7 deletions(-) 
---
diff -uprN linux-2.6.26-rc1-git6/drivers/hwmon/w83791d.c 
linux-2.6.26-rc1-git6-modified2/drivers/hwmon/w83791d.c
--- linux-2.6.26-rc1-git6/drivers/hwmon/w83791d.c	2008-05-03 
20:59:44.000000000 +0200
+++ linux-2.6.26-rc1-git6-modified2/drivers/hwmon/w83791d.c	2008-05-16 
22:13:15.000000000 +0200
@@ -233,11 +233,9 @@ static u8 fan_to_reg(long rpm, int div)
 static u8 div_to_reg(int nr, long val)
 {
 	int i;
-	int max;
 
-	/* first three fan's divisor max out at 8, rest max out at 128 */
-	max = (nr < 3) ? 8 : 128;
-	val = SENSORS_LIMIT(val, 1, max) >> 1;
+	/* fan divisors max out at 128 */
+	val = SENSORS_LIMIT(val, 1, 128) >> 1;
 	for (i = 0; i < 7; i++) {
 		if (val == 0)
 			break;
@@ -519,6 +517,7 @@ static ssize_t store_fan_div(struct devi
 	unsigned long min;
 	u8 tmp_fan_div;
 	u8 fan_div_reg;
+	u8 vbat_reg;
 	int indx = 0;
 	u8 keep_mask = 0;
 	u8 new_shift = 0;
@@ -570,6 +569,16 @@ static ssize_t store_fan_div(struct devi
 	w83791d_write(client, W83791D_REG_FAN_DIV[indx],
 				fan_div_reg | tmp_fan_div);
 
+	/* Bit 2 of fans 0-2 is stored in the vbat register (bits 5-7) */
+	if (nr < 3) {
+		keep_mask = ~(1 << (nr + 5));
+		vbat_reg = w83791d_read(client, W83791D_REG_VBAT)
+				& keep_mask;
+		tmp_fan_div = (data->fan_div[nr] << (3 + nr)) & ~keep_mask;
+		w83791d_write(client, W83791D_REG_VBAT,
+				vbat_reg | tmp_fan_div);
+	}
+
 	/* Restore fan_min */
 	data->fan_min[nr] = fan_to_reg(min, DIV_FROM_REG(data->fan_div[nr]));
 	w83791d_write(client, W83791D_REG_FAN_MIN[nr], data->fan_min[nr]);
@@ -1245,6 +1254,7 @@ static struct w83791d_data *w83791d_upda
 	struct w83791d_data *data = i2c_get_clientdata(client);
 	int i, j;
 	u8 reg_array_tmp[3];
+	u8 vbat_reg;
 
 	mutex_lock(&data->update_lock);
 
@@ -1282,6 +1292,12 @@ static struct w83791d_data *w83791d_upda
 		data->fan_div[3] = reg_array_tmp[2] & 0x07;
 		data->fan_div[4] = (reg_array_tmp[2] >> 4) & 0x07;
 
+		/* The fan divisor for fans 0-2 get bit 2 from
+		   bits 5-7 respectively of vbat register */
+		vbat_reg = w83791d_read(client, W83791D_REG_VBAT);
+		for (i = 0; i < 3; i++)
+			data->fan_div[i] |= (vbat_reg >> (3 + i)) & 0x04;
+
 		/* Update the first temperature sensor */
 		for (i = 0; i < 3; i++) {
 			data->temp1[i] = w83791d_read(client,
diff -uprN linux-2.6.26-rc1-git6/Documentation/hwmon/w83791d 
linux-2.6.26-rc1-git6-modified2/Documentation/hwmon/w83791d
--- linux-2.6.26-rc1-git6/Documentation/hwmon/w83791d	2008-05-03 
20:59:44.000000000 +0200
+++ linux-2.6.26-rc1-git6-modified2/Documentation/hwmon/w83791d	2008-05-16 
22:10:16.000000000 +0200
@@ -22,6 +22,7 @@ Credits:
 
 Additional contributors:
     Sven Anders <anders@anduras.de>
+    Marc Hulsman <m.hulsman@tudelft.nl>
 
 Module Parameters
 -----------------
@@ -67,9 +68,8 @@ on until the temperature falls below the
 
 Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
 triggered if the rotation speed has dropped below a programmable limit. Fan
-readings can be divided by a programmable divider (1, 2, 4, 8 for fan 1/2/3
-and 1, 2, 4, 8, 16, 32, 64 or 128 for fan 4/5) to give the readings more
-range or accuracy.
+readings can be divided by a programmable divider (1, 2, 4, 8, 16,
+32, 64 or 128 for all fans) to give the readings more range or accuracy.
 
 Voltage sensors (also known as IN sensors) report their values in millivolts.
 An alarm is triggered if the voltage has crossed a programmable minimum



-------------------------------------------------------

--Boundary-00=_i0UmIwBZcUnDJe9
Content-Type: text/x-diff; charset="us-ascii"; name="w83791d_fandiv.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="w83791d_fandiv.patch"

Update w83791d with fan bits in vbat mon register (7.48 of the
datasheet). This change allows all fans to have a divisor of 128, 
and fixes a problem with incorrectly reported fan speeds. 

Signed-off-by: Marc Hulsman <m.hulsman@tudelft.nl>
Acked-by: Jean Delvare <khali@linux-fr.org>
---

 Documentation/hwmon/w83791d |    6 +++---
 drivers/hwmon/w83791d.c     |   24 ++++++++++++++++++++----
 2 files changed, 23 insertions(+), 7 deletions(-) 
---
diff -uprN linux-2.6.26-rc1-git6/drivers/hwmon/w83791d.c linux-2.6.26-rc1-git6-modified2/drivers/hwmon/w83791d.c
--- linux-2.6.26-rc1-git6/drivers/hwmon/w83791d.c	2008-05-03 20:59:44.000000000 +0200
+++ linux-2.6.26-rc1-git6-modified2/drivers/hwmon/w83791d.c	2008-05-16 22:13:15.000000000 +0200
@@ -233,11 +233,9 @@ static u8 fan_to_reg(long rpm, int div)
 static u8 div_to_reg(int nr, long val)
 {
 	int i;
-	int max;
 
-	/* first three fan's divisor max out at 8, rest max out at 128 */
-	max = (nr < 3) ? 8 : 128;
-	val = SENSORS_LIMIT(val, 1, max) >> 1;
+	/* fan divisors max out at 128 */
+	val = SENSORS_LIMIT(val, 1, 128) >> 1;
 	for (i = 0; i < 7; i++) {
 		if (val == 0)
 			break;
@@ -519,6 +517,7 @@ static ssize_t store_fan_div(struct devi
 	unsigned long min;
 	u8 tmp_fan_div;
 	u8 fan_div_reg;
+	u8 vbat_reg;
 	int indx = 0;
 	u8 keep_mask = 0;
 	u8 new_shift = 0;
@@ -570,6 +569,16 @@ static ssize_t store_fan_div(struct devi
 	w83791d_write(client, W83791D_REG_FAN_DIV[indx],
 				fan_div_reg | tmp_fan_div);
 
+	/* Bit 2 of fans 0-2 is stored in the vbat register (bits 5-7) */
+	if (nr < 3) {
+		keep_mask = ~(1 << (nr + 5));
+		vbat_reg = w83791d_read(client, W83791D_REG_VBAT)
+				& keep_mask;
+		tmp_fan_div = (data->fan_div[nr] << (3 + nr)) & ~keep_mask;
+		w83791d_write(client, W83791D_REG_VBAT,
+				vbat_reg | tmp_fan_div);
+	}
+
 	/* Restore fan_min */
 	data->fan_min[nr] = fan_to_reg(min, DIV_FROM_REG(data->fan_div[nr]));
 	w83791d_write(client, W83791D_REG_FAN_MIN[nr], data->fan_min[nr]);
@@ -1245,6 +1254,7 @@ static struct w83791d_data *w83791d_upda
 	struct w83791d_data *data = i2c_get_clientdata(client);
 	int i, j;
 	u8 reg_array_tmp[3];
+	u8 vbat_reg;
 
 	mutex_lock(&data->update_lock);
 
@@ -1282,6 +1292,12 @@ static struct w83791d_data *w83791d_upda
 		data->fan_div[3] = reg_array_tmp[2] & 0x07;
 		data->fan_div[4] = (reg_array_tmp[2] >> 4) & 0x07;
 
+		/* The fan divisor for fans 0-2 get bit 2 from
+		   bits 5-7 respectively of vbat register */
+		vbat_reg = w83791d_read(client, W83791D_REG_VBAT);
+		for (i = 0; i < 3; i++)
+			data->fan_div[i] |= (vbat_reg >> (3 + i)) & 0x04;
+
 		/* Update the first temperature sensor */
 		for (i = 0; i < 3; i++) {
 			data->temp1[i] = w83791d_read(client,
diff -uprN linux-2.6.26-rc1-git6/Documentation/hwmon/w83791d linux-2.6.26-rc1-git6-modified2/Documentation/hwmon/w83791d
--- linux-2.6.26-rc1-git6/Documentation/hwmon/w83791d	2008-05-03 20:59:44.000000000 +0200
+++ linux-2.6.26-rc1-git6-modified2/Documentation/hwmon/w83791d	2008-05-16 22:10:16.000000000 +0200
@@ -22,6 +22,7 @@ Credits:
 
 Additional contributors:
     Sven Anders <anders@anduras.de>
+    Marc Hulsman <m.hulsman@tudelft.nl>
 
 Module Parameters
 -----------------
@@ -67,9 +68,8 @@ on until the temperature falls below the
 
 Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
 triggered if the rotation speed has dropped below a programmable limit. Fan
-readings can be divided by a programmable divider (1, 2, 4, 8 for fan 1/2/3
-and 1, 2, 4, 8, 16, 32, 64 or 128 for fan 4/5) to give the readings more
-range or accuracy.
+readings can be divided by a programmable divider (1, 2, 4, 8, 16,
+32, 64 or 128 for all fans) to give the readings more range or accuracy.
 
 Voltage sensors (also known as IN sensors) report their values in millivolts.
 An alarm is triggered if the voltage has crossed a programmable minimum



--Boundary-00=_i0UmIwBZcUnDJe9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Boundary-00=_i0UmIwBZcUnDJe9--

