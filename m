From: grant_lkml@dodo.com.au (Grant Coady)
Date: Fri, 27 May 2005 05:31:26 +0000
Subject: [lm-sensors] RFC PATCH I2C: w83781d: remove redundant w83697hf,
Message-Id: <eq4d91hhldf7u9jjp8s03hc7qrv0e9jo1k@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

This patch replaces previous one posted this day, removing redundant 
drivers w83697hf, w83627hf, w83627thf from w83781d as they are handled 
by the w83627hf driver.  Compile tested.

--Grant.

Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 w83781d.c |   78 +++++++++++++++++++-------------------------------------------
 1 files changed, 24 insertions(+), 54 deletions(-)

--- linux-2.6.12-rc5-mm1/drivers/i2c/chips/w83781d.c	2005-05-26 09:40:14.000000000 +1000
+++ linux-2.6.12-rc5-mm1a/drivers/i2c/chips/w83781d.c	2005-05-27 13:22:57.000000000 +1000
@@ -27,11 +27,8 @@
     as99127f	7	3	0	3	0x31	0x12c3	yes	no
     as99127f rev.2 (type_name = as99127f)	0x31	0x5ca3	yes	no
     w83781d	7	3	0	3	0x10-1	0x5ca3	yes	yes
-    w83627hf	9	3	2	3	0x21	0x5ca3	yes	yes(LPC)
-    w83627thf	9	3	2	3	0x90	0x5ca3	no	yes(LPC)
     w83782d	9	3	2-4	3	0x30	0x5ca3	yes	yes
     w83783s	5-6	3	2	1-2	0x40	0x5ca3	yes	no
-    w83697hf	8	2	2	2	0x60	0x5ca3	no	yes(LPC)
 
 */
 
@@ -52,7 +49,7 @@
 static unsigned int normal_isa[] = { 0x0290, I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_6(w83781d, w83782d, w83783s, w83627hf, as99127f, w83697hf);
+SENSORS_INSMOD_4(w83781d, w83782d, w83783s, as99127f);
 I2C_CLIENT_MODULE_PARM(force_subclients, "List of subclient addresses: "
 		    "{bus, clientaddr, subclientaddr1, subclientaddr2}");
 
@@ -116,7 +113,7 @@
 #define W83781D_REG_VBAT		0x5D
 
 /* PWM 782D (1-4) and 783S (1-2) only */
-#define W83781D_REG_PWM1		0x5B	/* 782d and 783s/627hf datasheets disagree */
+#define W83781D_REG_PWM1		0x5B	/* 782d and 783s datasheets disagree */
 						/* on which is which; */
 #define W83781D_REG_PWM2		0x5A	/* We follow the 782d convention here, */
 						/* However 782d is probably wrong. */
@@ -932,8 +929,6 @@
 		client_name = "w83782d subclient";
 	else if (kind = w83783s)
 		client_name = "w83783s subclient";
-	else if (kind = w83627hf)
-		client_name = "w83627hf subclient";
 	else if (kind = as99127f)
 		client_name = "as99127f subclient";
 
@@ -998,7 +993,7 @@
 		err = -EINVAL;
 		goto ERROR0;
 	}
-	if (!is_isa && kind = w83697hf) {
+	if (!is_isa) {
 		dev_err(&adapter->dev,
 			"Cannot force ISA-only chip for I2C address 0x%02x.\n",
 			address);
@@ -1137,12 +1132,8 @@
 		else if (val1 = 0x40 && vendid = winbond && !is_isa
 				&& address = 0x2d)
 			kind = w83783s;
-		else if ((val1 = 0x21 || val1 = 0x90) && vendid = winbond)
-			kind = w83627hf;
 		else if (val1 = 0x31 && !is_isa && address >= 0x28)
 			kind = as99127f;
-		else if (val1 = 0x60 && vendid = winbond && is_isa)
-			kind = w83697hf;
 		else {
 			if (kind = 0)
 				dev_warn(&new_client->dev, "Ignoring 'force' "
@@ -1160,15 +1151,8 @@
 		client_name = "w83782d";
 	} else if (kind = w83783s) {
 		client_name = "w83783s";
-	} else if (kind = w83627hf) {
-		if (val1 = 0x90)
-			client_name = "w83627thf";
-		else
-			client_name = "w83627hf";
 	} else if (kind = as99127f) {
 		client_name = "as99127f";
-	} else if (kind = w83697hf) {
-		client_name = "w83697hf";
 	}
 
 	/* Fill in the remaining client fields and put into the global list */
@@ -1206,7 +1190,7 @@
 
 	/* Register sysfs hooks */
 	device_create_file_in(new_client, 0);
-	if (kind != w83783s && kind != w83697hf)
+	if (kind != w83783s)
 		device_create_file_in(new_client, 1);
 	device_create_file_in(new_client, 2);
 	device_create_file_in(new_client, 3);
@@ -1220,24 +1204,20 @@
 
 	device_create_file_fan(new_client, 1);
 	device_create_file_fan(new_client, 2);
-	if (kind != w83697hf)
-		device_create_file_fan(new_client, 3);
+	device_create_file_fan(new_client, 3);
 
 	device_create_file_temp(new_client, 1);
 	device_create_file_temp(new_client, 2);
-	if (kind != w83783s && kind != w83697hf)
+	if (kind != w83783s)
 		device_create_file_temp(new_client, 3);
 
-	if (kind != w83697hf)
-		device_create_file_vid(new_client);
+	device_create_file_vid(new_client);
 
-	if (kind != w83697hf)
-		device_create_file_vrm(new_client);
+	device_create_file_vrm(new_client);
 
 	device_create_file_fan_div(new_client, 1);
 	device_create_file_fan_div(new_client, 2);
-	if (kind != w83697hf)
-		device_create_file_fan_div(new_client, 3);
+	device_create_file_fan_div(new_client, 3);
 
 	device_create_file_alarms(new_client);
 
@@ -1256,7 +1236,7 @@
 	if (kind != as99127f && kind != w83781d) {
 		device_create_file_sensor(new_client, 1);
 		device_create_file_sensor(new_client, 2);
-		if (kind != w83783s && kind != w83697hf)
+		if (kind != w83783s)
 			device_create_file_sensor(new_client, 3);
 	}
 
@@ -1479,7 +1459,7 @@
 				else
 					data->sens[i - 1] = 2;
 			}
-			if ((type = w83783s || type = w83697hf) && (i = 2))
+			if ((type = w83783s) && (i = 2))
 				break;
 		}
 	}
