From: Rudolf Marek <r.marek@assembler.cz>
Date: Mon, 24 Mar 2014 22:23:39 +0000
Subject: [lm-sensors] [PATCH 2/2]  hwmon: (it87) Add support for IT8623E
Message-Id: <5330B06B.5030207@assembler.cz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020106070608070408010405"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020106070608070408010405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

The attached patch adds support for the IT8623E found on Asus motherboards. It 
has same hardware monitoring block as IT8603E.

Signed-off-by: Rudolf Marek <r.marek@assembler.cz>

Compile tested. Martin, please can you test?

Thanks
Rudolf


--------------020106070608070408010405
Content-Type: text/x-diff;
 name="it8623.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="it8623.patch"

Index: linux-3.14-rc7/Documentation/hwmon/it87
===================================================================
--- linux-3.14-rc7.orig/Documentation/hwmon/it87	2014-03-17 02:51:24.000000000 +0100
+++ linux-3.14-rc7/Documentation/hwmon/it87	2014-03-24 23:01:24.946438930 +0100
@@ -2,7 +2,7 @@
 ==================
 
 Supported chips:
-  * IT8603E
+  * IT8603E/IT8623E
     Prefix: 'it8603'
     Addresses scanned: from Super I/O config space (8 I/O ports)
     Datasheet: Not publicly available
@@ -94,9 +94,9 @@
 Description
 -----------
 
-This driver implements support for the IT8603E, IT8705F, IT8712F, IT8716F,
-IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E, IT8771E, IT8772E,
-IT8782F, IT8783E/F, and SiS950 chips.
+This driver implements support for the IT8603E, IT8623E, IT8705F, IT8712F,
+IT8716F, IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E, IT8771E,
+IT8772E, IT8782F, IT8783E/F, and SiS950 chips.
 
 These chips are 'Super I/O chips', supporting floppy disks, infrared ports,
 joysticks and other miscellaneous stuff. For hardware monitoring, they
@@ -133,7 +133,7 @@
 The IT8728F, IT8771E, and IT8772E are considered compatible with the IT8721F,
 until a datasheet becomes available (hopefully.)
 
-The IT8603E is a custom design, hardware monitoring part is similar to
+The IT8603E/IT8623E is a custom design, hardware monitoring part is similar to
 IT8728F. It only supports 16-bit fan mode, the full speed mode of the
 fan is not supported (value 0 of pwmX_enable).
 
Index: linux-3.14-rc7/drivers/hwmon/it87.c
===================================================================
--- linux-3.14-rc7.orig/drivers/hwmon/it87.c	2014-03-24 22:57:57.213050493 +0100
+++ linux-3.14-rc7/drivers/hwmon/it87.c	2014-03-24 22:54:27.000000000 +0100
@@ -11,6 +11,7 @@
  *  similar parts.  The other devices are supported by different drivers.
  *
  *  Supports: IT8603E  Super I/O chip w/LPC interface
+ *            IT8623E  Super I/O chip w/LPC interface
  *            IT8705F  Super I/O chip w/LPC interface
  *            IT8712F  Super I/O chip w/LPC interface
  *            IT8716F  Super I/O chip w/LPC interface
@@ -148,6 +149,7 @@
 #define IT8782F_DEVID 0x8782
 #define IT8783E_DEVID 0x8783
 #define IT8603E_DEVID 0x8603
+#define IT8623E_DEVID 0x8623
 #define IT87_ACT_REG  0x30
 #define IT87_BASE_REG 0x60
 
@@ -1767,6 +1769,7 @@
 		sio_data->type = it8783;
 		break;
 	case IT8603E_DEVID:
+	case IT8623E_DEVID:
 		sio_data->type = it8603;
 		break;
 	case 0xffff:	/* No device at all */

--------------020106070608070408010405
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020106070608070408010405--
