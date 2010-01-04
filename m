From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Date: Mon, 04 Jan 2010 23:44:03 +0000
Subject: [lm-sensors] [PATCH 3/5] k10temp: make PCI device ids constant
Message-Id: <4B427D43.2080809@freemail.hu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Clemens Ladisch <clemens@ladisch.de>, lm-sensors@lm-sensors.org
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
diff -u -p a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
--- a/drivers/hwmon/k10temp.c 2009-12-27 12:20:18.000000000 +0100
+++ b/drivers/hwmon/k10temp.c 2010-01-03 20:55:44.000000000 +0100
@@ -169,7 +169,7 @@ static void __devexit k10temp_remove(str
 	dev_set_drvdata(&pdev->dev, NULL);
 }

-static struct pci_device_id k10temp_id_table[] = {
+static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_10H_NB_MISC) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_11H_NB_MISC) },
 	{}

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
