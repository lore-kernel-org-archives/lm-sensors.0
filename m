From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 13 Feb 2015 20:13:50 +0000
Subject: [lm-sensors] [PATCH 1/4] hwmon: (it87) Add support for IT8781F
Message-Id: <1423858433-1416-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

IT8781F is mostly compatible to IT8782F. Major difference is that it only
supports four instead of six UART channels, and therefore does not share
the uart6 pins.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/it87 | 22 +++++++++++++---------
 drivers/hwmon/Kconfig    |  4 ++--
 drivers/hwmon/it87.c     | 32 ++++++++++++++++++++++++--------
 3 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87
index fe80e9a..8e192ff 100644
--- a/Documentation/hwmon/it87
+++ b/Documentation/hwmon/it87
@@ -42,6 +42,10 @@ Supported chips:
     Prefix: 'it8772'
     Addresses scanned: from Super I/O config space (8 I/O ports)
     Datasheet: Not publicly available
+  * IT8781F
+    Prefix: 'it8781'
+    Addresses scanned: from Super I/O config space (8 I/O ports)
+    Datasheet: Not publicly available
   * IT8782F
     Prefix: 'it8782'
     Addresses scanned: from Super I/O config space (8 I/O ports)
@@ -96,7 +100,7 @@ Description
 
 This driver implements support for the IT8603E, IT8623E, IT8705F, IT8712F,
 IT8716F, IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E, IT8771E,
-IT8772E, IT8782F, IT8783E/F, and SiS950 chips.
+IT8772E, IT8781F, IT8782F, IT8783E/F, and SiS950 chips.
 
 These chips are 'Super I/O chips', supporting floppy disks, infrared ports,
 joysticks and other miscellaneous stuff. For hardware monitoring, they
@@ -120,11 +124,11 @@ The IT8716F, IT8718F, IT8720F, IT8721F/IT8758E and later IT8712F revisions
 have support for 2 additional fans. The additional fans are supported by the
 driver.
 
-The IT8716F, IT8718F, IT8720F, IT8721F/IT8758E, IT8782F, IT8783E/F, and late
-IT8712F and IT8705F also have optional 16-bit tachometer counters for fans 1 to
-3. This is better (no more fan clock divider mess) but not compatible with the
-older chips and revisions. The 16-bit tachometer mode is enabled by the driver
-when one of the above chips is detected.
+The IT8716F, IT8718F, IT8720F, IT8721F/IT8758E, IT8781F, IT8782F, IT8783E/F,
+and late IT8712F and IT8705F also have optional 16-bit tachometer counters
+for fans 1 to 3. This is better (no more fan clock divider mess) but not
+compatible with the older chips and revisions. The 16-bit tachometer mode
+is enabled by the driver when one of the above chips is detected.
 
 The IT8726F is just bit enhanced IT8716F with additional hardware
 for AMD power sequencing. Therefore the chip will appear as IT8716F
@@ -156,10 +160,10 @@ inputs can measure voltages between 0 and 4.08 volts, with a resolution of
 0.016 volt (except IT8603E, IT8721F/IT8758E and IT8728F: 0.012 volt.) The
 battery voltage in8 does not have limit registers.
 
-On the IT8603E, IT8721F/IT8758E, IT8782F, and IT8783E/F, some voltage inputs
-are internal and scaled inside the chip:
+On the IT8603E, IT8721F/IT8758E, IT8781F, IT8782F, and IT8783E/F, some
+voltage inputs are internal and scaled inside the chip:
 * in3 (optional)
-* in7 (optional for IT8782F and IT8783E/F)
+* in7 (optional for IT8781F, IT8782F, and IT8783E/F)
 * in8 (always)
 * in9 (relevant for IT8603E only)
 The driver handles this transparently so user-space doesn't have to care.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index c80c8a9..e5bad0a 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -599,8 +599,8 @@ config SENSORS_IT87
 	help
 	  If you say yes here you get support for ITE IT8705F, IT8712F,
 	  IT8716F, IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E,
-	  IT8771E, IT8772E, IT8782F, IT8783E/F and IT8603E sensor chips,
-	  and the SiS950 clone.
+	  IT8771E, IT8772E, IT8781F, IT8782F, IT8783E/F and IT8603E
+	  sensor chips, and the SiS950 clone.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called it87.
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 409116c..ed25e4b 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -23,6 +23,7 @@
  *            IT8758E  Super I/O chip w/LPC interface
  *            IT8771E  Super I/O chip w/LPC interface
  *            IT8772E  Super I/O chip w/LPC interface
