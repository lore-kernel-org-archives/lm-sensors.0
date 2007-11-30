From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 30 Nov 2007 22:51:24 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83781d) Drop W83627HF support
Message-Id: <20071130235124.0529601a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The W83627HF hardware monitoring features are supported by the
w83627hf driver for several years now. Support by the w83781d has
been advertised as deprecated 6 months ago, it's about time to see
it go.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/w83781d |   18 ++++++------------
 drivers/hwmon/Kconfig       |    6 +++---
 drivers/hwmon/w83781d.c     |   29 +++++------------------------
 3 files changed, 14 insertions(+), 39 deletions(-)

--- linux-2.6.24-rc3.orig/Documentation/hwmon/w83781d	2007-11-30 14:19:46.000000000 +0100
+++ linux-2.6.24-rc3/Documentation/hwmon/w83781d	2007-11-30 22:18:44.000000000 +0100
@@ -14,10 +14,6 @@ Supported chips:
     Prefix: 'w83783s'
     Addresses scanned: I2C 0x2d
     Datasheet: http://www.winbond-usa.com/products/winbond_products/pdfs/PCIC/w83783s.pdf
-  * Winbond W83627HF
-    Prefix: 'w83627hf'
-    Addresses scanned: I2C 0x28 - 0x2f, ISA 0x290 (8 I/O ports)
-    Datasheet: http://www.winbond.com/PDF/sheet/w83627hf.pdf
   * Asus AS99127F
     Prefix: 'as99127f'
     Addresses scanned: I2C 0x28 - 0x2f
@@ -50,20 +46,18 @@ force_subclients=bus,caddr,saddr,saddr
 Description
 -----------
 
-This driver implements support for the Winbond W83781D, W83782D, W83783S,
-W83627HF chips, and the Asus AS99127F chips. We will refer to them
-collectively as W8378* chips.
+This driver implements support for the Winbond W83781D, W83782D, W83783S
+chips, and the Asus AS99127F chips. We will refer to them collectively as
+W8378* chips.
 
 There is quite some difference between these chips, but they are similar
 enough that it was sensible to put them together in one driver.
-The W83627HF chip is assumed to be identical to the ISA W83782D.
 The Asus chips are similar to an I2C-only W83782D.
 
 Chip        #vin    #fanin  #pwm    #temp   wchipid vendid  i2c     ISA
 as99127f    7       3       0       3       0x31    0x12c3  yes     no
 as99127f rev.2 (type_name = as99127f)       0x31    0x5ca3  yes     no
 w83781d     7       3       0       3       0x10-1  0x5ca3  yes     yes
-w83627hf    9       3       2       3       0x21    0x5ca3  yes     yes(LPC)
 w83782d     9       3       2-4     3       0x30    0x5ca3  yes     yes
 w83783s     5-6     3       2       1-2     0x40    0x5ca3  yes     no
 
@@ -143,9 +137,9 @@ Individual alarm and beep bits:
 0x000400: in6
 0x000800: fan3
 0x001000: chassis
-0x002000: temp3 (W83782D and W83627HF only)
-0x010000: in7 (W83782D and W83627HF only)
-0x020000: in8 (W83782D and W83627HF only)
+0x002000: temp3 (W83782D only)
+0x010000: in7 (W83782D only)
+0x020000: in8 (W83782D only)
 
 If an alarm triggers, it will remain triggered until the hardware register
 is read at least once. This means that the cause for the alarm may
--- linux-2.6.24-rc3.orig/drivers/hwmon/Kconfig	2007-11-30 18:04:56.000000000 +0100
+++ linux-2.6.24-rc3/drivers/hwmon/Kconfig	2007-11-30 22:19:02.000000000 +0100
@@ -631,13 +631,13 @@ config SENSORS_VT8231
 	  will be called vt8231.
 
 config SENSORS_W83781D
-	tristate "Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F"
+	tristate "Winbond W83781D, W83782D, W83783S, Asus AS99127F"
 	depends on I2C
 	select HWMON_VID
 	help
 	  If you say yes here you get support for the Winbond W8378x series
-	  of sensor chips: the W83781D, W83782D, W83783S and W83627HF,
-	  and the similar Asus AS99127F.
+	  of sensor chips: the W83781D, W83782D and W83783S, and the similar
+	  Asus AS99127F.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called w83781d.
--- linux-2.6.24-rc3.orig/drivers/hwmon/w83781d.c	2007-11-30 14:19:46.000000000 +0100
+++ linux-2.6.24-rc3/drivers/hwmon/w83781d.c	2007-11-30 22:32:41.000000000 +0100
@@ -28,7 +28,6 @@
     as99127f	7	3	0	3	0x31	0x12c3	yes	no
     as99127f rev.2 (type_name = as99127f)	0x31	0x5ca3	yes	no
     w83781d	7	3	0	3	0x10-1	0x5ca3	yes	yes
