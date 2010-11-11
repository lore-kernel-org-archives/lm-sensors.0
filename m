From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 11 Nov 2010 15:49:23 +0000
Subject: [lm-sensors] [PATCH 2/2] intel_mid_thermal: clean up
Message-Id: <20101111154919.12776.42338.stgit@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Polish and tidy
- Use pr_fmt
- Printing prune
- Tidy comments/spelling
- Handle errors registering with the thermal zone
- Propogate errors back from conversion more cleanly
- Remove name based hack in identifying direct channel

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/hwmon/intel_mid_thermal.c |  255 ++++++++++++++++++++-----------------
 1 files changed, 140 insertions(+), 115 deletions(-)


diff --git a/drivers/hwmon/intel_mid_thermal.c b/drivers/hwmon/intel_mid_thermal.c
index da9da1d..eae58b2 100644
--- a/drivers/hwmon/intel_mid_thermal.c
+++ b/drivers/hwmon/intel_mid_thermal.c
@@ -23,6 +23,8 @@
  * Author: Durgadoss <durgadoss.r@intel.com>
  */
 
+#define pr_fmt(fmt)  "intel_mid_thermal: " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/err.h>
@@ -35,14 +37,8 @@
 
 #include <asm/intel_scu_ipc.h>
 
-MODULE_AUTHOR("Durgadoss <durgadoss.r@intel.com>");
-MODULE_DESCRIPTION("Intel Medfield Platform Thermal Driver");
-MODULE_LICENSE("GPL");
-
-#define DRIVER_NAME "msic_sensor"
-#define PREFIX "intel_mid_thermal:"
 
-/*No of Thermal sensors */
+/* Number of thermal sensors */
 #define MSIC_THERMAL_SENSORS	4
 
 /* ADC1 - thermal registers */
@@ -57,17 +53,17 @@ MODULE_LICENSE("GPL");
 
 #define MSIC_STOPBIT_MASK	16
 #define MSIC_ADCTHERM_MASK	4
-#define ADC_CHANLS_MAX		15 /*no of adc channels*/
+#define ADC_CHANLS_MAX		15 /* Number of ADC channels */
 #define ADC_LOOP_MAX		(ADC_CHANLS_MAX - MSIC_THERMAL_SENSORS)
 
 #define MSIC_VAUDA		0x0DB
 #define MSIC_VAUDA_VAL		0xFF
 
-/* adc channel code values */
-#define SKIN_SENSOR0_CODE		0x08
-#define SKIN_SENSOR1_CODE		0x09
-#define SYS_SENSOR_CODE			0x0A
-#define MSIC_DIE_SENSOR_CODE		0x03
+/* ADC channel code values */
+#define SKIN_SENSOR0_CODE	0x08
+#define SKIN_SENSOR1_CODE	0x09
+#define SYS_SENSOR_CODE		0x0A
+#define MSIC_DIE_SENSOR_CODE	0x03
 
 #define SKIN_THERM_SENSOR0	0
 #define SKIN_THERM_SENSOR1	1
@@ -75,22 +71,22 @@ MODULE_LICENSE("GPL");
 #define MSIC_DIE_THERM_SENSOR3	3
 
 /* ADC code range */
-#define ADC_MAX		977
-#define ADC_MIN		162
-#define ADC_VAL1	887
-#define ADC_VAL2	720
-#define ADC_VAL3	508
-#define ADC_VAL4	315
+#define ADC_MAX			977
+#define ADC_MIN			162
+#define ADC_VAL1		887
+#define ADC_VAL2		720
+#define ADC_VAL3		508
+#define ADC_VAL4		315
 
 /* ADC base addresses */
 #define ADC_CHNL_START_ADDR	0x1C5	/* increments by 1 */
 #define ADC_DATA_START_ADDR     0x1D4   /* increments by 2 */
 
