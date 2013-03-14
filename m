From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Mar 2013 00:44:18 +0000
Subject: [lm-sensors] [PATCH 3/9] hwmon: Fix CamelCase checkpatch warnings
Message-Id: <1363221864-15284-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ads7871.c                      |   42 ++---
 drivers/hwmon/asc7621.c                      |   56 +++----
 drivers/hwmon/da9052-hwmon.c                 |   14 +-
 drivers/hwmon/da9055-hwmon.c                 |    4 +-
 drivers/hwmon/it87.c                         |   24 +--
 drivers/hwmon/lm93.c                         |   38 ++---
 drivers/hwmon/ntc_thermistor.c               |  216 +++++++++++++-------------
 drivers/hwmon/via686a.c                      |   38 ++---
 include/linux/platform_data/ntc_thermistor.h |    4 +-
 9 files changed, 218 insertions(+), 218 deletions(-)

diff --git a/drivers/hwmon/ads7871.c b/drivers/hwmon/ads7871.c
index a798759..3eff73b 100644
--- a/drivers/hwmon/ads7871.c
+++ b/drivers/hwmon/ads7871.c
@@ -40,25 +40,25 @@
  * the instruction byte
  */
 /*Instruction Bit masks*/
-#define INST_MODE_bm	(1<<7)
-#define INST_READ_bm	(1<<6)
-#define INST_16BIT_bm	(1<<5)
+#define INST_MODE_BM	(1 << 7)
+#define INST_READ_BM	(1 << 6)
+#define INST_16BIT_BM	(1 << 5)
 
 /*From figure 18 in the datasheet*/
 /*bit masks for Rev/Oscillator Control Register*/
-#define MUX_CNV_bv	7
-#define MUX_CNV_bm	(1<<MUX_CNV_bv)
-#define MUX_M3_bm	(1<<3) /*M3 selects single ended*/
-#define MUX_G_bv	4 /*allows for reg = (gain << MUX_G_bv) | ...*/
+#define MUX_CNV_BV	7
+#define MUX_CNV_BM	(1 << MUX_CNV_BV)
+#define MUX_M3_BM	(1 << 3) /*M3 selects single ended*/
+#define MUX_G_BV	4 /*allows for reg = (gain << MUX_G_BV) | ...*/
 
 /*From figure 18 in the datasheet*/
 /*bit masks for Rev/Oscillator Control Register*/
