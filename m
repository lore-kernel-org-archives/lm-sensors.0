From: grant_lkml@dodo.com.au (Grant Coady)
Date: Sun, 29 May 2005 09:59:40 +0000
Subject: [lm-sensors] RFC PATCH I2C: w83781d: remove non-i2c w83697hf,
Message-Id: <k2ti91198dfb89235utku07866pgtejifg@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <m21i91l3t8424en9l05pgijanhm1h5es6v@4ax.com>
In-Reply-To: <m21i91l3t8424en9l05pgijanhm1h5es6v@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Sun, 29 May 2005 08:42:53 +0200, Jean Delvare <khali@linux-fr.org> wrote:

>For completeness, your patch should include changes to the documentation
>(see Rudolf Marek's recent patches adding it)

after I understand changes :)

>.. and Kconfig.

I can't see what needs changing?  w83627thf and w83697hf not mentioned 
under w83781d entry and w83627hf still valid i2c choice?  Or me blind?
>
>This ain't correct. If a W83627THF chip is found, instead of being
>discarded, it will be detected, but then won't get a client_name. That's
>obviously not what we want. We want W83627THF chips not to be recognized
>at all.
Bugger, had to _read_ the code, see where the 90h came from :)
>
>Please submit an updated patch addressing these issues.
appended, if I'm okay here I'll look at the documentation, submit 
again fresh subject.

--Grant.


Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 w83781d.c |   72 ++++++++++++++++++--------------------------------------------
 1 files changed, 21 insertions(+), 51 deletions(-)

--- linux-2.6.12-rc5-mm1/drivers/i2c/chips/w83781d.c	2005-05-26 09:40:14.000000000 +1000
+++ linux-2.6.12-rc5-mm1a/drivers/i2c/chips/w83781d.c	2005-05-29 17:38:51.000000000 +1000
@@ -28,10 +28,8 @@
     as99127f rev.2 (type_name = as99127f)	0x31	0x5ca3	yes	no
     w83781d	7	3	0	3	0x10-1	0x5ca3	yes	yes
     w83627hf	9	3	2	3	0x21	0x5ca3	yes	yes(LPC)
-    w83627thf	9	3	2	3	0x90	0x5ca3	no	yes(LPC)
     w83782d	9	3	2-4	3	0x30	0x5ca3	yes	yes
     w83783s	5-6	3	2	1-2	0x40	0x5ca3	yes	no
-    w83697hf	8	2	2	2	0x60	0x5ca3	no	yes(LPC)
 
 */
 
