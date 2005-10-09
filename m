From: xanni@glasswings.com.au (Andrew Pam)
Date: Sun, 09 Oct 2005 20:03:06 +0000
Subject: [lm-sensors] Myson MTP008 driver ported to 2.6 kernel
Message-Id: <20051009180129.GH7170@kira.glasswings.com.au>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051004125511.GI7154@kira.glasswings.com.au>
In-Reply-To: <20051004125511.GI7154@kira.glasswings.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 06, 2005 at 12:09:47PM +0200, Jean Delvare wrote:
> So it is OK to have tempN_type read/write, as long as writing only allows
> a sensor type change and not a function change.

OK, I have made this change and some others that you suggested, and at
the cost of an extra six bytes of memory have also refactored the code
to keep the (possible) extra two temperature sensor settings separately,
which simplifies the code.

Once again the code has been successfully compiled and tested under
Linux 2.6.12.3 and the full source is at http://www.sericyb.com.au/mtp008.c

The differences from the 6 October version are as follows:

Regards,
	Andrew

--- mtp008.c.20051006	2005-10-10 03:46:54.877505592 +1000
+++ mtp008.c	2005-10-10 03:44:45.618156000 +1000
@@ -112,18 +112,11 @@
 /* TEMP: mC (-128C to +127C)
    REG: 1C/bit, two's complement */
 #define TEMP_TO_REG(val)	(					\
-				 (					\
-				  ( (val) < 0 ? ((val) - 500)		\
-				 	      : ((val) + 500)		\
-			          ) / 1000				\
-				 ) & 0xff				\
-				)
-#define TEMP_FROM_REG(val)	(					      \
-				 (					      \
-				  (val) > 0x80 ? (val) - 0x100		      \
-					       : (val)			      \
-				 ) * 1000				      \
+				 ( (val) < 0 ? ((val) - 500)		\
+				 	     : ((val) + 500)		\
+			         ) / 1000				\
 				)
+#define TEMP_FROM_REG(val)	( (val) * 1000 )
 
 /* VID: mV
  * REG: 0x00 to 0x0f    = 2.05 to 1.30 (0.05 per unit)
@@ -150,11 +143,11 @@
 /* sysfs temperature sensor types	mtp008 sensor types
  * 0: Not defined			0: Analog input (voltage)
  * 1: PII/Celeron Diode			2: PII Diode
- * 2: 3904 transistor			1: Thermistor
- * 3: thermal diode
+ * 2: 3904 transistor
+ * 3: thermal diode			1: Thermistor
  */
-#define SENS_FROM_REG(val)	((val) = 0 ? 0	: ((val) ^ 0x03))
-#define SENS_TO_REG(val)	SENS_FROM_REG(val)
+#define SENS_FROM_REG(val)	((val) = 0 ? 0	: (val) = 1 ? 3 : 1)
+#define SENS_TO_REG(val)	((val) = 0 ? 0 : (val) = 1 ? 2 : 1)
 
 /*
  * For each registered MTP008, we need to keep some data in memory.  The
@@ -171,9 +164,9 @@
 	u8 in[7];				/* Register value */
 	u8 in_max[7];				/* Register value */
 	u8 in_min[7];				/* Register value */
-	u8 temp;				/* Register value */
-	u8 temp_max;				/* Register value */
-	u8 temp_min;				/* Register value */
+	s8 temp[3];				/* Register value */
+	s8 temp_max[3];				/* Register value */
+	s8 temp_min[3];				/* Register value */
 	u8 fan[3];				/* Register value */
 	u8 fan_min[3];				/* Register value */
 	u8 vid;					/* Register encoding */