-#define OSC_OSCR_bm	(1<<5)
-#define OSC_OSCE_bm	(1<<4)
-#define OSC_REFE_bm	(1<<3)
-#define OSC_BUFE_bm	(1<<2)
-#define OSC_R2V_bm	(1<<1)
-#define OSC_RBG_bm	(1<<0)
+#define OSC_OSCR_BM	(1 << 5)
+#define OSC_OSCE_BM	(1 << 4)
+#define OSC_REFE_BM	(1 << 3)
+#define OSC_BUFE_BM	(1 << 2)
+#define OSC_R2V_BM	(1 << 1)
+#define OSC_RBG_BM	(1 << 0)
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -79,7 +79,7 @@ struct ads7871_data {
 static int ads7871_read_reg8(struct spi_device *spi, int reg)
 {
 	int ret;
-	reg = reg | INST_READ_bm;
+	reg = reg | INST_READ_BM;
 	ret = spi_w8r8(spi, reg);
 	return ret;
 }
@@ -87,7 +87,7 @@ static int ads7871_read_reg8(struct spi_device *spi, int reg)
 static int ads7871_read_reg16(struct spi_device *spi, int reg)
 {
 	int ret;
-	reg = reg | INST_READ_bm | INST_16BIT_bm;
+	reg = reg | INST_READ_BM | INST_16BIT_BM;
 	ret = spi_w8r16(spi, reg);
 	return ret;
 }
@@ -111,13 +111,13 @@ static ssize_t show_voltage(struct device *dev,
 	 * TODO: add support for conversions
 	 * other than single ended with a gain of 1
 	 */
-	/*MUX_M3_bm forces single ended*/
+	/*MUX_M3_BM forces single ended*/
 	/*This is also where the gain of the PGA would be set*/
 	ads7871_write_reg8(spi, REG_GAIN_MUX,
-		(MUX_CNV_bm | MUX_M3_bm | channel));
+		(MUX_CNV_BM | MUX_M3_BM | channel));
 
 	ret = ads7871_read_reg8(spi, REG_GAIN_MUX);
-	mux_cnv = ((ret & MUX_CNV_bm)>>MUX_CNV_bv);
+	mux_cnv = ((ret & MUX_CNV_BM) >> MUX_CNV_BV);
 	/*
 	 * on 400MHz arm9 platform the conversion
 	 * is already done when we do this test
@@ -125,14 +125,14 @@ static ssize_t show_voltage(struct device *dev,
 	while ((i < 2) && mux_cnv) {
 		i++;
 		ret = ads7871_read_reg8(spi, REG_GAIN_MUX);
-		mux_cnv = ((ret & MUX_CNV_bm)>>MUX_CNV_bv);
+		mux_cnv = ((ret & MUX_CNV_BM) >> MUX_CNV_BV);
 		msleep_interruptible(1);
 	}
 
 	if (mux_cnv = 0) {
 		val = ads7871_read_reg16(spi, REG_LS_BYTE);
 		/*result in volts*10000 = (val/8192)*2.5*10000*/
-		val = ((val>>2) * 25000) / 8192;
+		val = ((val >> 2) * 25000) / 8192;
 		return sprintf(buf, "%d\n", val);
 	} else {
 		return -1;
@@ -189,7 +189,7 @@ static int ads7871_probe(struct spi_device *spi)
 	ads7871_write_reg8(spi, REG_SER_CONTROL, 0);
 	ads7871_write_reg8(spi, REG_AD_CONTROL, 0);
 
-	val = (OSC_OSCR_bm | OSC_OSCE_bm | OSC_REFE_bm | OSC_BUFE_bm);
+	val = (OSC_OSCR_BM | OSC_OSCE_BM | OSC_REFE_BM | OSC_BUFE_BM);
 	ads7871_write_reg8(spi, REG_OSC_CONTROL, val);
 	ret = ads7871_read_reg8(spi, REG_OSC_CONTROL);
 
diff --git a/drivers/hwmon/asc7621.c b/drivers/hwmon/asc7621.c
index da7f5b5..3ad9d84 100644
--- a/drivers/hwmon/asc7621.c
+++ b/drivers/hwmon/asc7621.c
@@ -159,12 +159,12 @@ static inline int write_byte(struct i2c_client *client, u8 reg, u8 data)
  * and retrieval of like parameters.
  */
 
-#define SETUP_SHOW_data_param(d, a) \
+#define SETUP_SHOW_DATA_PARAM(d, a) \
 	struct sensor_device_attribute *sda = to_sensor_dev_attr(a); \
 	struct asc7621_data *data = asc7621_update_device(d); \
 	struct asc7621_param *param = to_asc7621_param(sda)
 
-#define SETUP_STORE_data_param(d, a) \
+#define SETUP_STORE_DATA_PARAM(d, a) \
 	struct sensor_device_attribute *sda = to_sensor_dev_attr(a); \
 	struct i2c_client *client = to_i2c_client(d); \
 	struct asc7621_data *data = i2c_get_clientdata(client); \
@@ -177,7 +177,7 @@ static inline int write_byte(struct i2c_client *client, u8 reg, u8 data)
 static ssize_t show_u8(struct device *dev, struct device_attribute *attr,
 		       char *buf)
 {
-	SETUP_SHOW_data_param(dev, attr);
+	SETUP_SHOW_DATA_PARAM(dev, attr);
 
 	return sprintf(buf, "%u\n", data->reg[param->msb[0]]);
 }
@@ -185,7 +185,7 @@ static ssize_t show_u8(struct device *dev, struct device_attribute *attr,
 static ssize_t store_u8(struct device *dev, struct device_attribute *attr,
 			const char *buf, size_t count)
 {
-	SETUP_STORE_data_param(dev, attr);
+	SETUP_STORE_DATA_PARAM(dev, attr);
 	long reqval;
 
 	if (kstrtol(buf, 10, &reqval))
@@ -206,7 +206,7 @@ static ssize_t store_u8(struct device *dev, struct device_attribute *attr,
 static ssize_t show_bitmask(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	SETUP_SHOW_data_param(dev, attr);
+	SETUP_SHOW_DATA_PARAM(dev, attr);
 
 	return sprintf(buf, "%u\n",
 		       (data->reg[param->msb[0]] >> param->
@@ -217,7 +217,7 @@ static ssize_t store_bitmask(struct device *dev,
 			     struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
-	SETUP_STORE_data_param(dev, attr);
+	SETUP_STORE_DATA_PARAM(dev, attr);
 	long reqval;
 	u8 currval;
 
@@ -246,7 +246,7 @@ static ssize_t store_bitmask(struct device *dev,
 static ssize_t show_fan16(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
-	SETUP_SHOW_data_param(dev, attr);
+	SETUP_SHOW_DATA_PARAM(dev, attr);
 	u16 regval;
 
 	mutex_lock(&data->update_lock);
@@ -262,7 +262,7 @@ static ssize_t store_fan16(struct device *dev,
 			   struct device_attribute *attr, const char *buf,
 			   size_t count)
 {
-	SETUP_STORE_data_param(dev, attr);
+	SETUP_STORE_DATA_PARAM(dev, attr);
 	long reqval;
 
 	if (kstrtol(buf, 10, &reqval))
@@ -307,7 +307,7 @@ static int asc7621_in_scaling[] = {
 static ssize_t show_in10(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
-	SETUP_SHOW_data_param(dev, attr);
+	SETUP_SHOW_DATA_PARAM(dev, attr);
 	u16 regval;
 	u8 nr = sda->index;
 
@@ -325,7 +325,7 @@ static ssize_t show_in10(struct device *dev, struct device_attribute *attr,
 static ssize_t show_in8(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
-	SETUP_SHOW_data_param(dev, attr);
+	SETUP_SHOW_DATA_PARAM(dev, attr);
 	u8 nr = sda->index;
 
 	return sprintf(buf, "%u\n",
@@ -336,7 +336,7 @@ static ssize_t show_in8(struct device *dev, struct device_attribute *attr,
 static ssize_t store_in8(struct device *dev, struct device_attribute *attr,
 			 const char *buf, size_t count)
 {
-	SETUP_STORE_data_param(dev, attr);
+	SETUP_STORE_DATA_PARAM(dev, attr);
 	long reqval;
 	u8 nr = sda->index;
 
@@ -360,7 +360,7 @@ static ssize_t store_in8(struct device *dev, struct device_attribute *attr,
 static ssize_t show_temp8(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
-	SETUP_SHOW_data_param(dev, attr);
+	SETUP_SHOW_DATA_PARAM(dev, attr);
 
 	return sprintf(buf, "%d\n", ((s8) data->reg[param->msb[0]]) * 1000);
 }
@@ -369,7 +369,7 @@ static ssize_t store_temp8(struct device *dev,
 			   struct device_attribute *attr, const char *buf,
 			   size_t count)
 {
-	SETUP_STORE_data_param(dev, attr);
+	SETUP_STORE_DATA_PARAM(dev, attr);
 	long reqval;
 	s8 temp;
 
@@ -397,7 +397,7 @@ static ssize_t store_temp8(struct device *dev,
 static ssize_t show_temp10(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
-	SETUP_SHOW_data_param(dev, attr);
+	SETUP_SHOW_DATA_PARAM(dev, attr);
 	u8 msb, lsb;
 	int temp;
 
@@ -414,7 +414,7 @@ static ssize_t show_temp10(struct device *dev,
 static ssize_t show_temp62(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
-	SETUP_SHOW_data_param(dev, attr);
+	SETUP_SHOW_DATA_PARAM(dev, attr);
 	u8 regval = data->reg[param->msb[0]];
 	int temp = ((s8) (regval & 0xfc) * 1000) + ((regval & 0x03) * 250);
 
@@ -425,7 +425,7 @@ static ssize_t store_temp62(struct device *dev,
 			    struct device_attribute *attr, const char *buf,
 			    size_t count)
 {
-	SETUP_STORE_data_param(dev, attr);
+	SETUP_STORE_DATA_PARAM(dev, attr);
 	long reqval, i, f;
 	s8 temp;
 
@@ -459,7 +459,7 @@ static u32 asc7621_range_map[] = {
 static ssize_t show_ap2_temp(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	SETUP_SHOW_data_param(dev, attr);
+	SETUP_SHOW_DATA_PARAM(dev, attr);
 	long auto_point1;
 	u8 regval;
 	int temp;
@@ -479,7 +479,7 @@ static ssize_t store_ap2_temp(struct device *dev,
 			      struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
-	SETUP_STORE_data_param(dev, attr);
+	SETUP_STORE_DATA_PARAM(dev, attr);
 	long reqval, auto_point1;
 	int i;
 	u8 currval, newval = 0;
@@ -510,7 +510,7 @@ static ssize_t store_ap2_temp(struct device *dev,
 static ssize_t show_pwm_ac(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
-	SETUP_SHOW_data_param(dev, attr);
+	SETUP_SHOW_DATA_PARAM(dev, attr);
 	u8 config, altbit, regval;
 	u8 map[] = {
 		0x01, 0x02, 0x04, 0x1f, 0x00, 0x06, 0x07, 0x10,
@@ -530,7 +530,7 @@ static ssize_t store_pwm_ac(struct device *dev,
 			    struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
-	SETUP_STORE_data_param(dev, attr);
+	SETUP_STORE_DATA_PARAM(dev, attr);
 	unsigned long reqval;
 	u8 currval, config, altbit, newval;
 	u16 map[] = {
@@ -569,7 +569,7 @@ static ssize_t store_pwm_ac(struct device *dev,
 static ssize_t show_pwm_enable(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	SETUP_SHOW_data_param(dev, attr);
+	SETUP_SHOW_DATA_PARAM(dev, attr);
 	u8 config, altbit, minoff, val, newval;
 
 	mutex_lock(&data->update_lock);
@@ -599,7 +599,7 @@ static ssize_t store_pwm_enable(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
-	SETUP_STORE_data_param(dev, attr);
+	SETUP_STORE_DATA_PARAM(dev, attr);
 	long reqval;
 	u8 currval, config, altbit, newval, minoff = 255;
 
@@ -659,7 +659,7 @@ static u32 asc7621_pwm_freq_map[] = {
 static ssize_t show_pwm_freq(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	SETUP_SHOW_data_param(dev, attr);
+	SETUP_SHOW_DATA_PARAM(dev, attr);
 	u8 regval  	    (data->reg[param->msb[0]] >> param->shift[0]) & param->mask[0];
 
@@ -672,7 +672,7 @@ static ssize_t store_pwm_freq(struct device *dev,
 			      struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
-	SETUP_STORE_data_param(dev, attr);
+	SETUP_STORE_DATA_PARAM(dev, attr);
 	unsigned long reqval;
 	u8 currval, newval = 255;
 	int i;
@@ -707,7 +707,7 @@ static u32 asc7621_pwm_auto_spinup_map[] =  {
 static ssize_t show_pwm_ast(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	SETUP_SHOW_data_param(dev, attr);
+	SETUP_SHOW_DATA_PARAM(dev, attr);
 	u8 regval  	    (data->reg[param->msb[0]] >> param->shift[0]) & param->mask[0];
 
@@ -721,7 +721,7 @@ static ssize_t store_pwm_ast(struct device *dev,
 			     struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
-	SETUP_STORE_data_param(dev, attr);
+	SETUP_STORE_DATA_PARAM(dev, attr);
 	long reqval;
 	u8 currval, newval = 255;
 	u32 i;
@@ -756,7 +756,7 @@ static u32 asc7621_temp_smoothing_time_map[] = {
 static ssize_t show_temp_st(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	SETUP_SHOW_data_param(dev, attr);
+	SETUP_SHOW_DATA_PARAM(dev, attr);
 	u8 regval  	    (data->reg[param->msb[0]] >> param->shift[0]) & param->mask[0];
 	regval = clamp_val(regval, 0, 7);
@@ -768,7 +768,7 @@ static ssize_t store_temp_st(struct device *dev,
 			     struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
-	SETUP_STORE_data_param(dev, attr);
+	SETUP_STORE_DATA_PARAM(dev, attr);
 	long reqval;
 	u8 currval, newval = 255;
 	u32 i;
diff --git a/drivers/hwmon/da9052-hwmon.c b/drivers/hwmon/da9052-hwmon.c
index ab4452c..960fac3 100644
--- a/drivers/hwmon/da9052-hwmon.c
+++ b/drivers/hwmon/da9052-hwmon.c
@@ -43,19 +43,19 @@ static const char * const input_names[] = {
 };
 
 /* Conversion function for VDDOUT and VBAT */
-static inline int volt_reg_to_mV(int value)
+static inline int volt_reg_to_mv(int value)
 {
 	return DIV_ROUND_CLOSEST(value * 1000, 512) + 2500;
 }
 
 /* Conversion function for ADC channels 4, 5 and 6 */
-static inline int input_reg_to_mV(int value)
+static inline int input_reg_to_mv(int value)
 {
 	return DIV_ROUND_CLOSEST(value * 2500, 1023);
 }
 
 /* Conversion function for VBBAT */
-static inline int vbbat_reg_to_mV(int value)
+static inline int vbbat_reg_to_mv(int value)
 {
 	return DIV_ROUND_CLOSEST(value * 2500, 512);
 }
@@ -96,7 +96,7 @@ static ssize_t da9052_read_vddout(struct device *dev,
 		goto hwmon_err;
 
 	mutex_unlock(&hwmon->hwmon_lock);
-	return sprintf(buf, "%d\n", volt_reg_to_mV(vdd));
+	return sprintf(buf, "%d\n", volt_reg_to_mv(vdd));
 
 hwmon_err_release:
 	da9052_disable_vddout_channel(hwmon->da9052);
@@ -137,7 +137,7 @@ static ssize_t da9052_read_vbat(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%d\n", volt_reg_to_mV(ret));
+	return sprintf(buf, "%d\n", volt_reg_to_mv(ret));
 }
 
 static ssize_t da9052_read_misc_channel(struct device *dev,
@@ -152,7 +152,7 @@ static ssize_t da9052_read_misc_channel(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%d\n", input_reg_to_mV(ret));
+	return sprintf(buf, "%d\n", input_reg_to_mv(ret));
 }
 
 static ssize_t da9052_read_tjunc(struct device *dev,
@@ -187,7 +187,7 @@ static ssize_t da9052_read_vbbat(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%d\n", vbbat_reg_to_mV(ret));
+	return sprintf(buf, "%d\n", vbbat_reg_to_mv(ret));
 }
 
 static ssize_t da9052_hwmon_show_name(struct device *dev,
diff --git a/drivers/hwmon/da9055-hwmon.c b/drivers/hwmon/da9055-hwmon.c
index 9465c05..029ecab 100644
--- a/drivers/hwmon/da9055-hwmon.c
+++ b/drivers/hwmon/da9055-hwmon.c
@@ -119,7 +119,7 @@ static irqreturn_t da9055_auxadc_irq(int irq, void *irq_data)
 }
 
 /* Conversion function for VSYS and ADCINx */
-static inline int volt_reg_to_mV(int value, int channel)
+static inline int volt_reg_to_mv(int value, int channel)
 {
 	if (channel = DA9055_ADC_VSYS)
 		return DIV_ROUND_CLOSEST(value * 1000, DA9055_VSYS_DIV) + 2500;
@@ -168,7 +168,7 @@ static ssize_t da9055_read_auto_ch(struct device *dev,
 
 	mutex_unlock(&hwmon->hwmon_lock);
 
-	return sprintf(buf, "%d\n", volt_reg_to_mV(adc, channel));
+	return sprintf(buf, "%d\n", volt_reg_to_mv(adc, channel));
 
 hwmon_err_release:
 	da9055_disable_auto_mode(hwmon->da9055, channel);
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 37fc980..72b21d5 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -1778,7 +1778,7 @@ static int __init it87_find(unsigned short *address,
 		superio_select(5);
 		sio_data->beep_pin = superio_inb(IT87_SIO_BEEP_PIN_REG) & 0x3f;
 	} else if (sio_data->type = it8783) {
-		int reg25, reg27, reg2A, reg2C, regEF;
+		int reg25, reg27, reg2a, reg2c, regef;
 
 		sio_data->skip_vid = 1;	/* No VID */
 
@@ -1786,15 +1786,15 @@ static int __init it87_find(unsigned short *address,
 
 		reg25 = superio_inb(IT87_SIO_GPIO1_REG);
 		reg27 = superio_inb(IT87_SIO_GPIO3_REG);
-		reg2A = superio_inb(IT87_SIO_PINX1_REG);
-		reg2C = superio_inb(IT87_SIO_PINX2_REG);
-		regEF = superio_inb(IT87_SIO_SPI_REG);
+		reg2a = superio_inb(IT87_SIO_PINX1_REG);
+		reg2c = superio_inb(IT87_SIO_PINX2_REG);
+		regef = superio_inb(IT87_SIO_SPI_REG);
 
 		/* Check if fan3 is there or not */
-		if ((reg27 & (1 << 0)) || !(reg2C & (1 << 2)))
+		if ((reg27 & (1 << 0)) || !(reg2c & (1 << 2)))
 			sio_data->skip_fan |= (1 << 2);
 		if ((reg25 & (1 << 4))
-		    || (!(reg2A & (1 << 1)) && (regEF & (1 << 0))))
+		    || (!(reg2a & (1 << 1)) && (regef & (1 << 0))))
 			sio_data->skip_pwm |= (1 << 2);
 
 		/* Check if fan2 is there or not */
@@ -1804,7 +1804,7 @@ static int __init it87_find(unsigned short *address,
 			sio_data->skip_pwm |= (1 << 1);
 
 		/* VIN5 */
-		if ((reg27 & (1 << 0)) || (reg2C & (1 << 2)))
+		if ((reg27 & (1 << 0)) || (reg2c & (1 << 2)))
 			sio_data->skip_in |= (1 << 5); /* No VIN5 */
 
 		/* VIN6 */
@@ -1829,18 +1829,18 @@ static int __init it87_find(unsigned short *address,
 			 * not the case, and ask the user to report if the
 			 * resulting voltage is sane.
 			 */
-			if (!(reg2C & (1 << 1))) {
-				reg2C |= (1 << 1);
-				superio_outb(IT87_SIO_PINX2_REG, reg2C);
+			if (!(reg2c & (1 << 1))) {
+				reg2c |= (1 << 1);
+				superio_outb(IT87_SIO_PINX2_REG, reg2c);
 				pr_notice("Routing internal VCCH5V to in7.\n");
 			}
 			pr_notice("in7 routed to internal voltage divider, with external pin disabled.\n");
 			pr_notice("Please report if it displays a reasonable voltage.\n");
 		}
 
-		if (reg2C & (1 << 0))
+		if (reg2c & (1 << 0))
 			sio_data->internal |= (1 << 0);
-		if (reg2C & (1 << 1))
+		if (reg2c & (1 << 1))
 			sio_data->internal |= (1 << 1);
 
 		sio_data->beep_pin = superio_inb(IT87_SIO_BEEP_PIN_REG) & 0x3f;
diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
index b40f34c..340382f 100644
--- a/drivers/hwmon/lm93.c
+++ b/drivers/hwmon/lm93.c
@@ -354,12 +354,12 @@ static const unsigned long lm93_vin_val_max[16] = {
 
 static unsigned LM93_IN_FROM_REG(int nr, u8 reg)
 {
-	const long uV_max = lm93_vin_val_max[nr] * 1000;
-	const long uV_min = lm93_vin_val_min[nr] * 1000;
+	const long uv_max = lm93_vin_val_max[nr] * 1000;
+	const long uv_min = lm93_vin_val_min[nr] * 1000;
 
-	const long slope = (uV_max - uV_min) /
+	const long slope = (uv_max - uv_min) /
 		(lm93_vin_reg_max[nr] - lm93_vin_reg_min[nr]);
-	const long intercept = uV_min - slope * lm93_vin_reg_min[nr];
+	const long intercept = uv_min - slope * lm93_vin_reg_min[nr];
 
 	return (slope * reg + intercept + 500) / 1000;
 }
@@ -371,20 +371,20 @@ static unsigned LM93_IN_FROM_REG(int nr, u8 reg)
 static u8 LM93_IN_TO_REG(int nr, unsigned val)
 {
 	/* range limit */
-	const long mV = clamp_val(val,
+	const long mv = clamp_val(val,
 				  lm93_vin_val_min[nr], lm93_vin_val_max[nr]);
 
 	/* try not to lose too much precision here */
-	const long uV = mV * 1000;
-	const long uV_max = lm93_vin_val_max[nr] * 1000;
-	const long uV_min = lm93_vin_val_min[nr] * 1000;
+	const long uv = mv * 1000;
+	const long uv_max = lm93_vin_val_max[nr] * 1000;
+	const long uv_min = lm93_vin_val_min[nr] * 1000;
 
 	/* convert */
-	const long slope = (uV_max - uV_min) /
+	const long slope = (uv_max - uv_min) /
 		(lm93_vin_reg_max[nr] - lm93_vin_reg_min[nr]);
-	const long intercept = uV_min - slope * lm93_vin_reg_min[nr];
+	const long intercept = uv_min - slope * lm93_vin_reg_min[nr];
 
-	u8 result = ((uV - intercept + (slope/2)) / slope);
+	u8 result = ((uv - intercept + (slope/2)) / slope);
 	result = clamp_val(result,
 			   lm93_vin_reg_min[nr], lm93_vin_reg_max[nr]);
 	return result;
@@ -393,10 +393,10 @@ static u8 LM93_IN_TO_REG(int nr, unsigned val)
 /* vid in mV, upper = 0 indicates low limit, otherwise upper limit */
 static unsigned LM93_IN_REL_FROM_REG(u8 reg, int upper, int vid)
 {
-	const long uV_offset = upper ? (((reg >> 4 & 0x0f) + 1) * 12500) :
+	const long uv_offset = upper ? (((reg >> 4 & 0x0f) + 1) * 12500) :
 				(((reg >> 0 & 0x0f) + 1) * -25000);
-	const long uV_vid = vid * 1000;
-	return (uV_vid + uV_offset + 5000) / 10000;
+	const long uv_vid = vid * 1000;
+	return (uv_vid + uv_offset + 5000) / 10000;
 }
 
 #define LM93_IN_MIN_FROM_REG(reg, vid)	LM93_IN_REL_FROM_REG((reg), 0, (vid))
@@ -409,13 +409,13 @@ static unsigned LM93_IN_REL_FROM_REG(u8 reg, int upper, int vid)
  */
 static u8 LM93_IN_REL_TO_REG(unsigned val, int upper, int vid)
 {
-	long uV_offset = vid * 1000 - val * 10000;
+	long uv_offset = vid * 1000 - val * 10000;
 	if (upper) {
-		uV_offset = clamp_val(uV_offset, 12500, 200000);
-		return (u8)((uV_offset /  12500 - 1) << 4);
+		uv_offset = clamp_val(uv_offset, 12500, 200000);
+		return (u8)((uv_offset /  12500 - 1) << 4);
 	} else {
-		uV_offset = clamp_val(uV_offset, -400000, -25000);
-		return (u8)((uV_offset / -25000 - 1) << 0);
+		uv_offset = clamp_val(uv_offset, -400000, -25000);
+		return (u8)((uv_offset / -25000 - 1) << 0);
 	}
 }
 
diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index a6997a1..f565746 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -40,7 +40,7 @@
 #include <linux/hwmon-sysfs.h>
 
 struct ntc_compensation {
-	int		temp_C;
+	int		temp_c;
 	unsigned int	ohm;
 };
 
@@ -60,76 +60,76 @@ static const struct platform_device_id ntc_thermistor_id[] = {
  * Thermistors Datasheet
  */
 static const struct ntc_compensation ncpXXwb473[] = {
-	{ .temp_C	= -40, .ohm	= 1747920 },
-	{ .temp_C	= -35, .ohm	= 1245428 },
-	{ .temp_C	= -30, .ohm	= 898485 },
-	{ .temp_C	= -25, .ohm	= 655802 },
-	{ .temp_C	= -20, .ohm	= 483954 },
-	{ .temp_C	= -15, .ohm	= 360850 },
-	{ .temp_C	= -10, .ohm	= 271697 },
-	{ .temp_C	= -5, .ohm	= 206463 },
-	{ .temp_C	= 0, .ohm	= 158214 },
-	{ .temp_C	= 5, .ohm	= 122259 },
-	{ .temp_C	= 10, .ohm	= 95227 },
-	{ .temp_C	= 15, .ohm	= 74730 },
-	{ .temp_C	= 20, .ohm	= 59065 },
-	{ .temp_C	= 25, .ohm	= 47000 },
-	{ .temp_C	= 30, .ohm	= 37643 },
-	{ .temp_C	= 35, .ohm	= 30334 },
-	{ .temp_C	= 40, .ohm	= 24591 },
-	{ .temp_C	= 45, .ohm	= 20048 },
-	{ .temp_C	= 50, .ohm	= 16433 },
-	{ .temp_C	= 55, .ohm	= 13539 },
-	{ .temp_C	= 60, .ohm	= 11209 },
-	{ .temp_C	= 65, .ohm	= 9328 },
-	{ .temp_C	= 70, .ohm	= 7798 },
-	{ .temp_C	= 75, .ohm	= 6544 },
-	{ .temp_C	= 80, .ohm	= 5518 },
-	{ .temp_C	= 85, .ohm	= 4674 },
-	{ .temp_C	= 90, .ohm	= 3972 },
-	{ .temp_C	= 95, .ohm	= 3388 },
-	{ .temp_C	= 100, .ohm	= 2902 },
-	{ .temp_C	= 105, .ohm	= 2494 },
-	{ .temp_C	= 110, .ohm	= 2150 },
-	{ .temp_C	= 115, .ohm	= 1860 },
-	{ .temp_C	= 120, .ohm	= 1615 },
-	{ .temp_C	= 125, .ohm	= 1406 },
+	{ .temp_c	= -40, .ohm	= 1747920 },
+	{ .temp_c	= -35, .ohm	= 1245428 },
+	{ .temp_c	= -30, .ohm	= 898485 },
+	{ .temp_c	= -25, .ohm	= 655802 },
+	{ .temp_c	= -20, .ohm	= 483954 },
+	{ .temp_c	= -15, .ohm	= 360850 },
+	{ .temp_c	= -10, .ohm	= 271697 },
+	{ .temp_c	= -5, .ohm	= 206463 },
+	{ .temp_c	= 0, .ohm	= 158214 },
+	{ .temp_c	= 5, .ohm	= 122259 },
+	{ .temp_c	= 10, .ohm	= 95227 },
+	{ .temp_c	= 15, .ohm	= 74730 },
+	{ .temp_c	= 20, .ohm	= 59065 },
+	{ .temp_c	= 25, .ohm	= 47000 },
+	{ .temp_c	= 30, .ohm	= 37643 },
+	{ .temp_c	= 35, .ohm	= 30334 },
+	{ .temp_c	= 40, .ohm	= 24591 },
+	{ .temp_c	= 45, .ohm	= 20048 },
+	{ .temp_c	= 50, .ohm	= 16433 },
+	{ .temp_c	= 55, .ohm	= 13539 },
+	{ .temp_c	= 60, .ohm	= 11209 },
+	{ .temp_c	= 65, .ohm	= 9328 },
+	{ .temp_c	= 70, .ohm	= 7798 },
+	{ .temp_c	= 75, .ohm	= 6544 },
+	{ .temp_c	= 80, .ohm	= 5518 },
+	{ .temp_c	= 85, .ohm	= 4674 },
+	{ .temp_c	= 90, .ohm	= 3972 },
+	{ .temp_c	= 95, .ohm	= 3388 },
+	{ .temp_c	= 100, .ohm	= 2902 },
+	{ .temp_c	= 105, .ohm	= 2494 },
+	{ .temp_c	= 110, .ohm	= 2150 },
+	{ .temp_c	= 115, .ohm	= 1860 },
+	{ .temp_c	= 120, .ohm	= 1615 },
+	{ .temp_c	= 125, .ohm	= 1406 },
 };
 static const struct ntc_compensation ncpXXwl333[] = {
-	{ .temp_C	= -40, .ohm	= 1610154 },
-	{ .temp_C	= -35, .ohm	= 1130850 },
-	{ .temp_C	= -30, .ohm	= 802609 },
-	{ .temp_C	= -25, .ohm	= 575385 },
-	{ .temp_C	= -20, .ohm	= 416464 },
-	{ .temp_C	= -15, .ohm	= 304219 },
-	{ .temp_C	= -10, .ohm	= 224193 },
-	{ .temp_C	= -5, .ohm	= 166623 },
-	{ .temp_C	= 0, .ohm	= 124850 },
-	{ .temp_C	= 5, .ohm	= 94287 },
-	{ .temp_C	= 10, .ohm	= 71747 },
-	{ .temp_C	= 15, .ohm	= 54996 },
-	{ .temp_C	= 20, .ohm	= 42455 },
-	{ .temp_C	= 25, .ohm	= 33000 },
-	{ .temp_C	= 30, .ohm	= 25822 },
-	{ .temp_C	= 35, .ohm	= 20335 },
-	{ .temp_C	= 40, .ohm	= 16115 },
-	{ .temp_C	= 45, .ohm	= 12849 },
-	{ .temp_C	= 50, .ohm	= 10306 },
-	{ .temp_C	= 55, .ohm	= 8314 },
-	{ .temp_C	= 60, .ohm	= 6746 },
-	{ .temp_C	= 65, .ohm	= 5503 },
-	{ .temp_C	= 70, .ohm	= 4513 },
-	{ .temp_C	= 75, .ohm	= 3721 },
-	{ .temp_C	= 80, .ohm	= 3084 },
-	{ .temp_C	= 85, .ohm	= 2569 },
-	{ .temp_C	= 90, .ohm	= 2151 },
-	{ .temp_C	= 95, .ohm	= 1809 },
-	{ .temp_C	= 100, .ohm	= 1529 },
-	{ .temp_C	= 105, .ohm	= 1299 },
-	{ .temp_C	= 110, .ohm	= 1108 },
-	{ .temp_C	= 115, .ohm	= 949 },
-	{ .temp_C	= 120, .ohm	= 817 },
-	{ .temp_C	= 125, .ohm	= 707 },
+	{ .temp_c	= -40, .ohm	= 1610154 },
+	{ .temp_c	= -35, .ohm	= 1130850 },
+	{ .temp_c	= -30, .ohm	= 802609 },
+	{ .temp_c	= -25, .ohm	= 575385 },
+	{ .temp_c	= -20, .ohm	= 416464 },
+	{ .temp_c	= -15, .ohm	= 304219 },
+	{ .temp_c	= -10, .ohm	= 224193 },
+	{ .temp_c	= -5, .ohm	= 166623 },
+	{ .temp_c	= 0, .ohm	= 124850 },
+	{ .temp_c	= 5, .ohm	= 94287 },
+	{ .temp_c	= 10, .ohm	= 71747 },
+	{ .temp_c	= 15, .ohm	= 54996 },
+	{ .temp_c	= 20, .ohm	= 42455 },
+	{ .temp_c	= 25, .ohm	= 33000 },
+	{ .temp_c	= 30, .ohm	= 25822 },
+	{ .temp_c	= 35, .ohm	= 20335 },
+	{ .temp_c	= 40, .ohm	= 16115 },
+	{ .temp_c	= 45, .ohm	= 12849 },
+	{ .temp_c	= 50, .ohm	= 10306 },
+	{ .temp_c	= 55, .ohm	= 8314 },
+	{ .temp_c	= 60, .ohm	= 6746 },
+	{ .temp_c	= 65, .ohm	= 5503 },
+	{ .temp_c	= 70, .ohm	= 4513 },
+	{ .temp_c	= 75, .ohm	= 3721 },
+	{ .temp_c	= 80, .ohm	= 3084 },
+	{ .temp_c	= 85, .ohm	= 2569 },
+	{ .temp_c	= 90, .ohm	= 2151 },
+	{ .temp_c	= 95, .ohm	= 1809 },
+	{ .temp_c	= 100, .ohm	= 1529 },
+	{ .temp_c	= 105, .ohm	= 1299 },
+	{ .temp_c	= 110, .ohm	= 1108 },
+	{ .temp_c	= 115, .ohm	= 949 },
+	{ .temp_c	= 120, .ohm	= 817 },
+	{ .temp_c	= 125, .ohm	= 707 },
 };
 
 struct ntc_data {
@@ -155,7 +155,7 @@ static int ntc_adc_iio_read(struct ntc_thermistor_platform_data *pdata)
 	}
 
 	/* unit: mV */
-	result = pdata->pullup_uV * val;
+	result = pdata->pullup_uv * val;
 	result >>= 12;
 
 	return result;
@@ -194,7 +194,7 @@ ntc_thermistor_parse_dt(struct platform_device *pdev)
 	if (IS_ERR(chan))
 		return ERR_PTR(PTR_ERR(chan));
 
-	if (of_property_read_u32(np, "pullup-uv", &pdata->pullup_uV))
+	if (of_property_read_u32(np, "pullup-uv", &pdata->pullup_uv))
 		return ERR_PTR(-ENODEV);
 	if (of_property_read_u32(np, "pullup-ohm", &pdata->pullup_ohm))
 		return ERR_PTR(-ENODEV);
@@ -207,7 +207,7 @@ ntc_thermistor_parse_dt(struct platform_device *pdev)
 		pdata->connect = NTC_CONNECTED_GROUND;
 
 	pdata->chan = chan;
-	pdata->read_uV = ntc_adc_iio_read;
+	pdata->read_uv = ntc_adc_iio_read;
 
 	return pdata;
 }
@@ -236,37 +236,37 @@ static inline u64 div64_u64_safe(u64 dividend, u64 divisor)
 	return div64_u64(dividend, divisor);
 }
 
-static int get_ohm_of_thermistor(struct ntc_data *data, unsigned int uV)
+static int get_ohm_of_thermistor(struct ntc_data *data, unsigned int uv)
 {
 	struct ntc_thermistor_platform_data *pdata = data->pdata;
-	u64 mV = uV / 1000;
-	u64 pmV = pdata->pullup_uV / 1000;
-	u64 N, puO, pdO;
-	puO = pdata->pullup_ohm;
-	pdO = pdata->pulldown_ohm;
+	u64 mv = uv / 1000;
+	u64 pmv = pdata->pullup_uv / 1000;
+	u64 n, puo, pdo;
+	puo = pdata->pullup_ohm;
+	pdo = pdata->pulldown_ohm;
 
-	if (mV = 0) {
+	if (mv = 0) {
 		if (pdata->connect = NTC_CONNECTED_POSITIVE)
 			return INT_MAX;
 		return 0;
 	}
-	if (mV >= pmV)
+	if (mv >= pmv)
 		return (pdata->connect = NTC_CONNECTED_POSITIVE) ?
 			0 : INT_MAX;
 
-	if (pdata->connect = NTC_CONNECTED_POSITIVE && puO = 0)
-		N = div64_u64_safe(pdO * (pmV - mV), mV);
-	else if (pdata->connect = NTC_CONNECTED_GROUND && pdO = 0)
-		N = div64_u64_safe(puO * mV, pmV - mV);
+	if (pdata->connect = NTC_CONNECTED_POSITIVE && puo = 0)
+		n = div64_u64_safe(pdo * (pmv - mv), mv);
+	else if (pdata->connect = NTC_CONNECTED_GROUND && pdo = 0)
+		n = div64_u64_safe(puo * mv, pmv - mv);
 	else if (pdata->connect = NTC_CONNECTED_POSITIVE)
-		N = div64_u64_safe(pdO * puO * (pmV - mV),
-				puO * mV - pdO * (pmV - mV));
+		n = div64_u64_safe(pdo * puo * (pmv - mv),
+				puo * mv - pdo * (pmv - mv));
 	else
-		N = div64_u64_safe(pdO * puO * mV, pdO * (pmV - mV) - puO * mV);
+		n = div64_u64_safe(pdo * puo * mv, pdo * (pmv - mv) - puo * mv);
 
-	if (N > INT_MAX)
-		N = INT_MAX;
-	return N;
+	if (n > INT_MAX)
+		n = INT_MAX;
+	return n;
 }
 
 static void lookup_comp(struct ntc_data *data, unsigned int ohm,
@@ -335,7 +335,7 @@ static void lookup_comp(struct ntc_data *data, unsigned int ohm,
 		*i_high = end - 1;
 }
 
-static int get_temp_mC(struct ntc_data *data, unsigned int ohm)
+static int get_temp_mc(struct ntc_data *data, unsigned int ohm)
 {
 	int low, high;
 	int temp;
@@ -343,10 +343,10 @@ static int get_temp_mC(struct ntc_data *data, unsigned int ohm)
 	lookup_comp(data, ohm, &low, &high);
 	if (low = high) {
 		/* Unable to use linear approximation */
-		temp = data->comp[low].temp_C * 1000;
+		temp = data->comp[low].temp_c * 1000;
 	} else {
-		temp = data->comp[low].temp_C * 1000 +
-			((data->comp[high].temp_C - data->comp[low].temp_C) *
+		temp = data->comp[low].temp_c * 1000 +
+			((data->comp[high].temp_c - data->comp[low].temp_c) *
 			 1000 * ((int)ohm - (int)data->comp[low].ohm)) /
 			((int)data->comp[high].ohm - (int)data->comp[low].ohm);
 	}
@@ -355,16 +355,16 @@ static int get_temp_mC(struct ntc_data *data, unsigned int ohm)
 
 static int ntc_thermistor_get_ohm(struct ntc_data *data)
 {
-	int read_uV;
+	int read_uv;
 
 	if (data->pdata->read_ohm)
 		return data->pdata->read_ohm();
 
-	if (data->pdata->read_uV) {
-		read_uV = data->pdata->read_uV(data->pdata);
-		if (read_uV < 0)
-			return read_uV;
-		return get_ohm_of_thermistor(data, read_uV);
+	if (data->pdata->read_uv) {
+		read_uv = data->pdata->read_uv(data->pdata);
+		if (read_uv < 0)
+			return read_uv;
+		return get_ohm_of_thermistor(data, read_uv);
 	}
 	return -EINVAL;
 }
@@ -393,7 +393,7 @@ static ssize_t ntc_show_temp(struct device *dev,
 	if (ohm < 0)
 		return ohm;
 
-	return sprintf(buf, "%d\n", get_temp_mC(data, ohm));
+	return sprintf(buf, "%d\n", get_temp_mc(data, ohm));
 }
 
 static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGO, ntc_show_type, NULL, 0);
@@ -432,19 +432,19 @@ static int ntc_thermistor_probe(struct platform_device *pdev)
 	}
 
 	/* Either one of the two is required. */
-	if (!pdata->read_uV && !pdata->read_ohm) {
+	if (!pdata->read_uv && !pdata->read_ohm) {
 		dev_err(&pdev->dev,
-			"Both read_uV and read_ohm missing. Need either one of the two.\n");
+			"Both read_uv and read_ohm missing. Need either one of the two.\n");
 		return -EINVAL;
 	}
 
-	if (pdata->read_uV && pdata->read_ohm) {
+	if (pdata->read_uv && pdata->read_ohm) {
 		dev_warn(&pdev->dev,
-			 "Only one of read_uV and read_ohm is needed; ignoring read_uV.\n");
-		pdata->read_uV = NULL;
+			 "Only one of read_uv and read_ohm is needed; ignoring read_uv.\n");
+		pdata->read_uv = NULL;
 	}
 
-	if (pdata->read_uV && (pdata->pullup_uV = 0 ||
+	if (pdata->read_uv && (pdata->pullup_uv = 0 ||
 				(pdata->pullup_ohm = 0 && pdata->connect =
 				 NTC_CONNECTED_GROUND) ||
 				(pdata->pulldown_ohm = 0 && pdata->connect =
@@ -452,7 +452,7 @@ static int ntc_thermistor_probe(struct platform_device *pdev)
 				(pdata->connect != NTC_CONNECTED_POSITIVE &&
 				 pdata->connect != NTC_CONNECTED_GROUND))) {
 		dev_err(&pdev->dev,
-			"Required data to use read_uV not supplied.\n");
+			"Required data to use read_uv not supplied.\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
index 3123b30..9427e95 100644
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -125,7 +125,7 @@ static const u8 VIA686A_REG_TEMP_HYST[]	= { 0x3a, 0x3e, 0x1e };
  * (These conversions were contributed by Jonathan Teh Soon Yew
  * <j.teh@iname.com>)
  */
-static inline u8 IN_TO_REG(long val, int inNum)
+static inline u8 IN_TO_REG(long val, int in_num)
 {
 	/*
 	 * To avoid floating point, we multiply constants by 10 (100 for +12V).
@@ -134,29 +134,29 @@ static inline u8 IN_TO_REG(long val, int inNum)
 	 * by an additional 10000 (100000 for +12V): 1000 for val and 10 (100)
 	 * for the constants.
 	 */
-	if (inNum <= 1)
+	if (in_num <= 1)
 		return (u8) clamp_val((val * 21024 - 1205000) / 250000, 0, 255);
-	else if (inNum = 2)
+	else if (in_num = 2)
 		return (u8) clamp_val((val * 15737 - 1205000) / 250000, 0, 255);
-	else if (inNum = 3)
+	else if (in_num = 3)
 		return (u8) clamp_val((val * 10108 - 1205000) / 250000, 0, 255);
 	else
 		return (u8) clamp_val((val * 41714 - 12050000) / 2500000, 0,
 				      255);
 }
 
-static inline long IN_FROM_REG(u8 val, int inNum)
+static inline long IN_FROM_REG(u8 val, int in_num)
 {
 	/*
 	 * To avoid floating point, we multiply constants by 10 (100 for +12V).
 	 * We also multiply them by 1000 because we want 0.001V/bit for the
 	 * output value. Rounding is done.
 	 */
-	if (inNum <= 1)
+	if (in_num <= 1)
 		return (long) ((250000 * val + 1330000 + 21024 / 2) / 21024);
-	else if (inNum = 2)
+	else if (in_num = 2)
 		return (long) ((250000 * val + 1330000 + 15737 / 2) / 15737);
-	else if (inNum = 3)
+	else if (in_num = 3)
 		return (long) ((250000 * val + 1330000 + 10108 / 2) / 10108);
 	else
 		return (long) ((2500000 * val + 13300000 + 41714 / 2) / 41714);
@@ -210,10 +210,10 @@ static inline u8 FAN_TO_REG(long rpm, int div)
  * VIA register values 0-255.  I *10 before rounding, so we get tenth-degree
  * precision.  (I could have done all 1024 values for our 10-bit readings,
  * but the function is very linear in the useful range (0-80 deg C), so
- * we'll just use linear interpolation for 10-bit readings.)  So, tempLUT
+ * we'll just use linear interpolation for 10-bit readings.)  So, temp_lut
  * is the temp at via register values 0-255:
  */
-static const s16 tempLUT[] = {
+static const s16 temp_lut[] = {
 	-709, -688, -667, -646, -627, -607, -589, -570, -553, -536, -519,
 	-503, -487, -471, -456, -442, -428, -414, -400, -387, -375,
 	-362, -350, -339, -327, -316, -305, -295, -285, -275, -265,
@@ -261,7 +261,7 @@ static const s16 tempLUT[] = {
  * - 2.525453e-04*val^3 + 1.424593e-02*val^2 + 2.148941e+00*val +7.275808e+01)
  * Note that n1:
  */
-static const u8 viaLUT[] = {
+static const u8 via_lut[] = {
 	12, 12, 13, 14, 14, 15, 16, 16, 17, 18, 18, 19, 20, 20, 21, 22, 23,
 	23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 35, 36, 37, 39, 40,
 	41, 43, 45, 46, 48, 49, 51, 53, 55, 57, 59, 60, 62, 64, 66,
@@ -284,26 +284,26 @@ static const u8 viaLUT[] = {
  */
 static inline u8 TEMP_TO_REG(long val)
 {
-	return viaLUT[val <= -50000 ? 0 : val >= 110000 ? 160 :
+	return via_lut[val <= -50000 ? 0 : val >= 110000 ? 160 :
 		      (val < 0 ? val - 500 : val + 500) / 1000 + 50];
 }
 
 /* for 8-bit temperature hyst and over registers */
-#define TEMP_FROM_REG(val)	((long)tempLUT[val] * 100)
+#define TEMP_FROM_REG(val)	((long)temp_lut[val] * 100)
 
 /* for 10-bit temperature readings */
 static inline long TEMP_FROM_REG10(u16 val)
 {
-	u16 eightBits = val >> 2;
-	u16 twoBits = val & 3;
+	u16 eight_bits = val >> 2;
+	u16 two_bits = val & 3;
 
 	/* no interpolation for these */
-	if (twoBits = 0 || eightBits = 255)
-		return TEMP_FROM_REG(eightBits);
+	if (two_bits = 0 || eight_bits = 255)
+		return TEMP_FROM_REG(eight_bits);
 
 	/* do some linear interpolation */
-	return (tempLUT[eightBits] * (4 - twoBits) +
-		tempLUT[eightBits + 1] * twoBits) * 25;
+	return (temp_lut[eight_bits] * (4 - two_bits) +
+		temp_lut[eight_bits + 1] * two_bits) * 25;
 }
 
 #define DIV_FROM_REG(val) (1 << (val))
diff --git a/include/linux/platform_data/ntc_thermistor.h b/include/linux/platform_data/ntc_thermistor.h
index fa95f9c..c7285b5 100644
--- a/include/linux/platform_data/ntc_thermistor.h
+++ b/include/linux/platform_data/ntc_thermistor.h
@@ -45,8 +45,8 @@ struct ntc_thermistor_platform_data {
 	 * chan: iio_channel pointer to communicate with the ADC which the
 	 * thermistor is using for conversion of the analog values.
 	 */
-	int (*read_uV)(struct ntc_thermistor_platform_data *);
-	unsigned int pullup_uV;
+	int (*read_uv)(struct ntc_thermistor_platform_data *);
+	unsigned int pullup_uv;
 
 	unsigned int pullup_ohm;
 	unsigned int pulldown_ohm;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
