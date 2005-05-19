From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [PATCH 2.6] Forced i2c chip drivers have no name
Message-Id: <20040312231647.21a101ca.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

I just noticed that I am doing something wrong in the i2c chip drivers I
ported to Linux 2.6. If these drivers are forced to a specific chip type
("kind" as we call it internally), then the device doesn't have its name
set (and defaults to an empty string).

Affected drivers: gl518sm, lm83, lm90, w83l785ts.

I could verify the problem on my ADM1032 chip (lm90 driver). I also
verified that the proposed patch fixes the issue.

You may notice that I fix the problem differently for gl518sm and
w83l785ts on the one hand, and lm83 and lm90 on the other hand. This is
because the first two drivers are not expected to support more a single
chip in the future, while lm90 already does and lm83 could someday (for
example, support for the LM82 could be added on request).

Please apply (on top of your current tree),
Thanks.

diff -ruN linux-2.6.4+i2c/drivers/i2c/chips.orig/gl518sm.c linux-2.6.4+i2c/drivers/i2c/chips/gl518sm.c
--- linux-2.6.4+i2c/drivers/i2c/chips.orig/gl518sm.c	Thu Mar 11 22:19:59 2004
+++ linux-2.6.4+i2c/drivers/i2c/chips/gl518sm.c	Fri Mar 12 23:02:29 2004
@@ -349,7 +349,6 @@
 	struct i2c_client *new_client;
 	struct gl518_data *data;
 	int err = 0;
-	const char *name = "";
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
 				     I2C_FUNC_SMBUS_WORD_DATA))
@@ -389,10 +388,8 @@
 		i = gl518_read_value(new_client, GL518_REG_REVISION);
 		if (i = 0x00) {
 			kind = gl518sm_r00;
-			name = "gl518sm";
 		} else if (i = 0x80) {
 			kind = gl518sm_r80;
-			name = "gl518sm";
 		} else {
 			if (kind <= 0)
 				dev_info(&adapter->dev,
@@ -404,7 +401,7 @@
 	}
 
 	/* Fill in the remaining client fields */
-	strlcpy(new_client->name, name, I2C_NAME_SIZE);
+	strlcpy(new_client->name, "gl518sm", I2C_NAME_SIZE);
 	new_client->id = gl518_id++;
 	data->type = kind;
 	data->valid = 0;
diff -ruN linux-2.6.4+i2c/drivers/i2c/chips.orig/lm83.c linux-2.6.4+i2c/drivers/i2c/chips/lm83.c
--- linux-2.6.4+i2c/drivers/i2c/chips.orig/lm83.c	Thu Mar 11 22:19:59 2004
+++ linux-2.6.4+i2c/drivers/i2c/chips/lm83.c	Fri Mar 12 22:45:03 2004
@@ -288,7 +288,6 @@
 		if (man_id = 0x01) { /* National Semiconductor */
 			if (chip_id = 0x03) {
 				kind = lm83;
-				name = "lm83";
 			}
 		}
 
@@ -298,6 +297,10 @@
 			    "chip_id=0x%02X).\n", man_id, chip_id);
 			goto exit_free;
 		}
+	}
+
+	if (kind = lm83) {
+		name = "lm83";
 	}
 
 	/* We can fill in the remaining client fields */
diff -ruN linux-2.6.4+i2c/drivers/i2c/chips.orig/lm90.c linux-2.6.4+i2c/drivers/i2c/chips/lm90.c
--- linux-2.6.4+i2c/drivers/i2c/chips.orig/lm90.c	Thu Mar 11 22:19:59 2004
+++ linux-2.6.4+i2c/drivers/i2c/chips/lm90.c	Fri Mar 12 22:46:13 2004
@@ -341,7 +341,6 @@
 				LM90_REG_R_CONFIG2) & 0xF8) = 0x00
 			   && reg_convrate <= 0x09))) {
 				kind = lm90;
-				name = "lm90";
 			}
 		}
 		else if (man_id = 0x41) { /* Analog Devices */
@@ -349,7 +348,6 @@
 			 && (kind = 0 /* skip detection */
 			  || (reg_config1 & 0x3F) = 0x00)) {
 				kind = adm1032;
-				name = "adm1032";
 			}
 		}
 
@@ -359,6 +357,12 @@
 			    "chip_id=0x%02X).\n", man_id, chip_id);
 			goto exit_free;
 		}
+	}
+
+	if (kind = lm90) {
+		name = "lm90";
+	} else if (kind = adm1032) {
+		name = "adm1032";
 	}
 
 	/* We can fill in the remaining client fields */
diff -ruN linux-2.6.4+i2c/drivers/i2c/chips.orig/w83l785ts.c linux-2.6.4+i2c/drivers/i2c/chips/w83l785ts.c
--- linux-2.6.4+i2c/drivers/i2c/chips.orig/w83l785ts.c	Thu Mar 11 22:19:59 2004
+++ linux-2.6.4+i2c/drivers/i2c/chips/w83l785ts.c	Fri Mar 12 23:02:09 2004
@@ -163,7 +163,6 @@
 	struct i2c_client *new_client;
 	struct w83l785ts_data *data;
 	int err = 0;
-	const char *name = "";
 
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
@@ -224,7 +223,6 @@
 		if (man_id = 0x5CA3) { /* Winbond */
 			if (chip_id = 0x70) { /* W83L785TS-S */
 				kind = w83l785ts;			
-				name = "w83l785ts";
 			}
 		}
 	
@@ -237,7 +235,7 @@
 	}
 
 	/* We can fill in the remaining client fields. */
-	strlcpy(new_client->name, name, I2C_NAME_SIZE);
+	strlcpy(new_client->name, "w83l785ts", I2C_NAME_SIZE);
 	new_client->id = w83l785ts_id++;
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
