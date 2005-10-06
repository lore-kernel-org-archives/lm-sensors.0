From: xanni@glasswings.com.au (Andrew Pam)
Date: Thu, 06 Oct 2005 16:02:53 +0000
Subject: [lm-sensors] Myson MTP008 driver ported to 2.6 kernel
Message-Id: <20051006140138.GY7173@kira.glasswings.com.au>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051004125511.GI7154@kira.glasswings.com.au>
In-Reply-To: <20051004125511.GI7154@kira.glasswings.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 05, 2005 at 05:12:12PM +0200, Jean Delvare wrote:
> Here is a preliminary review of Andrew's version of the driver, so that
> you can fix all the problems I've noticed when porting the code to work
> with 2.6.14-rc3.

OK, I've made some of the easier suggested changes, compiled,
installed and tested with Linux 2.6.12.3.  This new version is now at
http://www.sericyb.com.au/mtp008.c and I include a diff against the
previous version below:

Regards,
	Andrew

--- mtp008.c.20050104	2005-10-06 22:31:26.395417872 +1000
+++ mtp008.c	2005-10-06 19:25:22.928522800 +1000
@@ -24,9 +24,11 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/err.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = {0x2c, 0x2e, I2C_CLIENT_END};
+static unsigned short normal_i2c[] = {0x2c, 0x2d, 0x2e, I2C_CLIENT_END};
 static unsigned int normal_isa[] = {I2C_CLIENT_ISA_END};
 
 /* Insmod parameters */
@@ -51,12 +53,6 @@
 #define MTP008_REG_INT_STAT1		0x41
 #define MTP008_REG_INT_STAT2		0x42
 
-#define MTP008_REG_SMI_MASK1		0x43
-#define MTP008_REG_SMI_MASK2		0x44
-
-#define MTP008_REG_NMI_MASK1		0x45
-#define MTP008_REG_NMI_MASK2		0x46
-
 #define MTP008_REG_VID_FANDIV		0x47
 
 #define MTP008_REG_I2C_ADDR		0x48
@@ -105,25 +101,22 @@
 	if (rpm <= 0)
 		return 255;
 
-	rpm = SENSORS_LIMIT(rpm, 1, 1000000);
-
 	return SENSORS_LIMIT( (1350000 + rpm * div / 2) / (rpm * div), 1, 254);
 }
 
-#define FAN_FROM_REG(val, div)	((val) = 0 ? -1			      \
-					    : (val) = 255 ? 0		      \
-							   : 1350000 /	      \
-							     ((val) * (div))  \
+#define FAN_FROM_REG(val, div)	( (val) = 0 ? -1		\
+				: (val) = 255 ? 0		\
+			        : 1350000 / ((val) * (div))	\
 				)
 
 /* TEMP: mC (-128C to +127C)
    REG: 1C/bit, two's complement */
