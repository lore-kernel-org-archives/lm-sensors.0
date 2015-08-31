From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 31 Aug 2015 23:57:33 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (nct6775) Add support for NCT6793D
Message-Id: <1441065453-23896-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1372180269-3213-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1372180269-3213-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

NCT6793D is register compatible with NCT6792D.

Tested-by: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/nct6775 |  4 ++++
 drivers/hwmon/Kconfig       |  4 ++--
 drivers/hwmon/nct6775.c     | 29 ++++++++++++++++++++++-------
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/Documentation/hwmon/nct6775 b/Documentation/hwmon/nct6775
index f0dd3d2fec96..76add4c9cd68 100644
--- a/Documentation/hwmon/nct6775
+++ b/Documentation/hwmon/nct6775
@@ -32,6 +32,10 @@ Supported chips:
     Prefix: 'nct6792'
     Addresses scanned: ISA address retrieved from Super I/O registers
     Datasheet: Available from Nuvoton upon request
+  * Nuvoton NCT6793D
+    Prefix: 'nct6793'
+    Addresses scanned: ISA address retrieved from Super I/O registers
+    Datasheet: Available from Nuvoton upon request
 
 Authors:
         Guenter Roeck <linux@roeck-us.net>
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 500b262b89bb..778ed4803494 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1140,8 +1140,8 @@ config SENSORS_NCT6775
 	help
 	  If you say yes here you get support for the hardware monitoring
 	  functionality of the Nuvoton NCT6106D, NCT6775F, NCT6776F, NCT6779D,
-	  NCT6791D, NCT6792D and compatible Super-I/O chips. This driver
-	  replaces the w83627ehf driver for NCT6775F and NCT6776F.
+	  NCT6791D, NCT6792D, NCT6793, and compatible Super-I/O chips. This
+	  driver replaces the w83627ehf driver for NCT6775F and NCT6776F.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called nct6775.
diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index b487a55d02c0..0e2f11daecde 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -39,6 +39,7 @@
  * nct6779d    15      5       5       2+6    0xc560 0xc1    0x5ca3
  * nct6791d    15      6       6       2+6    0xc800 0xc1    0x5ca3
  * nct6792d    15      6       6       2+6    0xc910 0xc1    0x5ca3
+ * nct6793d    15      6       6       2+6    0xd120 0xc1    0x5ca3
  *
  * #temp lists the number of monitored temperature sources (first value) plus
  * the number of directly connectable temperature sensors (second value).
@@ -63,7 +64,7 @@
 
 #define USE_ALTERNATE
 
