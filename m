From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 01 Oct 2009 15:12:18 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83627hf) Stop using globals for I/O
Message-Id: <20091001171218.5e56e358@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Stop using global variables REG and VAL for I/O port numbers. This is
ugly and unsafe.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Rodolfo Giometti <giometti@linux.it>
---
Rodolfo, your MFD conversion patch could go on top of the other patch I
just sent and this one. I presume it would then be much smaller and
easier to review.

 drivers/hwmon/w83627hf.c |   85 ++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 43 deletions(-)

--- linux-2.6.32-rc1.orig/drivers/hwmon/w83627hf.c	2009-10-01 15:36:01.000000000 +0200
+++ linux-2.6.32-rc1/drivers/hwmon/w83627hf.c	2009-10-01 16:31:46.000000000 +0200
@@ -59,6 +59,11 @@ static struct platform_device *pdev;
 #define DRVNAME "w83627hf"
 enum chips { w83627hf, w83627thf, w83697hf, w83637hf, w83687thf };
 
+struct w83627hf_sio_data {
+	enum chips type;
+	int sioaddr;
+};
+
 static u8 force_i2c = 0x1f;
 module_param(force_i2c, byte, 0);
 MODULE_PARM_DESC(force_i2c,
@@ -73,9 +78,7 @@ module_param(force_id, ushort, 0);
 MODULE_PARM_DESC(force_id, "Override the detected device ID");
 
 /* modified from kernel/include/traps.c */
-static int REG;		/* The register to read/write */
 #define	DEV	0x07	/* Register: Logical device select */
-static int VAL;		/* The value to read/write */
 
 /* logical device numbers for superio_select (below) */
 #define W83627HF_LD_FDC		0x00
@@ -105,37 +108,37 @@ static int VAL;		/* The value to read/wr
 #define W83687THF_VID_DATA	0xF1 /* w83687thf only */
 
 static inline void
-superio_outb(int reg, int val)
+superio_outb(struct w83627hf_sio_data *sio, int reg, int val)
 {
-	outb(reg, REG);
-	outb(val, VAL);
+	outb(reg, sio->sioaddr);
+	outb(val, sio->sioaddr + 1);
 }
 
 static inline int
-superio_inb(int reg)
+superio_inb(struct w83627hf_sio_data *sio, int reg)
 {
-	outb(reg, REG);
-	return inb(VAL);
+	outb(reg, sio->sioaddr);
+	return inb(sio->sioaddr + 1);
 }
 
 static inline void
-superio_select(int ld)
+superio_select(struct w83627hf_sio_data *sio, int ld)
 {
-	outb(DEV, REG);
-	outb(ld, VAL);
+	outb(DEV, sio->sioaddr);
+	outb(ld,  sio->sioaddr + 1);
 }
 
 static inline void
-superio_enter(void)
+superio_enter(struct w83627hf_sio_data *sio)
 {
-	outb(0x87, REG);
-	outb(0x87, REG);
+	outb(0x87, sio->sioaddr);
+	outb(0x87, sio->sioaddr);
 }
 
 static inline void
-superio_exit(void)
+superio_exit(struct w83627hf_sio_data *sio)
 {
-	outb(0xAA, REG);
+	outb(0xAA, sio->sioaddr);
 }
 
 #define W627_DEVID 0x52
@@ -376,10 +379,6 @@ struct w83627hf_data {
 	u8 vrm_ovt;		/* Register value, 627THF/637HF/687THF only */
 };
 
-struct w83627hf_sio_data {
-	enum chips type;
-};
-
 
 static int w83627hf_probe(struct platform_device *pdev);
 static int __devexit w83627hf_remove(struct platform_device *pdev);
@@ -1136,11 +1135,8 @@ static int __init w83627hf_find(int sioa
 		"W83687THF",
 	};
 
-	REG = sioaddr;
-	VAL = sioaddr + 1;
-
-	superio_enter();
-	val = force_id ? force_id : superio_inb(DEVID);
+	superio_enter(sio_data);
+	val = force_id ? force_id : superio_inb(sio_data, DEVID);
 	switch (val) {
 	case W627_DEVID:
 		sio_data->type = w83627hf;
@@ -1164,9 +1160,9 @@ static int __init w83627hf_find(int sioa
 		goto exit;
 	}
 
-	superio_select(W83627HF_LD_HWM);
-	val = (superio_inb(WINB_BASE_REG) << 8) |
-	       superio_inb(WINB_BASE_REG + 1);
+	superio_select(sio_data, W83627HF_LD_HWM);
+	val = (superio_inb(sio_data, WINB_BASE_REG) << 8) |
+	       superio_inb(sio_data, WINB_BASE_REG + 1);
 	*addr = val & WINB_ALIGNMENT;
 	if (*addr = 0) {
 		printk(KERN_WARNING DRVNAME ": Base address not set, "
@@ -1174,18 +1170,19 @@ static int __init w83627hf_find(int sioa
 		goto exit;
 	}
 
-	val = superio_inb(WINB_ACT_REG);
+	val = superio_inb(sio_data, WINB_ACT_REG);
 	if (!(val & 0x01)) {
 		printk(KERN_WARNING DRVNAME ": Enabling HWM logical device\n");
-		superio_outb(WINB_ACT_REG, val | 0x01);
+		superio_outb(sio_data, WINB_ACT_REG, val | 0x01);
 	}
 
 	err = 0;
+	sio_data->sioaddr = sioaddr;
 	pr_info(DRVNAME ": Found %s chip at %#x\n",
 		names[sio_data->type], *addr);
 
  exit:
-	superio_exit();
+	superio_exit(sio_data);
 	return err;
 }
 
@@ -1500,20 +1497,21 @@ static int w83627hf_read_value(struct w8
 
 static int __devinit w83627thf_read_gpio5(struct platform_device *pdev)
 {
+	struct w83627hf_sio_data *sio_data = pdev->dev.platform_data;
 	int res = 0xff, sel;
 
-	superio_enter();
-	superio_select(W83627HF_LD_GPIO5);
+	superio_enter(sio_data);
+	superio_select(sio_data, W83627HF_LD_GPIO5);
 
 	/* Make sure these GPIO pins are enabled */
-	if (!(superio_inb(W83627THF_GPIO5_EN) & (1<<3))) {
+	if (!(superio_inb(sio_data, W83627THF_GPIO5_EN) & (1<<3))) {
 		dev_dbg(&pdev->dev, "GPIO5 disabled, no VID function\n");
 		goto exit;
 	}
 
 	/* Make sure the pins are configured for input
 	   There must be at least five (VRM 9), and possibly 6 (VRM 10) */
-	sel = superio_inb(W83627THF_GPIO5_IOSR) & 0x3f;
+	sel = superio_inb(sio_data, W83627THF_GPIO5_IOSR) & 0x3f;
 	if ((sel & 0x1f) != 0x1f) {
 		dev_dbg(&pdev->dev, "GPIO5 not configured for VID "
 			"function\n");
@@ -1521,37 +1519,38 @@ static int __devinit w83627thf_read_gpio
 	}
 
 	dev_info(&pdev->dev, "Reading VID from GPIO5\n");
-	res = superio_inb(W83627THF_GPIO5_DR) & sel;
+	res = superio_inb(sio_data, W83627THF_GPIO5_DR) & sel;
 
 exit:
-	superio_exit();
+	superio_exit(sio_data);
 	return res;
 }
 
 static int __devinit w83687thf_read_vid(struct platform_device *pdev)
 {
+	struct w83627hf_sio_data *sio_data = pdev->dev.platform_data;
 	int res = 0xff;
 
-	superio_enter();
-	superio_select(W83627HF_LD_HWM);
+	superio_enter(sio_data);
+	superio_select(sio_data, W83627HF_LD_HWM);
 
 	/* Make sure these GPIO pins are enabled */
-	if (!(superio_inb(W83687THF_VID_EN) & (1 << 2))) {
+	if (!(superio_inb(sio_data, W83687THF_VID_EN) & (1 << 2))) {
 		dev_dbg(&pdev->dev, "VID disabled, no VID function\n");
 		goto exit;
 	}
 
 	/* Make sure the pins are configured for input */
-	if (!(superio_inb(W83687THF_VID_CFG) & (1 << 4))) {
+	if (!(superio_inb(sio_data, W83687THF_VID_CFG) & (1 << 4))) {
 		dev_dbg(&pdev->dev, "VID configured as output, "
 			"no VID function\n");
 		goto exit;
 	}
 
-	res = superio_inb(W83687THF_VID_DATA) & 0x3f;
+	res = superio_inb(sio_data, W83687THF_VID_DATA) & 0x3f;
 
 exit:
-	superio_exit();
+	superio_exit(sio_data);
 	return res;
 }
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
