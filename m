From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 19 May 2009 20:36:50 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83627ehf) Add W83627DHG-P support
Message-Id: <20090519223650.356cb0b3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for the new incarnation of the Winbond/Nuvoton W83627DHG
chip known as W83627DHG-P. It is basically the same as the original
W83627DHG with an additional automatic can speed control mode (not
supported by the driver yet.)

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/w83627ehf |   11 +++++++++--
 drivers/hwmon/w83627ehf.c     |   10 +++++++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

--- linux-2.6.30-rc6.orig/Documentation/hwmon/w83627ehf	2009-05-19 11:06:08.000000000 +0200
+++ linux-2.6.30-rc6/Documentation/hwmon/w83627ehf	2009-05-19 21:13:02.000000000 +0200
@@ -12,6 +12,10 @@ Supported chips:
     Addresses scanned: ISA address retrieved from Super I/O registers
     Datasheet:
         http://www.nuvoton.com.tw/NR/rdonlyres/7885623D-A487-4CF9-A47F-30C5F73D6FE6/0/W83627DHG.pdf
+  * Winbond W83627DHG-P
+    Prefix: 'w83627dhg'
+    Addresses scanned: ISA address retrieved from Super I/O registers
+    Datasheet: not available
   * Winbond W83667HG
     Prefix: 'w83667hg'
     Addresses scanned: ISA address retrieved from Super I/O registers
@@ -28,8 +32,8 @@ Description
 -----------
 
 This driver implements support for the Winbond W83627EHF, W83627EHG,
-W83627DHG and W83667HG super I/O chips. We will refer to them collectively
-as Winbond chips.
+W83627DHG, W83627DHG-P and W83667HG super I/O chips. We will refer to them
+collectively as Winbond chips.
 
 The chips implement three temperature sensors, five fan rotation
 speed sensors, ten analog voltage sensors (only nine for the 627DHG), one
@@ -135,3 +139,6 @@ done in the driver for all register addr
 The DHG also supports PECI, where the DHG queries Intel CPU temperatures, and
 the ICH8 southbridge gets that data via PECI from the DHG, so that the
 southbridge drives the fans. And the DHG supports SST, a one-wire serial bus.
+
+The DHG-P has an additional automatic fan speed control mode named Smart Fan
+(TM) III+. This mode is not yet supported by the driver.
--- linux-2.6.30-rc6.orig/drivers/hwmon/w83627ehf.c	2009-05-19 11:06:08.000000000 +0200
+++ linux-2.6.30-rc6/drivers/hwmon/w83627ehf.c	2009-05-19 14:13:56.000000000 +0200
@@ -36,6 +36,7 @@
     w83627ehf   10      5       4       3      0x8850 0x88    0x5ca3
                                                0x8860 0xa1
     w83627dhg    9      5       4       3      0xa020 0xc1    0x5ca3
+    w83627dhg-p  9      5       4       3      0xb070 0xc1    0x5ca3
     w83667hg     9      5       3       3      0xa510 0xc1    0x5ca3
 */
 
@@ -53,12 +54,13 @@
 #include <asm/io.h>
 #include "lm75.h"
 
-enum kinds { w83627ehf, w83627dhg, w83667hg };
+enum kinds { w83627ehf, w83627dhg, w83627dhg_p, w83667hg };
 
 /* used to set data->name = w83627ehf_device_names[data->sio_kind] */
 static const char * w83627ehf_device_names[] = {
 	"w83627ehf",
 	"w83627dhg",
+	"w83627dhg",
 	"w83667hg",
 };
 
@@ -86,6 +88,7 @@ MODULE_PARM_DESC(force_id, "Override the
 #define SIO_W83627EHF_ID	0x8850
 #define SIO_W83627EHG_ID	0x8860
 #define SIO_W83627DHG_ID	0xa020
+#define SIO_W83627DHG_P_ID	0xb070
 #define SIO_W83667HG_ID 	0xa510
 #define SIO_ID_MASK		0xFFF0
 
@@ -1517,6 +1520,7 @@ static int __init w83627ehf_find(int sio
 	static const char __initdata sio_name_W83627EHF[] = "W83627EHF";
 	static const char __initdata sio_name_W83627EHG[] = "W83627EHG";
 	static const char __initdata sio_name_W83627DHG[] = "W83627DHG";
+	static const char __initdata sio_name_W83627DHG_P[] = "W83627DHG-P";
 	static const char __initdata sio_name_W83667HG[] = "W83667HG";
 
 	u16 val;
@@ -1542,6 +1546,10 @@ static int __init w83627ehf_find(int sio
 		sio_data->kind = w83627dhg;
 		sio_name = sio_name_W83627DHG;
 		break;
+	case SIO_W83627DHG_P_ID:
+		sio_data->kind = w83627dhg_p;
+		sio_name = sio_name_W83627DHG_P;
+		break;
 	case SIO_W83667HG_ID:
 		sio_data->kind = w83667hg;
 		sio_name = sio_name_W83667HG;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
