From: grant_lkml@dodo.com.au (Grant Coady)
Date: Fri, 27 May 2005 05:03:23 +0000
Subject: [lm-sensors] RFC PATCH I2C: w83781d: remove w83697hf as it handled
Message-Id: <uh2d91p7njcalojs3dmb61k3lsvsduic25@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,

Jean Delvare suggested:
>BTW, you'll notice that the w83781d driver
>also has support for that chip - I'd like it ripped off, if you want to
>work on this. Same for the W83627THF support in w83781d 

Step one of several, removed w83697hf.  Compile tested.

--Grant.


Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 w83781d.c |   63 ++++++++++++++++++++++++--------------------------------------
 1 files changed, 25 insertions(+), 38 deletions(-)

--- linux-2.6.12-rc5-mm1/drivers/i2c/chips/w83781d.c	2005-05-26 09:40:14.000000000 +1000
+++ linux-2.6.12-rc5-mm1a/drivers/i2c/chips/w83781d.c	2005-05-27 12:50:20.000000000 +1000
@@ -31,10 +31,13 @@
     w83627thf	9	3	2	3	0x90	0x5ca3	no	yes(LPC)
     w83782d	9	3	2-4	3	0x30	0x5ca3	yes	yes
     w83783s	5-6	3	2	1-2	0x40	0x5ca3	yes	no
-    w83697hf	8	2	2	2	0x60	0x5ca3	no	yes(LPC)
 
 */
 
+/* FIXME remove this block in last patch of set
+ * removed w83697hf
+ * --Grant */
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -52,7 +55,7 @@
 static unsigned int normal_isa[] = { 0x0290, I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_6(w83781d, w83782d, w83783s, w83627hf, as99127f, w83697hf);
+SENSORS_INSMOD_5(w83781d, w83782d, w83783s, w83627hf, as99127f);
 I2C_CLIENT_MODULE_PARM(force_subclients, "List of subclient addresses: "
 		    "{bus, clientaddr, subclientaddr1, subclientaddr2}");
 
@@ -998,7 +1001,7 @@
 		err = -EINVAL;
 		goto ERROR0;
 	}
-	if (!is_isa && kind = w83697hf) {
+	if (!is_isa) {
 		dev_err(&adapter->dev,
 			"Cannot force ISA-only chip for I2C address 0x%02x.\n",
 			address);
@@ -1141,8 +1144,6 @@
 			kind = w83627hf;
 		else if (val1 = 0x31 && !is_isa && address >= 0x28)
 			kind = as99127f;
-		else if (val1 = 0x60 && vendid = winbond && is_isa)
-			kind = w83697hf;
 		else {
 			if (kind = 0)
 				dev_warn(&new_client->dev, "Ignoring 'force' "
@@ -1167,8 +1168,6 @@
 			client_name = "w83627hf";
 	} else if (kind = as99127f) {
 		client_name = "as99127f";
-	} else if (kind = w83697hf) {
-		client_name = "w83697hf";
 	}
 
 	/* Fill in the remaining client fields and put into the global list */
@@ -1206,7 +1205,7 @@
 
 	/* Register sysfs hooks */
 	device_create_file_in(new_client, 0);
-	if (kind != w83783s && kind != w83697hf)
+	if (kind != w83783s)
 		device_create_file_in(new_client, 1);
 	device_create_file_in(new_client, 2);
 	device_create_file_in(new_client, 3);
@@ -1220,24 +1219,20 @@
 
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
 
@@ -1256,7 +1251,7 @@
 	if (kind != as99127f && kind != w83781d) {
 		device_create_file_sensor(new_client, 1);
 		device_create_file_sensor(new_client, 2);
-		if (kind != w83783s && kind != w83697hf)
+		if (kind != w83783s)
 			device_create_file_sensor(new_client, 3);
 	}
 
@@ -1479,7 +1474,7 @@
 				else
 					data->sens[i - 1] = 2;
 			}
-			if ((type = w83783s || type = w83697hf) && (i = 2))
+			if (type = w83783s && (i = 2))
 				break;
 		}
 	}
@@ -1495,7 +1490,7 @@
 		}
 
 		/* Enable temp3 */
-		if (type != w83783s && type != w83697hf) {
+		if (type != w83783s) {
 			tmp = w83781d_read_value(client,
 				W83781D_REG_TEMP3_CONFIG);
 			if (tmp & 0x01) {
@@ -1536,7 +1531,7 @@
 		dev_dbg(dev, "Starting device update\n");
 
 		for (i = 0; i <= 8; i++) {
-			if ((data->type = w83783s || data->type = w83697hf)
+			if ((data->type = w83783s)
 			    && (i = 1))
 				continue;	/* 783S has no in1 */
 			data->in[i] @@ -1545,8 +1540,8 @@
 			    w83781d_read_value(client, W83781D_REG_IN_MIN(i));
 			data->in_max[i]  			    w83781d_read_value(client, W83781D_REG_IN_MAX(i));
-			if ((data->type != w83782d) && (data->type != w83697hf)
-			    && (data->type != w83627hf) && (i = 6))
+			if ((data->type != w83782d) && 
+					(data->type != w83627hf) && (i = 6))
 				break;
 		}
 		for (i = 1; i <= 3; i++) {
@@ -1581,7 +1576,7 @@
 		    w83781d_read_value(client, W83781D_REG_TEMP_OVER(2));
 		data->temp_max_hyst_add[0]  		    w83781d_read_value(client, W83781D_REG_TEMP_HYST(2));
-		if (data->type != w83783s && data->type != w83697hf) {
+		if (data->type != w83783s) {
 			data->temp_add[1]  			    w83781d_read_value(client, W83781D_REG_TEMP(3));
 			data->temp_max_add[1] @@ -1592,26 +1587,18 @@
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