@@ -1495,7 +1475,7 @@
 		}
 
 		/* Enable temp3 */
-		if (type != w83783s && type != w83697hf) {
+		if (type != w83783s) {
 			tmp = w83781d_read_value(client,
 				W83781D_REG_TEMP3_CONFIG);
 			if (tmp & 0x01) {
@@ -1536,8 +1516,7 @@
 		dev_dbg(dev, "Starting device update\n");
 
 		for (i = 0; i <= 8; i++) {
-			if ((data->type = w83783s || data->type = w83697hf)
-			    && (i = 1))
+			if ((data->type = w83783s) && (i = 1))
 				continue;	/* 783S has no in1 */
 			data->in[i]  			    w83781d_read_value(client, W83781D_REG_IN(i));
@@ -1545,8 +1524,7 @@
 			    w83781d_read_value(client, W83781D_REG_IN_MIN(i));
 			data->in_max[i]  			    w83781d_read_value(client, W83781D_REG_IN_MAX(i));
-			if ((data->type != w83782d) && (data->type != w83697hf)
-			    && (data->type != w83627hf) && (i = 6))
+			if ((data->type != w83782d) && (i = 6))
 				break;
 		}
 		for (i = 1; i <= 3; i++) {
@@ -1561,8 +1539,8 @@
 				    w83781d_read_value(client,
 						       W83781D_REG_PWM(i));
 				if ((data->type != w83782d
-				     || i2c_is_isa_client(client))
-				    && i = 2)
+						|| i2c_is_isa_client(client))
+						&& i = 2)
 					break;
 			}
 			/* Only PWM2 can be disabled */
@@ -1581,7 +1559,7 @@
 		    w83781d_read_value(client, W83781D_REG_TEMP_OVER(2));
 		data->temp_max_hyst_add[0]  		    w83781d_read_value(client, W83781D_REG_TEMP_HYST(2));
-		if (data->type != w83783s && data->type != w83697hf) {
+		if (data->type != w83783s) {
 			data->temp_add[1]  			    w83781d_read_value(client, W83781D_REG_TEMP(3));
 			data->temp_max_add[1] @@ -1592,32 +1570,24 @@
 					       W83781D_REG_TEMP_HYST(3));
 		}
 		i = w83781d_read_value(client, W83781D_REG_VID_FANDIV);
-		if (data->type != w83697hf) {
-			data->vid = i & 0x0f;
-			data->vid |-			    (w83781d_read_value(client, W83781D_REG_CHIPID) &
-			     0x01)
-			    << 4;
-		}
+		data->vid = i & 0x0f;
+		data->vid |= (w83781d_read_value(client,
+					W83781D_REG_CHIPID) & 0x01) << 4;
 		data->fan_div[0] = (i >> 4) & 0x03;
 		data->fan_div[1] = (i >> 6) & 0x03;
-		if (data->type != w83697hf) {
-			data->fan_div[2] = (w83781d_read_value(client,
-							       W83781D_REG_PIN)
-					    >> 6) & 0x03;
-		}
+		data->fan_div[2] = (w83781d_read_value(client,
+					W83781D_REG_PIN) >> 6) & 0x03;
 		if ((data->type != w83781d) && (data->type != as99127f)) {
 			i = w83781d_read_value(client, W83781D_REG_VBAT);
 			data->fan_div[0] |= (i >> 3) & 0x04;
 			data->fan_div[1] |= (i >> 4) & 0x04;
-			if (data->type != w83697hf)
-				data->fan_div[2] |= (i >> 5) & 0x04;
+			data->fan_div[2] |= (i >> 5) & 0x04;
 		}
 		data->alarms  		    w83781d_read_value(client,
 				       W83781D_REG_ALARM1) +
 		    (w83781d_read_value(client, W83781D_REG_ALARM2) << 8);
-		if ((data->type = w83782d) || (data->type = w83627hf)) {
+		if (data->type = w83782d) {
 			data->alarms | 			    w83781d_read_value(client,
 					       W83781D_REG_ALARM3) << 16;
