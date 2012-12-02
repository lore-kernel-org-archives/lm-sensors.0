From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 02 Dec 2012 19:17:47 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (it87) Add support for IT8771E
Message-Id: <1354475868-10032-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100225090135.4fefd2f6@hyperion.delvare>
In-Reply-To: <20100225090135.4fefd2f6@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Kelly Anderson <kelly@silka.with-linux.com>

Assume that IT8771E is fully compatible with IT8728F.

Contributions-by: Kelly Anderson <kelly@silka.with-linux.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/it87 |   10 +++++++---
 drivers/hwmon/Kconfig    |    2 +-
 drivers/hwmon/it87.c     |   25 ++++++++++++++++++++-----
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87
index 8386aad..b9e13a0 100644
--- a/Documentation/hwmon/it87
+++ b/Documentation/hwmon/it87
@@ -30,6 +30,10 @@ Supported chips:
     Prefix: 'it8728'
     Addresses scanned: from Super I/O config space (8 I/O ports)
     Datasheet: Not publicly available
+  * IT8771E
+    Prefix: 'it8771'
+    Addresses scanned: from Super I/O config space (8 I/O ports)
+    Datasheet: Not publicly available
   * IT8782F
     Prefix: 'it8782'
     Addresses scanned: from Super I/O config space (8 I/O ports)
@@ -83,7 +87,7 @@ Description
 -----------
 
 This driver implements support for the IT8705F, IT8712F, IT8716F,
-IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E, IT8781F, IT8782F,
+IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E, IT8771E, IT8782F,
 IT8783E/F, and SiS950 chips.
 
 These chips are 'Super I/O chips', supporting floppy disks, infrared ports,
@@ -118,8 +122,8 @@ The IT8726F is just bit enhanced IT8716F with additional hardware
 for AMD power sequencing. Therefore the chip will appear as IT8716F
 to userspace applications.
 
-The IT8728F is considered compatible with the IT8721F, until a datasheet
-becomes available (hopefully.)
+The IT8728F and IT8771E are considered compatible with the IT8721F, until
+a datasheet becomes available (hopefully.)
 
 Temperatures are measured in degrees Celsius. An alarm is triggered once
 when the Overtemperature Shutdown limit is crossed.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index c4633de..b1a4826 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -496,7 +496,7 @@ config SENSORS_IT87
 	help
 	  If you say yes here you get support for ITE IT8705F, IT8712F,
 	  IT8716F, IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E,
-	  IT8782F, and IT8783E/F sensor chips, and the SiS950 clone.
+	  IT8771E, IT8782F, and IT8783E/F sensor chips, and the SiS950 clone.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called it87.
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 6a1410b..5591a39 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -19,6 +19,7 @@
  *            IT8726F  Super I/O chip w/LPC interface
  *            IT8728F  Super I/O chip w/LPC interface
  *            IT8758E  Super I/O chip w/LPC interface
+ *            IT8771E  Super I/O chip w/LPC interface
  *            IT8782F  Super I/O chip w/LPC interface
  *            IT8783E/F Super I/O chip w/LPC interface
  *            Sis950   A clone of the IT8705F
@@ -61,8 +62,8 @@
 
 #define DRVNAME "it87"
 
-enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it8782,
-	     it8783 };
+enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it8771,
+	     it8782, it8783 };
 
 static unsigned short force_id;
 module_param(force_id, ushort, 0);
@@ -140,6 +141,7 @@ static inline void superio_exit(void)
 #define IT8721F_DEVID 0x8721
 #define IT8726F_DEVID 0x8726
 #define IT8728F_DEVID 0x8728
+#define IT8771E_DEVID 0x8771
 #define IT8782F_DEVID 0x8782
 #define IT8783E_DEVID 0x8783
 #define IT87_ACT_REG  0x30
@@ -281,6 +283,15 @@ static const struct it87_devices it87_devices[] = {
 		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI,
 		.peci_mask = 0x07,
 	},
+	[it8771] = {
+		.name = "it8771",
+		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
+		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI,
+					/* PECI: guesswork */
+					/* 12mV ADC (OHM) */
+					/* 16 bit fans (OHM) */
+		.peci_mask = 0x07,
+	},
 	[it8782] = {
 		.name = "it8782",
 		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
@@ -1709,6 +1720,9 @@ static int __init it87_find(unsigned short *address,
 	case IT8728F_DEVID:
 		sio_data->type = it8728;
 		break;
+	case IT8771E_DEVID:
+		sio_data->type = it8771;
+		break;
 	case IT8782F_DEVID:
 		sio_data->type = it8782;
 		break;
@@ -1826,10 +1840,10 @@ static int __init it87_find(unsigned short *address,
 
 		reg = superio_inb(IT87_SIO_GPIO3_REG);
 		if (sio_data->type = it8721 || sio_data->type = it8728 ||
-		    sio_data->type = it8782) {
+		    sio_data->type = it8771 || sio_data->type = it8782) {
 			/*
 			 * IT8721F/IT8758E, and IT8782F don't have VID pins
-			 * at all, not sure about the IT8728F.
+			 * at all, not sure about the IT8728F and compatibles.
 			 */
 			sio_data->skip_vid = 1;
 		} else {
@@ -1883,7 +1897,8 @@ static int __init it87_find(unsigned short *address,
 		if (reg & (1 << 0))
 			sio_data->internal |= (1 << 0);
 		if ((reg & (1 << 1)) || sio_data->type = it8721 ||
-		    sio_data->type = it8728)
+		    sio_data->type = it8728 ||
+		    sio_data->type = it8771)
 			sio_data->internal |= (1 << 1);
 
 		/*
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