-/*MSIC die attributes*/
-#define MSIC_DIE_ADC_MIN		488
-#define MSIC_DIE_ADC_MAX		1004
+/* MSIC die attributes */
+#define MSIC_DIE_ADC_MIN	488
+#define MSIC_DIE_ADC_MAX	1004
 
-/*convert adc_val to die temperature */
+/* convert adc_val to die temperature */
 #define TO_MSIC_DIE_TEMP(adc_val)	((368 * (adc_val) / 1000) - 220)
 
 static int channel_index;
@@ -102,22 +98,17 @@ struct platform_info {
 
 struct thermal_device_info {
 	unsigned int chnl_addr;
+	int direct;
 	long curr_temp;
 };
 
-static int read_curr_temp(struct thermal_zone_device *, unsigned long *);
 
-struct thermal_zone_device_ops tzd_ops = {
-	.get_temp = read_curr_temp,
-};
-
-static char *name[MSIC_THERMAL_SENSORS] = {"skin0", "skin1",
-					"sys", "msicdie"};
 /**
  * is_valid_adc - checks whether the adc code is within the defined range
  * @min: minimum value for the sensor
  * @max: maximum value for the sensor
- * context: can sleep
+ *
+ * Can sleep
  */
 static int is_valid_adc(uint16_t adc_val, uint16_t min, uint16_t max)
 {
@@ -126,7 +117,9 @@ static int is_valid_adc(uint16_t adc_val, uint16_t min, uint16_t max)
 
 /**
  * adc_to_temp - converts the ADC code to temperature in C
- * @adc_val: the adc_val needs to be converted
+ * @direct: true if ths channel is direct index
+ * @adc_val: the adc_val that needs to be converted
+ * @tp: temperature return value
  *
  * Linear approximation is used to covert the skin adc value into temperature.
  * This technique is used to avoid very long look-up table to get
@@ -135,22 +128,23 @@ static int is_valid_adc(uint16_t adc_val, uint16_t min, uint16_t max)
  * to achieve very close approximate temp value with less than
  * 0.5C error
  */
-static int adc_to_temp(char *type, uint16_t adc_val)
+static int adc_to_temp(int direct, uint16_t adc_val, unsigned long *tp)
 {
 	int temp;
 
-	/* direct conversion for die temperature*/
-	if (!strcmp(type, name[MSIC_DIE_THERM_SENSOR3])) {
-		if (is_valid_adc(adc_val, MSIC_DIE_ADC_MIN, MSIC_DIE_ADC_MAX))
-			return  (int)(TO_MSIC_DIE_TEMP(adc_val) * 1000);
-		else
-			return -ERANGE;
+	/* Direct conversion for die temperature */
+	if (direct) {
+		if (is_valid_adc(adc_val, MSIC_DIE_ADC_MIN, MSIC_DIE_ADC_MAX)) {
+			*tp = (int)(TO_MSIC_DIE_TEMP(adc_val) * 1000);
+			return 0;
+		}
+		return -ERANGE;
 	}
 
 	if (!is_valid_adc(adc_val, ADC_MIN, ADC_MAX))
 		return -ERANGE;
 
-	/* linear approximation for skin temperature*/
+	/* Linear approximation for skin temperature */
 	if (adc_val > ADC_VAL1) /* -20 to 0C */
 		temp = 177 - (adc_val/5);
 	else if ((adc_val <= ADC_VAL1) && (adc_val > ADC_VAL2)) /* 0C to 20C */
@@ -162,73 +156,72 @@ static int adc_to_temp(char *type, uint16_t adc_val)
 	else
 		temp = 112 - (adc_val/6); /* 60C to 85C */
 
-	/*convert tempertaure in celsius to milli degree celsius*/
-	return temp * 1000;
+	/* Convert temperature in celsius to milli degree celsius */
+	*tp = temp * 1000;
+	return 0;
 }
 
 /**
  * mid_read_temp - read sensors for temperature
  * @temp: holds the current temperature for the sensor after reading
- * Context: can sleep
  *
  * reads the adc_code from the channel and converts it to real
  * temperature. The converted value is stored in temp.
+ *
+ * Can sleep
  */
 static int mid_read_temp(struct thermal_zone_device *tzd, unsigned long *temp)
 {
+	struct thermal_device_info *td_info = tzd->devdata;
 	uint16_t adc_val, addr;
 	uint8_t data = 0;
 	int ret;
 	unsigned long curr_temp;
 
-	struct thermal_device_info *td_info -				(struct thermal_device_info *)tzd->devdata;
 
 	addr = td_info->chnl_addr;
 
-	/* enable the msic for conversion before reading */
+	/* Enable the msic for conversion before reading */
 	ret = intel_scu_ipc_iowrite8(MSIC_THERM_ADC1CNTL3, MSIC_ADCRRDATA_ENBL);
 	if (ret)
 		return ret;
 
-	/* re-toggle the RRDATARD bit
-	 * temporary workaround */
+	/* Re-toggle the RRDATARD bit (temporary workaround) */
 	ret = intel_scu_ipc_iowrite8(MSIC_THERM_ADC1CNTL3, MSIC_ADCTHERM_ENBL);
 	if (ret)
 		return ret;
 
-	/* reading the higher bits of data */
+	/* Read the higher bits of data */
 	ret = intel_scu_ipc_ioread8(addr, &data);
 	if (ret)
 		return ret;
 
-	/* shifting bits to accomodate the lower two data bits */
+	/* Shift bits to accomodate the lower two data bits */
 	adc_val = (data << 2);
 	addr++;
 
-	ret = intel_scu_ipc_ioread8(addr, &data);/* reading lower bits */
+	ret = intel_scu_ipc_ioread8(addr, &data);/* Read lower bits */
 	if (ret)
 		return ret;
 
-	/*adding lower two bits to the higher bits*/
+	/* Adding lower two bits to the higher bits */
 	data &= 03;
 	adc_val += data;
 
-	/*convert adc value to temperature*/
-	curr_temp = adc_to_temp(tzd->type, adc_val);
-	if (curr_temp = -ERANGE)
-		return -ERANGE;
-
-	*temp = td_info->curr_temp = curr_temp;
-	return 0;
+	/* Convert ADC value to temperature */
+	ret = adc_to_temp(td_info->direct, adc_val, &curr_temp);
+	if (ret = 0)
+		*temp = td_info->curr_temp = curr_temp;
+	return ret;
 }
 
 /**
- * configure_adc - enables/disables adc for conversion
- * @val: zero: disables the adc non-zero:enables the adc
- * Context: can sleep
+ * configure_adc - enables/disables the ADC for conversion
+ * @val: zero: disables the adc non-zero:enables the ADC
+ *
+ * Enable/Disable the ADC depending on the argument
  *
- * Enable/Disable the adc depending on the argument
+ * Can sleep
  */
 static int configure_adc(int val)
 {
@@ -240,28 +233,28 @@ static int configure_adc(int val)
 		return ret;
 
 	if (val)
-		/* enable and start the adc */
+		/* Enable and start the adc */
 		data |= (MSIC_ADC_ENBL | MSIC_ADC_START);
 	else
-		/* just stop the adc */
+		/* Just stop the adc */
 		data &= (~MSIC_ADC_START);
 
-	ret = intel_scu_ipc_iowrite8(MSIC_THERM_ADC1CNTL1, data);
-	return ret;
+	return intel_scu_ipc_iowrite8(MSIC_THERM_ADC1CNTL1, data);
 }
 
 /**
  * set_up_therm_chnl - enable thermal channel for conversion
- * @base_addr: index of free msic adc channel
- * Context: can sleep
+ * @base_addr: index of free msic ADC channel
  *
  * Enable all the three channels for conversion
+ *
+ * Can sleep
  */
 static int set_up_therm_chnl(u16 base_addr)
 {
 	int ret;
 
-	/* enabling all the sensor channels */
+	/* Enable all the sensor channels */
 	ret = intel_scu_ipc_iowrite8(base_addr, SKIN_SENSOR0_CODE);
 	if (ret)
 		return ret;
@@ -274,19 +267,19 @@ static int set_up_therm_chnl(u16 base_addr)
 	if (ret)
 		return ret;
 
-	/*since this is the last channel, set the stop bit
-	to 1 by ORing the DIE_SENSOR_CODE with 0x10*/
+	/* Since this is the last channel, set the stop bit
+	   to 1 by ORing the DIE_SENSOR_CODE with 0x10 */
 	ret = intel_scu_ipc_iowrite8(base_addr + 3,
 					(MSIC_DIE_SENSOR_CODE | 0x10));
 	if (ret)
 		return ret;
 
-	/* enable VAUDA line: temporary workaround for MSIC issue */
+	/* Enable VAUDA line: temporary workaround for MSIC issue */
 	ret = intel_scu_ipc_iowrite8(MSIC_VAUDA, MSIC_VAUDA_VAL);
 	if (ret)
 		return ret;
 
-	/* enable adc and start it*/
+	/* Enable adc and start it */
 	ret = configure_adc(1);
 
 	return ret;
@@ -295,7 +288,8 @@ static int set_up_therm_chnl(u16 base_addr)
 /**
  * reset_stopbit - sets the stop bit to 0 on the given channel
  * @addr: address of the channel
- * context: can sleep
+ *
+ * Can sleep
  */
 static int reset_stopbit(uint16_t addr)
 {
@@ -304,19 +298,22 @@ static int reset_stopbit(uint16_t addr)
 	ret = intel_scu_ipc_ioread8(addr, &data);
 	if (ret)
 		return ret;
-	/*setting the stop bit to zero*/
-	ret = intel_scu_ipc_iowrite8(addr, (data & 0xEF));
-	return ret;
+	/* Set the stop bit to zero */
+	return intel_scu_ipc_iowrite8(addr, (data & 0xEF));
 }
 
 /**
  * find_free_channel - finds an empty channel for conversion
- * Context: can sleep
  *
- * If adc is not enabled then start using 0th channel
+ * If the ADC is not enabled then start using 0th channel
  * itself. Otherwise find an empty channel by looking for a
  * channel in which the stopbit is set to 1. returns the index
- * of the first free channel if succeeds,-EINVAL otherwise
+ * of the first free channel if succeeds or an error code.
+ *
+ * Context: can sleep
+ *
+ * FIXME: Ultimately the channel allocator will move into the intel_scu_ipc
+ * code.
  */
 static int find_free_channel(void)
 {
@@ -324,7 +321,7 @@ static int find_free_channel(void)
 	int i;
 	uint8_t data;
 
-	/*check whether ADC is enabled */
+	/* check whether ADC is enabled */
 	ret = intel_scu_ipc_ioread8(MSIC_THERM_ADC1CNTL1, &data);
 	if (ret)
 		return ret;
@@ -332,7 +329,7 @@ static int find_free_channel(void)
 	if ((data & MSIC_ADC_ENBL) = 0)
 		return 0;
 
-	/*ADC is already enabled; Looping for empty channel */
+	/* ADC is already enabled; Looki for an empty channel */
 	for (i = 0; i < ADC_CHANLS_MAX; i++) {
 		ret = intel_scu_ipc_ioread8(ADC_CHNL_START_ADDR + i, &data);
 		if (ret)
@@ -347,10 +344,10 @@ static int find_free_channel(void)
 }
 
 /**
- * mid_initialize_adc - initializing the adc
- * Context: can sleep
+ * mid_initialize_adc - initializing the ADC
+ * @dev: our device structure
  *
- * Initialize the adc for reading thermistor values
+ * Initialize the ADC for reading thermistor values. Can sleep.
  */
 static int mid_initialize_adc(struct device *dev)
 {
@@ -358,26 +355,28 @@ static int mid_initialize_adc(struct device *dev)
 	u16 base_addr;
 	int ret;
 
-	/* ensure that adctherm is disabled before we
-	 * initialize the adc */
+	/*
+	 * Ensure that adctherm is disabled before we
+	 * initialize the ADC
+	 */
 	ret = intel_scu_ipc_ioread8(MSIC_THERM_ADC1CNTL3, &data);
 	if (ret)
 		return ret;
 
 	if (data & MSIC_ADCTHERM_MASK)
-		dev_warn(dev, PREFIX "%s:ADCTHERM already set", __func__);
+		dev_warn(dev, "ADCTHERM already set");
 
 	/* Index of the first channel in which the stop bit is set */
 	channel_index = find_free_channel();
-	if (channel_index = -EINVAL) {
-		dev_warn(dev, PREFIX "%s:No free channels", __func__);
-		return -EINVAL;
+	if (channel_index < 0) {
+		dev_err(dev, "No free ADC channels");
+		return channel_index;
 	}
 
 	base_addr = ADC_CHNL_START_ADDR + channel_index;
 
 	if (!(channel_index = 0 || channel_index = ADC_LOOP_MAX)) {
-		/* reset stop bit for channels other than 0 and 12 */
+		/* Reset stop bit for channels other than 0 and 12 */
 		ret = reset_stopbit(base_addr);
 		if (ret)
 			return ret;
@@ -389,17 +388,17 @@ static int mid_initialize_adc(struct device *dev)
 
 	ret = set_up_therm_chnl(base_addr);
 	if (ret) {
-		dev_warn(dev, PREFIX "%s:adc enabling failed", __func__);
+		dev_err(dev, "unable to enable ADC");
 		return ret;
 	}
-
-	dev_info(dev, PREFIX "adc initialization successfull");
+	dev_dbg(dev, "ADC initialization successful");
 	return ret;
 }
 
 /**
  * initialize_sensor - sets default temp and timer ranges
  * @index: index of the sensor
+ *
  * Context: can sleep
  */
 static struct thermal_device_info *initialize_sensor(int index)
@@ -410,18 +409,19 @@ static struct thermal_device_info *initialize_sensor(int index)
 	if (!td_info)
 		return NULL;
 
-	/*setting the base addr of the channel for this sensor*/
-	td_info->chnl_addr = ADC_DATA_START_ADDR+2*(channel_index+index);
-
+	/* Set the base addr of the channel for this sensor */
+	td_info->chnl_addr = ADC_DATA_START_ADDR + 2 * (channel_index + index);
+	/* Sensor 3 is direct conversion */
+	if (index = 3)
+		td_info->direct = 1;
 	return td_info;
 }
 
 /**
  * mid_thermal_resume - resume routine
  * @pdev: platform device structure
- * Context: can sleep
  *
- * mid thermal resume: re-initializes the adc
+ * mid thermal resume: re-initializes the adc. Can sleep.
  */
 static int mid_thermal_resume(struct platform_device *pdev)
 {
@@ -431,16 +431,16 @@ static int mid_thermal_resume(struct platform_device *pdev)
 /**
  * mid_thermal_suspend - suspend routine
  * @pdev: platform device structure
- * Context: can sleep
  *
  * mid thermal suspend implements the suspend functionality
- * by stopping the adc
+ * by stopping the ADC. Can sleep.
  */
 static int mid_thermal_suspend(struct platform_device *pdev, pm_message_t mesg)
 {
-	/* this just stops adc and does not disable it.
-	 * temporary workaround until a generic adc driver comes.
-	 * If 0 is passed, it disables the adc.
+	/*
+	 * This just stops the ADC and does not disable it.
+	 * temporary workaround until we have a generic ADC driver.
+	 * If 0 is passed, it disables the ADC.
 	 */
 	return configure_adc(0);
 }
@@ -448,7 +448,8 @@ static int mid_thermal_suspend(struct platform_device *pdev, pm_message_t mesg)
 /**
  * read_curr_temp - reads the current temperature and stores in temp
  * @temp: holds the current temperature value after reading
- * context: can sleep
+ *
+ * Can sleep
  */
 static int read_curr_temp(struct thermal_zone_device *tzd, unsigned long *temp)
 {
@@ -456,16 +457,25 @@ static int read_curr_temp(struct thermal_zone_device *tzd, unsigned long *temp)
 	return mid_read_temp(tzd, temp);
 }
 
+/* Can't be const */
+static struct thermal_zone_device_ops tzd_ops = {
+	.get_temp = read_curr_temp,
+};
+
+
 /**
  * mid_thermal_probe - mfld thermal initialize
  * @pdev: platform device structure
- * Context: can sleep
  *
  * mid thermal probe initializes the hardware and registers
- * all the sensors with the generic thermal framework.
+ * all the sensors with the generic thermal framework. Can sleep.
  */
 static int mid_thermal_probe(struct platform_device *pdev)
 {
+	static char *name[MSIC_THERMAL_SENSORS] = {
+		"skin0", "skin1", "sys", "msicdie"
+	};
+
 	int ret;
 	int i;
 	struct platform_info *pinfo;
@@ -477,29 +487,37 @@ static int mid_thermal_probe(struct platform_device *pdev)
 	/* Initializing the hardware */
 	ret = mid_initialize_adc(&pdev->dev);
 	if (ret) {
-		dev_err(&pdev->dev, PREFIX "%s: adc init failed", __func__);
+		dev_err(&pdev->dev, "ADC init failed");
 		return ret;
 	}
 
-	/* register each sensor with the generic thermal framework*/
-	for (i = 0; i < MSIC_THERMAL_SENSORS; i++)
+	/* Register each sensor with the generic thermal framework */
+	for (i = 0; i < MSIC_THERMAL_SENSORS; i++) {
 		pinfo->tzd[i] = thermal_zone_device_register(name[i],
 					0, initialize_sensor(i),
 					&tzd_ops, 0, 0, 0, 0);
+		if (IS_ERR(pinfo->tzd[i]))
+			goto reg_fail;
+	}
 
 	pinfo->pdev = pdev;
 	platform_set_drvdata(pdev, pinfo);
+	return 0;
 
+reg_fail:
+	ret = PTR_ERR(pinfo->tzd[i]);
+	while (--i >= 0)
+		thermal_zone_device_unregister(pinfo->tzd[i]);
+	configure_adc(0);
 	return ret;
 }
 
 /**
  * mid_thermal_remove - mfld thermal finalize
  * @dev: platform device structure
- * Context: can sleep
  *
  * MLFD thermal remove unregisters all the sensors from the generic
- * thermal framework.
+ * thermal framework. Can sleep
  */
 static int mid_thermal_remove(struct platform_device *pdev)
 {
@@ -511,7 +529,7 @@ static int mid_thermal_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 
-	/* stop the adc */
+	/* Stop the ADC */
 	configure_adc(0);
 	return 0;
 }
@@ -519,6 +537,9 @@ static int mid_thermal_remove(struct platform_device *pdev)
 /*********************************************************************
  *		Driver initialisation and finalization
  *********************************************************************/
+
+#define DRIVER_NAME "msic_sensor"
+
 static const struct platform_device_id therm_id_table[] = {
 	{ DRIVER_NAME, 1 },
 };
@@ -547,3 +568,7 @@ static void __exit mid_thermal_module_exit(void)
 
 module_init(mid_thermal_module_init);
 module_exit(mid_thermal_module_exit);
+
+MODULE_AUTHOR("Durgadoss <durgadoss.r@intel.com>");
+MODULE_DESCRIPTION("Intel Medfield Platform Thermal Driver");
+MODULE_LICENSE("GPL");


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
