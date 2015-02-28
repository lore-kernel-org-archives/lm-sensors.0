From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 28 Feb 2015 15:52:24 +0000
Subject: [lm-sensors] [RFC PATCH] hwmon: (it87) Add support for IT8620E
Message-Id: <1425138744-30206-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

IT8620E is widely reported to be compatible to IT7828F.
Add generic support for it.

Note that IT8620E is reported to support up to 5 pwm controls.
This functionality is not currently supported.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Do we know enough about the chip to add support for it ?
Should we assume that it is closer to IT8603E/IT8623E ?

 Documentation/hwmon/it87 | 17 ++++++++++++-----
 drivers/hwmon/Kconfig    |  2 +-
 drivers/hwmon/it87.c     | 19 ++++++++++++++++---
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87
index 19fbe77..34d654e 100644
--- a/Documentation/hwmon/it87
+++ b/Documentation/hwmon/it87
@@ -6,6 +6,10 @@ Supported chips:
     Prefix: 'it8603'
     Addresses scanned: from Super I/O config space (8 I/O ports)
     Datasheet: Not publicly available
+  * IT8620E
+    Prefix: 'it8620'
+    Addresses scanned: from Super I/O config space (8 I/O ports)
+    Datasheet: Not publicly available
   * IT8705F
     Prefix: 'it87'
     Addresses scanned: from Super I/O config space (8 I/O ports)
@@ -102,9 +106,9 @@ motherboard models.
 Description
 -----------
 
-This driver implements support for the IT8603E, IT8623E, IT8705F, IT8712F,
-IT8716F, IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E, IT8771E,
-IT8772E, IT8781F, IT8782F, IT8783E/F, IT8786E, and SiS950 chips.
+This driver implements support for the IT8603E, IT8620E, IT8623E, IT8705F,
+IT8712F, IT8716F, IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E,
+IT8771E, IT8772E, IT8781F, IT8782F, IT8783E/F, IT8786E, and SiS950 chips.
 
 These chips are 'Super I/O chips', supporting floppy disks, infrared ports,
 joysticks and other miscellaneous stuff. For hardware monitoring, they
@@ -142,8 +146,11 @@ The IT8728F, IT8771E, and IT8772E are considered compatible with the IT8721F,
 until a datasheet becomes available (hopefully.)
 
 The IT8603E/IT8623E is a custom design, hardware monitoring part is similar to
-IT8728F. It only supports 16-bit fan mode, the full speed mode of the
-fan is not supported (value 0 of pwmX_enable).
+IT8728F. It only supports three fans, 16-bit fan mode, and the full speed mode
+of the fan is not supported (value 0 of pwmX_enable).
+
+The IT8620E is another custom design, hardware monitoring part is similar to
+IT8728F. It only supports 16-bit fan mode.
 
 Temperatures are measured in degrees Celsius. An alarm is triggered once
 when the Overtemperature Shutdown limit is crossed.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 018f574..a17c98c 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -600,7 +600,7 @@ config SENSORS_IT87
 	  If you say yes here you get support for ITE IT8705F, IT8712F,
 	  IT8716F, IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E,
 	  IT8771E, IT8772E, IT8781F, IT8782F, IT8783E/F, IT8786E,
-	  and IT8603E sensor chips, and the SiS950 clone.
+	  IT8603E, IT8620E, and IT8623E sensor chips, and the SiS950 clone.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called it87.
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index ab12dc2..ab9a8be 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -11,6 +11,7 @@
  *  similar parts.  The other devices are supported by different drivers.
  *
  *  Supports: IT8603E  Super I/O chip w/LPC interface
+ *            IT8620E  Super I/O chip w/LPC interface
  *            IT8623E  Super I/O chip w/LPC interface
  *            IT8705F  Super I/O chip w/LPC interface
  *            IT8712F  Super I/O chip w/LPC interface
@@ -68,7 +69,7 @@
 #define DRVNAME "it87"
 
 enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it8771,
-	     it8772, it8781, it8782, it8783, it8786, it8603 };
+	     it8772, it8781, it8782, it8783, it8786, it8603, it8620 };
 
 static unsigned short force_id;
 module_param(force_id, ushort, 0);
@@ -153,6 +154,7 @@ static inline void superio_exit(void)
 #define IT8783E_DEVID 0x8783
 #define IT8786E_DEVID 0x8786
 #define IT8603E_DEVID 0x8603
+#define IT8620E_DEVID 0x8620
 #define IT8623E_DEVID 0x8623
 #define IT87_ACT_REG  0x30
 #define IT87_BASE_REG 0x60
@@ -349,6 +351,12 @@ static const struct it87_devices it87_devices[] = {
 		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI,
 		.peci_mask = 0x07,
 	},
+	[it8620] = {
+		.name = "it8620",
+		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
+		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI | FEAT_FIVE_FANS,
+		.peci_mask = 0x07,
+	},
 };
 
 #define has_16bit_fans(data)	((data)->features & FEAT_16BIT_FANS)
@@ -1804,6 +1812,9 @@ static int __init it87_find(unsigned short *address,
 	case IT8623E_DEVID:
 		sio_data->type = it8603;
 		break;
+	case IT8620E_DEVID:
+		sio_data->type = it8620;
+		break;
 	case 0xffff:	/* No device at all */
 		goto exit;
 	default:
@@ -1827,7 +1838,8 @@ static int __init it87_find(unsigned short *address,
 	sio_data->revision = superio_inb(DEVREV) & 0x0f;
 	pr_info("Found IT%04x%c chip at 0x%x, revision %d\n", chip_type,
 		chip_type = 0x8771 || chip_type = 0x8772 ||
-		chip_type = 0x8786 || chip_type = 0x8603 ? 'E' : 'F',
+		chip_type = 0x8786 || chip_type = 0x8603 ||
+		chip_type = 0x8620 ? 'E' : 'F',
 		*address, sio_data->revision);
 
 	/* in8 (Vbat) is always internal */
@@ -1993,7 +2005,8 @@ static int __init it87_find(unsigned short *address,
 		}
 		if (reg & (1 << 0))
 			sio_data->internal |= (1 << 0);
-		if ((reg & (1 << 1)) || sio_data->type = it8721 ||
+		if ((reg & (1 << 1)) ||
+		    sio_data->type = it8620 || sio_data->type = it8721 ||
 		    sio_data->type = it8728 || sio_data->type = it8771 ||
 		    sio_data->type = it8772 || sio_data->type = it8786)
 			sio_data->internal |= (1 << 1);
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
