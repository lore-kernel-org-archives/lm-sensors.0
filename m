From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: EP-9NDA3+ w/ Winbond W83627THF LPC
Message-Id: <20041219140615.24c584b2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <32906.216.9.170.171.1103272080.spork@webmail.necrotec.com>
In-Reply-To: <32906.216.9.170.171.1103272080.spork@webmail.necrotec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again Erek,

> Explanation was: the W83627THF is on secondary Super-I/O address
> (0x4e/0x4f), and the driver doesn't support that.
> 
> The driver would need to be updated in the same way I did for the
> pc87360.

I have come up with a very simplified patch that would do that. Not
exactly elegant but it keeps the changes to a minimum. The one I worked
on while we were on IRC was really too complex and had drawbacks too.

I have attached the patch to this mail, could you please give it a try?
It should apply to your 2.6.8.1 kernel just fine (to the original file
of course, not the one we modified together). If it works I'll push it
to Greg for inclusion into the main kernel tree, and will also backport
it to our lm_sensors CVS repository.

I also have a second patch (attached too) which partly rewrites the way
the VID pins (nominal CPU core voltage) are read on the W83627THF (the
chip you have). I would be grateful if you could give a try to this one
too (again, should apply fine to your 2.6.8.1 kernel on top of the first
one of this mail) and report if VID value is still OK for you. The patch
drops useless code and adds additional validity checks and support for
VRM 10 (6-bit VID values).

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
-------------- next part --------------
--- linux-2.6.10-rc3/drivers/i2c/chips/w83627hf.c.orig	2004-12-19 12:14:44.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/chips/w83627hf.c	2004-12-19 12:55:31.000000000 +0100
@@ -67,9 +67,9 @@
 MODULE_PARM_DESC(init, "Set to zero to bypass chip initialization");
 
 /* modified from kernel/include/traps.c */
-#define	REG	0x2e	/* The register to read/write */
+static int REG;		/* The register to read/write */
 #define	DEV	0x07	/* Register: Logical device select */
-#define	VAL	0x2f	/* The value to read/write */
+static int VAL;		/* The value to read/write */
 
 /* logical device numbers for superio_select (below) */
 #define W83627HF_LD_FDC		0x00
@@ -938,10 +938,13 @@
 	return i2c_detect(adapter, &addr_data, w83627hf_detect);
 }
 
-static int w83627hf_find(int *address)
+static int w83627hf_find(int sioaddr, int *address)
 {
 	u16 val;
 
+	REG = sioaddr;
+	VAL = sioaddr + 1;
+
 	superio_enter();
 	val= superio_inb(DEVID);
 	if(val != W627_DEVID &&
@@ -1422,7 +1425,8 @@
 {
 	int addr;
 
-	if (w83627hf_find(&addr)) {
+	if (w83627hf_find(0x2e, &addr)
+	 && w83627hf_find(0x4e, &addr)) {
 		return -ENODEV;
 	}
 	normal_isa[0] = addr;
-------------- next part --------------
--- linux-2.6.10-rc3/drivers/i2c/chips/w83627hf.c.orig	2004-12-19 12:55:31.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/chips/w83627hf.c	2004-12-19 13:57:59.000000000 +0100
@@ -90,9 +90,9 @@
 
 #define	DEVID	0x20	/* Register: Device ID */
 
+#define W83627THF_GPIO5_EN	0x30 /* w83627thf only */
 #define W83627THF_GPIO5_IOSR	0xf3 /* w83627thf only */
 #define W83627THF_GPIO5_DR	0xf4 /* w83627thf only */
-#define W83627THF_GPIO5_INVR	0xf5 /* w83627thf only */
 
 static inline void
 superio_outb(int reg, int val)
@@ -1190,16 +1190,31 @@
 
 static int w83627thf_read_gpio5(struct i2c_client *client)
 {
-	struct w83627hf_data *data = i2c_get_clientdata(client);
-	int res, inv;
+	int res = 0xff, sel;
 
-	down(&data->lock);
 	superio_enter();
 	superio_select(W83627HF_LD_GPIO5);
-	res = superio_inb(W83627THF_GPIO5_DR);
-	inv = superio_inb(W83627THF_GPIO5_INVR);
+
+	/* Make sure these GPIO pins are enabled */
+	if (!(superio_inb(W83627THF_GPIO5_EN) & (1<<3))) {
+		dev_dbg(&client->dev, "GPIO5 disabled, no VID function\n");
+		goto exit;
+	}
+
+	/* Make sure the pins are configured for input
+	   There must be at least five (VRM 9), and possibly 6 (VRM 10) */
+	sel = superio_inb(W83627THF_GPIO5_IOSR);
+	if ((sel & 0x1f) != 0x1f) {
+		dev_dbg(&client->dev, "GPIO5 not configured for VID "
+			"function\n");
+		goto exit;
+	}
+
+	dev_info(&client->dev, "Reading VID from GPIO5\n");
+	res = superio_inb(W83627THF_GPIO5_DR) & sel;
+
+exit:
 	superio_exit();
-	up(&data->lock);
 	return res;
 }
 
@@ -1272,7 +1287,7 @@
 		int hi = w83627hf_read_value(client, W83781D_REG_CHIPID);
 		data->vid = (lo & 0x0f) | ((hi & 0x01) << 4);
 	} else if (w83627thf = data->type) {
-		data->vid = w83627thf_read_gpio5(client) & 0x1f;
+		data->vid = w83627thf_read_gpio5(client) & 0x3f;
 	}
 
 	/* Read VRM & OVT Config only once */