-    w83627hf	9	3	2	3	0x21	0x5ca3	yes	yes(LPC)
     w83782d	9	3	2-4	3	0x30	0x5ca3	yes	yes
     w83783s	5-6	3	2	1-2	0x40	0x5ca3	yes	no
 
@@ -59,7 +58,7 @@ static unsigned short normal_i2c[] = { 0
 static unsigned short isa_address = 0x290;
 
 /* Insmod parameters */
-I2C_CLIENT_INSMOD_5(w83781d, w83782d, w83783s, w83627hf, as99127f);
+I2C_CLIENT_INSMOD_4(w83781d, w83782d, w83783s, as99127f);
 I2C_CLIENT_MODULE_PARM(force_subclients, "List of subclient addresses: "
 		    "{bus, clientaddr, subclientaddr1, subclientaddr2}");
 
@@ -113,7 +112,7 @@ MODULE_PARM_DESC(init, "Set to zero to b
 #define W83781D_REG_ALARM1		0x41
 #define W83781D_REG_ALARM2		0x42
 
-/* Real-time status (W83782D, W83783S, W83627HF) */
+/* Real-time status (W83782D, W83783S) */
 #define W83782D_REG_ALARM1		0x459
 #define W83782D_REG_ALARM2		0x45A
 #define W83782D_REG_ALARM3		0x45B
@@ -962,8 +961,6 @@ w83781d_detect_subclients(struct i2c_ada
 		client_name = "w83782d subclient";
 	else if (kind = w83783s)
 		client_name = "w83783s subclient";
-	else if (kind = w83627hf)
-		client_name = "w83627hf subclient";
 	else if (kind = as99127f)
 		client_name = "as99127f subclient";
 
@@ -1267,8 +1264,6 @@ w83781d_detect(struct i2c_adapter *adapt
 			kind = w83782d;
 		else if (val1 = 0x40 && vendid = winbond && address = 0x2d)
 			kind = w83783s;
-		else if (val1 = 0x21 && vendid = winbond)
-			kind = w83627hf;
 		else if (val1 = 0x31)
 			kind = as99127f;
 		else {
@@ -1287,8 +1282,6 @@ w83781d_detect(struct i2c_adapter *adapt
 		client_name = "w83782d";
 	} else if (kind = w83783s) {
 		client_name = "w83783s";
-	} else if (kind = w83627hf) {
-		client_name = "w83627hf";
 	} else if (kind = as99127f) {
 		client_name = "as99127f";
 	}
@@ -1395,10 +1388,6 @@ w83781d_isa_probe(struct platform_device
 
 	reg = w83781d_read_value(data, W83781D_REG_WCHIPID);
 	switch (reg) {
-	case 0x21:
-		data->type = w83627hf;
-		name = "w83627hf";
-		break;
 	case 0x30:
 		data->type = w83782d;
 		name = "w83782d";
@@ -1598,11 +1587,6 @@ w83781d_init_device(struct device *dev)
 	int type = data->type;
 	u8 tmp;
 
-	if (type = w83627hf)
-		dev_info(dev, "The W83627HF chip is better supported by the "
-			 "w83627hf driver, support will be dropped from the "
-			 "w83781d driver soon\n");
-
 	if (reset && type != as99127f) { /* this resets registers we don't have
 					   documentation for on the as99127f */
 		/* Resetting the chip has been the default for a long time,
@@ -1716,8 +1700,7 @@ static struct w83781d_data *w83781d_upda
 			    w83781d_read_value(data, W83781D_REG_IN_MIN(i));
 			data->in_max[i]  			    w83781d_read_value(data, W83781D_REG_IN_MAX(i));
-			if ((data->type != w83782d)
-			    && (data->type != w83627hf) && (i = 6))
+			if ((data->type != w83782d) && (i = 6))
 				break;
 		}
 		for (i = 0; i < 3; i++) {
@@ -1775,7 +1758,7 @@ static struct w83781d_data *w83781d_upda
 			data->fan_div[1] |= (i >> 4) & 0x04;
 			data->fan_div[2] |= (i >> 5) & 0x04;
 		}
-		if ((data->type = w83782d) || (data->type = w83627hf)) {
+		if (data->type = w83782d) {
 			data->alarms = w83781d_read_value(data,
 						W83782D_REG_ALARM1)
 				     | (w83781d_read_value(data,
@@ -1885,13 +1868,11 @@ w83781d_isa_found(unsigned short address
 	outb_p(W83781D_REG_WCHIPID, address + W83781D_ADDR_REG_OFFSET);
 	val = inb_p(address + W83781D_DATA_REG_OFFSET);
 	if ((val & 0xfe) = 0x10	/* W83781D */
-	 || val = 0x30			/* W83782D */
-	 || val = 0x21)		/* W83627HF */
+	 || val = 0x30)		/* W83782D */
 		found = 1;
 
 	if (found)
 		pr_info("w83781d: Found a %s chip at %#x\n",
-			val = 0x21 ? "W83627HF" :
 			val = 0x30 ? "W83782D" : "W83781D", (int)address);
 
  release:


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
