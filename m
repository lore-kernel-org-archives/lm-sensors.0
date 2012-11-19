From: Bill Pemberton <wfp5p@virginia.edu>
Date: Mon, 19 Nov 2012 18:21:20 +0000
Subject: [lm-sensors] [PATCH 131/493] hwmon: remove use of __devexit_p
Message-Id: <1353349642-3677-131-git-send-email-wfp5p@virginia.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
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
 drivers/hwmon/abituguru.c      | 2 +-
 drivers/hwmon/abituguru3.c     | 2 +-
 drivers/hwmon/ad7314.c         | 2 +-
 drivers/hwmon/ad7414.c         | 2 +-
 drivers/hwmon/adcxx.c          | 2 +-
 drivers/hwmon/ads7871.c        | 2 +-
 drivers/hwmon/adt7411.c        | 2 +-
 drivers/hwmon/coretemp.c       | 2 +-
 drivers/hwmon/da9052-hwmon.c   | 2 +-
 drivers/hwmon/da9055-hwmon.c   | 2 +-
 drivers/hwmon/dme1737.c        | 2 +-
 drivers/hwmon/f71805f.c        | 2 +-
 drivers/hwmon/fam15h_power.c   | 2 +-
 drivers/hwmon/gpio-fan.c       | 2 +-
 drivers/hwmon/hih6130.c        | 2 +-
 drivers/hwmon/i5k_amb.c        | 2 +-
 drivers/hwmon/it87.c           | 2 +-
 drivers/hwmon/jz4740-hwmon.c   | 2 +-
 drivers/hwmon/k10temp.c        | 2 +-
 drivers/hwmon/k8temp.c         | 2 +-
 drivers/hwmon/lm70.c           | 2 +-
 drivers/hwmon/lm78.c           | 2 +-
 drivers/hwmon/max1111.c        | 2 +-
 drivers/hwmon/max197.c         | 2 +-
 drivers/hwmon/mc13783-adc.c    | 2 +-
 drivers/hwmon/ntc_thermistor.c | 2 +-
 drivers/hwmon/pc87360.c        | 2 +-
 drivers/hwmon/pc87427.c        | 2 +-
 drivers/hwmon/s3c-hwmon.c      | 2 +-
 drivers/hwmon/sht15.c          | 2 +-
 drivers/hwmon/sht21.c          | 2 +-
 drivers/hwmon/sis5595.c        | 2 +-
 drivers/hwmon/smsc47b397.c     | 2 +-
 drivers/hwmon/tmp102.c         | 2 +-
 drivers/hwmon/ultra45_env.c    | 2 +-
 drivers/hwmon/vexpress.c       | 2 +-
 drivers/hwmon/via-cputemp.c    | 2 +-
 drivers/hwmon/via686a.c        | 2 +-
 drivers/hwmon/vt1211.c         | 2 +-
 drivers/hwmon/vt8231.c         | 2 +-
 drivers/hwmon/w83627ehf.c      | 2 +-
 drivers/hwmon/w83627hf.c       | 2 +-
 drivers/hwmon/w83781d.c        | 2 +-
 drivers/hwmon/wm831x-hwmon.c   | 2 +-
 drivers/hwmon/wm8350-hwmon.c   | 2 +-
 45 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
index 78b8179..d12c3fb 100644
--- a/drivers/hwmon/abituguru.c
+++ b/drivers/hwmon/abituguru.c
@@ -1545,7 +1545,7 @@ static struct platform_driver abituguru_driver = {
 		.pm	= ABIT_UGURU_PM,
 	},
 	.probe		= abituguru_probe,
-	.remove		= __devexit_p(abituguru_remove),
+	.remove		= abituguru_remove,
 };
 
 static int __init abituguru_detect(void)
diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index b174b8b..56a8075 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -1171,7 +1171,7 @@ static struct platform_driver abituguru3_driver = {
 		.pm	= ABIT_UGURU3_PM
 	},
 	.probe	= abituguru3_probe,
-	.remove	= __devexit_p(abituguru3_remove),
+	.remove	= abituguru3_remove,
 };
 
 static int __init abituguru3_dmi_detect(void)