-enum kinds { nct6106, nct6775, nct6776, nct6779, nct6791, nct6792 };
+enum kinds { nct6106, nct6775, nct6776, nct6779, nct6791, nct6792, nct6793 };
 
 /* used to set data->name = nct6775_device_names[data->sio_kind] */
 static const char * const nct6775_device_names[] = {
@@ -73,6 +74,7 @@ static const char * const nct6775_device_names[] = {
 	"nct6779",
 	"nct6791",
 	"nct6792",
+	"nct6793",
 };
 
 static unsigned short force_id;
@@ -104,6 +106,7 @@ MODULE_PARM_DESC(fan_debounce, "Enable debouncing for fan RPM signal");
 #define SIO_NCT6779_ID		0xc560
 #define SIO_NCT6791_ID		0xc800
 #define SIO_NCT6792_ID		0xc910
+#define SIO_NCT6793_ID		0xd120
 #define SIO_ID_MASK		0xFFF0
 
 enum pwm_enable { off, manual, thermal_cruise, speed_cruise, sf3, sf4 };
@@ -542,7 +545,7 @@ static const s8 NCT6791_ALARM_BITS[] = {
 	4, 5, 13, -1, -1, -1,		/* temp1..temp6 */
 	12, 9 };			/* intrusion0, intrusion1 */
 
-/* NCT6792 specific data */
+/* NCT6792/NCT6793 specific data */
 
 static const u16 NCT6792_REG_TEMP_MON[] = {
 	0x73, 0x75, 0x77, 0x79, 0x7b, 0x7d };
@@ -1065,6 +1068,7 @@ static bool is_word_sized(struct nct6775_data *data, u16 reg)
 	case nct6779:
 	case nct6791:
 	case nct6792:
+	case nct6793:
 		return reg = 0x150 || reg = 0x153 || reg = 0x155 ||
 		  ((reg & 0xfff0) = 0x4b0 && (reg & 0x000f) < 0x0b) ||
 		  reg = 0x402 ||
@@ -1416,6 +1420,7 @@ static void nct6775_update_pwm_limits(struct device *dev)
 		case nct6779:
 		case nct6791:
 		case nct6792:
+		case nct6793:
 			reg = nct6775_read_value(data,
 					data->REG_CRITICAL_PWM_ENABLE[i]);
 			if (reg & data->CRITICAL_PWM_ENABLE_MASK)
@@ -2831,6 +2836,7 @@ store_auto_pwm(struct device *dev, struct device_attribute *attr,
 		case nct6779:
 		case nct6791:
 		case nct6792:
+		case nct6793:
 			nct6775_write_value(data, data->REG_CRITICAL_PWM[nr],
 					    val);
 			reg = nct6775_read_value(data,
@@ -3265,7 +3271,7 @@ nct6775_check_fan_inputs(struct nct6775_data *data)
 		pwm4pin = false;
 		pwm5pin = false;
 		pwm6pin = false;
-	} else {	/* NCT6779D, NCT6791D, or NCT6792D */
+	} else {	/* NCT6779D, NCT6791D, NCT6792D, or NCT6793D */
 		regval = superio_inb(sioreg, 0x1c);
 
 		fan3pin = !(regval & (1 << 5));
@@ -3278,7 +3284,8 @@ nct6775_check_fan_inputs(struct nct6775_data *data)
 
 		fan4min = fan4pin;
 
-		if (data->kind = nct6791 || data->kind = nct6792) {
+		if (data->kind = nct6791 || data->kind = nct6792 ||
+		    data->kind = nct6793) {
 			regval = superio_inb(sioreg, 0x2d);
 			fan6pin = (regval & (1 << 1));
 			pwm6pin = (regval & (1 << 0));
@@ -3652,6 +3659,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		break;
 	case nct6791:
 	case nct6792:
+	case nct6793:
 		data->in_num = 15;
 		data->pwm_num = 6;
 		data->auto_pwm_num = 4;
@@ -3927,6 +3935,7 @@ static int nct6775_probe(struct platform_device *pdev)
 	case nct6779:
 	case nct6791:
 	case nct6792:
+	case nct6793:
 		break;
 	}
 
@@ -3959,6 +3968,7 @@ static int nct6775_probe(struct platform_device *pdev)
 			break;
 		case nct6791:
 		case nct6792:
+		case nct6793:
 			tmp |= 0x7e;
 			break;
 		}
@@ -4056,7 +4066,8 @@ static int __maybe_unused nct6775_resume(struct device *dev)
 	if (reg != data->sio_reg_enable)
 		superio_outb(sioreg, SIO_REG_ENABLE, data->sio_reg_enable);
 
-	if (data->kind = nct6791 || data->kind = nct6792)
+	if (data->kind = nct6791 || data->kind = nct6792 ||
+	    data->kind = nct6793)
 		nct6791_enable_io_mapping(sioreg);
 
 	superio_exit(sioreg);
@@ -4159,6 +4170,9 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 	case SIO_NCT6792_ID:
 		sio_data->kind = nct6792;
 		break;
+	case SIO_NCT6793_ID:
+		sio_data->kind = nct6793;
+		break;
 	default:
 		if (val != 0xffff)
 			pr_debug("unsupported chip ID: 0x%04x\n", val);
@@ -4184,7 +4198,8 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 		superio_outb(sioaddr, SIO_REG_ENABLE, val | 0x01);
 	}
 
-	if (sio_data->kind = nct6791 || sio_data->kind = nct6792)
+	if (sio_data->kind = nct6791 || sio_data->kind = nct6792 ||
+	    sio_data->kind = nct6793)
 		nct6791_enable_io_mapping(sioaddr);
 
 	superio_exit(sioaddr);
@@ -4294,7 +4309,7 @@ static void __exit sensors_nct6775_exit(void)
 }
 
 MODULE_AUTHOR("Guenter Roeck <linux@roeck-us.net>");
-MODULE_DESCRIPTION("NCT6106D/NCT6775F/NCT6776F/NCT6779D/NCT6791D/NCT6792D driver");
+MODULE_DESCRIPTION("Driver for NCT6775F and compatible chips");
 MODULE_LICENSE("GPL");
 
 module_init(sensors_nct6775_init);
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
