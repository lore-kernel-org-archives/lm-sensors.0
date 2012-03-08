From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 08 Mar 2012 04:25:39 +0000
Subject: [lm-sensors] [PATCH] hwmon: (it87) Add support for IT8781F, IT8782F, IT8783E/F
Message-Id: <1331180739-19470-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Assume all three are compatible and have the same functionality.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
This patch depends on the other pending changes for the it87 driver in my
hwmon-next tree.

 Documentation/hwmon/it87 |   24 +++++++----
 drivers/hwmon/it87.c     |   93 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 100 insertions(+), 17 deletions(-)

diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87
index 23b7def..b0c1dcd 100644
--- a/Documentation/hwmon/it87
+++ b/Documentation/hwmon/it87
@@ -30,6 +30,10 @@ Supported chips:
     Prefix: 'it8728'
     Addresses scanned: from Super I/O config space (8 I/O ports)
     Datasheet: Not publicly available
+  * IT8781F/IT8782F/IT8783E/F
+    Prefix: 'it8783'
+    Addresses scanned: from Super I/O config space (8 I/O ports)
+    Datasheet: Not publicly available
   * SiS950   [clone of IT8705F]
     Prefix: 'it87'
     Addresses scanned: from Super I/O config space (8 I/O ports)
@@ -75,7 +79,8 @@ Description
 -----------
 
 This driver implements support for the IT8705F, IT8712F, IT8716F,
-IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E and SiS950 chips.
+IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E, IT8781F, IT8782F,
+IT8783E/F, and SiS950 chips.
 
 These chips are 'Super I/O chips', supporting floppy disks, infrared ports,
 joysticks and other miscellaneous stuff. For hardware monitoring, they
@@ -99,11 +104,11 @@ The IT8716F, IT8718F, IT8720F, IT8721F/IT8758E and later IT8712F revisions
 have support for 2 additional fans. The additional fans are supported by the
 driver.
 
-The IT8716F, IT8718F, IT8720F and IT8721F/IT8758E, and late IT8712F and
-IT8705F also have optional 16-bit tachometer counters for fans 1 to 3. This
-is better (no more fan clock divider mess) but not compatible with the older
-chips and revisions. The 16-bit tachometer mode is enabled by the driver when
-one of the above chips is detected.
+The IT8716F, IT8718F, IT8720F and IT8721F/IT8758E, IT8781F, IT8782F, IT8783E/F,
+and late IT8712F and IT8705F also have optional 16-bit tachometer counters for
+fans 1 to 3. This is better (no more fan clock divider mess) but not compatible
+with the older chips and revisions. The 16-bit tachometer mode is enabled by the
+driver when one of the above chips is detected.
 
 The IT8726F is just bit enhanced IT8716F with additional hardware
 for AMD power sequencing. Therefore the chip will appear as IT8716F
@@ -131,9 +136,10 @@ inputs can measure voltages between 0 and 4.08 volts, with a resolution of
 0.016 volt (except IT8721F/IT8758E and IT8728F: 0.012 volt.) The battery
 voltage in8 does not have limit registers.
 
-On the IT8721F/IT8758E, some voltage inputs are internal and scaled inside
-the chip (in7, in8 and optionally in3). The driver handles this transparently
-so user-space doesn't have to care.
+On the IT8721F/IT8758E/IT8781F/IT8782F/IT8783E/F, some voltage inputs are
+internal and scaled inside the chip (in7 (optional for IT8781/2/3), in8 and
+optionally in3). The driver handles this transparently so user-space doesn't
+have to care.
 
 The VID lines (IT8712F/IT8716F/IT8718F/IT8720F) encode the core voltage value:
 the voltage level your processor should work with. This is hardcoded by
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 0b204e4..afaf19b 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -19,6 +19,9 @@
  *            IT8726F  Super I/O chip w/LPC interface
  *            IT8728F  Super I/O chip w/LPC interface
  *            IT8758E  Super I/O chip w/LPC interface
+ *            IT8781F  Super I/O chip w/LPC interface
+ *            IT8782F  Super I/O chip w/LPC interface
+ *            IT8783E/F Super I/O chip w/LPC interface
  *            Sis950   A clone of the IT8705F
  *
  *  Copyright (C) 2001 Chris Gauthron
@@ -59,7 +62,7 @@
 
 #define DRVNAME "it87"
 
-enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728 };
+enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it8783 };
 
 static unsigned short force_id;
 module_param(force_id, ushort, 0);
@@ -137,13 +140,19 @@ static inline void superio_exit(void)
 #define IT8721F_DEVID 0x8721
 #define IT8726F_DEVID 0x8726
 #define IT8728F_DEVID 0x8728
+#define IT8781F_DEVID 0x8781
+#define IT8782F_DEVID 0x8782
+#define IT8783E_DEVID 0x8783
 #define IT87_ACT_REG  0x30
 #define IT87_BASE_REG 0x60
 
 /* Logical device 7 registers (IT8712F and later) */
+#define IT87_SIO_GPIO1_REG	0x25
 #define IT87_SIO_GPIO3_REG	0x27
 #define IT87_SIO_GPIO5_REG	0x29
+#define IT87_SIO_PINX1_REG	0x2a	/* Pin selection */
 #define IT87_SIO_PINX2_REG	0x2c	/* Pin selection */
+#define IT87_SIO_SPI_REG	0xef	/* SPI function pin select */
 #define IT87_SIO_VID_REG	0xfc	/* VID value */
 #define IT87_SIO_BEEP_PIN_REG	0xf6	/* Beep pin mapping */
 
