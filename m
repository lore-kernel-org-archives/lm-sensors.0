From: Rudolf Marek <r.marek@assembler.cz>
Date: Mon, 21 May 2007 20:58:13 +0000
Subject: [lm-sensors] [PATCH] Add IT8726F
Message-Id: <465207E5.3010500@assembler.cz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060309040509080307000405"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------060309040509080307000405
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Following patch adds support for IT8726F chip driver, which is just same as 
IT8716F with additional glue logic for AMD power sequencing.

Signed-off-by: Rudolf Marek <r.marek@assembler.cz>

Please apply. Compile tested.

Rudolf

--------------060309040509080307000405
Content-Type: text/x-patch;
 name="add-it8726f.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add-it8726f.patch"

Index: linux-2.6.22-rc2/Documentation/hwmon/it87
===================================================================
--- linux-2.6.22-rc2.orig/Documentation/hwmon/it87	2007-05-19 22:26:18.575093712 +0200
+++ linux-2.6.22-rc2/Documentation/hwmon/it87	2007-05-19 22:32:43.925053550 +0200
@@ -12,11 +12,12 @@
     Addresses scanned: from Super I/O config space (8 I/O ports)
     Datasheet: Publicly available at the ITE website
                http://www.ite.com.tw/
-  * IT8716F
+  * IT8716F/IT8726F
     Prefix: 'it8716'
     Addresses scanned: from Super I/O config space (8 I/O ports)
     Datasheet: Publicly available at the ITE website
                http://www.ite.com.tw/product_info/file/pc/IT8716F_V0.3.ZIP
+               http://www.ite.com.tw/product_info/file/pc/IT8726F_V0.3.pdf
   * IT8718F
     Prefix: 'it8718'
     Addresses scanned: from Super I/O config space (8 I/O ports)
@@ -68,7 +69,7 @@
 -----------
 
 This driver implements support for the IT8705F, IT8712F, IT8716F,
-IT8718F and SiS950 chips.
+IT8718F, IT8726F and SiS950 chips.
 
 These chips are 'Super I/O chips', supporting floppy disks, infrared ports,
 joysticks and other miscellaneous stuff. For hardware monitoring, they
@@ -97,6 +98,10 @@
 revisions. For now, the driver only uses the 16-bit mode on the
 IT8716F and IT8718F.
 
+The IT8726F is just bit enhanced IT8716F with additional hardware
+for AMD power sequencing. Therefore the chip will appear as IT8716F
+to userspace applications.
+
 Temperatures are measured in degrees Celsius. An alarm is triggered once
 when the Overtemperature Shutdown limit is crossed.
 
Index: linux-2.6.22-rc2/drivers/hwmon/it87.c
===================================================================
--- linux-2.6.22-rc2.orig/drivers/hwmon/it87.c	2007-05-19 22:38:32.168898840 +0200
+++ linux-2.6.22-rc2/drivers/hwmon/it87.c	2007-05-19 22:35:35.000000000 +0200
@@ -6,6 +6,7 @@
               IT8712F  Super I/O chip w/LPC interface
               IT8716F  Super I/O chip w/LPC interface
               IT8718F  Super I/O chip w/LPC interface
+              IT8726F  Super I/O chip w/LPC interface
               Sis950   A clone of the IT8705F
 
     Copyright (C) 2001 Chris Gauthron <chrisg@0-in.com> 
@@ -97,6 +98,7 @@
 #define IT8705F_DEVID 0x8705
 #define IT8716F_DEVID 0x8716
 #define IT8718F_DEVID 0x8718
+#define IT8726F_DEVID 0x8726
 #define IT87_ACT_REG  0x30
 #define IT87_BASE_REG 0x60
 
@@ -885,6 +887,7 @@
 	chip_type = superio_inw(DEVID);
 	if (chip_type != IT8712F_DEVID
 	 && chip_type != IT8716F_DEVID
+	 && chip_type != IT8726F_DEVID
 	 && chip_type != IT8718F_DEVID
 	 && chip_type != IT8705F_DEVID)
 	 	goto exit;
@@ -965,6 +968,8 @@
 		data->type = it8712;
 		name = "it8712";
 		break;
+	case IT8726F_DEVID:
+	/* fall through */
 	case IT8716F_DEVID:
 		data->type = it8716;
 		name = "it8716";
@@ -1389,7 +1394,7 @@
 
 MODULE_AUTHOR("Chris Gauthron <chrisg@0-in.com>, "
 	      "Jean Delvare <khali@linux-fr.org>");
-MODULE_DESCRIPTION("IT8705F/8712F/8716F/8718F, SiS950 driver");
+MODULE_DESCRIPTION("IT8705F/8712F/8716F/8718F/8726F, SiS950 driver");
 module_param(update_vbat, bool, 0);
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");
 module_param(fix_pwm_polarity, bool, 0);

--------------060309040509080307000405
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------060309040509080307000405--
