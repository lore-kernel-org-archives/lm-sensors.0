From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 11 Mar 2007 08:56:57 +0000
Subject: [lm-sensors] [PATCH] w83627hf: Preliminary cleanups
Message-Id: <20070311095657.84e71f8d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some preliminary cleanups to the w83627hf hardware monitoring driver,
to make its conversion to a platform driver easier:

* Add missing include ioport.h
* Drop unused enum value any_chip
* Group module parameters
* Define and use DRVNAME
* Drop unused struct member lm75
* Move the handling of force_addr and device activation to
  w83627hf_find
* Consistently use local type in w83627hf_init_client

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/w83627hf.c |   76 ++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 40 deletions(-)

--- linux-2.6.21-rc3.orig/drivers/hwmon/w83627hf.c	2007-03-11 08:46:28.000000000 +0100
+++ linux-2.6.21-rc3/drivers/hwmon/w83627hf.c	2007-03-11 09:49:13.000000000 +0100
@@ -48,9 +48,16 @@
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/ioport.h>
 #include <asm/io.h>
 #include "lm75.h"
 
+/* The actual ISA address is read from Super-I/O configuration space */
+static unsigned short address;
+
+#define DRVNAME "w83627hf"
+enum chips { w83627hf, w83627thf, w83697hf, w83637hf, w83687thf };
+
 static u16 force_addr;
 module_param(force_addr, ushort, 0);
 MODULE_PARM_DESC(force_addr,
@@ -60,12 +67,6 @@ module_param(force_i2c, byte, 0);
 MODULE_PARM_DESC(force_i2c,
 		 "Initialize the i2c address of the sensors");
 
-/* The actual ISA address is read from Super-I/O configuration space */
-static unsigned short address;
-
-/* Insmod parameters */
-enum chips { any_chip, w83627hf, w83627thf, w83697hf, w83637hf, w83687thf };
-
 static int reset;
 module_param(reset, bool, 0);
 MODULE_PARM_DESC(reset, "Set to one to reset chip on load");
@@ -298,9 +299,6 @@ struct w83627hf_data {
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
-	struct i2c_client *lm75;	/* for secondary I2C addresses */
-	/* pointer to array of 2 subclients */
-
 	u8 in[9];		/* Register value */
 	u8 in_max[9];		/* Register value */
 	u8 in_min[9];		/* Register value */
@@ -339,7 +337,7 @@ static void w83627hf_init_client(struct 
 static struct i2c_driver w83627hf_driver = {
 	.driver = {
 		.owner	= THIS_MODULE,
-		.name	= "w83627hf",
+		.name	= DRVNAME,
 	},
 	.attach_adapter	= w83627hf_detect,
 	.detach_client	= w83627hf_detach_client,
@@ -931,6 +929,7 @@ sysfs_sensor(3);
 
 static int __init w83627hf_find(int sioaddr, unsigned short *addr)
 {
+	int err = -ENODEV;
 	u16 val;
 
 	REG = sioaddr;
@@ -943,21 +942,37 @@ static int __init w83627hf_find(int sioa
 	   val != W697_DEVID &&
 	   val != W637_DEVID &&
 	   val != W687THF_DEVID) {
-		superio_exit();
-		return -ENODEV;
+		goto exit;
 	}
 
 	superio_select(W83627HF_LD_HWM);
+	force_addr &= WINB_ALIGNMENT;
+	if (force_addr) {
+		printk(KERN_WARNING DRVNAME ": Forcing address 0x%x\n",
+		       force_addr);
+		superio_outb(WINB_BASE_REG, force_addr >> 8);
+		superio_outb(WINB_BASE_REG + 1, force_addr & 0xff);
+	}
 	val = (superio_inb(WINB_BASE_REG) << 8) |
 	       superio_inb(WINB_BASE_REG + 1);
 	*addr = val & WINB_ALIGNMENT;
-	if (*addr = 0 && force_addr = 0) {
-		superio_exit();
-		return -ENODEV;
+	if (*addr = 0) {
+		printk(KERN_WARNING DRVNAME ": Base address not set, "
+		       "skipping\n");
+		goto exit;
+	}
+
+	val = superio_inb(WINB_ACT_REG);
+	if (!(val & 0x01)) {
+		printk(KERN_WARNING DRVNAME ": Enabling HWM logical device\n");
+		superio_outb(WINB_ACT_REG, val | 0x01);
 	}
 
+	err = 0;
+
+ exit:
 	superio_exit();
-	return 0;
+	return err;
 }
 
 static struct attribute *w83627hf_attributes[] = {
@@ -1047,24 +1062,12 @@ static int w83627hf_detect(struct i2c_ad
 	int err = 0;
 	const char *client_name = "";
 
-	if(force_addr)
-		address = force_addr & WINB_ALIGNMENT;
-
 	if (!request_region(address + WINB_REGION_OFFSET, WINB_REGION_SIZE,
 	                    w83627hf_driver.driver.name)) {
 		err = -EBUSY;
 		goto ERROR0;
 	}
 
-	if(force_addr) {
-		printk("w83627hf.o: forcing ISA address 0x%04X\n", address);
-		superio_enter();
-		superio_select(W83627HF_LD_HWM);
-		superio_outb(WINB_BASE_REG, address >> 8);
-		superio_outb(WINB_BASE_REG+1, address & 0xff);
-		superio_exit();
-	}
-
 	superio_enter();
 	val= superio_inb(DEVID);
 	if(val = W627_DEVID)
@@ -1082,10 +1085,6 @@ static int w83627hf_detect(struct i2c_ad
 			 "Unsupported chip (dev_id=0x%02X).\n", val);
 		goto ERROR1;
 	}
-
-	superio_select(W83627HF_LD_HWM);
-	if((val = 0x01 & superio_inb(WINB_ACT_REG)) = 0)
-		superio_outb(WINB_ACT_REG, 1);
 	superio_exit();
 
 	/* OK. For now, we presume we have a valid client. We now create the
@@ -1128,8 +1127,6 @@ static int w83627hf_detect(struct i2c_ad
 	if ((err = i2c_attach_client(new_client)))
 		goto ERROR2;
 
-	data->lm75 = NULL;
-
 	/* Initialize the chip */
 	w83627hf_init_client(new_client);
 
@@ -1374,7 +1371,7 @@ static void w83627hf_init_client(struct 
 {
 	struct w83627hf_data *data = i2c_get_clientdata(client);
 	int i;
-	int type = data->type;
+	enum chips type = data->type;
 	u8 tmp;
 
 	if (reset) {
@@ -1407,19 +1404,18 @@ static void w83627hf_init_client(struct 
 	w83627hf_write_value(client, W83781D_REG_I2C_ADDR, force_i2c);
 
 	/* Read VID only once */
-	if (w83627hf = data->type || w83637hf = data->type) {
+	if (type = w83627hf || type = w83637hf) {
 		int lo = w83627hf_read_value(client, W83781D_REG_VID_FANDIV);
 		int hi = w83627hf_read_value(client, W83781D_REG_CHIPID);
 		data->vid = (lo & 0x0f) | ((hi & 0x01) << 4);
-	} else if (w83627thf = data->type) {
+	} else if (type = w83627thf) {
 		data->vid = w83627thf_read_gpio5(client);
-	} else if (w83687thf = data->type) {
+	} else if (type = w83687thf) {
 		data->vid = w83687thf_read_vid(client);
 	}
 
 	/* Read VRM & OVT Config only once */
-	if (w83627thf = data->type || w83637hf = data->type
-	 || w83687thf = data->type) {
+	if (type = w83627thf || type = w83637hf || type = w83687thf) {
 		data->vrm_ovt = 
 			w83627hf_read_value(client, W83627THF_REG_VRM_OVT_CFG);
 	}


-- 
Jean Delvare