diff --git a/drivers/hwmon/ad7314.c b/drivers/hwmon/ad7314.c
index 37c01e7..fdda321 100644
--- a/drivers/hwmon/ad7314.c
+++ b/drivers/hwmon/ad7314.c
@@ -159,7 +159,7 @@ static struct spi_driver ad7314_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ad7314_probe,
-	.remove = __devexit_p(ad7314_remove),
+	.remove = ad7314_remove,
 	.id_table = ad7314_id,
 };
 
diff --git a/drivers/hwmon/ad7414.c b/drivers/hwmon/ad7414.c
index b420fb3..20276ca 100644
--- a/drivers/hwmon/ad7414.c
+++ b/drivers/hwmon/ad7414.c
@@ -246,7 +246,7 @@ static struct i2c_driver ad7414_driver = {
 		.name	= "ad7414",
 	},
 	.probe	= ad7414_probe,
-	.remove	= __devexit_p(ad7414_remove),
+	.remove	= ad7414_remove,
 	.id_table = ad7414_id,
 };
 
diff --git a/drivers/hwmon/adcxx.c b/drivers/hwmon/adcxx.c
index f4c5867..dff6f4f 100644
--- a/drivers/hwmon/adcxx.c
+++ b/drivers/hwmon/adcxx.c
@@ -240,7 +240,7 @@ static struct spi_driver adcxx_driver = {
 	},
 	.id_table = adcxx_ids,
 	.probe	= adcxx_probe,
-	.remove	= __devexit_p(adcxx_remove),
+	.remove	= adcxx_remove,
 };
 
 module_spi_driver(adcxx_driver);
diff --git a/drivers/hwmon/ads7871.c b/drivers/hwmon/ads7871.c
index 1b53aa4..5a6cc1f 100644
--- a/drivers/hwmon/ads7871.c
+++ b/drivers/hwmon/ads7871.c
@@ -241,7 +241,7 @@ static struct spi_driver ads7871_driver = {
 	},
 
 	.probe = ads7871_probe,
-	.remove = __devexit_p(ads7871_remove),
+	.remove = ads7871_remove,
 };
 
 module_spi_driver(ads7871_driver);
diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
index 517f185..a961af6 100644
--- a/drivers/hwmon/adt7411.c
+++ b/drivers/hwmon/adt7411.c
@@ -337,7 +337,7 @@ static struct i2c_driver adt7411_driver = {
 		.name		= "adt7411",
 	},
 	.probe  = adt7411_probe,
-	.remove	= __devexit_p(adt7411_remove),
+	.remove	= adt7411_remove,
 	.id_table = adt7411_id,
 	.detect = adt7411_detect,
 	.address_list = normal_i2c,
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 24426a7..6df893b 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -606,7 +606,7 @@ static struct platform_driver coretemp_driver = {
 		.name = DRVNAME,
 	},
 	.probe = coretemp_probe,
-	.remove = __devexit_p(coretemp_remove),
+	.remove = coretemp_remove,
 };
 
 static int __cpuinit coretemp_device_add(unsigned int cpu)