-#define TEMP_TO_REG(val)	(					      \
-				 (val) < 0				      \
-				    ? SENSORS_LIMIT(((val) - 500) / 1000,     \
-						    0, 255) \
-				    : SENSORS_LIMIT(((val) + 500) / 1000,     \
-						    0, 255) \
+#define TEMP_TO_REG(val)	(					\
+				 (					\
+				  ( (val) < 0 ? ((val) - 500)		\
+				 	      : ((val) + 500)		\
+			          ) / 1000				\
+				 ) & 0xff				\
 				)
 #define TEMP_FROM_REG(val)	(					      \
 				 (					      \
@@ -146,21 +139,6 @@
  * Fan divider.
  */
 #define DIV_FROM_REG(val)	(1 << (val))
-#define DIV_TO_REG(val)		((val) = 8 ? 3				      \
-					    : (val) = 4 ? 2		      \
-							 : (val) = 2 ? 1     \
-								      : 0)
-
-/*
- * Alarms (interrupt status).
- */
-#define ALARMS_FROM_REG(val)	(val)
-
-/*
- * Beep controls.
- */
-#define BEEPS_FROM_REG(val)	(val)
-#define BEEPS_TO_REG(val)	(val)
 
 /*
  * PWM control.  (nr is 0..2)
@@ -185,7 +163,6 @@
  */
 struct mtp008_data {
 	struct i2c_client client;
-	enum chips type;
 
 	struct semaphore update_lock;
 	char valid;				/* !=0 if fields are valid */
@@ -203,7 +180,7 @@
 	u8 fan_div[3];				/* Register encoding */
 	u16 alarms;				/* Register encoding */
 	u16 beeps;				/* Register encoding */
-	u8 pwm[4];				/* Register value */
+	u8 pwm[3];				/* Register value */
 	u8 sens[3];				/* 0 = Analog input,
 						   1 = Thermistor,
 						   2 = PII/Celeron diode */
@@ -214,8 +191,6 @@
 static int mtp008_detect(struct i2c_adapter *adapter, int address, int kind);
 static int mtp008_detach_client(struct i2c_client *client);
 
-static int mtp008_read_value(struct i2c_client *client, u8 register);
-static int mtp008_write_value(struct i2c_client *client, u8 register, u8 value);
 static struct mtp008_data *mtp008_update_device(struct device *dev);
 static void mtp008_init_client(struct i2c_client *client);
 
@@ -267,7 +242,7 @@
 	if ((nr != 4 && nr != 5) || data->sens[nr - 3] = 0) {
 		down(&data->update_lock);
 		data->in_min[nr] = IN_TO_REG(val);
-		mtp008_write_value(client, MTP008_REG_IN_MIN(nr),
+		i2c_smbus_write_byte_data(client, MTP008_REG_IN_MIN(nr),
 				data->in_min[nr]);
 		up(&data->update_lock);
 	}
@@ -284,7 +259,7 @@
 	if ((nr != 4 && nr != 5) || data->sens[nr - 3] = 0) {
 		down(&data->update_lock);
 		data->in_max[nr] = IN_TO_REG(val);
-		mtp008_write_value(client, MTP008_REG_IN_MAX(nr),
+		i2c_smbus_write_byte_data(client, MTP008_REG_IN_MAX(nr),
 				data->in_max[nr]);
 		up(&data->update_lock);
 	}
@@ -365,11 +340,12 @@
 	down(&data->update_lock);
 	if (nr = 1) {
 		data->temp_max = TEMP_TO_REG(val);
-		mtp008_write_value(client, MTP008_REG_TEMP_MAX, data->temp_max);
+		i2c_smbus_write_byte_data(client, MTP008_REG_TEMP_MAX,
+				data->temp_max);
 	}
 	else if (data->sens[nr - 1] != 0) {
 		data->in_max[nr + 2] = TEMP_TO_REG(val);
-		mtp008_write_value(client, MTP008_REG_IN_MAX(nr + 2),
+		i2c_smbus_write_byte_data(client, MTP008_REG_IN_MAX(nr + 2),
 				data->in_max[nr + 2]);
 	}
 	up(&data->update_lock);
@@ -397,11 +373,12 @@
 	down(&data->update_lock);
 	if (nr = 1) {
 		data->temp_min = TEMP_TO_REG(val);
-		mtp008_write_value(client, MTP008_REG_TEMP_MIN, data->temp_min);
+		i2c_smbus_write_byte_data(client, MTP008_REG_TEMP_MIN,
+				data->temp_min);
 	}
 	else if (data->sens[nr - 1] != 0) {
 		data->in_min[nr + 2] = TEMP_TO_REG(val);
-		mtp008_write_value(client, MTP008_REG_IN_MIN(nr + 2),
+		i2c_smbus_write_byte_data(client, MTP008_REG_IN_MIN(nr + 2),
 				data->in_min[nr + 2]);
 	}
 	up(&data->update_lock);
@@ -456,7 +433,7 @@
 static ssize_t show_fan_min(struct device *dev, char *buf, const int nr)
 {
 	struct mtp008_data *data = mtp008_update_device(dev);
-	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan_min[nr],
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[nr],
 		DIV_FROM_REG(data->fan_div[nr])) );
 }
 
@@ -469,7 +446,8 @@
 
 	down(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
-	mtp008_write_value(client, MTP008_REG_FAN_MIN(nr), data->fan_min[nr]);
+	i2c_smbus_write_byte_data(client, MTP008_REG_FAN_MIN(nr),
+			data->fan_min[nr]);
 	up(&data->update_lock);
 	return count;
 }
@@ -511,25 +489,26 @@
 
 	switch (nr) {
 	case 0:
-		reg = mtp008_read_value(client, MTP008_REG_VID_FANDIV);
+		reg = i2c_smbus_read_byte_data(client, MTP008_REG_VID_FANDIV);
 		reg = (reg & 0xcf) | ((data->fan_div[nr] & 0x03) << 4);
-		mtp008_write_value(client, MTP008_REG_VID_FANDIV, reg);
+		i2c_smbus_write_byte_data(client, MTP008_REG_VID_FANDIV, reg);
 		break;
 	case 1:
-		reg = mtp008_read_value(client, MTP008_REG_VID_FANDIV);
+		reg = i2c_smbus_read_byte_data(client, MTP008_REG_VID_FANDIV);
 		reg = (reg & 0x3f) | ((data->fan_div[nr] & 0x03) << 6);
-		mtp008_write_value(client, MTP008_REG_VID_FANDIV, reg);
+		i2c_smbus_write_byte_data(client, MTP008_REG_VID_FANDIV, reg);
 		break;
 	case 2:
-		reg = mtp008_read_value(client, MTP008_REG_PIN_CTRL1);
+		reg = i2c_smbus_read_byte_data(client, MTP008_REG_PIN_CTRL1);
 		reg = (reg & 0x3f) | ((data->fan_div[nr] & 0x03) << 6);
-		mtp008_write_value(client, MTP008_REG_PIN_CTRL1, reg);
+		i2c_smbus_write_byte_data(client, MTP008_REG_PIN_CTRL1, reg);
 		break;
 	}
 
 	data->fan_min[nr]  		FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
-	mtp008_write_value(client, MTP008_REG_FAN_MIN(nr), data->fan_min[nr]);
+	i2c_smbus_write_byte_data(client, MTP008_REG_FAN_MIN(nr),
+			data->fan_min[nr]);
 	up(&data->update_lock);
 
 	return count;
@@ -580,7 +559,7 @@
 static ssize_t show_alarms(struct device *dev, char *buf)
 {
 	struct mtp008_data *data = mtp008_update_device(dev);
-	return sprintf(buf, "%u\n", ALARMS_FROM_REG(data->alarms));
+	return sprintf(buf, "%u\n", data->alarms);
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
@@ -588,7 +567,7 @@
 static ssize_t show_beeps(struct device *dev, char *buf)
 {
 	struct mtp008_data *data = mtp008_update_device(dev);
-	return sprintf(buf, "%u\n", BEEPS_FROM_REG(data->beeps));
+	return sprintf(buf, "%u\n", data->beeps);
 }
 
 static ssize_t set_beeps(struct device *dev, const char *buf,
@@ -599,9 +578,11 @@
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	down(&data->update_lock);
-	data->beeps = BEEPS_TO_REG(val) & 0xdf8f;
-	mtp008_write_value(client, MTP008_REG_BEEP_CTRL1, data->beeps & 0xff);
-	mtp008_write_value(client, MTP008_REG_BEEP_CTRL2, data->beeps >> 8);
+	data->beeps = val & 0xdf8f;
+	i2c_smbus_write_byte_data(client, MTP008_REG_BEEP_CTRL1,
+			data->beeps & 0xff);
+	i2c_smbus_write_byte_data(client, MTP008_REG_BEEP_CTRL2,
+			data->beeps >> 8);
 	up(&data->update_lock);
 	return count;
 }
@@ -622,8 +603,9 @@
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	down(&data->update_lock);
-	data->pwm[nr-1] = PWM_TO_REG(val);
-	mtp008_write_value(client, MTP008_REG_PWM_CTRL(nr), data->pwm[nr]);
+	data->pwm[nr] = PWM_TO_REG(val);
+	i2c_smbus_write_byte_data(client, MTP008_REG_PWM_CTRL(nr),
+			data->pwm[nr]);
 	up(&data->update_lock);
 	return count;
 }
@@ -647,7 +629,8 @@
 		data->pwmenable |= (0x10 << nr);
 	else
 		data->pwmenable &= ~(0x10 << nr);
-	mtp008_write_value(client, MTP008_REG_PIN_CTRL2, data->pwmenable);
+	i2c_smbus_write_byte_data(client, MTP008_REG_PIN_CTRL2,
+			data->pwmenable);
 	up(&data->update_lock);
 	return count;
 }
@@ -706,9 +689,9 @@
 	else {
 		down(&data->update_lock);
 		data->sens[nr] = SENS_TO_REG(val);
-		reg = (mtp008_read_value(client, MTP008_REG_PIN_CTRL2)
+		reg = (i2c_smbus_read_byte_data(client, MTP008_REG_PIN_CTRL2)
 			& ~mask) | (data->sens[nr] << ((2 - nr) + 1));
-		mtp008_write_value(client, MTP008_REG_PIN_CTRL2, reg);
+		i2c_smbus_write_byte_data(client, MTP008_REG_PIN_CTRL2, reg);
 		up(&data->update_lock);
 	}
 	return count;
@@ -745,7 +728,6 @@
 
 int mtp008_detect(struct i2c_adapter *adapter, int address, int kind)
 {
-	const char *client_name = "";
 	int err, i;
 	struct i2c_client *new_client;
 	struct mtp008_data *data;
@@ -772,7 +754,10 @@
 
 	/* Remaining detection. */
 	if (kind < 0) {
-		if (mtp008_read_value(new_client, MTP008_REG_CHIPID) != 0xac) {
+		if ( i2c_smbus_read_byte_data(new_client, MTP008_REG_CHIPID)
+			!= 0xac
+		||   i2c_smbus_read_byte_data(new_client, MTP008_REG_I2C_ADDR)
+			!= address)	{
 			err = -ENODEV;
 			goto exit_free;
 		}
@@ -780,9 +765,7 @@
 	/*
 	 * Fill in the remaining client fields and put it into the global list.
 	 */
-	client_name = "mtp008";
-	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
-	data->type = kind;
+	strlcpy(new_client->name, "mtp008", I2C_NAME_SIZE);
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
 
@@ -795,7 +778,7 @@
 
 	/* A few vars need to be filled upon startup */
 	for (i = 0; i < 3; i++) {
-		data->fan_min[i] = mtp008_read_value(new_client,
+		data->fan_min[i] = i2c_smbus_read_byte_data(new_client,
 					MTP008_REG_FAN_MIN(i));
 	}
 
@@ -875,17 +858,6 @@
 	return 0;
 }
 
-
-static int mtp008_read_value(struct i2c_client *client, u8 reg)
-{
-	return i2c_smbus_read_byte_data(client, reg) & 0xff;
-}
-
-static int mtp008_write_value(struct i2c_client *client, u8 reg, u8 value)
-{
-	return i2c_smbus_write_byte_data(client, reg, value);
-}
-
 static void mtp008_getsensortype(struct mtp008_data *data, u8 inp)
 {
 	inp &= 0x0f;
@@ -898,28 +870,17 @@
 static void mtp008_init_client(struct i2c_client *client)
 {
 	struct mtp008_data *data = i2c_get_clientdata(client);
-	u8 save1, save2;
-
-	/*
-	 * Initialize the Myson MTP008 hardware monitoring chip.
-	 * Save the pin settings that the BIOS hopefully set.
-	 */
-	save1 = mtp008_read_value(client, MTP008_REG_PIN_CTRL1);
-	save2 = mtp008_read_value(client, MTP008_REG_PIN_CTRL2);
-	mtp008_write_value(client, MTP008_REG_CONFIG,
-	     (mtp008_read_value(client, MTP008_REG_CONFIG) & 0x7f) | 0x80);
-	mtp008_write_value(client, MTP008_REG_PIN_CTRL1, save1);
-	mtp008_write_value(client, MTP008_REG_PIN_CTRL2, save2);
-
-	mtp008_getsensortype(data, save2);
 
+	mtp008_getsensortype(data, i2c_smbus_read_byte_data(client,
+				MTP008_REG_PIN_CTRL2) );
 
 	/*
 	 * Start monitoring.
 	 */
-	mtp008_write_value(
+	i2c_smbus_write_byte_data(
 		client, MTP008_REG_CONFIG,
-		(mtp008_read_value(client, MTP008_REG_CONFIG) & 0xf7) | 0x01
+		(i2c_smbus_read_byte_data(client, MTP008_REG_CONFIG) & 0xf7)
+		| 0x01
 	);
 }
 
@@ -945,66 +906,70 @@
 		 */
 		for (i = 0; i < 7; i++) {
 			data->in[i] -				mtp008_read_value(client, MTP008_REG_IN(i));
+				i2c_smbus_read_byte_data(client,
+						MTP008_REG_IN(i));
 			data->in_max[i] -				mtp008_read_value(client, MTP008_REG_IN_MAX(i));
+				i2c_smbus_read_byte_data(client,
+						MTP008_REG_IN_MAX(i));
 			data->in_min[i] -				mtp008_read_value(client, MTP008_REG_IN_MIN(i));
+				i2c_smbus_read_byte_data(client,
+						MTP008_REG_IN_MIN(i));
 		}
 
 		/*
 		 * Read the temperature sensor.
 		 */
-		data->temp = mtp008_read_value(client, MTP008_REG_TEMP);
-		data->temp_max = mtp008_read_value(client, MTP008_REG_TEMP_MAX);
-		data->temp_min = mtp008_read_value(client, MTP008_REG_TEMP_MIN);
+		data->temp = i2c_smbus_read_byte_data(client, MTP008_REG_TEMP);
+		data->temp_max = i2c_smbus_read_byte_data(client,
+				MTP008_REG_TEMP_MAX);
+		data->temp_min = i2c_smbus_read_byte_data(client,
+				MTP008_REG_TEMP_MIN);
 
 		/*
 		 * Read the first 2 fan dividers and the VID setting.  Read the
 		 * third fan divider from a different register.
 		 */
-		inp = mtp008_read_value(client, MTP008_REG_VID_FANDIV);
+		inp = i2c_smbus_read_byte_data(client, MTP008_REG_VID_FANDIV);
 		data->vid = inp & 0x0f;
-		data->vid |= (mtp008_read_value(client,
-				     MTP008_REG_RESET_VID4) & 0x01) << 4;
+		data->vid |= (i2c_smbus_read_byte_data(client,
+				MTP008_REG_RESET_VID4) & 0x01) << 4;
 
 		data->fan_div[0] = (inp >> 4) & 0x03;
 		data->fan_div[1] = inp >> 6;
-		data->fan_div[2] -			mtp008_read_value(client, MTP008_REG_PIN_CTRL1) >> 6;
+		data->fan_div[2] = i2c_smbus_read_byte_data(client,
+				MTP008_REG_PIN_CTRL1) >> 6;
 
 		/*
 		 * Read the interrupt status registers.
 		 */
 		data->alarms -			(mtp008_read_value(client,
+			(i2c_smbus_read_byte_data(client,
 					   MTP008_REG_INT_STAT1) & 0xdf) |
-			(mtp008_read_value(client,
+			(i2c_smbus_read_byte_data(client,
 					   MTP008_REG_INT_STAT2) & 0x0f) << 8;
 
 		/*
 		 * Read the beep control registers.
 		 */
 		data->beeps -			(mtp008_read_value(client,
+			(i2c_smbus_read_byte_data(client,
 					   MTP008_REG_BEEP_CTRL1) & 0xdf) |
-			(mtp008_read_value(client,
+			(i2c_smbus_read_byte_data(client,
 					   MTP008_REG_BEEP_CTRL2) & 0x8f) << 8;
 
 		/*
 		 * Read the sensor configuration.
 		 */
-		inp = mtp008_read_value(client, MTP008_REG_PIN_CTRL2);
+		inp = i2c_smbus_read_byte_data(client, MTP008_REG_PIN_CTRL2);
 		mtp008_getsensortype(data, inp);
 		data->pwmenable = inp;
 
 		/*
 		 * Read the PWM registers if enabled.
 		 */
-		for (i = 0; i < 3; i++)
-		{
+		for (i = 0; i < 3; i++) {
 			if(PWMENABLE_FROM_REG(i, inp))
-				data->pwm[i] = mtp008_read_value(client,
+				data->pwm[i] = i2c_smbus_read_byte_data(client,
 						  MTP008_REG_PWM_CTRL(i));
 			else
 				data->pwm[i] = 255;
@@ -1018,9 +983,10 @@
 				data->fan[2] = 0;
 				data->fan_min[2] = 0;
 			} else {
-				data->fan[i] = mtp008_read_value(client,
+				data->fan[i] = i2c_smbus_read_byte_data(client,
 					  MTP008_REG_FAN(i));
-				data->fan_min[i] = mtp008_read_value(client,
+				data->fan_min[i] +					i2c_smbus_read_byte_data(client,
 					  MTP008_REG_FAN_MIN(i));
 			}
 		}
@@ -1045,9 +1011,7 @@
 
 
 
-MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>, "
-	      "Philip Edelbrock <phil@netroedge.com>, "
-	      "Kris Van Hees <aedil@alchar.org> "
+MODULE_AUTHOR("Kris Van Hees <aedil@alchar.org> "
 	      "and Andrew Pam <andrew@sericyb.com.au>");
 MODULE_DESCRIPTION("MTP008 driver");
 MODULE_LICENSE("GPL");

-- 
mailto:xanni@xanadu.net                         Andrew Pam
http://www.xanadu.com.au/                       Chief Scientist, Xanadu
http://www.glasswings.com.au/                   Partner, Glass Wings
http://www.sericyb.com.au/                      Manager, Serious Cybernetics