@@ -52,7 +50,7 @@ static unsigned short normal_i2c[] = { 0
 static unsigned int normal_isa[] = { 0x0290, I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_6(w83781d, w83782d, w83783s, w83627hf, as99127f, w83697hf);
+SENSORS_INSMOD_5(w83781d, w83782d, w83783s, w83627hf, as99127f);
 I2C_CLIENT_MODULE_PARM(force_subclients, "List of subclient addresses: "
 		    "{bus, clientaddr, subclientaddr1, subclientaddr2}");
 
@@ -998,14 +996,6 @@ w83781d_detect(struct i2c_adapter *adapt
 		err = -EINVAL;
 		goto ERROR0;
 	}
-	if (!is_isa && kind = w83697hf) {
-		dev_err(&adapter->dev,
-			"Cannot force ISA-only chip for I2C address 0x%02x.\n",
-			address);
-		err = -EINVAL;
-		goto ERROR0;
-	}
-	
 	if (is_isa)
 		if (!request_region(address, W83781D_EXTENT,
 				    w83781d_driver.name)) {
@@ -1137,12 +1127,10 @@ w83781d_detect(struct i2c_adapter *adapt
 		else if (val1 = 0x40 && vendid = winbond && !is_isa
 				&& address = 0x2d)
 			kind = w83783s;
-		else if ((val1 = 0x21 || val1 = 0x90) && vendid = winbond)
+		else if (val1 = 0x21 && vendid = winbond)
 			kind = w83627hf;
 		else if (val1 = 0x31 && !is_isa && address >= 0x28)
 			kind = as99127f;
-		else if (val1 = 0x60 && vendid = winbond && is_isa)
-			kind = w83697hf;
 		else {
 			if (kind = 0)
 				dev_warn(&new_client->dev, "Ignoring 'force' "
@@ -1161,14 +1149,9 @@ w83781d_detect(struct i2c_adapter *adapt
 	} else if (kind = w83783s) {
 		client_name = "w83783s";
 	} else if (kind = w83627hf) {
-		if (val1 = 0x90)
-			client_name = "w83627thf";
-		else
-			client_name = "w83627hf";
+		client_name = "w83627hf";
 	} else if (kind = as99127f) {
 		client_name = "as99127f";
-	} else if (kind = w83697hf) {
-		client_name = "w83697hf";
 	}
 
 	/* Fill in the remaining client fields and put into the global list */
@@ -1206,7 +1189,7 @@ w83781d_detect(struct i2c_adapter *adapt
 
 	/* Register sysfs hooks */
 	device_create_file_in(new_client, 0);
-	if (kind != w83783s && kind != w83697hf)
+	if (kind != w83783s)
 		device_create_file_in(new_client, 1);
 	device_create_file_in(new_client, 2);
 	device_create_file_in(new_client, 3);
@@ -1220,24 +1203,20 @@ w83781d_detect(struct i2c_adapter *adapt
 
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
 
@@ -1256,7 +1235,7 @@ w83781d_detect(struct i2c_adapter *adapt
 	if (kind != as99127f && kind != w83781d) {
 		device_create_file_sensor(new_client, 1);
 		device_create_file_sensor(new_client, 2);
-		if (kind != w83783s && kind != w83697hf)
+		if (kind != w83783s)
 			device_create_file_sensor(new_client, 3);
 	}
 
@@ -1479,7 +1458,7 @@ w83781d_init_client(struct i2c_client *c
 				else
 					data->sens[i - 1] = 2;
 			}
-			if ((type = w83783s || type = w83697hf) && (i = 2))
+			if (type = w83783s && i = 2)
 				break;
 		}
 	}
@@ -1495,7 +1474,7 @@ w83781d_init_client(struct i2c_client *c
 		}
 
 		/* Enable temp3 */
-		if (type != w83783s && type != w83697hf) {
+		if (type != w83783s) {
 			tmp = w83781d_read_value(client,
 				W83781D_REG_TEMP3_CONFIG);
 			if (tmp & 0x01) {
@@ -1536,8 +1515,7 @@ static struct w83781d_data *w83781d_upda
 		dev_dbg(dev, "Starting device update\n");
 
 		for (i = 0; i <= 8; i++) {
-			if ((data->type = w83783s || data->type = w83697hf)
-			    && (i = 1))
+			if (data->type = w83783s && i = 1)
 				continue;	/* 783S has no in1 */
 			data->in[i]  			    w83781d_read_value(client, W83781D_REG_IN(i));
@@ -1545,7 +1523,7 @@ static struct w83781d_data *w83781d_upda
 			    w83781d_read_value(client, W83781D_REG_IN_MIN(i));
 			data->in_max[i]  			    w83781d_read_value(client, W83781D_REG_IN_MAX(i));
-			if ((data->type != w83782d) && (data->type != w83697hf)
+			if ((data->type != w83782d)
 			    && (data->type != w83627hf) && (i = 6))
 				break;
 		}
@@ -1581,7 +1559,7 @@ static struct w83781d_data *w83781d_upda
 		    w83781d_read_value(client, W83781D_REG_TEMP_OVER(2));
 		data->temp_max_hyst_add[0]  		    w83781d_read_value(client, W83781D_REG_TEMP_HYST(2));
-		if (data->type != w83783s && data->type != w83697hf) {
+		if (data->type != w83783s) {
 			data->temp_add[1]  			    w83781d_read_value(client, W83781D_REG_TEMP(3));
 			data->temp_max_add[1] @@ -1592,26 +1570,18 @@ static struct w83781d_data *w83781d_upda
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