@@ -313,8 +322,12 @@ static u8 in_to_reg(const struct it87_data *data, int nr, long val)
 			lsb = 24;
 		else
 			lsb = 12;
-	} else
-		lsb = 16;
+	} else {
+		if (data->in_scaled & (1 << nr))
+			lsb = 32;
+		else
+			lsb = 16;
+	}
 
 	val = DIV_ROUND_CLOSEST(val, lsb);
 	return SENSORS_LIMIT(val, 0, 255);
@@ -327,8 +340,12 @@ static int in_from_reg(const struct it87_data *data, int nr, int val)
 			return val * 24;
 		else
 			return val * 12;
-	} else
-		return val * 16;
+	} else {
+		if (data->in_scaled & (1 << nr))
+			return val * 32;
+		else
+			return val * 16;
+	}
 }
 
 static inline u8 FAN_TO_REG(long rpm, int div)
@@ -407,7 +424,8 @@ static inline int has_16bit_fans(const struct it87_data *data)
 	    || data->type = it8718
 	    || data->type = it8720
 	    || data->type = it8721
-	    || data->type = it8728;
+	    || data->type = it8728
+	    || data->type = it8783;
 }
 
 static inline int has_old_autopwm(const struct it87_data *data)
@@ -1651,6 +1669,11 @@ static int __init it87_find(unsigned short *address,
 	case IT8728F_DEVID:
 		sio_data->type = it8728;
 		break;
+	case IT8781F_DEVID:
+	case IT8782F_DEVID:
+	case IT8783E_DEVID:
+		sio_data->type = it8783;
+		break;
 	case 0xffff:	/* No device at all */
 		goto exit;
 	default:
@@ -1686,6 +1709,54 @@ static int __init it87_find(unsigned short *address,
 		/* The IT8705F has a different LD number for GPIO */
 		superio_select(5);
 		sio_data->beep_pin = superio_inb(IT87_SIO_BEEP_PIN_REG) & 0x3f;
+	} else if (sio_data->type = it8783) {
+		int reg25, reg27, reg2A, reg2C, regEF;
+
+		sio_data->skip_vid = 1;	/* No VID */
+
+		superio_select(GPIO);
+
+		reg25 = superio_inb(IT87_SIO_GPIO1_REG);
+		reg27 = superio_inb(IT87_SIO_GPIO3_REG);
+		reg2A = superio_inb(IT87_SIO_PINX1_REG);
+		reg2C = superio_inb(IT87_SIO_PINX2_REG);
+		regEF = superio_inb(IT87_SIO_SPI_REG);
+
+		/* Check if fan3 is there or not */
+		if ((reg27 & (1 << 0)) || !(reg2C & (1 << 2)))
+			sio_data->skip_fan |= (1 << 2);
+		if ((reg25 & (1 << 4))
+		    || (!(reg2A & (1 << 1)) && (regEF & (1 << 0))))
+			sio_data->skip_pwm |= (1 << 2);
+
+		/* Check if fan2 is there or not */
+		if (reg27 & (1 << 7))
+			sio_data->skip_fan |= (1 << 1);
+		if (reg27 & (1 << 3))
+			sio_data->skip_pwm |= (1 << 1);
+
+		/* VIN5 */
+		if ((reg27 & (1 << 0)) || (reg2C & (1 << 2)))
+			; /* No VIN5 */
+
+		/* VIN6 */
+		if ((reg27 & (1 << 1)) || (reg2C & (1 << 2)))
+			; /* No VIN6 */
+
+		/*
+		 * VIN7
+		 * Does not depend on bit 2 of Reg2C, contrary to datasheet.
+		 */
+		if (reg27 & (1 << 2))
+			; /* No VIN7 */
+
+		if (reg2C & (1 << 0))
+			sio_data->internal |= (1 << 0);
+		if (reg2C & (1 << 1))
+			sio_data->internal |= (1 << 1);
+
+		sio_data->beep_pin = superio_inb(IT87_SIO_BEEP_PIN_REG) & 0x3f;
+
 	} else {
 		int reg;
 
@@ -1823,6 +1894,7 @@ static int __devinit it87_probe(struct platform_device *pdev)
 		"it8720",
 		"it8721",
 		"it8728",
+		"it8783",
 	};
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
@@ -1867,6 +1939,11 @@ static int __devinit it87_probe(struct platform_device *pdev)
 			data->in_scaled |= (1 << 7);	/* in7 is VSB */
 		if (sio_data->internal & (1 << 2))
 			data->in_scaled |= (1 << 8);	/* in8 is Vbat */
+	} else if (sio_data->type = it8783) {
+		if (sio_data->internal & (1 << 0))
+			data->in_scaled |= (1 << 3);	/* in3 is VCC5V */
+		if (sio_data->internal & (1 << 1))
+			data->in_scaled |= (1 << 7);	/* in7 is VCCH5V */
 	}
 
 	/* Initialize the IT87 chip */
@@ -2143,8 +2220,8 @@ static void __devinit it87_init_device(struct platform_device *pdev)
 			it87_write_value(data, IT87_REG_FAN_16BIT,
 					 tmp | 0x07);
 		}
-		/* IT8705F only supports three fans. */
-		if (data->type != it87) {
+		/* IT8705F and IT8783E/F only support three fans. */
+		if (data->type != it87 && data->type != it8783) {
 			if (tmp & (1 << 4))
 				data->has_fan |= (1 << 3); /* fan4 enabled */
 			if (tmp & (1 << 5))
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
