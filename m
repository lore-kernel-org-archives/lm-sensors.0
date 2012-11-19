From: Bill Pemberton <wfp5p@virginia.edu>
Date: Mon, 19 Nov 2012 18:22:35 +0000
Subject: [lm-sensors] [PATCH 206/493] hwmon: remove use of __devinit
Message-Id: <1353349642-3677-206-git-send-email-wfp5p@virginia.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Hans de Goede <hdegoede@redhat.com> 
Cc: Jean Delvare <khali@linux-fr.org> 
Cc: Guenter Roeck <linux@roeck-us.net> 
Cc: Alistair John Strachan <alistair@devzero.co.uk> 
Cc: Fenghua Yu <fenghua.yu@intel.com> 
Cc: Juerg Haefliger <juergh@gmail.com> 
Cc: Andreas Herrmann <herrmann.der.user@googlemail.com> 
Cc: Clemens Ladisch <clemens@ladisch.de> 
Cc: Rudolf Marek <r.marek@assembler.cz> 
Cc: Jim Cromie <jim.cromie@gmail.com> 
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com> 
Cc: Roger Lucas <vt8231@hiddenengine.co.uk> 
Cc: lm-sensors@lm-sensors.org 
Cc: patches@opensource.wolfsonmicro.com 
---
 drivers/hwmon/abituguru.c          |  8 ++++----
 drivers/hwmon/abituguru3.c         |  2 +-
 drivers/hwmon/ad7314.c             |  2 +-
 drivers/hwmon/adcxx.c              |  2 +-
 drivers/hwmon/ads7871.c            |  2 +-
 drivers/hwmon/adt7411.c            |  2 +-
 drivers/hwmon/coretemp.c           |  4 ++--
 drivers/hwmon/da9052-hwmon.c       |  2 +-
 drivers/hwmon/da9055-hwmon.c       |  2 +-
 drivers/hwmon/dme1737.c            |  2 +-
 drivers/hwmon/f71805f.c            |  4 ++--
 drivers/hwmon/f71882fg.c           |  8 ++++----
 drivers/hwmon/fam15h_power.c       |  6 +++---
 drivers/hwmon/gpio-fan.c           |  2 +-
 drivers/hwmon/hih6130.c            |  2 +-
 drivers/hwmon/i5k_amb.c            | 10 +++++-----
 drivers/hwmon/it87.c               |  6 +++---
 drivers/hwmon/jz4740-hwmon.c       |  2 +-
 drivers/hwmon/k10temp.c            |  4 ++--
 drivers/hwmon/k8temp.c             |  4 ++--
 drivers/hwmon/lm70.c               |  2 +-
 drivers/hwmon/lm78.c               |  2 +-
 drivers/hwmon/max1111.c            |  4 ++--
 drivers/hwmon/max197.c             |  2 +-
 drivers/hwmon/ntc_thermistor.c     |  2 +-
 drivers/hwmon/pc87360.c            |  2 +-
 drivers/hwmon/pc87427.c            |  6 +++---
 drivers/hwmon/s3c-hwmon.c          |  2 +-
 drivers/hwmon/sch5627.c            |  4 ++--
 drivers/hwmon/sch5636.c            |  2 +-
 drivers/hwmon/sht15.c              |  2 +-
 drivers/hwmon/sht21.c              |  2 +-
 drivers/hwmon/sis5595.c            |  8 ++++----
 drivers/hwmon/smsc47b397.c         |  2 +-
 drivers/hwmon/tmp102.c             |  2 +-
 drivers/hwmon/twl4030-madc-hwmon.c |  2 +-
 drivers/hwmon/ultra45_env.c        |  2 +-
 drivers/hwmon/via-cputemp.c        |  2 +-
 drivers/hwmon/via686a.c            |  8 ++++----
 drivers/hwmon/vt1211.c             |  4 ++--
 drivers/hwmon/vt8231.c             |  6 +++---
 drivers/hwmon/w83627ehf.c          |  8 ++++----
 drivers/hwmon/w83627hf.c           |  8 ++++----
 drivers/hwmon/w83781d.c            |  2 +-
 drivers/hwmon/wm831x-hwmon.c       |  2 +-
 drivers/hwmon/wm8350-hwmon.c       |  2 +-
 46 files changed, 83 insertions(+), 83 deletions(-)

diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
index d12c3fb..700d5e0 100644
--- a/drivers/hwmon/abituguru.c
+++ b/drivers/hwmon/abituguru.c
@@ -478,7 +478,7 @@ static int abituguru_write(struct abituguru_data *data,
  * alarm for sensor type X and then enabling the sensor as sensor type
  * X, if we then get an alarm it is a sensor of type X.
  */
-static int __devinit
+static int
 abituguru_detect_bank1_sensor_type(struct abituguru_data *data,
 				   u8 sensor_addr)
 {
@@ -635,7 +635,7 @@ abituguru_detect_bank1_sensor_type_exit:
  * read/write test would be feasible because of the reaction above, I've
  * however opted to stay on the safe side.
  */
-static void __devinit
+static void
 abituguru_detect_no_bank2_sensors(struct abituguru_data *data)
 {
 	int i;
@@ -691,7 +691,7 @@ abituguru_detect_no_bank2_sensors(struct abituguru_data *data)
 		(int)data->bank2_sensors);
 }
 
-static void __devinit
+static void
 abituguru_detect_no_pwms(struct abituguru_data *data)
 {
 	int i, j;
@@ -1264,7 +1264,7 @@ static struct sensor_device_attribute_2 abituguru_sysfs_attr[] = {
 	SENSOR_ATTR_2(name, 0444, show_name, NULL, 0, 0),
 };
 
-static int __devinit abituguru_probe(struct platform_device *pdev)
+static int abituguru_probe(struct platform_device *pdev)
 {
 	struct abituguru_data *data;
 	int i, j, used, sysfs_names_free, sysfs_attr_i, res = -ENODEV;
diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index 56a8075..b8d0942 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -966,7 +966,7 @@ static struct sensor_device_attribute_2 abituguru3_sysfs_attr[] = {
 	SENSOR_ATTR_2(name, 0444, show_name, NULL, 0, 0),
 };
 
-static int __devinit abituguru3_probe(struct platform_device *pdev)
+static int abituguru3_probe(struct platform_device *pdev)
 {
 	const int no_sysfs_attr[3] = { 10, 8, 7 };
 	int sensor_index[3] = { 0, 1, 1 };
diff --git a/drivers/hwmon/ad7314.c b/drivers/hwmon/ad7314.c
index fdda321..defd34b 100644
--- a/drivers/hwmon/ad7314.c
+++ b/drivers/hwmon/ad7314.c
@@ -107,7 +107,7 @@ static const struct attribute_group ad7314_group = {
 	.attrs = ad7314_attributes,
 };
 
-static int __devinit ad7314_probe(struct spi_device *spi_dev)
+static int ad7314_probe(struct spi_device *spi_dev)
 {
 	int ret;
 	struct ad7314_data *chip;
diff --git a/drivers/hwmon/adcxx.c b/drivers/hwmon/adcxx.c
index dff6f4f..ecc1e6c 100644
--- a/drivers/hwmon/adcxx.c
+++ b/drivers/hwmon/adcxx.c
@@ -161,7 +161,7 @@ static struct sensor_device_attribute ad_input[] = {
 
 /*----------------------------------------------------------------------*/
 
-static int __devinit adcxx_probe(struct spi_device *spi)
+static int adcxx_probe(struct spi_device *spi)
 {
 	int channels = spi_get_device_id(spi)->driver_data;
 	struct adcxx *adc;
diff --git a/drivers/hwmon/ads7871.c b/drivers/hwmon/ads7871.c
index 5a6cc1f..41a7837 100644
--- a/drivers/hwmon/ads7871.c
+++ b/drivers/hwmon/ads7871.c
@@ -173,7 +173,7 @@ static const struct attribute_group ads7871_group = {
 	.attrs = ads7871_attributes,
 };
 
-static int __devinit ads7871_probe(struct spi_device *spi)
+static int ads7871_probe(struct spi_device *spi)
 {
 	int ret, err;
 	uint8_t val;
diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
index a961af6..68a5da7 100644
--- a/drivers/hwmon/adt7411.c
+++ b/drivers/hwmon/adt7411.c
@@ -276,7 +276,7 @@ static int adt7411_detect(struct i2c_client *client,
 	return 0;
 }
 
-static int __devinit adt7411_probe(struct i2c_client *client,
+static int adt7411_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
 	struct adt7411_data *data;
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 6df893b..c336afc 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -356,7 +356,7 @@ static int __cpuinit get_tjmax(struct cpuinfo_x86 *c, u32 id,
 	return adjust_tjmax(c, id, dev);
 }
 
-static int __devinit create_name_attr(struct platform_data *pdata,
+static int create_name_attr(struct platform_data *pdata,
 				      struct device *dev)
 {
 	sysfs_attr_init(&pdata->name_attr.attr);
@@ -551,7 +551,7 @@ static void coretemp_remove_core(struct platform_data *pdata,
 	pdata->core_data[indx] = NULL;
 }
 
-static int __devinit coretemp_probe(struct platform_device *pdev)
+static int coretemp_probe(struct platform_device *pdev)
 {
 	struct platform_data *pdata;
 	int err;
diff --git a/drivers/hwmon/da9052-hwmon.c b/drivers/hwmon/da9052-hwmon.c
index d919ed6..7c53a23 100644
--- a/drivers/hwmon/da9052-hwmon.c
+++ b/drivers/hwmon/da9052-hwmon.c
@@ -270,7 +270,7 @@ static struct attribute *da9052_attr[] = {
 
 static const struct attribute_group da9052_attr_group = {.attrs = da9052_attr};
 
-static int __devinit da9052_hwmon_probe(struct platform_device *pdev)
+static int da9052_hwmon_probe(struct platform_device *pdev)
 {
 	struct da9052_hwmon *hwmon;
 	int ret;
diff --git a/drivers/hwmon/da9055-hwmon.c b/drivers/hwmon/da9055-hwmon.c
index bd8b695..cd35f46 100644
--- a/drivers/hwmon/da9055-hwmon.c
+++ b/drivers/hwmon/da9055-hwmon.c
@@ -256,7 +256,7 @@ static struct attribute *da9055_attr[] = {
 
 static const struct attribute_group da9055_attr_group = {.attrs = da9055_attr};
 
-static int __devinit da9055_hwmon_probe(struct platform_device *pdev)
+static int da9055_hwmon_probe(struct platform_device *pdev)
 {
 	struct da9055_hwmon *hwmon;
 	int hwmon_irq, ret;
diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
index 32f81ca..aa6a493 100644
--- a/drivers/hwmon/dme1737.c
+++ b/drivers/hwmon/dme1737.c
@@ -2630,7 +2630,7 @@ exit:
 	return err;
 }
 
-static int __devinit dme1737_isa_probe(struct platform_device *pdev)
+static int dme1737_isa_probe(struct platform_device *pdev)
 {
 	u8 company, device;
 	struct resource *res;
diff --git a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
index 56860dd..0c8426e 100644
--- a/drivers/hwmon/f71805f.c
+++ b/drivers/hwmon/f71805f.c
@@ -1343,7 +1343,7 @@ static struct attribute *f71805f_attr_pwm[] = {
  * Device registration and initialization
  */
 
-static void __devinit f71805f_init_device(struct f71805f_data *data)
+static void f71805f_init_device(struct f71805f_data *data)
 {
 	u8 reg;
 	int i;
@@ -1374,7 +1374,7 @@ static void __devinit f71805f_init_device(struct f71805f_data *data)
 	}
 }
 
-static int __devinit f71805f_probe(struct platform_device *pdev)
+static int f71805f_probe(struct platform_device *pdev)
 {
 	struct f71805f_sio_data *sio_data = pdev->dev.platform_data;
 	struct f71805f_data *data;
diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 50e4ce2..bb7275c 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -364,7 +364,7 @@ static ssize_t store_pwm_auto_point_temp(struct device *dev,
 static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
 	char *buf);
 
-static int __devinit f71882fg_probe(struct platform_device *pdev);
+static int f71882fg_probe(struct platform_device *pdev);
 static int f71882fg_remove(struct platform_device *pdev);
 
 static struct platform_driver f71882fg_driver = {
@@ -2145,7 +2145,7 @@ static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
 	return sprintf(buf, "%s\n", f71882fg_names[data->type]);
 }
 
-static int __devinit f71882fg_create_sysfs_files(struct platform_device *pdev,
+static int f71882fg_create_sysfs_files(struct platform_device *pdev,
 	struct sensor_device_attribute_2 *attr, int count)
 {
 	int err, i;
@@ -2167,7 +2167,7 @@ static void f71882fg_remove_sysfs_files(struct platform_device *pdev,
 		device_remove_file(&pdev->dev, &attr[i].dev_attr);
 }
 
-static int __devinit f71882fg_create_fan_sysfs_files(
+static int f71882fg_create_fan_sysfs_files(
 	struct platform_device *pdev, int idx)
 {
 	struct f71882fg_data *data = platform_get_drvdata(pdev);
@@ -2265,7 +2265,7 @@ static int __devinit f71882fg_create_fan_sysfs_files(
 	return err;
 }
 
-static int __devinit f71882fg_probe(struct platform_device *pdev)
+static int f71882fg_probe(struct platform_device *pdev)
 {
 	struct f71882fg_data *data;
 	struct f71882fg_sio_data *sio_data = pdev->dev.platform_data;
diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 327fbc6..4eca298 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -111,7 +111,7 @@ static const struct attribute_group fam15h_power_attr_group = {
 	.attrs	= fam15h_power_attrs,
 };
 
-static bool __devinit fam15h_power_is_internal_node0(struct pci_dev *f4)
+static bool fam15h_power_is_internal_node0(struct pci_dev *f4)
 {
 	u32 val;
 
@@ -168,7 +168,7 @@ static int fam15h_power_resume(struct pci_dev *pdev)
 #define fam15h_power_resume NULL
 #endif
 
-static void __devinit fam15h_power_init_data(struct pci_dev *f4,
+static void fam15h_power_init_data(struct pci_dev *f4,
 					     struct fam15h_power_data *data)
 {
 	u32 val;
@@ -194,7 +194,7 @@ static void __devinit fam15h_power_init_data(struct pci_dev *f4,
 	data->processor_pwr_watts = (tmp * 15625) >> 10;
 }
 
-static int __devinit fam15h_power_probe(struct pci_dev *pdev,
+static int fam15h_power_probe(struct pci_dev *pdev,
 					const struct pci_device_id *id)
 {
 	struct fam15h_power_data *data;
diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index 4b1767f..e52856b 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -505,7 +505,7 @@ static struct of_device_id of_gpio_fan_match[] __devinitdata = {
 };
 #endif /* CONFIG_OF_GPIO */
 
-static int __devinit gpio_fan_probe(struct platform_device *pdev)
+static int gpio_fan_probe(struct platform_device *pdev)
 {
 	int err;
 	struct gpio_fan_data *fan_data;
diff --git a/drivers/hwmon/hih6130.c b/drivers/hwmon/hih6130.c
index 9ebe24e..5c65aef 100644
--- a/drivers/hwmon/hih6130.c
+++ b/drivers/hwmon/hih6130.c
@@ -220,7 +220,7 @@ static const struct attribute_group hih6130_attr_group = {
  * device's name.
  * Returns 0 on success.
  */
-static int __devinit hih6130_probe(struct i2c_client *client,
+static int hih6130_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
 	struct hih6130 *hih6130;
diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
index 3fa3cc8..0d0faf0 100644
--- a/drivers/hwmon/i5k_amb.c
+++ b/drivers/hwmon/i5k_amb.c
@@ -260,7 +260,7 @@ static ssize_t show_label(struct device *dev,
 		       attr->index & DIMM_MASK);
 }
 
-static int __devinit i5k_amb_hwmon_init(struct platform_device *pdev)
+static int i5k_amb_hwmon_init(struct platform_device *pdev)
 {
 	int i, j, k, d = 0;
 	u16 c;
@@ -406,7 +406,7 @@ exit_remove:
 	return res;
 }
 
-static int __devinit i5k_amb_add(void)
+static int i5k_amb_add(void)
 {
 	int res = -ENODEV;
 
@@ -425,7 +425,7 @@ err:
 	return res;
 }
 
-static int __devinit i5k_find_amb_registers(struct i5k_amb_data *data,
+static int i5k_find_amb_registers(struct i5k_amb_data *data,
 					    unsigned long devid)
 {
 	struct pci_dev *pcidev;
@@ -459,7 +459,7 @@ out:
 	return res;
 }
 
-static int __devinit i5k_channel_probe(u16 *amb_present, unsigned long dev_id)
+static int i5k_channel_probe(u16 *amb_present, unsigned long dev_id)
 {
 	struct pci_dev *pcidev;
 	u16 val16;
@@ -503,7 +503,7 @@ static struct pci_device_id i5k_amb_ids[] __devinitdata = {
 MODULE_DEVICE_TABLE(pci, i5k_amb_ids);
 #endif
 
-static int __devinit i5k_amb_probe(struct platform_device *pdev)
+static int i5k_amb_probe(struct platform_device *pdev)
 {
 	struct i5k_amb_data *data;
 	struct resource *reso;
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 94f40c2..467b7d4 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -1979,7 +1979,7 @@ static void it87_remove_files(struct device *dev)
 	sysfs_remove_group(&dev->kobj, &it87_group_label);
 }
 
-static int __devinit it87_probe(struct platform_device *pdev)
+static int it87_probe(struct platform_device *pdev)
 {
 	struct it87_data *data;
 	struct resource *res;
@@ -2227,7 +2227,7 @@ static void it87_write_value(struct it87_data *data, u8 reg, u8 value)
 }
 
 /* Return 1 if and only if the PWM interface is safe to use */
-static int __devinit it87_check_pwm(struct device *dev)
+static int it87_check_pwm(struct device *dev)
 {
 	struct it87_data *data = dev_get_drvdata(dev);
 	/*
@@ -2284,7 +2284,7 @@ static int __devinit it87_check_pwm(struct device *dev)
 }
 
 /* Called when we have found a new IT87. */
-static void __devinit it87_init_device(struct platform_device *pdev)
+static void it87_init_device(struct platform_device *pdev)
 {
 	struct it87_sio_data *sio_data = pdev->dev.platform_data;
 	struct it87_data *data = platform_get_drvdata(pdev);
diff --git a/drivers/hwmon/jz4740-hwmon.c b/drivers/hwmon/jz4740-hwmon.c
index fca0d37..b944d61 100644
--- a/drivers/hwmon/jz4740-hwmon.c
+++ b/drivers/hwmon/jz4740-hwmon.c
@@ -102,7 +102,7 @@ static const struct attribute_group jz4740_hwmon_attr_group = {
 	.attrs = jz4740_hwmon_attributes,
 };
 
-static int __devinit jz4740_hwmon_probe(struct platform_device *pdev)
+static int jz4740_hwmon_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct jz4740_hwmon *hwmon;
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 2722cde..da8acda 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -95,7 +95,7 @@ static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp_crit, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO, show_temp_crit, NULL, 1);
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
-static bool __devinit has_erratum_319(struct pci_dev *pdev)
+static bool has_erratum_319(struct pci_dev *pdev)
 {
 	u32 pkg_type, reg_dram_cfg;
 
@@ -129,7 +129,7 @@ static bool __devinit has_erratum_319(struct pci_dev *pdev)
 	       (boot_cpu_data.x86_model = 4 && boot_cpu_data.x86_mask <= 2);
 }
 
-static int __devinit k10temp_probe(struct pci_dev *pdev,
+static int k10temp_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *id)
 {
 	struct device *hwmon_dev;
diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index 143a2f8..8c46753 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -142,7 +142,7 @@ static DEFINE_PCI_DEVICE_TABLE(k8temp_ids) = {
 
 MODULE_DEVICE_TABLE(pci, k8temp_ids);
 
-static int __devinit is_rev_g_desktop(u8 model)
+static int is_rev_g_desktop(u8 model)
 {
 	u32 brandidx;
 
@@ -173,7 +173,7 @@ static int __devinit is_rev_g_desktop(u8 model)
 	return 1;
 }
 
-static int __devinit k8temp_probe(struct pci_dev *pdev,
+static int k8temp_probe(struct pci_dev *pdev,
 				  const struct pci_device_id *id)
 {
 	int err;
diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index d3d5afd..d5f006e 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -131,7 +131,7 @@ static DEVICE_ATTR(name, S_IRUGO, lm70_show_name, NULL);
 
 /*----------------------------------------------------------------------*/
 
-static int __devinit lm70_probe(struct spi_device *spi)
+static int lm70_probe(struct spi_device *spi)
 {
 	int chip = spi_get_device_id(spi)->driver_data;
 	struct lm70 *p_lm70;
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index 1dc3433..181d756 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -833,7 +833,7 @@ static struct lm78_data *lm78_update_device(struct device *dev)
 }
 
 #ifdef CONFIG_ISA
-static int __devinit lm78_isa_probe(struct platform_device *pdev)
+static int lm78_isa_probe(struct platform_device *pdev)
 {
 	int err;
 	struct lm78_data *data;
diff --git a/drivers/hwmon/max1111.c b/drivers/hwmon/max1111.c
index 5ac15b0..410351b 100644
--- a/drivers/hwmon/max1111.c
+++ b/drivers/hwmon/max1111.c
@@ -157,7 +157,7 @@ static const struct attribute_group max1110_attr_group = {
 	.attrs	= max1110_attributes,
 };
 
-static int __devinit setup_transfer(struct max1111_data *data)
+static int setup_transfer(struct max1111_data *data)
 {
 	struct spi_message *m;
 	struct spi_transfer *x;
@@ -179,7 +179,7 @@ static int __devinit setup_transfer(struct max1111_data *data)
 	return 0;
 }
 
-static int __devinit max1111_probe(struct spi_device *spi)
+static int max1111_probe(struct spi_device *spi)
 {
 	enum chips chip = spi_get_device_id(spi)->driver_data;
 	struct max1111_data *data;
diff --git a/drivers/hwmon/max197.c b/drivers/hwmon/max197.c
index 170e1b2..76c941e 100644
--- a/drivers/hwmon/max197.c
+++ b/drivers/hwmon/max197.c
@@ -257,7 +257,7 @@ static const struct attribute_group max197_sysfs_group = {
 	},
 };
 
-static int __devinit max197_probe(struct platform_device *pdev)
+static int max197_probe(struct platform_device *pdev)
 {
 	int ch, ret;
 	struct max197_data *data;
diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index dd23230..ac4f403 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -309,7 +309,7 @@ static const struct attribute_group ntc_attr_group = {
 	.attrs = ntc_attributes,
 };
 
-static int __devinit ntc_thermistor_probe(struct platform_device *pdev)
+static int ntc_thermistor_probe(struct platform_device *pdev)
 {
 	struct ntc_data *data;
 	struct ntc_thermistor_platform_data *pdata = pdev->dev.platform_data;
diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 0785663..b4c11c6 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -1221,7 +1221,7 @@ static void pc87360_remove_files(struct device *dev)
 	sysfs_remove_group(&dev->kobj, &pc8736x_vin_group);
 }
 
-static int __devinit pc87360_probe(struct platform_device *pdev)
+static int pc87360_probe(struct platform_device *pdev)
 {
 	int i;
 	struct pc87360_data *data;
diff --git a/drivers/hwmon/pc87427.c b/drivers/hwmon/pc87427.c
index 288a775..36a0d17 100644
--- a/drivers/hwmon/pc87427.c
+++ b/drivers/hwmon/pc87427.c
@@ -956,7 +956,7 @@ static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
  * Device detection, attach and detach
  */
 
-static int __devinit pc87427_request_regions(struct platform_device *pdev,
+static int pc87427_request_regions(struct platform_device *pdev,
 					     int count)
 {
 	struct resource *res;
@@ -980,7 +980,7 @@ static int __devinit pc87427_request_regions(struct platform_device *pdev,
 	return 0;
 }
 
-static void __devinit pc87427_init_device(struct device *dev)
+static void pc87427_init_device(struct device *dev)
 {
 	struct pc87427_sio_data *sio_data = dev->platform_data;
 	struct pc87427_data *data = dev_get_drvdata(dev);
@@ -1072,7 +1072,7 @@ static void pc87427_remove_files(struct device *dev)
 	}
 }
 
-static int __devinit pc87427_probe(struct platform_device *pdev)
+static int pc87427_probe(struct platform_device *pdev)
 {
 	struct pc87427_sio_data *sio_data = pdev->dev.platform_data;
 	struct pc87427_data *data;
diff --git a/drivers/hwmon/s3c-hwmon.c b/drivers/hwmon/s3c-hwmon.c
index df405e3..397e2ad 100644
--- a/drivers/hwmon/s3c-hwmon.c
+++ b/drivers/hwmon/s3c-hwmon.c
@@ -275,7 +275,7 @@ static void s3c_hwmon_remove_attr(struct device *dev,
  * s3c_hwmon_probe - device probe entry.
  * @dev: The device being probed.
 */
-static int __devinit s3c_hwmon_probe(struct platform_device *dev)
+static int s3c_hwmon_probe(struct platform_device *dev)
 {
 	struct s3c_hwmon_pdata *pdata = dev->dev.platform_data;
 	struct s3c_hwmon *hwmon;
diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
index 49f6230..0cc99fd 100644
--- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -153,7 +153,7 @@ abort:
 	return ret;
 }
 
-static int __devinit sch5627_read_limits(struct sch5627_data *data)
+static int sch5627_read_limits(struct sch5627_data *data)
 {
 	int i, val;
 
@@ -465,7 +465,7 @@ static int sch5627_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devinit sch5627_probe(struct platform_device *pdev)
+static int sch5627_probe(struct platform_device *pdev)
 {
 	struct sch5627_data *data;
 	int err, build_code, build_id, hwmon_rev, val;
diff --git a/drivers/hwmon/sch5636.c b/drivers/hwmon/sch5636.c
index 5171180..547b5c9 100644
--- a/drivers/hwmon/sch5636.c
+++ b/drivers/hwmon/sch5636.c
@@ -405,7 +405,7 @@ static int sch5636_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devinit sch5636_probe(struct platform_device *pdev)
+static int sch5636_probe(struct platform_device *pdev)
 {
 	struct sch5636_data *data;
 	int i, err, val, revision[2];
diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index 32e3b29..d5b79e7 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -884,7 +884,7 @@ static int sht15_invalidate_voltage(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static int __devinit sht15_probe(struct platform_device *pdev)
+static int sht15_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct sht15_data *data;
diff --git a/drivers/hwmon/sht21.c b/drivers/hwmon/sht21.c
index 3ffd3b3..9a4cc3b 100644
--- a/drivers/hwmon/sht21.c
+++ b/drivers/hwmon/sht21.c
@@ -187,7 +187,7 @@ static const struct attribute_group sht21_attr_group = {
  * device's name.
  * Returns 0 on success.
  */
-static int __devinit sht21_probe(struct i2c_client *client,
+static int sht21_probe(struct i2c_client *client,
 	const struct i2c_device_id *id)
 {
 	struct sht21 *sht21;
diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index fb6b6ed..5adc829 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -583,7 +583,7 @@ static const struct attribute_group sis5595_group_temp1 = {
 };
 
 /* This is called when the module is loaded */
-static int __devinit sis5595_probe(struct platform_device *pdev)
+static int sis5595_probe(struct platform_device *pdev)
 {
 	int err = 0;
 	int i;
@@ -693,7 +693,7 @@ static void sis5595_write_value(struct sis5595_data *data, u8 reg, u8 value)
 }
 
 /* Called when we have found a new SIS5595. */
-static void __devinit sis5595_init_device(struct sis5595_data *data)
+static void sis5595_init_device(struct sis5595_data *data)
 {
 	u8 config = sis5595_read_value(data, SIS5595_REG_CONFIG);
 	if (!(config & 0x01))
@@ -774,7 +774,7 @@ static int blacklist[] __devinitdata = {
 	PCI_DEVICE_ID_SI_5598,
 	0 };
 
-static int __devinit sis5595_device_add(unsigned short address)
+static int sis5595_device_add(unsigned short address)
 {
 	struct resource res = {
 		.start	= address,
@@ -815,7 +815,7 @@ exit:
 	return err;
 }
 
-static int __devinit sis5595_pci_probe(struct pci_dev *dev,
+static int sis5595_pci_probe(struct pci_dev *dev,
 				       const struct pci_device_id *id)
 {
 	u16 address;
diff --git a/drivers/hwmon/smsc47b397.c b/drivers/hwmon/smsc47b397.c
index 6edad30..9100a27 100644
--- a/drivers/hwmon/smsc47b397.c
+++ b/drivers/hwmon/smsc47b397.c
@@ -249,7 +249,7 @@ static struct platform_driver smsc47b397_driver = {
 	.remove		= smsc47b397_remove,
 };
 
-static int __devinit smsc47b397_probe(struct platform_device *pdev)
+static int smsc47b397_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct smsc47b397_data *data;
diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index ec11400..bd8e4af 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -147,7 +147,7 @@ static const struct attribute_group tmp102_attr_group = {
 #define TMP102_CONFIG  (TMP102_CONF_TM | TMP102_CONF_EM | TMP102_CONF_CR1)
 #define TMP102_CONFIG_RD_ONLY (TMP102_CONF_R0 | TMP102_CONF_R1 | TMP102_CONF_AL)
 
-static int __devinit tmp102_probe(struct i2c_client *client,
+static int tmp102_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
 	struct tmp102 *tmp102;
diff --git a/drivers/hwmon/twl4030-madc-hwmon.c b/drivers/hwmon/twl4030-madc-hwmon.c
index 1a174f0..6b42f41 100644
--- a/drivers/hwmon/twl4030-madc-hwmon.c
+++ b/drivers/hwmon/twl4030-madc-hwmon.c
@@ -96,7 +96,7 @@ static const struct attribute_group twl4030_madc_group = {
 	.attrs = twl4030_madc_attributes,
 };
 
-static int __devinit twl4030_madc_hwmon_probe(struct platform_device *pdev)
+static int twl4030_madc_hwmon_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct device *hwmon;
diff --git a/drivers/hwmon/ultra45_env.c b/drivers/hwmon/ultra45_env.c
index 89747b8..4a06fc0 100644
--- a/drivers/hwmon/ultra45_env.c
+++ b/drivers/hwmon/ultra45_env.c
@@ -250,7 +250,7 @@ static const struct attribute_group env_group = {
 	.attrs = env_attributes,
 };
 
-static int __devinit env_probe(struct platform_device *op)
+static int env_probe(struct platform_device *op)
 {
 	struct env *p = kzalloc(sizeof(*p), GFP_KERNEL);
 	int err = -ENOMEM;
diff --git a/drivers/hwmon/via-cputemp.c b/drivers/hwmon/via-cputemp.c
index 6021b7f..b86ad79 100644
--- a/drivers/hwmon/via-cputemp.c
+++ b/drivers/hwmon/via-cputemp.c
@@ -121,7 +121,7 @@ static const struct attribute_group via_cputemp_group = {
 /* Optional attributes */
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_cpu_vid, NULL);
 
-static int __devinit via_cputemp_probe(struct platform_device *pdev)
+static int via_cputemp_probe(struct platform_device *pdev)
 {
 	struct via_cputemp_data *data;
 	struct cpuinfo_x86 *c = &cpu_data(pdev->id);
diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
index b2c155d..9d6e27e 100644
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -682,7 +682,7 @@ static struct platform_driver via686a_driver = {
 
 
 /* This is called when the module is loaded */
-static int __devinit via686a_probe(struct platform_device *pdev)
+static int via686a_probe(struct platform_device *pdev)
 {
 	struct via686a_data *data;
 	struct resource *res;
@@ -745,7 +745,7 @@ static void via686a_update_fan_div(struct via686a_data *data)
 	data->fan_div[1] = reg >> 6;
 }
 
-static void __devinit via686a_init_device(struct via686a_data *data)
+static void via686a_init_device(struct via686a_data *data)
 {
 	u8 reg;
 
@@ -833,7 +833,7 @@ static DEFINE_PCI_DEVICE_TABLE(via686a_pci_ids) = {
 };
 MODULE_DEVICE_TABLE(pci, via686a_pci_ids);
 
-static int __devinit via686a_device_add(unsigned short address)
+static int via686a_device_add(unsigned short address)
 {
 	struct resource res = {
 		.start	= address,
@@ -874,7 +874,7 @@ exit:
 	return err;
 }
 
-static int __devinit via686a_pci_probe(struct pci_dev *dev,
+static int via686a_pci_probe(struct pci_dev *dev,
 				       const struct pci_device_id *id)
 {
 	u16 address, val;
diff --git a/drivers/hwmon/vt1211.c b/drivers/hwmon/vt1211.c
index 07ec260..ae02edb 100644
--- a/drivers/hwmon/vt1211.c
+++ b/drivers/hwmon/vt1211.c
@@ -1086,7 +1086,7 @@ static struct device_attribute vt1211_sysfs_misc[] = {
  * Device registration and initialization
  * --------------------------------------------------------------------- */
 
-static void __devinit vt1211_init_device(struct vt1211_data *data)
+static void vt1211_init_device(struct vt1211_data *data)
 {
 	/* set VRM */
 	data->vrm = vid_which_vrm();
@@ -1141,7 +1141,7 @@ static void vt1211_remove_sysfs(struct platform_device *pdev)
 		device_remove_file(dev, &vt1211_sysfs_misc[i]);
 }
 
-static int __devinit vt1211_probe(struct platform_device *pdev)
+static int vt1211_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct vt1211_data *data;
diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
index 28f95bd..a86ef1b 100644
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -772,7 +772,7 @@ static DEFINE_PCI_DEVICE_TABLE(vt8231_pci_ids) = {
 
 MODULE_DEVICE_TABLE(pci, vt8231_pci_ids);
 
-static int __devinit vt8231_pci_probe(struct pci_dev *dev,
+static int vt8231_pci_probe(struct pci_dev *dev,
 				      const struct pci_device_id *id);
 
 static struct pci_driver vt8231_pci_driver = {
@@ -943,7 +943,7 @@ static struct vt8231_data *vt8231_update_device(struct device *dev)
 	return data;
 }
 
-static int __devinit vt8231_device_add(unsigned short address)
+static int vt8231_device_add(unsigned short address)
 {
 	struct resource res = {
 		.start	= address,
@@ -984,7 +984,7 @@ exit:
 	return err;
 }
 
-static int __devinit vt8231_pci_probe(struct pci_dev *dev,
+static int vt8231_pci_probe(struct pci_dev *dev,
 				const struct pci_device_id *id)
 {
 	u16 address, val;
diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 8817cb4..0d4caab 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -1875,7 +1875,7 @@ static void w83627ehf_device_remove_files(struct device *dev)
 }
 
 /* Get the monitoring functions started */
-static inline void __devinit w83627ehf_init_device(struct w83627ehf_data *data,
+static inline void w83627ehf_init_device(struct w83627ehf_data *data,
 						   enum kinds kind)
 {
 	int i;
@@ -1961,7 +1961,7 @@ static void w82627ehf_swap_tempreg(struct w83627ehf_data *data,
 	data->reg_temp_config[r2] = tmp;
 }
 
-static void __devinit
+static void
 w83627ehf_set_temp_reg_ehf(struct w83627ehf_data *data, int n_temp)
 {
 	int i;
@@ -1974,7 +1974,7 @@ w83627ehf_set_temp_reg_ehf(struct w83627ehf_data *data, int n_temp)
 	}
 }
 
-static void __devinit
+static void
 w83627ehf_check_fan_inputs(const struct w83627ehf_sio_data *sio_data,
 			   struct w83627ehf_data *data)
 {
@@ -2063,7 +2063,7 @@ w83627ehf_check_fan_inputs(const struct w83627ehf_sio_data *sio_data,
 	}
 }
 
-static int __devinit w83627ehf_probe(struct platform_device *pdev)
+static int w83627ehf_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct w83627ehf_sio_data *sio_data = dev->platform_data;
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 45bb811..94b38b0 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -1415,7 +1415,7 @@ static const struct attribute_group w83627hf_group_opt = {
 	.attrs = w83627hf_attributes_opt,
 };
 
-static int __devinit w83627hf_probe(struct platform_device *pdev)
+static int w83627hf_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct w83627hf_sio_data *sio_data = dev->platform_data;
@@ -1637,7 +1637,7 @@ static int w83627hf_read_value(struct w83627hf_data *data, u16 reg)
 	return res;
 }
 
-static int __devinit w83627thf_read_gpio5(struct platform_device *pdev)
+static int w83627thf_read_gpio5(struct platform_device *pdev)
 {
 	struct w83627hf_sio_data *sio_data = pdev->dev.platform_data;
 	int res = 0xff, sel;
@@ -1670,7 +1670,7 @@ exit:
 	return res;
 }
 
-static int __devinit w83687thf_read_vid(struct platform_device *pdev)
+static int w83687thf_read_vid(struct platform_device *pdev)
 {
 	struct w83627hf_sio_data *sio_data = pdev->dev.platform_data;
 	int res = 0xff;
@@ -1722,7 +1722,7 @@ static int w83627hf_write_value(struct w83627hf_data *data, u16 reg, u16 value)
 	return 0;
 }
 
-static void __devinit w83627hf_init_device(struct platform_device *pdev)
+static void w83627hf_init_device(struct platform_device *pdev)
 {
 	struct w83627hf_data *data = platform_get_drvdata(pdev);
 	int i;
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index becd9d6..54674a5 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -1764,7 +1764,7 @@ w83781d_write_value(struct w83781d_data *data, u16 reg, u16 value)
 	return 0;
 }
 
-static int __devinit
+static int
 w83781d_isa_probe(struct platform_device *pdev)
 {
 	int err, reg;
diff --git a/drivers/hwmon/wm831x-hwmon.c b/drivers/hwmon/wm831x-hwmon.c
index d77bdf4..81e7166 100644
--- a/drivers/hwmon/wm831x-hwmon.c
+++ b/drivers/hwmon/wm831x-hwmon.c
@@ -157,7 +157,7 @@ static const struct attribute_group wm831x_attr_group = {
 	.attrs	= wm831x_attributes,
 };
 
-static int __devinit wm831x_hwmon_probe(struct platform_device *pdev)
+static int wm831x_hwmon_probe(struct platform_device *pdev)
 {
 	struct wm831x *wm831x = dev_get_drvdata(pdev->dev.parent);
 	struct wm831x_hwmon *hwmon;
diff --git a/drivers/hwmon/wm8350-hwmon.c b/drivers/hwmon/wm8350-hwmon.c
index 9544485..1fd6417 100644
--- a/drivers/hwmon/wm8350-hwmon.c
+++ b/drivers/hwmon/wm8350-hwmon.c
@@ -91,7 +91,7 @@ static const struct attribute_group wm8350_attr_group = {
 	.attrs	= wm8350_attributes,
 };
 
-static int __devinit wm8350_hwmon_probe(struct platform_device *pdev)
+static int wm8350_hwmon_probe(struct platform_device *pdev)
 {
 	struct wm8350 *wm8350 = platform_get_drvdata(pdev);
 	int ret;
-- 
1.8.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