@@ -208,28 +201,19 @@
 static ssize_t show_in(struct device *dev, char *buf, const int nr)
 {
 	struct mtp008_data *data = mtp008_update_device(dev);
-	int result = 0;
-	if ((nr != 4 && nr != 5) || data->sens[nr - 3] = 0)
-		result = IN_FROM_REG(data->in[nr]);
-	return sprintf(buf, "%d\n", result);
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in[nr]));
 }
 
 static ssize_t show_in_min(struct device *dev, char *buf, const int nr)
 {
 	struct mtp008_data *data = mtp008_update_device(dev);
-	int result = 0;
-	if ((nr != 4 && nr != 5) || data->sens[nr - 3] = 0)
-		result = IN_FROM_REG(data->in_min[nr]);
-	return sprintf(buf, "%d\n", result);
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_min[nr]));
 }
 
 static ssize_t show_in_max(struct device *dev, char *buf, const int nr)
 {
 	struct mtp008_data *data = mtp008_update_device(dev);
-	int result = 0;
-	if ((nr != 4 && nr != 5) || data->sens[nr - 3] = 0)
-		result = IN_FROM_REG(data->in_max[nr]);
-	return sprintf(buf, "%d\n", result);
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_max[nr]));
 }
 
 static ssize_t set_in_min(struct device *dev, const char *buf,
@@ -311,23 +295,13 @@
 static ssize_t show_temp(struct device *dev, char *buf, const int nr)
 {
 	struct mtp008_data *data = mtp008_update_device(dev);
-	int result = 0;
-	if (nr = 1)
-		result = TEMP_FROM_REG(data->temp);
-	else if (data->sens[nr - 1] != 0)
-		result = TEMP_FROM_REG(data->in[nr + 2]);
-	return sprintf(buf, "%d\n", result);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr]));
 }
 
 static ssize_t show_temp_max(struct device *dev, char *buf, const int nr)
 {
 	struct mtp008_data *data = mtp008_update_device(dev);
-	int result = 0;
-	if (nr = 1)
-		result = TEMP_FROM_REG(data->temp_max);
-	else if (data->sens[nr - 1] != 0)
-		result = TEMP_FROM_REG(data->in_max[nr + 2]);
-	return sprintf(buf, "%d\n", result);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[nr]));
 }
 
 static ssize_t set_temp_max(struct device *dev, const char *buf,
@@ -338,15 +312,14 @@
 	long val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	if (nr = 1) {
-		data->temp_max = TEMP_TO_REG(val);
+	data->temp_max[nr] = TEMP_TO_REG(val);
+	if (nr = 0) {
 		i2c_smbus_write_byte_data(client, MTP008_REG_TEMP_MAX,
-				data->temp_max);
+				data->temp_max[nr]);
 	}
-	else if (data->sens[nr - 1] != 0) {
-		data->in_max[nr + 2] = TEMP_TO_REG(val);
-		i2c_smbus_write_byte_data(client, MTP008_REG_IN_MAX(nr + 2),
-				data->in_max[nr + 2]);
+	else if (data->sens[nr] != 0) {
+		i2c_smbus_write_byte_data(client, MTP008_REG_IN_MAX(nr + 3),
+				data->temp_max[nr]);
 	}
 	up(&data->update_lock);
 	return count;
@@ -355,12 +328,7 @@
 static ssize_t show_temp_min(struct device *dev, char *buf, const int nr)
 {
 	struct mtp008_data *data = mtp008_update_device(dev);
-	int result = 0;
-	if (nr = 1)
-		result = TEMP_FROM_REG(data->temp_min);
-	else if (data->sens[nr - 1] != 0)
-		result = TEMP_FROM_REG(data->in_min[nr + 2]);
-	return sprintf(buf, "%d\n", result);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[nr]));
 }
 
 static ssize_t set_temp_min(struct device *dev, const char *buf,
@@ -371,15 +339,14 @@
 	long val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	if (nr = 1) {
-		data->temp_min = TEMP_TO_REG(val);
+	data->temp_min[nr] = TEMP_TO_REG(val);
+	if (nr = 0) {
 		i2c_smbus_write_byte_data(client, MTP008_REG_TEMP_MIN,
-				data->temp_min);
+				data->temp_min[nr]);
 	}
-	else if (data->sens[nr - 1] != 0) {
-		data->in_min[nr + 2] = TEMP_TO_REG(val);
-		i2c_smbus_write_byte_data(client, MTP008_REG_IN_MIN(nr + 2),
-				data->in_min[nr + 2]);
+	else if (data->sens[nr] != 0) {
+		i2c_smbus_write_byte_data(client, MTP008_REG_IN_MIN(nr + 3),
+				data->temp_min[nr]);
 	}
 	up(&data->update_lock);
 	return count;
@@ -389,29 +356,29 @@
 static ssize_t								\
 	show_temp##offset (struct device *dev, char *buf)		\
 {									\
-	return show_temp(dev, buf, offset);				\
+	return show_temp(dev, buf, offset - 1);				\
 }									\
 static DEVICE_ATTR(temp##offset##_input, S_IRUGO, 			\
 		show_temp##offset, NULL);				\
 static ssize_t								\
 	show_temp##offset##_min (struct device *dev, char *buf)		\
 {									\
-	return show_temp_min(dev, buf, offset);				\
+	return show_temp_min(dev, buf, offset - 1);			\
 }									\
 static ssize_t								\
 	show_temp##offset##_max (struct device *dev, char *buf)		\
 {									\
-	return show_temp_max(dev, buf, offset);				\
+	return show_temp_max(dev, buf, offset - 1);			\
 }									\
 static ssize_t set_temp##offset##_min (struct device *dev,		\
 		const char *buf, size_t count)				\
 {									\
-	return set_temp_min(dev, buf, count, offset);			\
+	return set_temp_min(dev, buf, count, offset - 1);		\
 }									\
 static ssize_t set_temp##offset##_max (struct device *dev,		\
 		const char *buf, size_t count)				\
 {									\
-	return set_temp_max(dev, buf, count, offset);			\
+	return set_temp_max(dev, buf, count, offset - 1);		\
 }									\
 static DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR,		\
 		show_temp##offset##_min, set_temp##offset##_min);	\
@@ -676,13 +643,17 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct mtp008_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
-	u8 reg, mask;
+	u8 reg, mask, bits;
 
 	mask = (nr = 0) ? MTP008_CFG_VT1_MASK
 			 : (nr = 1) ? MTP008_CFG_VT2_MASK
 			 	     : MTP008_CFG_VT3_MASK;
+	bits = SENS_TO_REG(val) << ((2 - nr) + 1);
 
-	if ((SENS_TO_REG(val) << ((2 - nr) + 1)) & ~mask)
+	if ( (val = 0)				/* Undefined */
+	     || (data->sens[nr] = 0)		/* Voltage sensor */
+	     || ((bits & ~mask) != 0)		/* Invalid setting */
+	   )
 		dev_err(&client->dev,
 			"Invalid sensor type %ld for sensor %d.\n",
 			val, nr + 1);
@@ -690,7 +661,7 @@
 		down(&data->update_lock);
 		data->sens[nr] = SENS_TO_REG(val);
 		reg = (i2c_smbus_read_byte_data(client, MTP008_REG_PIN_CTRL2)
-			& ~mask) | (data->sens[nr] << ((2 - nr) + 1));
+			& ~mask) | bits;
 		i2c_smbus_write_byte_data(client, MTP008_REG_PIN_CTRL2, reg);
 		up(&data->update_lock);
 	}
