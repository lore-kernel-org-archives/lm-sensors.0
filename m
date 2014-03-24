From: Rudolf Marek <r.marek@assembler.cz>
Date: Mon, 24 Mar 2014 22:21:26 +0000
Subject: [lm-sensors] [PATCH 1/2]  hwmon: (it87) Fix 8603E define name
Message-Id: <5330AFE6.9070801@assembler.cz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090808090307050009050605"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------090808090307050009050605
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

The attached patch fixes small typo in the define name for IT 8603E.

Signed-off-by: Rudolf Marek <r.marek@assembler.cz>

Thanks
Rudolf

--------------090808090307050009050605
Content-Type: text/x-diff;
 name="it8603-fixtypo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="it8603-fixtypo.patch"

Index: linux-3.14-rc7/drivers/hwmon/it87.c
===================================================================
--- linux-3.14-rc7.orig/drivers/hwmon/it87.c	2014-03-17 02:51:24.000000000 +0100
+++ linux-3.14-rc7/drivers/hwmon/it87.c	2014-03-24 23:01:36.750290538 +0100
@@ -147,7 +147,7 @@
 #define IT8772E_DEVID 0x8772
 #define IT8782F_DEVID 0x8782
 #define IT8783E_DEVID 0x8783
-#define IT8306E_DEVID 0x8603
+#define IT8603E_DEVID 0x8603
 #define IT87_ACT_REG  0x30
 #define IT87_BASE_REG 0x60
 
@@ -1431,7 +1431,7 @@
 static SENSOR_DEVICE_ATTR(in3_label, S_IRUGO, show_label, NULL, 0);
 static SENSOR_DEVICE_ATTR(in7_label, S_IRUGO, show_label, NULL, 1);
 static SENSOR_DEVICE_ATTR(in8_label, S_IRUGO, show_label, NULL, 2);
-/* special AVCC3 IT8306E in9 */
+/* special AVCC3 IT8603E in9 */
 static SENSOR_DEVICE_ATTR(in9_label, S_IRUGO, show_label, NULL, 0);
 
 static ssize_t show_name(struct device *dev, struct device_attribute
@@ -1766,7 +1766,7 @@
 	case IT8783E_DEVID:
 		sio_data->type = it8783;
 		break;
-	case IT8306E_DEVID:
+	case IT8603E_DEVID:
 		sio_data->type = it8603;
 		break;
 	case 0xffff:	/* No device at all */

--------------090808090307050009050605
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------090808090307050009050605--
