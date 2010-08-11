From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Aug 2010 15:08:09 +0000
Subject: [lm-sensors] [PATCH 1/6] hwmon: (pc87427) Handle disabled fan
Message-Id: <20100811170809.284a0a17@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Most fan input pins of the PC87427 can have alternate functions.
Update the driver to check the configuration register and only support
fan inputs which are really used for fan monitoring.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/pc87427.c |   67 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 9 deletions(-)

--- linux-2.6.32-rc3.orig/drivers/hwmon/pc87427.c	2009-10-02 16:11:15.000000000 +0200
+++ linux-2.6.32-rc3/drivers/hwmon/pc87427.c	2009-10-11 14:27:30.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  pc87427.c - hardware monitoring driver for the
  *              National Semiconductor PC87427 Super-I/O chip
- *  Copyright (C) 2006 Jean Delvare <khali@linux-fr.org>
+ *  Copyright (C) 2006, 2008  Jean Delvare <khali@linux-fr.org>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -59,12 +59,21 @@ struct pc87427_data {
 	u8 fan_status[8];		/* register values */
 };
 
+struct pc87427_sio_data {
+	u8 has_fanin;
+};
+
 /*
  * Super-I/O registers and operations
  */
 
 #define SIOREG_LDSEL	0x07	/* Logical device select */
 #define SIOREG_DEVID	0x20	/* Device ID */
+#define SIOREG_CF2	0x22	/* Configuration 2 */
+#define SIOREG_CF3	0x23	/* Configuration 3 */
+#define SIOREG_CF4	0x24	/* Configuration 4 */
+#define SIOREG_CFB	0x2B	/* Configuration B */
+#define SIOREG_CFD	0x2D	/* Configuration D */
 #define SIOREG_ACT	0x30	/* Device activation */
 #define SIOREG_MAP	0x50	/* I/O or memory mapping */
 #define SIOREG_IOBASE	0x60	/* I/O base address */
@@ -393,6 +402,7 @@ static DEVICE_ATTR(name, S_IRUGO, show_n
 
 static void __devinit pc87427_init_device(struct device *dev)
 {
+	struct pc87427_sio_data *sio_data = dev->platform_data;
 	struct pc87427_data *data = dev_get_drvdata(dev);
 	int i;
 	u8 reg;
@@ -404,6 +414,8 @@ static void __devinit pc87427_init_devic
 
 	/* Check which fans are enabled */
 	for (i = 0; i < 8; i++) {
+		if (!(sio_data->has_fanin & (1 << i)))	/* Not wired */
+			continue;
 		reg = pc87427_read8_bank(data, LD_FAN, BANK_FM(i),
 					 PC87427_REG_FAN_STATUS);
 		if (reg & FAN_STATUS_MONEN)
@@ -411,12 +423,15 @@ static void __devinit pc87427_init_devic
 	}
 
 	if (!data->fan_enabled) {
-		dev_dbg(dev, "Enabling all fan inputs\n");
-		for (i = 0; i < 8; i++)
+		dev_dbg(dev, "Enabling monitoring of all fans\n");
+		for (i = 0; i < 8; i++) {
+			if (!(sio_data->has_fanin & (1 << i)))	/* Not wired */
+				continue;
 			pc87427_write8_bank(data, LD_FAN, BANK_FM(i),
 					    PC87427_REG_FAN_STATUS,
 					    FAN_STATUS_MONEN);
-		data->fan_enabled = 0xff;
+		}
+		data->fan_enabled = sio_data->has_fanin;
 	}
 }
 
@@ -515,7 +530,8 @@ static struct platform_driver pc87427_dr
 	.remove		= __devexit_p(pc87427_remove),
 };
 
-static int __init pc87427_device_add(unsigned short address)
+static int __init pc87427_device_add(unsigned short address,
+				     const struct pc87427_sio_data *sio_data)
 {
 	struct resource res = {
 		.start	= address,
@@ -543,6 +559,13 @@ static int __init pc87427_device_add(uns
 		goto exit_device_put;
 	}
 
+	err = platform_device_add_data(pdev, sio_data,
+				       sizeof(struct pc87427_sio_data));
+	if (err) {
+		printk(KERN_ERR DRVNAME ": Platform data allocation failed\n");
+		goto exit_device_put;
+	}
+
 	err = platform_device_add(pdev);
 	if (err) {
 		printk(KERN_ERR DRVNAME ": Device addition failed (%d)\n",
@@ -558,9 +581,11 @@ exit:
 	return err;
 }
 
-static int __init pc87427_find(int sioaddr, unsigned short *address)
+static int __init pc87427_find(int sioaddr, unsigned short *address,
+			       struct pc87427_sio_data *sio_data)
 {
 	u16 val;
+	u8 cfg, cfg_b;
 	int i, err = 0;
 
 	/* Identify device */
@@ -599,6 +624,29 @@ static int __init pc87427_find(int sioad
 		address[i] = val;
 	}
 
+	/* Check which fan inputs are wired */
+	sio_data->has_fanin = (1 << 2) | (1 << 3);	/* FANIN2, FANIN3 */
+
+	cfg = superio_inb(sioaddr, SIOREG_CF2);
+	if (!(cfg & (1 << 3)))
+		sio_data->has_fanin |= (1 << 0);	/* FANIN0 */
+	if (!(cfg & (1 << 2)))
+		sio_data->has_fanin |= (1 << 4);	/* FANIN4 */
+
+	cfg = superio_inb(sioaddr, SIOREG_CFD);
+	if (!(cfg & (1 << 0)))
+		sio_data->has_fanin |= (1 << 1);	/* FANIN1 */
+
+	cfg = superio_inb(sioaddr, SIOREG_CF4);
+	if (!(cfg & (1 << 0)))
+		sio_data->has_fanin |= (1 << 7);	/* FANIN7 */
+	cfg_b = superio_inb(sioaddr, SIOREG_CFB);
+	if (!(cfg & (1 << 1)) && (cfg_b & (1 << 3)))
+		sio_data->has_fanin |= (1 << 5);	/* FANIN5 */
+	cfg = superio_inb(sioaddr, SIOREG_CF3);
+	if ((cfg & (1 << 3)) && !(cfg_b & (1 << 5)))
+		sio_data->has_fanin |= (1 << 6);	/* FANIN6 */
+
 exit:
 	superio_exit(sioaddr);
 	return err;
@@ -608,9 +656,10 @@ static int __init pc87427_init(void)
 {
 	int err;
 	unsigned short address[2];
+	struct pc87427_sio_data sio_data;
 
-	if (pc87427_find(0x2e, address)
-	 && pc87427_find(0x4e, address))
+	if (pc87427_find(0x2e, address, &sio_data)
+	 && pc87427_find(0x4e, address, &sio_data))
 		return -ENODEV;
 
 	/* For now the driver only handles fans so we only care about the
@@ -623,7 +672,7 @@ static int __init pc87427_init(void)
 		goto exit;
 
 	/* Sets global pdev as a side effect */
-	err = pc87427_device_add(address[0]);
+	err = pc87427_device_add(address[0], &sio_data);
 	if (err)
 		goto exit_driver;
 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