diff --git a/drivers/hwmon/da9052-hwmon.c b/drivers/hwmon/da9052-hwmon.c
index 1970494..d919ed6 100644
--- a/drivers/hwmon/da9052-hwmon.c
+++ b/drivers/hwmon/da9052-hwmon.c
@@ -315,7 +315,7 @@ static int __devexit da9052_hwmon_remove(struct platform_device *pdev)
 
 static struct platform_driver da9052_hwmon_driver = {
 	.probe = da9052_hwmon_probe,
-	.remove = __devexit_p(da9052_hwmon_remove),
+	.remove = da9052_hwmon_remove,
 	.driver = {
 		.name = "da9052-hwmon",
 		.owner = THIS_MODULE,
diff --git a/drivers/hwmon/da9055-hwmon.c b/drivers/hwmon/da9055-hwmon.c
index 3a3377c..bd8b695 100644
--- a/drivers/hwmon/da9055-hwmon.c
+++ b/drivers/hwmon/da9055-hwmon.c
@@ -321,7 +321,7 @@ static int __devexit da9055_hwmon_remove(struct platform_device *pdev)
 
 static struct platform_driver da9055_hwmon_driver = {
 	.probe = da9055_hwmon_probe,
-	.remove = __devexit_p(da9055_hwmon_remove),
+	.remove = da9055_hwmon_remove,
 	.driver = {
 		.name = "da9055-hwmon",
 		.owner = THIS_MODULE,
diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
index fe0eeec..32f81ca 100644
--- a/drivers/hwmon/dme1737.c
+++ b/drivers/hwmon/dme1737.c
@@ -2734,7 +2734,7 @@ static struct platform_driver dme1737_isa_driver = {
 		.name = "dme1737",
 	},
 	.probe = dme1737_isa_probe,
-	.remove = __devexit_p(dme1737_isa_remove),
+	.remove = dme1737_isa_remove,
 };
 
 /* ---------------------------------------------------------------------
diff --git a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
index 4dd7723..56860dd 100644
--- a/drivers/hwmon/f71805f.c
+++ b/drivers/hwmon/f71805f.c
@@ -1510,7 +1510,7 @@ static struct platform_driver f71805f_driver = {
 		.name	= DRVNAME,
 	},
 	.probe		= f71805f_probe,
-	.remove		= __devexit_p(f71805f_remove),
+	.remove		= f71805f_remove,
 };
 
 static int __init f71805f_device_add(unsigned short address,
diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 4f41104..327fbc6 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -256,7 +256,7 @@ static struct pci_driver fam15h_power_driver = {
 	.name = "fam15h_power",
 	.id_table = fam15h_power_id_table,
 	.probe = fam15h_power_probe,
-	.remove = __devexit_p(fam15h_power_remove),
+	.remove = fam15h_power_remove,
 	.resume = fam15h_power_resume,
 };
 
diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index 1381a2e..4b1767f 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -626,7 +626,7 @@ static SIMPLE_DEV_PM_OPS(gpio_fan_pm, gpio_fan_suspend, gpio_fan_resume);
 
 static struct platform_driver gpio_fan_driver = {
 	.probe		= gpio_fan_probe,
-	.remove		= __devexit_p(gpio_fan_remove),
+	.remove		= gpio_fan_remove,
 	.driver	= {
 		.name	= "gpio-fan",
 		.pm	= GPIO_FAN_PM,
diff --git a/drivers/hwmon/hih6130.c b/drivers/hwmon/hih6130.c
index 9a675ef..9ebe24e 100644
--- a/drivers/hwmon/hih6130.c
+++ b/drivers/hwmon/hih6130.c
@@ -283,7 +283,7 @@ MODULE_DEVICE_TABLE(i2c, hih6130_id);
 static struct i2c_driver hih6130_driver = {
 	.driver.name = "hih6130",
 	.probe       = hih6130_probe,
-	.remove      = __devexit_p(hih6130_remove),
+	.remove      = hih6130_remove,
 	.id_table    = hih6130_id,
 };
 
diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
index 46141ab..3fa3cc8 100644
--- a/drivers/hwmon/i5k_amb.c
+++ b/drivers/hwmon/i5k_amb.c
@@ -587,7 +587,7 @@ static struct platform_driver i5k_amb_driver = {
 		.name = DRVNAME,
 	},
 	.probe = i5k_amb_probe,
-	.remove = __devexit_p(i5k_amb_remove),
+	.remove = i5k_amb_remove,
 };
 
 static int __init i5k_amb_init(void)
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 6a1410b..94f40c2 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -471,7 +471,7 @@ static struct platform_driver it87_driver = {
 		.name	= DRVNAME,
 	},
 	.probe	= it87_probe,
-	.remove	= __devexit_p(it87_remove),
+	.remove	= it87_remove,
 };
 
 static ssize_t show_in(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/hwmon/jz4740-hwmon.c b/drivers/hwmon/jz4740-hwmon.c
index dee9eec..fca0d37 100644
--- a/drivers/hwmon/jz4740-hwmon.c
+++ b/drivers/hwmon/jz4740-hwmon.c
@@ -184,7 +184,7 @@ static int __devexit jz4740_hwmon_remove(struct platform_device *pdev)
 
 static struct platform_driver jz4740_hwmon_driver = {
 	.probe	= jz4740_hwmon_probe,
-	.remove = __devexit_p(jz4740_hwmon_remove),
+	.remove = jz4740_hwmon_remove,
 	.driver = {
 		.name = "jz4740-hwmon",
 		.owner = THIS_MODULE,
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index f2fe807..2722cde 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -219,7 +219,7 @@ static struct pci_driver k10temp_driver = {
 	.name = "k10temp",
 	.id_table = k10temp_id_table,
 	.probe = k10temp_probe,
-	.remove = __devexit_p(k10temp_remove),
+	.remove = k10temp_remove,
 };
 
 module_pci_driver(k10temp_driver);
diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index e8c7fb0..143a2f8 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -324,7 +324,7 @@ static struct pci_driver k8temp_driver = {
 	.name = "k8temp",
 	.id_table = k8temp_ids,
 	.probe = k8temp_probe,
-	.remove = __devexit_p(k8temp_remove),
+	.remove = k8temp_remove,
 };
 
 module_pci_driver(k8temp_driver);
diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index 2d1777a..d3d5afd 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -207,7 +207,7 @@ static struct spi_driver lm70_driver = {
 	},
 	.id_table = lm70_ids,
 	.probe	= lm70_probe,
-	.remove	= __devexit_p(lm70_remove),
+	.remove	= lm70_remove,
 };
 
 module_spi_driver(lm70_driver);
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index c6ffafe..1dc3433 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -903,7 +903,7 @@ static struct platform_driver lm78_isa_driver = {
 		.name	= "lm78",
 	},
 	.probe		= lm78_isa_probe,
-	.remove		= __devexit_p(lm78_isa_remove),
+	.remove		= lm78_isa_remove,
 };
 
 /* return 1 if a supported chip is found, 0 otherwise */
diff --git a/drivers/hwmon/max1111.c b/drivers/hwmon/max1111.c
index b4eb088..5ac15b0 100644
--- a/drivers/hwmon/max1111.c
+++ b/drivers/hwmon/max1111.c
@@ -283,7 +283,7 @@ static struct spi_driver max1111_driver = {
 	},
 	.id_table	= max1111_ids,
 	.probe		= max1111_probe,
-	.remove		= __devexit_p(max1111_remove),
+	.remove		= max1111_remove,
 };
 
 module_spi_driver(max1111_driver);
diff --git a/drivers/hwmon/max197.c b/drivers/hwmon/max197.c
index 6304f26..170e1b2 100644
--- a/drivers/hwmon/max197.c
+++ b/drivers/hwmon/max197.c
@@ -339,7 +339,7 @@ static struct platform_driver max197_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = max197_probe,
-	.remove = __devexit_p(max197_remove),
+	.remove = max197_remove,
 	.id_table = max197_device_ids,
 };
 module_platform_driver(max197_driver);
diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
index cf47a59..50032ee 100644
--- a/drivers/hwmon/mc13783-adc.c
+++ b/drivers/hwmon/mc13783-adc.c
@@ -265,7 +265,7 @@ static const struct platform_device_id mc13783_adc_idtable[] = {
 MODULE_DEVICE_TABLE(platform, mc13783_adc_idtable);
 
 static struct platform_driver mc13783_adc_driver = {
-	.remove		= __devexit_p(mc13783_adc_remove),
+	.remove		= mc13783_adc_remove,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= DRIVER_NAME,
diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index 74a6c58..dd23230 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -419,7 +419,7 @@ static struct platform_driver ntc_thermistor_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ntc_thermistor_probe,
-	.remove = __devexit_p(ntc_thermistor_remove),
+	.remove = ntc_thermistor_remove,
 	.id_table = ntc_thermistor_id,
 };
 
diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 91d5b2a..0785663 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -248,7 +248,7 @@ static struct platform_driver pc87360_driver = {
 		.name	= "pc87360",
 	},
 	.probe		= pc87360_probe,
-	.remove		= __devexit_p(pc87360_remove),
+	.remove		= pc87360_remove,
 };
 
 /*
diff --git a/drivers/hwmon/pc87427.c b/drivers/hwmon/pc87427.c
index f185b1f..288a775 100644
--- a/drivers/hwmon/pc87427.c
+++ b/drivers/hwmon/pc87427.c
@@ -1158,7 +1158,7 @@ static struct platform_driver pc87427_driver = {
 		.name	= DRVNAME,
 	},
 	.probe		= pc87427_probe,
-	.remove		= __devexit_p(pc87427_remove),
+	.remove		= pc87427_remove,
 };
 
 static int __init pc87427_device_add(const struct pc87427_sio_data *sio_data)
diff --git a/drivers/hwmon/s3c-hwmon.c b/drivers/hwmon/s3c-hwmon.c
index bcecd02..df405e3 100644
--- a/drivers/hwmon/s3c-hwmon.c
+++ b/drivers/hwmon/s3c-hwmon.c
@@ -386,7 +386,7 @@ static struct platform_driver s3c_hwmon_driver = {
 		.owner		= THIS_MODULE,
 	},
 	.probe		= s3c_hwmon_probe,
-	.remove		= __devexit_p(s3c_hwmon_remove),
+	.remove		= s3c_hwmon_remove,
 };
 
 module_platform_driver(s3c_hwmon_driver);
diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index 07a0c1a..32e3b29 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -1043,7 +1043,7 @@ static struct platform_driver sht15_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = sht15_probe,
-	.remove = __devexit_p(sht15_remove),
+	.remove = sht15_remove,
 	.id_table = sht15_device_ids,
 };
 module_platform_driver(sht15_driver);
diff --git a/drivers/hwmon/sht21.c b/drivers/hwmon/sht21.c
index 5f67546..3ffd3b3 100644
--- a/drivers/hwmon/sht21.c
+++ b/drivers/hwmon/sht21.c
@@ -253,7 +253,7 @@ MODULE_DEVICE_TABLE(i2c, sht21_id);
 static struct i2c_driver sht21_driver = {
 	.driver.name = "sht21",
 	.probe       = sht21_probe,
-	.remove      = __devexit_p(sht21_remove),
+	.remove      = sht21_remove,
 	.id_table    = sht21_id,
 };
 
diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index 8275f0e..fb6b6ed 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -217,7 +217,7 @@ static struct platform_driver sis5595_driver = {
 		.name	= "sis5595",
 	},
 	.probe		= sis5595_probe,
-	.remove		= __devexit_p(sis5595_remove),
+	.remove		= sis5595_remove,
 };
 
 /* 4 Voltages */
diff --git a/drivers/hwmon/smsc47b397.c b/drivers/hwmon/smsc47b397.c
index 65b07de..6edad30 100644
--- a/drivers/hwmon/smsc47b397.c
+++ b/drivers/hwmon/smsc47b397.c
@@ -246,7 +246,7 @@ static struct platform_driver smsc47b397_driver = {
 		.name	= DRVNAME,
 	},
 	.probe		= smsc47b397_probe,
-	.remove		= __devexit_p(smsc47b397_remove),
+	.remove		= smsc47b397_remove,
 };
 
 static int __devinit smsc47b397_probe(struct platform_device *pdev)
diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index b8777e5..ec11400 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -283,7 +283,7 @@ static struct i2c_driver tmp102_driver = {
 	.driver.name	= DRIVER_NAME,
 	.driver.pm	= TMP102_DEV_PM_OPS,
 	.probe		= tmp102_probe,
-	.remove		= __devexit_p(tmp102_remove),
+	.remove		= tmp102_remove,
 	.id_table	= tmp102_id,
 };
 
diff --git a/drivers/hwmon/ultra45_env.c b/drivers/hwmon/ultra45_env.c
index 44136bb..89747b8 100644
--- a/drivers/hwmon/ultra45_env.c
+++ b/drivers/hwmon/ultra45_env.c
@@ -321,7 +321,7 @@ static struct platform_driver env_driver = {
 		.of_match_table = env_match,
 	},
 	.probe		= env_probe,
-	.remove		= __devexit_p(env_remove),
+	.remove		= env_remove,
 };
 
 module_platform_driver(env_driver);
diff --git a/drivers/hwmon/vexpress.c b/drivers/hwmon/vexpress.c
index 59fd126..1b77957 100644
--- a/drivers/hwmon/vexpress.c
+++ b/drivers/hwmon/vexpress.c
@@ -213,7 +213,7 @@ static int __devexit vexpress_hwmon_remove(struct platform_device *pdev)
 
 static struct platform_driver vexpress_hwmon_driver = {
 	.probe = vexpress_hwmon_probe,
-	.remove = __devexit_p(vexpress_hwmon_remove),
+	.remove = vexpress_hwmon_remove,
 	.driver	= {
 		.name = DRVNAME,
 		.owner = THIS_MODULE,
diff --git a/drivers/hwmon/via-cputemp.c b/drivers/hwmon/via-cputemp.c
index 4cddee0..6021b7f 100644
--- a/drivers/hwmon/via-cputemp.c
+++ b/drivers/hwmon/via-cputemp.c
@@ -209,7 +209,7 @@ static struct platform_driver via_cputemp_driver = {
 		.name = DRVNAME,
 	},
 	.probe = via_cputemp_probe,
-	.remove = __devexit_p(via_cputemp_remove),
+	.remove = via_cputemp_remove,
 };
 
 struct pdev_entry {
diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
index 299399a..b2c155d 100644
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -677,7 +677,7 @@ static struct platform_driver via686a_driver = {
 		.name	= "via686a",
 	},
 	.probe		= via686a_probe,
-	.remove		= __devexit_p(via686a_remove),
+	.remove		= via686a_remove,
 };
 
 
diff --git a/drivers/hwmon/vt1211.c b/drivers/hwmon/vt1211.c
index f2c6115..07ec260 100644
--- a/drivers/hwmon/vt1211.c
+++ b/drivers/hwmon/vt1211.c
@@ -1233,7 +1233,7 @@ static struct platform_driver vt1211_driver = {
 		.name  = DRVNAME,
 	},
 	.probe  = vt1211_probe,
-	.remove = __devexit_p(vt1211_remove),
+	.remove = vt1211_remove,
 };
 
 static int __init vt1211_device_add(unsigned short address)
diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
index 84e3dc5..28f95bd 100644
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -762,7 +762,7 @@ static struct platform_driver vt8231_driver = {
 		.name	= "vt8231",
 	},
 	.probe	= vt8231_probe,
-	.remove	= __devexit_p(vt8231_remove),
+	.remove	= vt8231_remove,
 };
 
 static DEFINE_PCI_DEVICE_TABLE(vt8231_pci_ids) = {
diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 3af84fb..8817cb4 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -2711,7 +2711,7 @@ static struct platform_driver w83627ehf_driver = {
 		.pm	= W83627EHF_DEV_PM_OPS,
 	},
 	.probe		= w83627ehf_probe,
-	.remove		= __devexit_p(w83627ehf_remove),
+	.remove		= w83627ehf_remove,
 };
 
 /* w83627ehf_find() looks for a '627 in the Super-I/O config space */
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 060d4ce..45bb811 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -480,7 +480,7 @@ static struct platform_driver w83627hf_driver = {
 		.pm	= W83627HF_DEV_PM_OPS,
 	},
 	.probe		= w83627hf_probe,
-	.remove		= __devexit_p(w83627hf_remove),
+	.remove		= w83627hf_remove,
 };
 
 static ssize_t
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index 20f11d3..becd9d6 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -1842,7 +1842,7 @@ static struct platform_driver w83781d_isa_driver = {
 		.name = "w83781d",
 	},
 	.probe = w83781d_isa_probe,