@@ -753,15 +724,15 @@
 	new_client->flags = 0;
 
 	/* Remaining detection. */
-	if (kind < 0) {
-		if ( i2c_smbus_read_byte_data(new_client, MTP008_REG_CHIPID)
-			!= 0xac
-		||   i2c_smbus_read_byte_data(new_client, MTP008_REG_I2C_ADDR)
-			!= address)	{
-			err = -ENODEV;
-			goto exit_free;
-		}
+	if ((kind < 0)
+	    && (i2c_smbus_read_byte_data(new_client, MTP008_REG_CHIPID) != 0xac
+		|| i2c_smbus_read_byte_data(new_client, MTP008_REG_I2C_ADDR)
+			!= address)
+	   ) {
+		err = -ENODEV;
+		goto exit_free;
 	}
+
 	/*
 	 * Fill in the remaining client fields and put it into the global list.
 	 */
@@ -874,9 +845,7 @@
 	mtp008_getsensortype(data, i2c_smbus_read_byte_data(client,
 				MTP008_REG_PIN_CTRL2) );
 
-	/*
-	 * Start monitoring.
-	 */
+	/* Start monitoring. */
 	i2c_smbus_write_byte_data(
 		client, MTP008_REG_CONFIG,
 		(i2c_smbus_read_byte_data(client, MTP008_REG_CONFIG) & 0xf7)
@@ -902,7 +871,7 @@
 		 * Read in the analog inputs.  We're reading AIN4 and AIN5 as
 		 * regular analog inputs, even though they may have been
 		 * configured as temperature readings instead.  Interpretation
-		 * of these values is done elsewhere.
+		 * of these values is done below.
 		 */
 		for (i = 0; i < 7; i++) {
 			data->in[i] @@ -916,13 +885,12 @@
 						MTP008_REG_IN_MIN(i));
 		}
 
-		/*
-		 * Read the temperature sensor.
-		 */
-		data->temp = i2c_smbus_read_byte_data(client, MTP008_REG_TEMP);
-		data->temp_max = i2c_smbus_read_byte_data(client,
+		/* Read the temperature sensor. */
+		data->temp[0] = i2c_smbus_read_byte_data(client,
+				MTP008_REG_TEMP);
+		data->temp_max[0] = i2c_smbus_read_byte_data(client,
 				MTP008_REG_TEMP_MAX);
-		data->temp_min = i2c_smbus_read_byte_data(client,
+		data->temp_min[0] = i2c_smbus_read_byte_data(client,
 				MTP008_REG_TEMP_MIN);
 
 		/*
@@ -939,34 +907,42 @@
 		data->fan_div[2] = i2c_smbus_read_byte_data(client,
 				MTP008_REG_PIN_CTRL1) >> 6;
 
-		/*
-		 * Read the interrupt status registers.
-		 */
+		/* Read the interrupt status registers. */
 		data->alarms  			(i2c_smbus_read_byte_data(client,
 					   MTP008_REG_INT_STAT1) & 0xdf) |
 			(i2c_smbus_read_byte_data(client,
 					   MTP008_REG_INT_STAT2) & 0x0f) << 8;
 
-		/*
-		 * Read the beep control registers.
-		 */
+		/* Read the beep control registers. */
 		data->beeps  			(i2c_smbus_read_byte_data(client,
 					   MTP008_REG_BEEP_CTRL1) & 0xdf) |
 			(i2c_smbus_read_byte_data(client,
 					   MTP008_REG_BEEP_CTRL2) & 0x8f) << 8;
 
-		/*
-		 * Read the sensor configuration.
-		 */
+		/* Read the sensor configuration. */
 		inp = i2c_smbus_read_byte_data(client, MTP008_REG_PIN_CTRL2);
 		mtp008_getsensortype(data, inp);
 		data->pwmenable = inp;
 
-		/*
-		 * Read the PWM registers if enabled.
-		 */
+		/* Deal with the configuration of sensors 2 and 3. */
+		for (i = 1; i < 3; i++)
+			if (data->sens[i] = 0) {	/* Voltage */
+				data->temp[i] = 0;
+				data->temp_max[i] = 0;
+				data->temp_min[i] = 0;
+			}
+			else {
+				data->temp[i] = data->in[i + 3];
+				data->in[i + 3] = 0;
+				data->temp_max[i] = data->in_max[i + 3];
+				data->in_max[i + 3] = 0;
+				data->temp_min[i] = data->in_min[i + 3];
+				data->in_min[i + 3] = 0;
+			}
+
+		/* Read the PWM registers if enabled. */
 		for (i = 0; i < 3; i++) {
 			if(PWMENABLE_FROM_REG(i, inp))
 				data->pwm[i] = i2c_smbus_read_byte_data(client,
@@ -975,9 +951,7 @@
 				data->pwm[i] = 255;
 		}
 
-		/*
-		 * Read the fan sensors. Skip 3 if PWM1 enabled.
-		 */
+		/* Read the fan sensors. Skip 3 if PWM1 enabled. */
 		for (i = 0; i < 3; i++) {
 			if (i = 2 && PWMENABLE_FROM_REG(0, inp)) {
 				data->fan[2] = 0;

-- 
mailto:xanni@xanadu.net                         Andrew Pam
http://www.xanadu.com.au/                       Chief Scientist, Xanadu
http://www.glasswings.com.au/                   Partner, Glass Wings
http://www.sericyb.com.au/                      Manager, Serious Cybernetics