+ *            IT8781F  Super I/O chip w/LPC interface
  *            IT8782F  Super I/O chip w/LPC interface
  *            IT8783E/F Super I/O chip w/LPC interface
  *            Sis950   A clone of the IT8705F
@@ -66,7 +67,7 @@
 #define DRVNAME "it87"
 
 enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it8771,
-	     it8772, it8782, it8783, it8603 };
+	     it8772, it8781, it8782, it8783, it8603 };
 
 static unsigned short force_id;
 module_param(force_id, ushort, 0);
@@ -146,6 +147,7 @@ static inline void superio_exit(void)
 #define IT8728F_DEVID 0x8728
 #define IT8771E_DEVID 0x8771
 #define IT8772E_DEVID 0x8772
+#define IT8781F_DEVID 0x8781
 #define IT8782F_DEVID 0x8782
 #define IT8783E_DEVID 0x8783
 #define IT8603E_DEVID 0x8603
@@ -307,6 +309,12 @@ static const struct it87_devices it87_devices[] = {
 					/* 16 bit fans (HWSensors4, OHM) */
 		.peci_mask = 0x07,
 	},
+	[it8781] = {
+		.name = "it8781",
+		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
+		  | FEAT_TEMP_OLD_PECI,
+		.old_peci_mask = 0x4,
+	},
 	[it8782] = {
 		.name = "it8782",
 		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
@@ -1761,6 +1769,9 @@ static int __init it87_find(unsigned short *address,
 	case IT8772E_DEVID:
 		sio_data->type = it8772;
 		break;
+	case IT8781F_DEVID:
+		sio_data->type = it8781;
+		break;
 	case IT8782F_DEVID:
 		sio_data->type = it8782;
 		break;
@@ -1919,10 +1930,11 @@ static int __init it87_find(unsigned short *address,
 		reg = superio_inb(IT87_SIO_GPIO3_REG);
 		if (sio_data->type = it8721 || sio_data->type = it8728 ||
 		    sio_data->type = it8771 || sio_data->type = it8772 ||
-		    sio_data->type = it8782) {
+		    sio_data->type = it8781 || sio_data->type = it8782) {
 			/*
-			 * IT8721F/IT8758E, and IT8782F don't have VID pins
-			 * at all, not sure about the IT8728F and compatibles.
+			 * IT8721F/IT8758E, IT8728F, IT8772F, IT8781F, and
+			 * IT8782F don't have VID pins at all, not sure about
+			 * the IT8771F.
 			 */
 			sio_data->skip_vid = 1;
 		} else {
@@ -2147,7 +2159,8 @@ static int it87_probe(struct platform_device *pdev)
 			data->in_scaled |= (1 << 8);	/* in8 is Vbat */
 		if (sio_data->internal & (1 << 3))
 			data->in_scaled |= (1 << 9);	/* in9 is AVCC */
-	} else if (sio_data->type = it8782 || sio_data->type = it8783) {
+	} else if (sio_data->type = it8781 || sio_data->type = it8782 ||
+		   sio_data->type = it8783) {
 		if (sio_data->internal & (1 << 0))
 			data->in_scaled |= (1 << 3);	/* in3 is VCC5V */
 		if (sio_data->internal & (1 << 1))
@@ -2460,9 +2473,12 @@ static void it87_init_device(struct platform_device *pdev)
 			it87_write_value(data, IT87_REG_FAN_16BIT,
 					 tmp | 0x07);
 		}
-		/* IT8705F, IT8782F, and IT8783E/F only support three fans. */
-		if (data->type != it87 && data->type != it8782 &&
-		    data->type != it8783) {
+		/*
+		 * IT8705F, IT8781F, IT8782F, and IT8783E/F only support
+		 * three fans.
+		 */
+		if (data->type != it87 && data->type != it8781 &&
+		    data->type != it8782 && data->type != it8783) {
 			if (tmp & (1 << 4))
 				data->has_fan |= (1 << 3); /* fan4 enabled */
 			if (tmp & (1 << 5))
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