-	.remove = __devexit_p(w83781d_isa_remove),
+	.remove = w83781d_isa_remove,
 };
 
 /* return 1 if a supported chip is found, 0 otherwise */
diff --git a/drivers/hwmon/wm831x-hwmon.c b/drivers/hwmon/wm831x-hwmon.c
index d0db1f2..d77bdf4 100644
--- a/drivers/hwmon/wm831x-hwmon.c
+++ b/drivers/hwmon/wm831x-hwmon.c
@@ -201,7 +201,7 @@ static int __devexit wm831x_hwmon_remove(struct platform_device *pdev)
 
 static struct platform_driver wm831x_hwmon_driver = {
 	.probe = wm831x_hwmon_probe,
-	.remove = __devexit_p(wm831x_hwmon_remove),
+	.remove = wm831x_hwmon_remove,
 	.driver = {
 		.name = "wm831x-hwmon",
 		.owner = THIS_MODULE,
diff --git a/drivers/hwmon/wm8350-hwmon.c b/drivers/hwmon/wm8350-hwmon.c
index b955756..9544485 100644
--- a/drivers/hwmon/wm8350-hwmon.c
+++ b/drivers/hwmon/wm8350-hwmon.c
@@ -126,7 +126,7 @@ static int __devexit wm8350_hwmon_remove(struct platform_device *pdev)
 
 static struct platform_driver wm8350_hwmon_driver = {
 	.probe = wm8350_hwmon_probe,
-	.remove = __devexit_p(wm8350_hwmon_remove),
+	.remove = wm8350_hwmon_remove,
 	.driver = {
 		.name = "wm8350-hwmon",
 		.owner = THIS_MODULE,
-- 
1.8.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
