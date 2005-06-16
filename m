From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 16 Jun 2005 18:51:48 +0000
Subject: [lm-sensors] fixing ticket #1944
Message-Id: <20050616185057.2b5c8ac8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050615222035.91224.qmail@web31003.mail.mud.yahoo.com>
In-Reply-To: <20050615222035.91224.qmail@web31003.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Good evening Hugo,

Attached are:

1* A patch to sensors-detect, which should add support for the Winbond
W83687THF chip.

2* A patch to linux-2.6.11.12, which adds experimental support for the
Winbond W83687THF chip to the w83627hf driver. I assumed that the chip
would be mostly identical to the W83627THF because they have the same ID
register and were supposedly released by Winbond at the same time. This
assumption may or may not be correct, use at your own risk. You
shouldn't try unless you have a physical access to the machine and can
notice if something goes wrong (such as a fan stopping...) If we can get
a datasheet at a later time I will be able to verify.

"sensors" won't work out of the box, but you should be able to get the
readings from /sys/bus/i2c. Let us know how it works :)

-- 
Jean Delvare
-------------- next part --------------
--- sensors-detect.orig	Thu Jun 16 14:00:51 2005
+++ sensors-detect	Thu Jun 16 14:10:29 2005
@@ -1798,6 +1798,12 @@
 	logdev => 0x0b,
       },
       {
+	name => "Winbond W83687THF Super IO Sensors",
+	driver => "w83627hf",
+	devid => 0x85,
+	logdev => 0x0b,
+      },
+      {
 	name => "Winbond W83697HF Super IO Sensors",
 	driver => "w83627hf",
 	devid => 0x60,
-------------- next part --------------
--- linux-2.6.11.12/drivers/i2c/chips/w83627hf.c.orig	2005-03-13 09:14:45.000000000 +0100
+++ linux-2.6.11.12/drivers/i2c/chips/w83627hf.c	2005-06-16 18:38:17.000000000 +0200
@@ -28,6 +28,7 @@
     w83627hf	9	3	2	3	0x20	0x5ca3	no	yes(LPC)
     w83627thf	7	3	3	3	0x90	0x5ca3	no	yes(LPC)
     w83637hf	7	3	3	3	0x80	0x5ca3	no	yes(LPC)
+    w83687thf	?	?	?	?	0x90	0x5ca3	no	yes(LPC)
     w83697hf	8	2	2	2	0x60	0x5ca3	no	yes(LPC)
 
     For other winbond chips, and for i2c support in the above chips,
@@ -60,7 +61,7 @@
 static unsigned int normal_isa[] = { 0, I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_4(w83627hf, w83627thf, w83697hf, w83637hf);
+SENSORS_INSMOD_5(w83627hf, w83627thf, w83697hf, w83637hf, w83687thf);
 
 static int init = 1;
 module_param(init, bool, 0);
@@ -132,6 +133,7 @@
 #define W627THF_DEVID 0x82
 #define W697_DEVID 0x60
 #define W637_DEVID 0x70
+#define W687THF_DEVID 0x85
 #define WINB_ACT_REG 0x30
 #define WINB_BASE_REG 0x60
 /* Constants specified below */
@@ -405,7 +407,8 @@
 	long in0;
 
 	if ((data->vrm_ovt & 0x01) &&
-		(w83627thf = data->type || w83637hf = data->type))
+		(w83627thf = data->type || w83637hf = data->type
+		 || w83687thf = data->type))
 
 		/* use VRM9 calculation */
 		in0 = (long)((reg * 488 + 70000 + 50) / 100);
@@ -443,7 +446,8 @@
 
 	val = simple_strtoul(buf, NULL, 10);
 	if ((data->vrm_ovt & 0x01) &&
-		(w83627thf = data->type || w83637hf = data->type))
+		(w83627thf = data->type || w83637hf = data->type
+		 || w83687thf = data->type))
 
 		/* use VRM9 calculation */
 		data->in_min[0] = (u8)(((val * 100) - 70000 + 244) / 488);
@@ -464,7 +468,8 @@
 
 	val = simple_strtoul(buf, NULL, 10);
 	if ((data->vrm_ovt & 0x01) &&
-		(w83627thf = data->type || w83637hf = data->type))
+		(w83627thf = data->type || w83637hf = data->type
+		 || w83687thf = data->type))
 		
 		/* use VRM9 calculation */
 		data->in_max[0] = (u8)(((val * 100) - 70000 + 244) / 488);
