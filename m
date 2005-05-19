From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: [PATCH 2.6] I2C: Improve it87 super-i/o detection
Message-Id: <20050113205332.75db90cd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This patch improves the detection of Super-I/O it87 chips (IT8712F,
IT8705F).

* Find the IT8712F and IT8705F address through Super-I/O (as opposed to
  IT8712F only so far).

* Verify that the device is activated. Print info lines if a
  disactivated or unconfigured chip is found.

* Print an info line when finding either chip, with device name,
  address and revision.

* Rearrange code in it87_find() (error path).

* (bonus) Get rid of the useless i2c_client id.

Successfully tested on two IT8712F and one IT8705F, thanks to Jonas
Munsin, Rudolf Marek and Karine Proot.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.11-rc1/drivers/i2c/chips/it87.c.orig	2005-01-13 19:09:10.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/it87.c	2005-01-13 20:12:50.000000000 +0100
@@ -56,6 +56,7 @@
 #define	VAL	0x2f	/* The value to read/write */
 #define PME	0x04	/* The device with the fan registers in it */
 #define	DEVID	0x20	/* Register: Device ID */
+#define	DEVREV	0x22	/* Register: Device Revision */
 
 static inline int
 superio_inb(int reg)
@@ -64,6 +65,16 @@
 	return inb(VAL);
 }
 
+static int superio_inw(int reg)
+{
+	int val;
+	outb(reg++, REG);
+	val = inb(VAL) << 8;
+	outb(reg, REG);
+	val |= inb(VAL);
+	return val;
+}
+
 static inline void
 superio_select(void)
 {
@@ -87,9 +98,8 @@
 	outb(0x02, VAL);
 }
 
-/* just IT8712F for now - this should be extended to support the other
-   chips as well */
 #define IT8712F_DEVID 0x8712
+#define IT8705F_DEVID 0x8705
 #define IT87_ACT_REG  0x30
 #define IT87_BASE_REG 0x60
 
@@ -228,8 +238,6 @@
 	.detach_client	= it87_detach_client,
 };
 
-static int it87_id;
-
 static ssize_t show_in(struct device *dev, char *buf, int nr)
 {
 	struct it87_data *data = it87_update_device(dev);
@@ -673,25 +681,33 @@
 /* SuperIO detection - will change normal_isa[0] if a chip is found */
 static int it87_find(int *address)
 {
-	u16 val;
+	int err = -ENODEV;
 
 	superio_enter();
-	chip_type = (superio_inb(DEVID) << 8) |
-	       superio_inb(DEVID + 1);
-	if (chip_type != IT8712F_DEVID) {
-		superio_exit();
-		return -ENODEV;
-	}
+	chip_type = superio_inw(DEVID);
+	if (chip_type != IT8712F_DEVID
+	 && chip_type != IT8705F_DEVID)
+	 	goto exit;
 
 	superio_select();
-	val = (superio_inb(IT87_BASE_REG) << 8) |
-	       superio_inb(IT87_BASE_REG + 1);
-	superio_exit();
-	*address = val & ~(IT87_EXTENT - 1);
+	if (!(superio_inb(IT87_ACT_REG) & 0x01)) {
+		pr_info("it87: Device not activated, skipping\n");
+		goto exit;
+	}
+
+	*address = superio_inw(IT87_BASE_REG) & ~(IT87_EXTENT - 1);
 	if (*address = 0) {
-		return -ENODEV;
+		pr_info("it87: Base address not set, skipping\n");
+		goto exit;
 	}
-	return 0;
+
+	err = 0;
+	pr_info("it87: Found IT%04xF chip at 0x%x, revision %d\n",
+		chip_type, *address, superio_inb(DEVREV) & 0x0f);
+
+exit:
+	superio_exit();
+	return err;
 }
 
 /* This function is called by i2c_detect */
@@ -800,10 +816,7 @@
 
 	/* Fill in the remaining client fields and put it into the global list */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
-
 	data->type = kind;
-
-	new_client->id = it87_id++;
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
 


-- 
Jean Delvare
http://khali.linux-fr.org/
