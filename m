From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Date: Mon, 04 Jan 2010 23:44:08 +0000
Subject: [lm-sensors] [PATCH 4/5] sis5595: make PCI device id constant
Message-Id: <4B427D48.7000100@freemail.hu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Aurelien Jarno <aurelien@aurel32.net>, lm-sensors@lm-sensors.org
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
diff -u -p a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
--- a/drivers/hwmon/sis5595.c 2009-12-03 04:51:21.000000000 +0100
+++ b/drivers/hwmon/sis5595.c 2010-01-03 20:55:51.000000000 +0100
@@ -697,7 +697,7 @@ static struct sis5595_data *sis5595_upda
 	return data;
 }

-static struct pci_device_id sis5595_pci_ids[] = {
+static const struct pci_device_id sis5595_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_503) },
 	{ 0, }
 };

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
