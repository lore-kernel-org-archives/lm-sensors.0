From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [PATCH 2.6] Don't handle kind errors that cannot happen
Message-Id: <20040313185302.6955c4a9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

A number of chip drivers in 2.6.4-mm1 try to handle an error case that
cannot happen when setting the chip name. The following patch changes
that.

Affected drivers: adm1021, it87, lm75, lm78, lm85, w83627hf, w83781d.

Note that in any case, the worst that could happen (but then again, it
cannot happen) is that the chip name would be set to an empty string,
which doesn't hurt much.

The patch also cleans up a few things in it87, w83627hf and w83781d,
which are tightly related to the rest of the changes and necessary for
them to be safe.

it87: There is only really one "kind" in this driver, so I removed all
references to other kinds.

w83627hf: The driver did not handle unknown chips.

w83781d: The user shouldn't be allowed to force a kind that doesn't
match the chip's bus type (I2C or ISA). The code was not meant to handle
that case, although no check was done so far.

Tested on my AS99127F, works as intended.

Please apply,
thanks.

Note: What kind of error should the detection function return when the
user forces the driver, but the driver doesn't agree to load? Some of
our drivers return -EINVAL (e.g. w83781d), some -ENODEV (e.g. asb100,
lm78), some return without an error (e.g. it87). I think we should decide
of a policy and stick to it.

diff -u linux-2.6.4+i2c/drivers/i2c/chips.orig/adm1021.c linux-2.6.4+i2c/drivers/i2c/chips/adm1021.c
--- linux-2.6.4+i2c/drivers/i2c/chips.orig/adm1021.c	Thu Mar 11 22:19:59 2004
+++ linux-2.6.4+i2c/drivers/i2c/chips/adm1021.c	Sat Mar 13 16:17:00 2004
@@ -301,10 +301,6 @@
 		type_name = "gl523sm";
 	} else if (kind = mc1066) {
 		type_name = "mc1066";
-	} else {
-		dev_err(&adapter->dev, "Internal error: unknown kind (%d)?!?",
-			kind);
-		goto error1;
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
diff -u linux-2.6.4+i2c/drivers/i2c/chips.orig/it87.c linux-2.6.4+i2c/drivers/i2c/chips/it87.c
--- linux-2.6.4+i2c/drivers/i2c/chips.orig/it87.c	Thu Mar 11 22:19:59 2004
+++ linux-2.6.4+i2c/drivers/i2c/chips/it87.c	Sat Mar 13 16:12:55 2004
@@ -51,7 +51,7 @@
 static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_4(it87, it8705, it8712, sis950);
+SENSORS_INSMOD_1(it87);
 
 
 /* Update battery voltage after every reading if true */
@@ -604,12 +604,6 @@
 
 	if (kind = it87) {
 		name = "it87";
-	} /* else if (kind = it8712) {
-		name = "it8712";
-	} */ else {
-		dev_dbg(&adapter->dev, "Internal error: unknown kind (%d)?!?",
-			kind);
-		goto ERROR1;
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
@@ -837,13 +831,7 @@
 		}
 
 		/* The 8705 does not have VID capability */
-		/*if (data->type = it8712) {
-			data->vid = it87_read_value(client, IT87_REG_VID);
-			data->vid &= 0x1f;
-		}
-		else */ {
-			data->vid = 0x1f;
-		}
+		data->vid = 0x1f;
 
 		i = it87_read_value(client, IT87_REG_FAN_DIV);
 		data->fan_div[0] = i & 0x07;
diff -u linux-2.6.4+i2c/drivers/i2c/chips.orig/lm75.c linux-2.6.4+i2c/drivers/i2c/chips/lm75.c
--- linux-2.6.4+i2c/drivers/i2c/chips.orig/lm75.c	Thu Mar 11 22:19:59 2004
+++ linux-2.6.4+i2c/drivers/i2c/chips/lm75.c	Sat Mar 13 16:37:36 2004
@@ -120,7 +120,7 @@
 	struct i2c_client *new_client;
 	struct lm75_data *data;
 	int err = 0;
-	const char *name;
+	const char *name = "";
 
 	/* Make sure we aren't probing the ISA bus!! This is just a safety check
 	   at this moment; i2c_detect really won't call us. */
@@ -174,10 +174,6 @@
 
 	if (kind = lm75) {
 		name = "lm75";
-	} else {
-		dev_dbg(&adapter->dev, "Internal error: unknown kind (%d)?!?",
-			kind);
-		goto exit_free;
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
diff -u linux-2.6.4+i2c/drivers/i2c/chips.orig/lm78.c linux-2.6.4+i2c/drivers/i2c/chips/lm78.c
--- linux-2.6.4+i2c/drivers/i2c/chips.orig/lm78.c	Thu Mar 11 22:19:59 2004
+++ linux-2.6.4+i2c/drivers/i2c/chips/lm78.c	Sat Mar 13 15:53:29 2004
@@ -613,11 +613,6 @@
 		client_name = "lm78-j";
 	} else if (kind = lm79) {
 		client_name = "lm79";
-	} else {
-		dev_dbg(&adapter->dev, "Internal error: unknown kind (%d)?!?",
-			kind);
-		err = -ENODEV;
-		goto ERROR2;
 	}
 
 	/* Fill in the remaining client fields and put into the global list */
diff -u linux-2.6.4+i2c/drivers/i2c/chips.orig/lm85.c linux-2.6.4+i2c/drivers/i2c/chips/lm85.c
--- linux-2.6.4+i2c/drivers/i2c/chips.orig/lm85.c	Thu Mar 11 22:19:59 2004
+++ linux-2.6.4+i2c/drivers/i2c/chips/lm85.c	Sat Mar 13 15:42:49 2004
@@ -819,10 +819,6 @@
 		type_name = "adm1027";
 	} else if ( kind = adt7463 ) {
 		type_name = "adt7463";
-	} else {
-		dev_dbg(&adapter->dev, "Internal error, invalid kind (%d)!", kind);
-		err = -EFAULT ;
-		goto ERROR1;
 	}
 	strlcpy(new_client->name, type_name, I2C_NAME_SIZE);
 
