From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Mar 2013 00:02:44 +0000
Subject: [lm-sensors] [PATCH 4/4] hwmon: (w83627hf) Use request_muxed_region
Message-Id: <1363219364-5221-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Serialize access to the hardware by using "request_muxed_region".
Calls to this macro will hold off the requestor if the resource is
currently busy. "superio_enter" will return an error if call to
"request_muxed_region" fails. Rest of the code change is to pass
errors returned from superio_enter to the top level.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83627hf.c |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 765d419..041217e 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -130,17 +130,21 @@ superio_select(struct w83627hf_sio_data *sio, int ld)
 	outb(ld,  sio->sioaddr + 1);
 }
 
-static inline void
+static inline int
 superio_enter(struct w83627hf_sio_data *sio)
 {
+	if (!request_muxed_region(sio->sioaddr, 2, DRVNAME))
+		return -EBUSY;
 	outb(0x87, sio->sioaddr);
 	outb(0x87, sio->sioaddr);
+	return 0;
 }
 
 static inline void
 superio_exit(struct w83627hf_sio_data *sio)
 {
 	outb(0xAA, sio->sioaddr);
+	release_region(sio->sioaddr, 2);
 }
 
 #define W627_DEVID 0x52
@@ -1458,7 +1462,8 @@ static int w83627thf_read_gpio5(struct platform_device *pdev)
 	struct w83627hf_sio_data *sio_data = pdev->dev.platform_data;
 	int res = 0xff, sel;
 
-	superio_enter(sio_data);
+	if (superio_enter(sio_data))
+		return res;
 	superio_select(sio_data, W83627HF_LD_GPIO5);
 
 	/* Make sure these GPIO pins are enabled */
@@ -1491,7 +1496,8 @@ static int w83687thf_read_vid(struct platform_device *pdev)
 	struct w83627hf_sio_data *sio_data = pdev->dev.platform_data;
 	int res = 0xff;
 
-	superio_enter(sio_data);
+	if (superio_enter(sio_data))
+		return res;
 	superio_select(sio_data, W83627HF_LD_HWM);
 
 	/* Make sure these GPIO pins are enabled */
@@ -1621,6 +1627,7 @@ static int w83627hf_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
+
 	data = devm_kzalloc(dev, sizeof(struct w83627hf_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -1902,7 +1909,7 @@ exit:
 static int __init w83627hf_find(int sioaddr, unsigned short *addr,
 				struct w83627hf_sio_data *sio_data)
 {
-	int err = -ENODEV;
+	int err;
 	u16 val;
 
 	static __initconst char *const names[] = {
@@ -1914,7 +1921,9 @@ static int __init w83627hf_find(int sioaddr, unsigned short *addr,
 	};
 
 	sio_data->sioaddr = sioaddr;
-	superio_enter(sio_data);
+	err = superio_enter(sio_data);
+	if (err)
+		return err;
 	val = force_id ? force_id : superio_inb(sio_data, DEVID);
 	switch (val) {
 	case W627_DEVID:
@@ -1933,8 +1942,10 @@ static int __init w83627hf_find(int sioaddr, unsigned short *addr,
 		sio_data->type = w83687thf;
 		break;
 	case 0xff:	/* No device at all */
+		err = -ENODEV;
 		goto exit;
 	default:
+		err = -ENODEV;
 		pr_debug(DRVNAME ": Unsupported chip (DEVID=0x%02x)\n", val);
 		goto exit;
 	}
@@ -1954,7 +1965,6 @@ static int __init w83627hf_find(int sioaddr, unsigned short *addr,
 		superio_outb(sio_data, WINB_ACT_REG, val | 0x01);
 	}
 
-	err = 0;
 	pr_info(DRVNAME ": Found %s chip at %#x\n",
 		names[sio_data->type], *addr);
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
