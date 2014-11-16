From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 16 Nov 2014 18:15:13 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (nct6775) Add support for NCT6792D
Message-Id: <1416161714-23796-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1372180172-3159-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1372180172-3159-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

NCT6792D is similar to NCT6791D. Only beep control and temperature
monitoring registers are different.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c | 47 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 504cbdd..ffe7427 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -38,6 +38,7 @@
  * nct6776f     9      5       3       6+3    0xc330 0xc1    0x5ca3
  * nct6779d    15      5       5       2+6    0xc560 0xc1    0x5ca3
  * nct6791d    15      6       6       2+6    0xc800 0xc1    0x5ca3
+ * nct6792d    15      6       6       2+6    0xc911 0xc1    0x5ca3
  *
  * #temp lists the number of monitored temperature sources (first value) plus
  * the number of directly connectable temperature sensors (second value).
@@ -61,7 +62,7 @@
 
 #define USE_ALTERNATE
 
-enum kinds { nct6106, nct6775, nct6776, nct6779, nct6791 };
+enum kinds { nct6106, nct6775, nct6776, nct6779, nct6791, nct6792 };
 
 /* used to set data->name = nct6775_device_names[data->sio_kind] */
 static const char * const nct6775_device_names[] = {
@@ -70,6 +71,7 @@ static const char * const nct6775_device_names[] = {
 	"nct6776",
 	"nct6779",
 	"nct6791",
+	"nct6792",
 };
 
 static unsigned short force_id;
@@ -100,6 +102,7 @@ MODULE_PARM_DESC(fan_debounce, "Enable debouncing for fan RPM signal");
 #define SIO_NCT6776_ID		0xc330
 #define SIO_NCT6779_ID		0xc560
 #define SIO_NCT6791_ID		0xc800
+#define SIO_NCT6792_ID		0xc910
 #define SIO_ID_MASK		0xFFF0
 
 enum pwm_enable { off, manual, thermal_cruise, speed_cruise, sf3, sf4 };
@@ -529,6 +532,12 @@ static const s8 NCT6791_ALARM_BITS[] = {
 	4, 5, 13, -1, -1, -1,		/* temp1..temp6 */
 	12, 9 };			/* intrusion0, intrusion1 */
 
+/* NCT6792 specific data */
+
+static const u16 NCT6792_REG_TEMP_MON[] = {
+	0x73, 0x75, 0x77, 0x79, 0x7b, 0x7d };
+static const u16 NCT6792_REG_BEEP[NUM_REG_BEEP] = {
+	0xb2, 0xb3, 0xb4, 0xb5, 0xbf };
 
 /* NCT6102D/NCT6106D specific data */
 
@@ -1043,13 +1052,14 @@ static bool is_word_sized(struct nct6775_data *data, u16 reg)
 		  reg = 0x73 || reg = 0x75 || reg = 0x77;
 	case nct6779:
 	case nct6791:
+	case nct6792:
 		return reg = 0x150 || reg = 0x153 || reg = 0x155 ||
 		  ((reg & 0xfff0) = 0x4b0 && (reg & 0x000f) < 0x0b) ||
 		  reg = 0x402 ||
 		  reg = 0x63a || reg = 0x63c || reg = 0x63e ||
 		  reg = 0x640 || reg = 0x642 ||
 		  reg = 0x73 || reg = 0x75 || reg = 0x77 || reg = 0x79 ||
-		  reg = 0x7b;
+		  reg = 0x7b || reg = 0x7d;
 	}
 	return false;
 }
@@ -1391,6 +1401,7 @@ static void nct6775_update_pwm_limits(struct device *dev)
 		case nct6106:
 		case nct6779:
 		case nct6791:
+		case nct6792:
 			reg = nct6775_read_value(data,
 					data->REG_CRITICAL_PWM_ENABLE[i]);
 			if (reg & data->CRITICAL_PWM_ENABLE_MASK)
