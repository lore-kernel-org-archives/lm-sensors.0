From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Date: Mon, 04 Jan 2010 23:44:13 +0000
Subject: [lm-sensors] [PATCH 5/5] k8temp: make PCI device id constant
Message-Id: <4B427D4D.8060200@freemail.hu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Rudolf Marek <r.marek@assembler.cz>, lm-sensors@lm-sensors.org
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
diff -u -p a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
--- a/drivers/hwmon/k8temp.c 2009-12-03 04:51:21.000000000 +0100
+++ b/drivers/hwmon/k8temp.c 2010-01-03 20:56:11.000000000 +0100
@@ -136,7 +136,7 @@ static SENSOR_DEVICE_ATTR_2(temp3_input,
 static SENSOR_DEVICE_ATTR_2(temp4_input, S_IRUGO, show_temp, NULL, 1, 1);
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);

-static struct pci_device_id k8temp_ids[] = {
+static const struct pci_device_id k8temp_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB_MISC) },
 	{ 0 },
 };

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
