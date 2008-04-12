From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Apr 2008 17:55:52 +0000
Subject: [lm-sensors] [PATCH 03/10] hwmon: (lm85) Drop dead code
Message-Id: <20080412195552.421b4a28@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Drop a lot of useless register defines, conversion macros, data structure
members and update code. All these register values were read from the
device but nothing is done out of them, so this is all dead code in
practice.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/lm85 |   11 ++----
 drivers/hwmon/lm85.c     |   82 +---------------------------------------------
 2 files changed, 6 insertions(+), 87 deletions(-)

--- linux-2.6.25-rc8.orig/drivers/hwmon/lm85.c	2008-04-04 10:45:10.000000000 +0200
+++ linux-2.6.25-rc8/drivers/hwmon/lm85.c	2008-04-04 15:41:53.000000000 +0200
@@ -56,16 +56,9 @@ I2C_CLIENT_INSMOD_6(lm85b, lm85c, adm102
 
 #define	LM85_REG_PWM(nr)		(0x30 + (nr))
 
-#define	ADT7463_REG_OPPOINT(nr)		(0x33 + (nr))
-
-#define	ADT7463_REG_TMIN_CTL1		0x36
-#define	ADT7463_REG_TMIN_CTL2		0x37
-
-#define	LM85_REG_DEVICE			0x3d
 #define	LM85_REG_COMPANY		0x3e
 #define	LM85_REG_VERSTEP		0x3f
 /* These are the recognized values for the above regs */
-#define	LM85_DEVICE_ADX			0x27
 #define	LM85_COMPANY_NATIONAL		0x01
 #define	LM85_COMPANY_ANALOG_DEV		0x41
 #define	LM85_COMPANY_SMSC		0x5c
@@ -91,27 +84,14 @@ I2C_CLIENT_INSMOD_6(lm85b, lm85c, adm102
 #define	LM85_REG_AFAN_CONFIG(nr)	(0x5c + (nr))
 #define	LM85_REG_AFAN_RANGE(nr)		(0x5f + (nr))
 #define	LM85_REG_AFAN_SPIKE1		0x62
-#define	LM85_REG_AFAN_SPIKE2		0x63
 #define	LM85_REG_AFAN_MINPWM(nr)	(0x64 + (nr))
 #define	LM85_REG_AFAN_LIMIT(nr)		(0x67 + (nr))
 #define	LM85_REG_AFAN_CRITICAL(nr)	(0x6a + (nr))
 #define	LM85_REG_AFAN_HYST1		0x6d
 #define	LM85_REG_AFAN_HYST2		0x6e
 
-#define	LM85_REG_TACH_MODE		0x74
-#define	LM85_REG_SPINUP_CTL		0x75
-
-#define	ADM1027_REG_TEMP_OFFSET(nr)	(0x70 + (nr))
-#define	ADM1027_REG_CONFIG2		0x73
-#define	ADM1027_REG_INTMASK1		0x74
-#define	ADM1027_REG_INTMASK2		0x75
 #define	ADM1027_REG_EXTEND_ADC1		0x76
 #define	ADM1027_REG_EXTEND_ADC2		0x77
-#define	ADM1027_REG_CONFIG3		0x78
-#define	ADM1027_REG_FAN_PPR		0x7b
-
-#define	ADT7463_REG_THERM		0x79
-#define	ADT7463_REG_THERM_LIMIT		0x7A
 
 #define EMC6D100_REG_ALARM3             0x7d
 /* IN5, IN6 and IN7 */
@@ -264,13 +244,6 @@ static int ZONE_TO_REG(int zone)
 #define HYST_TO_REG(val)	SENSORS_LIMIT(((val) + 500) / 1000, 0, 15)
 #define HYST_FROM_REG(val)	((val) * 1000)
 
-#define OFFSET_TO_REG(val)	SENSORS_LIMIT((val) / 25, -127, 127)
-#define OFFSET_FROM_REG(val)	((val) * 25)
-
-#define PPR_MASK(fan)		(0x03 << ((fan) * 2))
-#define PPR_TO_REG(val, fan)	(SENSORS_LIMIT((val) - 1, 0, 3) << ((fan) * 2))
-#define PPR_FROM_REG(val, fan)	((((val) >> ((fan) * 2)) & 0x03) + 1)
-
 /* Chip sampling rates
  *
  * Some sensors are not updated more frequently than once per second
@@ -331,23 +304,15 @@ struct lm85_data {
 	s8 temp[3];		/* Register value */
 	s8 temp_min[3];		/* Register value */
 	s8 temp_max[3];		/* Register value */
-	s8 temp_offset[3];	/* Register value */
 	u16 fan[4];		/* Register value */
 	u16 fan_min[4];		/* Register value */
 	u8 pwm[3];		/* Register value */
-	u8 spinup_ctl;		/* Register encoding, combined */
-	u8 tach_mode;		/* Register encoding, combined */
 	u8 temp_ext[3];		/* Decoded values */
 	u8 in_ext[8];		/* Decoded values */
-	u8 fan_ppr;		/* Register value */
-	u8 smooth[3];		/* Register encoding */
+	u8 smooth[1];		/* Register encoding */
 	u8 vid;			/* Register value */
 	u8 vrm;			/* VRM version */
 	u8 syncpwm3;		/* Saved PWM3 for TACH 2,3,4 config */
-	u8 oppoint[3];		/* Register value */
-	u16 tmin_ctl;		/* Register value */
-	unsigned long therm_total; /* Cummulative therm count */
-	u8 therm_limit;		/* Register value */
 	u32 alarms;		/* Register encoding, combined */
 	struct lm85_autofan autofan[3];
 	struct lm85_zone zone[3];
@@ -1336,10 +1301,6 @@ static int lm85_read_value(struct i2c_cl
 		res = i2c_smbus_read_byte_data(client, reg) & 0xff;
 		res |= i2c_smbus_read_byte_data(client, reg + 1) << 8;
 		break;
-	case ADT7463_REG_TMIN_CTL1:  /* Read WORD MSB, LSB */
-		res = i2c_smbus_read_byte_data(client, reg) << 8;
-		res |= i2c_smbus_read_byte_data(client, reg + 1) & 0xff;
-		break;
 	default:	/* Read BYTE data */
 		res = i2c_smbus_read_byte_data(client, reg);
 		break;
@@ -1366,11 +1327,6 @@ static int lm85_write_value(struct i2c_c
 		res |= i2c_smbus_write_byte_data(client, reg + 1,
 						 (value >> 8) & 0xff);
 		break;
-	case ADT7463_REG_TMIN_CTL1:  /* Write WORD MSB, LSB */
-		res = i2c_smbus_write_byte_data(client, reg,
-						(value >> 8) & 0xff);
-		res |= i2c_smbus_write_byte_data(client, reg + 1, value & 0xff);
-		break;
 	default:	/* Write BYTE data */
 		res = i2c_smbus_write_byte_data(client, reg, value);
 		break;
@@ -1482,12 +1438,7 @@ static struct lm85_data *lm85_update_dev
 
 		data->alarms = lm85_read_value(client, LM85_REG_ALARM1);
 
-		if (data->type = adt7463) {
-			if (data->therm_total < ULONG_MAX - 256) {
-			    data->therm_total +-				lm85_read_value(client, ADT7463_REG_THERM);
-			}
-		} else if (data->type = emc6d100) {
+		if (data->type = emc6d100) {
 			/* Three more voltage sensors */
 			for (i = 5; i <= 7; ++i) {
 				data->in[i] = lm85_read_value(client,
@@ -1584,9 +1535,6 @@ static struct lm85_data *lm85_update_dev
 		data->autofan[0].min_off = (i & 0x20) != 0;
 		data->autofan[1].min_off = (i & 0x40) != 0;
 		data->autofan[2].min_off = (i & 0x80) != 0;
-		i = lm85_read_value(client, LM85_REG_AFAN_SPIKE2);
-		data->smooth[1] = (i>>4) & 0x0f;
-		data->smooth[2] = i & 0x0f;
 
 		i = lm85_read_value(client, LM85_REG_AFAN_HYST1);
 		data->zone[0].hyst = (i>>4) & 0x0f;
@@ -1595,32 +1543,6 @@ static struct lm85_data *lm85_update_dev
 		i = lm85_read_value(client, LM85_REG_AFAN_HYST2);
 		data->zone[2].hyst = (i>>4) & 0x0f;
 
-		if (data->type = lm85b || data->type = lm85c) {
-			data->tach_mode = lm85_read_value(client,
-				LM85_REG_TACH_MODE);
-			data->spinup_ctl = lm85_read_value(client,
-				LM85_REG_SPINUP_CTL);
-		} else if (data->type = adt7463 || data->type = adm1027) {
-			if (data->type = adt7463) {
-				for (i = 0; i <= 2; ++i) {
-				    data->oppoint[i] = lm85_read_value(client,
-					ADT7463_REG_OPPOINT(i));
-				}
-				data->tmin_ctl = lm85_read_value(client,
-					ADT7463_REG_TMIN_CTL1);
-				data->therm_limit = lm85_read_value(client,
-					ADT7463_REG_THERM_LIMIT);
-			}
-			for (i = 0; i <= 2; ++i) {
-				data->temp_offset[i] = lm85_read_value(client,
-						ADM1027_REG_TEMP_OFFSET(i));
-			}
-			data->tach_mode = lm85_read_value(client,
-				ADM1027_REG_CONFIG3);
-			data->fan_ppr = lm85_read_value(client,
-				ADM1027_REG_FAN_PPR);
-		}
-
 		data->last_config = jiffies;
 	}  /* last_config */
 
--- linux-2.6.25-rc8.orig/Documentation/hwmon/lm85	2008-04-04 15:41:52.000000000 +0200
+++ linux-2.6.25-rc8/Documentation/hwmon/lm85	2008-04-04 15:46:40.000000000 +0200
@@ -96,11 +96,6 @@ initial testing of the ADM1027 it was 1.
 confirmed this "bug". The ADT7463 is reported to work as described in the
 documentation. The current lm85 driver does not show the offset register.
 
-The ADT7463 has a THERM asserted counter. This counter has a 22.76ms
-resolution and a range of 5.8 seconds. The driver implements a 32-bit
-accumulator of the counter value to extend the range to over a year. The
-counter will stay at it's max value until read.
-
 See the vendor datasheets for more information. There is application note
 from National (AN-1260) with some additional information about the LM85.
 The Analog Devices datasheet is very detailed and describes a procedure for
@@ -206,13 +201,15 @@ Configuration choices:
 
 The National LM85's have two vendor specific configuration
 features. Tach. mode and Spinup Control. For more details on these,
-see the LM85 datasheet or Application Note AN-1260.
+see the LM85 datasheet or Application Note AN-1260. These features
+are not currently supported by the lm85 driver.
 
 The Analog Devices ADM1027 has several vendor specific enhancements.
 The number of pulses-per-rev of the fans can be set, Tach monitoring
 can be optimized for PWM operation, and an offset can be applied to
 the temperatures to compensate for systemic errors in the
-measurements.
+measurements. These features are not currently supported by the lm85
+driver.
 
 In addition to the ADM1027 features, the ADT7463 also has Tmin control
 and THERM asserted counts. Automatic Tmin control acts to adjust the


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
