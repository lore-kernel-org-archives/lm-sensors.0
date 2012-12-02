From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 02 Dec 2012 19:17:48 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (it87) Add support for IT8772E
Message-Id: <1354475868-10032-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Assume that IT8772E is fully compatible with IT8728F and IT8771E.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/it87 |   12 ++++++++----
 drivers/hwmon/Kconfig    |    3 ++-
 drivers/hwmon/it87.c     |   22 +++++++++++++++++++---
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87
index b9e13a0..c263740 100644
--- a/Documentation/hwmon/it87
+++ b/Documentation/hwmon/it87
@@ -34,6 +34,10 @@ Supported chips:
     Prefix: 'it8771'
     Addresses scanned: from Super I/O config space (8 I/O ports)
     Datasheet: Not publicly available
+  * IT8772E
+    Prefix: 'it8772'
+    Addresses scanned: from Super I/O config space (8 I/O ports)
+    Datasheet: Not publicly available
   * IT8782F
     Prefix: 'it8782'
     Addresses scanned: from Super I/O config space (8 I/O ports)
@@ -87,8 +91,8 @@ Description
 -----------
 
 This driver implements support for the IT8705F, IT8712F, IT8716F,
-IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E, IT8771E, IT8782F,
-IT8783E/F, and SiS950 chips.
+IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E, IT8771E, IT8772E,
+IT8782F, IT8783E/F, and SiS950 chips.
 
 These chips are 'Super I/O chips', supporting floppy disks, infrared ports,
 joysticks and other miscellaneous stuff. For hardware monitoring, they
@@ -122,8 +126,8 @@ The IT8726F is just bit enhanced IT8716F with additional hardware
 for AMD power sequencing. Therefore the chip will appear as IT8716F
 to userspace applications.
 
-The IT8728F and IT8771E are considered compatible with the IT8721F, until
-a datasheet becomes available (hopefully.)
+The IT8728F, IT8771E, and IT8772E are considered compatible with the IT8721F,
+until a datasheet becomes available (hopefully.)
 
 Temperatures are measured in degrees Celsius. An alarm is triggered once
 when the Overtemperature Shutdown limit is crossed.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index b1a4826..0b77ac3 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -496,7 +496,8 @@ config SENSORS_IT87
 	help
 	  If you say yes here you get support for ITE IT8705F, IT8712F,
 	  IT8716F, IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E,
-	  IT8771E, IT8782F, and IT8783E/F sensor chips, and the SiS950 clone.
+	  IT8771E, IT8772E, IT8782F, and IT8783E/F sensor chips, and the
+	  SiS950 clone.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called it87.
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 5591a39..531b5df 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -20,6 +20,7 @@
  *            IT8728F  Super I/O chip w/LPC interface
  *            IT8758E  Super I/O chip w/LPC interface
  *            IT8771E  Super I/O chip w/LPC interface
+ *            IT8772E  Super I/O chip w/LPC interface
  *            IT8782F  Super I/O chip w/LPC interface
  *            IT8783E/F Super I/O chip w/LPC interface
  *            Sis950   A clone of the IT8705F
@@ -63,7 +64,7 @@
 #define DRVNAME "it87"
 
 enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it8771,
-	     it8782, it8783 };
+	     it8772, it8782, it8783 };
 
 static unsigned short force_id;
 module_param(force_id, ushort, 0);
@@ -142,6 +143,7 @@ static inline void superio_exit(void)
 #define IT8726F_DEVID 0x8726
 #define IT8728F_DEVID 0x8728
 #define IT8771E_DEVID 0x8771
+#define IT8772E_DEVID 0x8772
 #define IT8782F_DEVID 0x8782
 #define IT8783E_DEVID 0x8783
 #define IT87_ACT_REG  0x30
@@ -292,6 +294,15 @@ static const struct it87_devices it87_devices[] = {
 					/* 16 bit fans (OHM) */
 		.peci_mask = 0x07,
 	},
+	[it8772] = {
+		.name = "it8772",
+		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
+		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI,
+					/* PECI (coreboot) */
+					/* 12mV ADC (HWSensors4, OHM) */
+					/* 16 bit fans (HWSensors4, OHM) */
+		.peci_mask = 0x07,
+	},
 	[it8782] = {
 		.name = "it8782",
 		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
@@ -1723,6 +1734,9 @@ static int __init it87_find(unsigned short *address,
 	case IT8771E_DEVID:
 		sio_data->type = it8771;
 		break;
+	case IT8772E_DEVID:
+		sio_data->type = it8772;
+		break;
 	case IT8782F_DEVID:
 		sio_data->type = it8782;
 		break;
@@ -1840,7 +1854,8 @@ static int __init it87_find(unsigned short *address,
 
 		reg = superio_inb(IT87_SIO_GPIO3_REG);
 		if (sio_data->type = it8721 || sio_data->type = it8728 ||
-		    sio_data->type = it8771 || sio_data->type = it8782) {
+		    sio_data->type = it8771 || sio_data->type = it8772 ||
+		    sio_data->type = it8782) {
 			/*
 			 * IT8721F/IT8758E, and IT8782F don't have VID pins
 			 * at all, not sure about the IT8728F and compatibles.
@@ -1898,7 +1913,8 @@ static int __init it87_find(unsigned short *address,
 			sio_data->internal |= (1 << 0);
 		if ((reg & (1 << 1)) || sio_data->type = it8721 ||
 		    sio_data->type = it8728 ||
-		    sio_data->type = it8771)
+		    sio_data->type = it8771 ||
+		    sio_data->type = it8772)
 			sio_data->internal |= (1 << 1);
 
 		/*
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
