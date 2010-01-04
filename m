From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Date: Mon, 04 Jan 2010 23:44:00 +0000
Subject: [lm-sensors] [PATCH 2/5] vt8231: make PCI device id constant
Message-Id: <4B427D40.3010102@freemail.hu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Roger Lucas <vt8231@hiddenengine.co.uk>, lm-sensors@lm-sensors.org
Cc: Julia Lawall <julia@diku.dk>, cocci@diku.dk, LKML <linux-kernel@vger.kernel.org>

From: Márton Németh <nm127@freemail.hu>

The id_table field of the struct pci_driver is constant in <linux/pci.h>
so it is worth to make pci_device_id also constant.

The semantic match that finds this kind of pattern is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
identifier I1, I2, x;
@@
	struct I1 {
	  ...
	  const struct I2 *x;
	  ...
	};
@s@
identifier r.I1, y;
identifier r.x, E;
@@
	struct I1 y = {
	  .x = E,
	};
@c@
identifier r.I2;
identifier s.E;
@@
	const struct I2 E[] = ... ;
@depends on !c@
identifier r.I2;
identifier s.E;
@@
+	const
	struct I2 E[] = ...;
// </smpl>

Signed-off-by: Márton Németh <nm127@freemail.hu>
Cc: Julia Lawall <julia@diku.dk>
Cc: cocci@diku.dk
---
diff -u -p a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
--- a/drivers/hwmon/vt8231.c 2009-12-03 04:51:21.000000000 +0100
+++ b/drivers/hwmon/vt8231.c 2010-01-03 20:55:14.000000000 +0100
@@ -697,7 +697,7 @@ static struct platform_driver vt8231_dri
 	.remove	= __devexit_p(vt8231_remove),
 };

-static struct pci_device_id vt8231_pci_ids[] = {
+static const struct pci_device_id vt8231_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8231_4) },
 	{ 0, }
 };

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