@@ -2790,6 +2801,7 @@ store_auto_pwm(struct device *dev, struct device_attribute *attr,
 		case nct6106:
 		case nct6779:
 		case nct6791:
+		case nct6792:
 			nct6775_write_value(data, data->REG_CRITICAL_PWM[nr],
 					    val);
 			reg = nct6775_read_value(data,
@@ -3202,7 +3214,7 @@ nct6775_check_fan_inputs(struct nct6775_data *data)
 		pwm4pin = false;
 		pwm5pin = false;
 		pwm6pin = false;
-	} else {	/* NCT6779D or NCT6791D */
+	} else {	/* NCT6779D, NCT6791D, or NCT6792D */
 		regval = superio_inb(sioreg, 0x1c);
 
 		fan3pin = !(regval & (1 << 5));
@@ -3215,7 +3227,7 @@ nct6775_check_fan_inputs(struct nct6775_data *data)
 
 		fan4min = fan4pin;
 
-		if (data->kind = nct6791) {
+		if (data->kind = nct6791 || data->kind = nct6792) {
 			regval = superio_inb(sioreg, 0x2d);
 			fan6pin = (regval & (1 << 1));
 			pwm6pin = (regval & (1 << 0));
@@ -3588,6 +3600,7 @@ static int nct6775_probe(struct platform_device *pdev)
 
 		break;
 	case nct6791:
+	case nct6792:
 		data->in_num = 15;
 		data->pwm_num = 6;
 		data->auto_pwm_num = 4;
@@ -3650,12 +3663,20 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->REG_WEIGHT_TEMP[1] = NCT6791_REG_WEIGHT_TEMP_STEP_TOL;
 		data->REG_WEIGHT_TEMP[2] = NCT6791_REG_WEIGHT_TEMP_BASE;
 		data->REG_ALARM = NCT6791_REG_ALARM;
-		data->REG_BEEP = NCT6776_REG_BEEP;
+		if (data->kind = nct6791)
+			data->REG_BEEP = NCT6776_REG_BEEP;
+		else
+			data->REG_BEEP = NCT6792_REG_BEEP;
 
 		reg_temp = NCT6779_REG_TEMP;
-		reg_temp_mon = NCT6779_REG_TEMP_MON;
 		num_reg_temp = ARRAY_SIZE(NCT6779_REG_TEMP);
-		num_reg_temp_mon = ARRAY_SIZE(NCT6779_REG_TEMP_MON);
+		if (data->kind = nct6791) {
+			reg_temp_mon = NCT6779_REG_TEMP_MON;
+			num_reg_temp_mon = ARRAY_SIZE(NCT6779_REG_TEMP_MON);
+		} else {
+			reg_temp_mon = NCT6792_REG_TEMP_MON;
+			num_reg_temp_mon = ARRAY_SIZE(NCT6792_REG_TEMP_MON);
+		}
 		reg_temp_over = NCT6779_REG_TEMP_OVER;
 		reg_temp_hyst = NCT6779_REG_TEMP_HYST;
 		reg_temp_config = NCT6779_REG_TEMP_CONFIG;
@@ -3854,6 +3875,7 @@ static int nct6775_probe(struct platform_device *pdev)
 	case nct6106:
 	case nct6779:
 	case nct6791:
+	case nct6792:
 		break;
 	}
 
@@ -3885,6 +3907,7 @@ static int nct6775_probe(struct platform_device *pdev)
 			tmp |= 0x3e;
 			break;
 		case nct6791:
+		case nct6792:
 			tmp |= 0x7e;
 			break;
 		}
@@ -3972,7 +3995,7 @@ static int nct6775_resume(struct device *dev)
 	mutex_lock(&data->update_lock);
 	data->bank = 0xff;		/* Force initial bank selection */
 
-	if (data->kind = nct6791) {
+	if (data->kind = nct6791 || data->kind = nct6792) {
 		err = superio_enter(data->sioreg);
 		if (err)
 			goto abort;
@@ -4052,6 +4075,7 @@ static const char * const nct6775_sio_names[] __initconst = {
 	"NCT6776D/F",
 	"NCT6779D",
 	"NCT6791D",
+	"NCT6792D",
 };
 
 /* nct6775_find() looks for a '627 in the Super-I/O config space */
@@ -4086,6 +4110,9 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 	case SIO_NCT6791_ID:
 		sio_data->kind = nct6791;
 		break;
+	case SIO_NCT6792_ID:
+		sio_data->kind = nct6792;
+		break;
 	default:
 		if (val != 0xffff)
 			pr_debug("unsupported chip ID: 0x%04x\n", val);
@@ -4111,7 +4138,7 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 		superio_outb(sioaddr, SIO_REG_ENABLE, val | 0x01);
 	}
 
-	if (sio_data->kind = nct6791)
+	if (sio_data->kind = nct6791 || sio_data->kind = nct6792)
 		nct6791_enable_io_mapping(sioaddr);
 
 	superio_exit(sioaddr);
@@ -4221,7 +4248,7 @@ static void __exit sensors_nct6775_exit(void)
 }
 
 MODULE_AUTHOR("Guenter Roeck <linux@roeck-us.net>");
-MODULE_DESCRIPTION("NCT6106D/NCT6775F/NCT6776F/NCT6779D/NCT6791D driver");
+MODULE_DESCRIPTION("NCT6106D/NCT6775F/NCT6776F/NCT6779D/NCT6791D/NCT6792D driver");
 MODULE_LICENSE("GPL");
 
 module_init(sensors_nct6775_init);
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
