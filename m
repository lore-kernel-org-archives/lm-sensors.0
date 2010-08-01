From: Giel van Schijndel <me@mortis.eu>
Date: Sun, 01 Aug 2010 13:30:54 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: f71882fg: use a muxed resource lock
Message-Id: <1280669455-31283-1-git-send-email-me@mortis.eu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100801132226.GE3711@salidar.me.mortis.eu>
In-Reply-To: <20100801132226.GE3711@salidar.me.mortis.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 
Cc: Laurens Leemans <laurens@signips.com>, Jonathan Cameron <jic23@cam.ac.uk>, Giel van Schijndel <me@mortis.eu>, Jean Delvare <khali@linux-fr.org>, Hans de Goede <hdegoede@redhat.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Sleep while acquiring a resource lock on the Super I/O port. This should
prevent collisions from causing the hardware probe to fail with -EBUSY.

Signed-off-by: Giel van Schijndel <me@mortis.eu>
---
 drivers/hwmon/f71882fg.c |   32 +++++++++++++++++++-------------
 1 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 7857ed3..267cb92 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -113,7 +113,7 @@ static struct platform_device *f71882fg_pdev;
 /* Super-I/O Function prototypes */
 static inline int superio_inb(int base, int reg);
 static inline int superio_inw(int base, int reg);
-static inline void superio_enter(int base);
+static inline int superio_enter(int base);
 static inline void superio_select(int base, int ld);
 static inline void superio_exit(int base);
 
@@ -883,11 +883,20 @@ static int superio_inw(int base, int reg)
 	return val;
 }
 
-static inline void superio_enter(int base)
+static inline int superio_enter(int base)
 {
+	/* Don't step on other drivers' I/O space by accident */
+	if (!request_muxed_region(base, 2, DRVNAME)) {
+		printk(KERN_ERR DRVNAME ": I/O address 0x%04x already in use\n",
+				base);
+		return -EBUSY;
+	}
+
 	/* according to the datasheet the key must be send twice! */
 	outb(SIO_UNLOCK_KEY, base);
 	outb(SIO_UNLOCK_KEY, base);
+
+	return 0;
 }
 
 static inline void superio_select(int base, int ld)
@@ -899,6 +908,7 @@ static inline void superio_select(int base, int ld)
 static inline void superio_exit(int base)
 {
 	outb(SIO_LOCK_KEY, base);
+	release_region(base, 2);
 }
 
 static inline int fan_from_reg(u16 reg)
@@ -2239,21 +2249,15 @@ static int f71882fg_remove(struct platform_device *pdev)
 static int __init f71882fg_find(int sioaddr, unsigned short *address,
 	struct f71882fg_sio_data *sio_data)
 {
-	int err = -ENODEV;
 	u16 devid;
-
-	/* Don't step on other drivers' I/O space by accident */
-	if (!request_region(sioaddr, 2, DRVNAME)) {
-		printk(KERN_ERR DRVNAME ": I/O address 0x%04x already in use\n",
-				(int)sioaddr);
-		return -EBUSY;
-	}
-
-	superio_enter(sioaddr);
+	int err = superio_enter(sioaddr);
+	if (err)
+		return err;
 
 	devid = superio_inw(sioaddr, SIO_REG_MANID);
 	if (devid != SIO_FINTEK_ID) {
 		pr_debug(DRVNAME ": Not a Fintek device\n");
+		err = -ENODEV;
 		goto exit;
 	}
 
@@ -2280,6 +2284,7 @@ static int __init f71882fg_find(int sioaddr, unsigned short *address,
 	default:
 		printk(KERN_INFO DRVNAME ": Unsupported Fintek device: %04x\n",
 		       (unsigned int)devid);
+		err = -ENODEV;
 		goto exit;
 	}
 
@@ -2290,12 +2295,14 @@ static int __init f71882fg_find(int sioaddr, unsigned short *address,
 
 	if (!(superio_inb(sioaddr, SIO_REG_ENABLE) & 0x01)) {
 		printk(KERN_WARNING DRVNAME ": Device not activated\n");
+		err = -ENODEV;
 		goto exit;
 	}
 
 	*address = superio_inw(sioaddr, SIO_REG_ADDR);
 	if (*address = 0) {
 		printk(KERN_WARNING DRVNAME ": Base address not set\n");
+		err = -ENODEV;
 		goto exit;
 	}
 	*address &= ~(REGION_LENGTH - 1);	/* Ignore 3 LSB */
@@ -2306,7 +2313,6 @@ static int __init f71882fg_find(int sioaddr, unsigned short *address,
 		(int)superio_inb(sioaddr, SIO_REG_DEVREV));
 exit:
 	superio_exit(sioaddr);
-	release_region(sioaddr, 2);
 	return err;
 }
 
-- 
1.6.4.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