@@ -815,7 +820,7 @@
 
 	val = simple_strtoul(buf, NULL, 10);
 
-	if (data->type = w83627thf) {
+	if (data->type = w83627thf || data->type = w83687thf) {
 		/* bits 0-3 are reserved  in 627THF */
 		data->pwm[nr - 1] = PWM_TO_REG(val) & 0xf0;
 		w83627hf_write_value(client,
@@ -950,7 +955,8 @@
 	if(val != W627_DEVID &&
 	   val != W627THF_DEVID &&
 	   val != W697_DEVID &&
-	   val != W637_DEVID) {
+	   val != W637_DEVID &&
+	   val != W687THF_DEVID) {
 		superio_exit();
 		return -ENODEV;
 	}
@@ -1011,6 +1017,8 @@
 		kind = w83627thf;
 	else if(val = W637_DEVID)
 		kind = w83637hf;
+	else if(val = W687THF_DEVID)
+		kind = w83687thf;
 	else {
 		dev_info(&adapter->dev,
 			 "Unsupported chip (dev_id=0x%02X).\n", val);
@@ -1049,6 +1057,8 @@
 		client_name = "w83697hf";
 	} else if (kind = w83637hf) {
 		client_name = "w83637hf";
+	} else if (kind = w83687thf) {
+		client_name = "w83687thf";
 	}
 
 	/* Fill in the remaining client fields and put into the global list */
@@ -1078,7 +1088,7 @@
 	device_create_file_in(new_client, 2);
 	device_create_file_in(new_client, 3);
 	device_create_file_in(new_client, 4);
-	if (kind != w83627thf && kind != w83637hf) {
+	if (kind = w83627hf || kind = w83697hf) {
 		device_create_file_in(new_client, 5);
 		device_create_file_in(new_client, 6);
 	}
@@ -1112,7 +1122,7 @@
 
 	device_create_file_pwm(new_client, 1);
 	device_create_file_pwm(new_client, 2);
-	if (kind = w83627thf || kind = w83637hf)
+	if (kind = w83627thf || kind = w83637hf || kind = w83687thf)
 		device_create_file_pwm(new_client, 3);
 
 	device_create_file_sensor(new_client, 1);
@@ -1286,12 +1296,13 @@
 		int lo = w83627hf_read_value(client, W83781D_REG_VID_FANDIV);
 		int hi = w83627hf_read_value(client, W83781D_REG_CHIPID);
 		data->vid = (lo & 0x0f) | ((hi & 0x01) << 4);
-	} else if (w83627thf = data->type) {
+	} else if (w83627thf = data->type || w83687thf = data->type) {
 		data->vid = w83627thf_read_gpio5(client) & 0x3f;
 	}
 
 	/* Read VRM & OVT Config only once */
-	if (w83627thf = data->type || w83637hf = data->type) {
+	if (w83627thf = data->type || w83637hf = data->type
+	 || w83687thf = data->type) {
 		data->vrm_ovt = 
 			w83627hf_read_value(client, W83627THF_REG_VRM_OVT_CFG);
 		data->vrm = (data->vrm_ovt & 0x01) ? 90 : 82;
@@ -1355,7 +1366,8 @@
 		for (i = 0; i <= 8; i++) {
 			/* skip missing sensors */
 			if (((data->type = w83697hf) && (i = 1)) ||
-			    ((data->type = w83627thf || data->type = w83637hf)
+			    ((data->type = w83627thf || data->type = w83637hf
+			      || data->type = w83687thf)
 			    && (i = 4 || i = 5)))
 				continue;
 			data->in[i] @@ -1378,7 +1390,7 @@
 			u8 tmp = w83627hf_read_value(client,
 				W836X7HF_REG_PWM(data->type, i));
  			/* bits 0-3 are reserved  in 627THF */
- 			if (data->type = w83627thf)
+ 			if (data->type = w83627thf || data->type = w83687thf)
 				tmp &= 0xf0;
 			data->pwm[i - 1] = tmp;
 			if(i = 2 &&