diff -u linux-2.6.4+i2c/drivers/i2c/chips.orig/w83627hf.c linux-2.6.4+i2c/drivers/i2c/chips/w83627hf.c
--- linux-2.6.4+i2c/drivers/i2c/chips.orig/w83627hf.c	Thu Mar 11 22:19:59 2004
+++ linux-2.6.4+i2c/drivers/i2c/chips/w83627hf.c	Sat Mar 13 15:39:26 2004
@@ -923,6 +923,11 @@
 		kind = w83627thf;
 	else if(val = W637_DEVID)
 		kind = w83637hf;
+	else {
+		dev_info(&adapter->dev,
+			 "Unsupported chip (dev_id=0x%02X).\n", val);
+		goto ERROR1;
+	}
 
 	superio_select(W83627HF_LD_HWM);
 	if((val = 0x01 & superio_inb(WINB_ACT_REG)) = 0)
@@ -960,11 +965,6 @@
 		client_name = "w83697hf";
 	} else if (kind = w83637hf) {
 		client_name = "w83637hf";
-	} else {
-		dev_err(&new_client->dev, "Internal error: unknown "
-						"kind (%d)?!?", kind);
-		err = -ENODEV;
-		goto ERROR2;
 	}
 
 	/* Fill in the remaining client fields and put into the global list */
diff -u linux-2.6.4+i2c/drivers/i2c/chips.orig/w83781d.c linux-2.6.4+i2c/drivers/i2c/chips/w83781d.c
--- linux-2.6.4+i2c/drivers/i2c/chips.orig/w83781d.c	Thu Mar 11 22:19:59 2004
+++ linux-2.6.4+i2c/drivers/i2c/chips/w83781d.c	Sat Mar 13 18:44:30 2004
@@ -970,7 +970,7 @@
 {
 	int i, val1 = 0, id;
 	int err;
-	const char *client_name;
+	const char *client_name = "";
 	struct w83781d_data *data = i2c_get_clientdata(new_client);
 
 	data->lm75[0] = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
@@ -1036,8 +1036,6 @@
 		client_name = "w83627hf subclient";
 	else if (kind = as99127f)
 		client_name = "as99127f subclient";
-	else
-		client_name = "unknown subclient?";
 
 	for (i = 0; i <= 1; i++) {
 		/* store all data in w83781d */
@@ -1091,6 +1089,23 @@
 		goto ERROR0;
 	}
 
+	/* Prevent users from forcing a kind for a bus it isn't supposed
+	   to possibly be on */
+	if (is_isa && (kind = as99127f || kind = w83783s)) {
+		dev_err(&adapter->dev,
+			"Cannot force I2C-only chip for ISA address 0x%02x.\n",
+			address);
+		err = -EINVAL;
+		goto ERROR0;
+	}
+	if (!is_isa && kind = w83697hf) {
+		dev_err(&adapter->dev,
+			"Cannot force ISA-only chip for I2C address 0x%02x.\n",
+			address);
+		err = -EINVAL;
+		goto ERROR0;
+	}
+	
 	if (is_isa)
 		if (!request_region(address, W83781D_EXTENT, "w83781d")) {
 			err = -EBUSY;
@@ -1244,11 +1259,6 @@
 		client_name = "as99127f";
 	} else if (kind = w83697hf) {
 		client_name = "w83697hf";
-	} else {
-		dev_err(&new_client->dev, "Internal error: unknown "
-						"kind (%d)?!?", kind);
-		err = -ENODEV;
-		goto ERROR2;
 	}
 
 	/* Fill in the remaining client fields and put into the global list */


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
