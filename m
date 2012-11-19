From: Bill Pemberton <wfp5p@virginia.edu>
Date: Mon, 19 Nov 2012 18:25:51 +0000
Subject: [lm-sensors] [PATCH 402/493] hwmon: remove use of __devexit
Message-Id: <1353349642-3677-402-git-send-email-wfp5p@virginia.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

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
 drivers/hwmon/abituguru.c          | 2 +-
 drivers/hwmon/abituguru3.c         | 2 +-
 drivers/hwmon/ad7314.c             | 2 +-
 drivers/hwmon/ad7414.c             | 2 +-
 drivers/hwmon/adcxx.c              | 2 +-
 drivers/hwmon/ads7871.c            | 2 +-
 drivers/hwmon/adt7411.c            | 2 +-
 drivers/hwmon/coretemp.c           | 2 +-
 drivers/hwmon/da9052-hwmon.c       | 2 +-
 drivers/hwmon/da9055-hwmon.c       | 2 +-
 drivers/hwmon/dme1737.c            | 2 +-
 drivers/hwmon/f71805f.c            | 2 +-
 drivers/hwmon/fam15h_power.c       | 2 +-
 drivers/hwmon/gpio-fan.c           | 2 +-
 drivers/hwmon/hih6130.c            | 2 +-
 drivers/hwmon/i5k_amb.c            | 2 +-
 drivers/hwmon/it87.c               | 4 ++--
 drivers/hwmon/jz4740-hwmon.c       | 2 +-
 drivers/hwmon/k10temp.c            | 2 +-
 drivers/hwmon/k8temp.c             | 2 +-
 drivers/hwmon/lm70.c               | 2 +-
 drivers/hwmon/lm78.c               | 2 +-
 drivers/hwmon/max1111.c            | 2 +-
 drivers/hwmon/max197.c             | 2 +-
 drivers/hwmon/mc13783-adc.c        | 2 +-
 drivers/hwmon/ntc_thermistor.c     | 2 +-
 drivers/hwmon/pc87360.c            | 4 ++--
 drivers/hwmon/pc87427.c            | 2 +-
 drivers/hwmon/s3c-hwmon.c          | 2 +-
 drivers/hwmon/sht15.c              | 2 +-
 drivers/hwmon/sht21.c              | 2 +-
 drivers/hwmon/sis5595.c            | 4 ++--
 drivers/hwmon/smsc47b397.c         | 2 +-
 drivers/hwmon/tmp102.c             | 2 +-
 drivers/hwmon/twl4030-madc-hwmon.c | 2 +-
 drivers/hwmon/ultra45_env.c        | 2 +-
 drivers/hwmon/vexpress.c           | 2 +-
 drivers/hwmon/via-cputemp.c        | 2 +-
 drivers/hwmon/via686a.c            | 4 ++--
 drivers/hwmon/vt1211.c             | 2 +-
 drivers/hwmon/vt8231.c             | 4 ++--
 drivers/hwmon/w83627ehf.c          | 2 +-
 drivers/hwmon/w83627hf.c           | 4 ++--
 drivers/hwmon/w83781d.c            | 2 +-
 drivers/hwmon/wm831x-hwmon.c       | 2 +-
 drivers/hwmon/wm8350-hwmon.c       | 2 +-
 46 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
index 700d5e0..6119ff8 100644
--- a/drivers/hwmon/abituguru.c
+++ b/drivers/hwmon/abituguru.c
@@ -1434,7 +1434,7 @@ abituguru_probe_error:
 	return res;
 }
 
-static int __devexit abituguru_remove(struct platform_device *pdev)
+static int abituguru_remove(struct platform_device *pdev)
 {
 	int i;
 	struct abituguru_data *data = platform_get_drvdata(pdev);
diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index b8d0942..205327d 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -1072,7 +1072,7 @@ abituguru3_probe_error:
 	return res;
 }
 
-static int __devexit abituguru3_remove(struct platform_device *pdev)
+static int abituguru3_remove(struct platform_device *pdev)
 {
 	int i;
 	struct abituguru3_data *data = platform_get_drvdata(pdev);
diff --git a/drivers/hwmon/ad7314.c b/drivers/hwmon/ad7314.c
index defd34b..a57584d 100644
--- a/drivers/hwmon/ad7314.c
+++ b/drivers/hwmon/ad7314.c
@@ -135,7 +135,7 @@ error_remove_group:
 	return ret;
 }
 
-static int __devexit ad7314_remove(struct spi_device *spi_dev)
+static int ad7314_remove(struct spi_device *spi_dev)
 {
 	struct ad7314_data *chip = dev_get_drvdata(&spi_dev->dev);
 
diff --git a/drivers/hwmon/ad7414.c b/drivers/hwmon/ad7414.c
index 20276ca..f3a5d47 100644
--- a/drivers/hwmon/ad7414.c
+++ b/drivers/hwmon/ad7414.c
@@ -226,7 +226,7 @@ exit_remove:
 	return err;
 }
 
-static int __devexit ad7414_remove(struct i2c_client *client)
+static int ad7414_remove(struct i2c_client *client)
 {
 	struct ad7414_data *data = i2c_get_clientdata(client);
 
diff --git a/drivers/hwmon/adcxx.c b/drivers/hwmon/adcxx.c
index ecc1e6c..751b1f0 100644
--- a/drivers/hwmon/adcxx.c
+++ b/drivers/hwmon/adcxx.c
@@ -208,7 +208,7 @@ out_err:
 	return status;
 }
 
-static int __devexit adcxx_remove(struct spi_device *spi)
+static int adcxx_remove(struct spi_device *spi)
 {
 	struct adcxx *adc = spi_get_drvdata(spi);
 	int i;
diff --git a/drivers/hwmon/ads7871.c b/drivers/hwmon/ads7871.c
index 41a7837..a798759 100644
--- a/drivers/hwmon/ads7871.c
+++ b/drivers/hwmon/ads7871.c
@@ -225,7 +225,7 @@ error_remove:
 	return err;
 }
 
-static int __devexit ads7871_remove(struct spi_device *spi)
+static int ads7871_remove(struct spi_device *spi)
 {
 	struct ads7871_data *pdata = spi_get_drvdata(spi);
 
diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
index 68a5da7..34ff03a 100644
--- a/drivers/hwmon/adt7411.c
+++ b/drivers/hwmon/adt7411.c
@@ -317,7 +317,7 @@ static int adt7411_probe(struct i2c_client *client,
 	return ret;
 }
 
-static int __devexit adt7411_remove(struct i2c_client *client)
+static int adt7411_remove(struct i2c_client *client)
 {
 	struct adt7411_data *data = i2c_get_clientdata(client);
 
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index c336afc..d64923d 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -584,7 +584,7 @@ exit_free:
 	return err;
 }
 
-static int __devexit coretemp_remove(struct platform_device *pdev)
+static int coretemp_remove(struct platform_device *pdev)
 {
 	struct platform_data *pdata = platform_get_drvdata(pdev);
 	int i;
diff --git a/drivers/hwmon/da9052-hwmon.c b/drivers/hwmon/da9052-hwmon.c
index 7c53a23..ab4452c 100644
--- a/drivers/hwmon/da9052-hwmon.c
+++ b/drivers/hwmon/da9052-hwmon.c
@@ -303,7 +303,7 @@ err_mem:
 	return ret;
 }
 
-static int __devexit da9052_hwmon_remove(struct platform_device *pdev)
+static int da9052_hwmon_remove(struct platform_device *pdev)
 {
 	struct da9052_hwmon *hwmon = platform_get_drvdata(pdev);
 
diff --git a/drivers/hwmon/da9055-hwmon.c b/drivers/hwmon/da9055-hwmon.c
index cd35f46..9465c05 100644
--- a/drivers/hwmon/da9055-hwmon.c
+++ b/drivers/hwmon/da9055-hwmon.c
@@ -309,7 +309,7 @@ err:
 	return ret;
 }
 
-static int __devexit da9055_hwmon_remove(struct platform_device *pdev)
+static int da9055_hwmon_remove(struct platform_device *pdev)
 {
 	struct da9055_hwmon *hwmon = platform_get_drvdata(pdev);
 
diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
index aa6a493..7430f70 100644
--- a/drivers/hwmon/dme1737.c
+++ b/drivers/hwmon/dme1737.c
@@ -2718,7 +2718,7 @@ exit_remove_files:
 	return err;
 }
 
-static int __devexit dme1737_isa_remove(struct platform_device *pdev)
+static int dme1737_isa_remove(struct platform_device *pdev)
 {
 	struct dme1737_data *data = platform_get_drvdata(pdev);
 
diff --git a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
index 0c8426e..a981697 100644
--- a/drivers/hwmon/f71805f.c
+++ b/drivers/hwmon/f71805f.c
@@ -1490,7 +1490,7 @@ exit_remove_files:
 	return err;
 }
 
-static int __devexit f71805f_remove(struct platform_device *pdev)
+static int f71805f_remove(struct platform_device *pdev)
 {
 	struct f71805f_data *data = platform_get_drvdata(pdev);
 	int i;
diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 4eca298..5cec685 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -235,7 +235,7 @@ exit_remove_group:
 	return err;
 }
 
-static void __devexit fam15h_power_remove(struct pci_dev *pdev)
+static void fam15h_power_remove(struct pci_dev *pdev)
 {
 	struct device *dev;
 	struct fam15h_power_data *data;
diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index 0f46cca..4e04c12 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -581,7 +581,7 @@ err_free_alarm:
 	return err;
 }
 
-static int __devexit gpio_fan_remove(struct platform_device *pdev)
+static int gpio_fan_remove(struct platform_device *pdev)
 {
 	struct gpio_fan_data *fan_data = platform_get_drvdata(pdev);
 
diff --git a/drivers/hwmon/hih6130.c b/drivers/hwmon/hih6130.c
index 5c65aef..2dc37c7 100644
--- a/drivers/hwmon/hih6130.c
+++ b/drivers/hwmon/hih6130.c
@@ -263,7 +263,7 @@ fail_remove_sysfs:
  * hih6130_remove() - remove device
  * @client: I2C client device
  */
-static int __devexit hih6130_remove(struct i2c_client *client)
+static int hih6130_remove(struct i2c_client *client)
 {
 	struct hih6130 *hih6130 = i2c_get_clientdata(client);
 
diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
index f3bc723..b87c2cc 100644
--- a/drivers/hwmon/i5k_amb.c
+++ b/drivers/hwmon/i5k_amb.c
@@ -564,7 +564,7 @@ err:
 	return res;
 }
 
-static int __devexit i5k_amb_remove(struct platform_device *pdev)
+static int i5k_amb_remove(struct platform_device *pdev)
 {
 	int i;
 	struct i5k_amb_data *data = platform_get_drvdata(pdev);
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 467b7d4..117d66f 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -456,7 +456,7 @@ static const unsigned int pwm_freq[8] = {
 };
 
 static int it87_probe(struct platform_device *pdev);
-static int __devexit it87_remove(struct platform_device *pdev);
+static int it87_remove(struct platform_device *pdev);
 
 static int it87_read_value(struct it87_data *data, u8 reg);
 static void it87_write_value(struct it87_data *data, u8 reg, u8 value);
@@ -2194,7 +2194,7 @@ error:
 	return err;
 }
 
-static int __devexit it87_remove(struct platform_device *pdev)
+static int it87_remove(struct platform_device *pdev)
 {
 	struct it87_data *data = platform_get_drvdata(pdev);
 
diff --git a/drivers/hwmon/jz4740-hwmon.c b/drivers/hwmon/jz4740-hwmon.c
index b944d61..e0d66b9 100644
--- a/drivers/hwmon/jz4740-hwmon.c
+++ b/drivers/hwmon/jz4740-hwmon.c
@@ -172,7 +172,7 @@ err_remove_file:
 	return ret;
 }
 
-static int __devexit jz4740_hwmon_remove(struct platform_device *pdev)
+static int jz4740_hwmon_remove(struct platform_device *pdev)
 {
 	struct jz4740_hwmon *hwmon = platform_get_drvdata(pdev);
 
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index da8acda..e3b037c 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -192,7 +192,7 @@ exit:
 	return err;
 }
 
-static void __devexit k10temp_remove(struct pci_dev *pdev)
+static void k10temp_remove(struct pci_dev *pdev)
 {
 	hwmon_device_unregister(pci_get_drvdata(pdev));
 	device_remove_file(&pdev->dev, &dev_attr_name);
diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index 8c46753..9f3c0ae 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -304,7 +304,7 @@ exit_remove:
 	return err;
 }
 
-static void __devexit k8temp_remove(struct pci_dev *pdev)
+static void k8temp_remove(struct pci_dev *pdev)
 {
 	struct k8temp_data *data = pci_get_drvdata(pdev);
 
diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index d5f006e..016efa2 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -178,7 +178,7 @@ out_dev_create_temp_file_failed:
 	return status;
 }
 
-static int __devexit lm70_remove(struct spi_device *spi)
+static int lm70_remove(struct spi_device *spi)
 {
 	struct lm70 *p_lm70 = spi_get_drvdata(spi);
 
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index 181d756..53d6ee8 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -886,7 +886,7 @@ static int lm78_isa_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int __devexit lm78_isa_remove(struct platform_device *pdev)
+static int lm78_isa_remove(struct platform_device *pdev)
 {
 	struct lm78_data *data = platform_get_drvdata(pdev);
 
diff --git a/drivers/hwmon/max1111.c b/drivers/hwmon/max1111.c
index 410351b..eda077d 100644
--- a/drivers/hwmon/max1111.c
+++ b/drivers/hwmon/max1111.c
@@ -256,7 +256,7 @@ err_remove:
 	return err;
 }
 
-static int __devexit max1111_remove(struct spi_device *spi)
+static int max1111_remove(struct spi_device *spi)
 {
 	struct max1111_data *data = spi_get_drvdata(spi);
 
diff --git a/drivers/hwmon/max197.c b/drivers/hwmon/max197.c
index 76c941e..b5ebb91 100644
--- a/drivers/hwmon/max197.c
+++ b/drivers/hwmon/max197.c
@@ -316,7 +316,7 @@ error:
 	return ret;
 }
 
-static int __devexit max197_remove(struct platform_device *pdev)
+static int max197_remove(struct platform_device *pdev)
 {
 	struct max197_data *data = platform_get_drvdata(pdev);
 
diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
index 50032ee..2a7f331 100644
--- a/drivers/hwmon/mc13783-adc.c
+++ b/drivers/hwmon/mc13783-adc.c
@@ -233,7 +233,7 @@ out_err_create_16chans:
 	return ret;
 }
 
-static int __devexit mc13783_adc_remove(struct platform_device *pdev)
+static int mc13783_adc_remove(struct platform_device *pdev)
 {
 	struct mc13783_adc_priv *priv = platform_get_drvdata(pdev);
 	kernel_ulong_t driver_data = platform_get_device_id(pdev)->driver_data;
diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index ac4f403..a87eb89 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -393,7 +393,7 @@ err_after_sysfs:
 	return ret;
 }
 
-static int __devexit ntc_thermistor_remove(struct platform_device *pdev)
+static int ntc_thermistor_remove(struct platform_device *pdev)
 {
 	struct ntc_data *data = platform_get_drvdata(pdev);
 
diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index b4c11c6..e35856b 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -228,7 +228,7 @@ struct pc87360_data {
  */
 
 static int pc87360_probe(struct platform_device *pdev);
-static int __devexit pc87360_remove(struct platform_device *pdev);
+static int pc87360_remove(struct platform_device *pdev);
 
 static int pc87360_read_value(struct pc87360_data *data, u8 ldi, u8 bank,
 			      u8 reg);
@@ -1375,7 +1375,7 @@ error:
 	return err;
 }
 
-static int __devexit pc87360_remove(struct platform_device *pdev)
+static int pc87360_remove(struct platform_device *pdev)
 {
 	struct pc87360_data *data = platform_get_drvdata(pdev);
 
diff --git a/drivers/hwmon/pc87427.c b/drivers/hwmon/pc87427.c
index 36a0d17..6086ad0 100644
--- a/drivers/hwmon/pc87427.c
+++ b/drivers/hwmon/pc87427.c
@@ -1141,7 +1141,7 @@ exit_remove_files:
 	return err;
 }
 
-static int __devexit pc87427_remove(struct platform_device *pdev)
+static int pc87427_remove(struct platform_device *pdev)
 {
 	struct pc87427_data *data = platform_get_drvdata(pdev);
 
diff --git a/drivers/hwmon/s3c-hwmon.c b/drivers/hwmon/s3c-hwmon.c
index 397e2ad..ff2ae02 100644
--- a/drivers/hwmon/s3c-hwmon.c
+++ b/drivers/hwmon/s3c-hwmon.c
@@ -364,7 +364,7 @@ static int s3c_hwmon_probe(struct platform_device *dev)
 	return ret;
 }
 
-static int __devexit s3c_hwmon_remove(struct platform_device *dev)
+static int s3c_hwmon_remove(struct platform_device *dev)
 {
 	struct s3c_hwmon *hwmon = platform_get_drvdata(dev);
 	int i;
diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index d5b79e7..1c85d39 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -1002,7 +1002,7 @@ err_release_reg:
 	return ret;
 }
 
-static int __devexit sht15_remove(struct platform_device *pdev)
+static int sht15_remove(struct platform_device *pdev)
 {
 	struct sht15_data *data = platform_get_drvdata(pdev);
 
diff --git a/drivers/hwmon/sht21.c b/drivers/hwmon/sht21.c
index 9a4cc3b..2e9f957 100644
--- a/drivers/hwmon/sht21.c
+++ b/drivers/hwmon/sht21.c
@@ -233,7 +233,7 @@ fail_remove_sysfs:
  * sht21_remove() - remove device
  * @client: I2C client device
  */
-static int __devexit sht21_remove(struct i2c_client *client)
+static int sht21_remove(struct i2c_client *client)
 {
 	struct sht21 *sht21 = i2c_get_clientdata(client);
 
diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index e84836b..06ce3c9 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -204,7 +204,7 @@ struct sis5595_data {
 static struct pci_dev *s_bridge;	/* pointer to the (only) sis5595 */
 
 static int sis5595_probe(struct platform_device *pdev);
-static int __devexit sis5595_remove(struct platform_device *pdev);
+static int sis5595_remove(struct platform_device *pdev);
 
 static int sis5595_read_value(struct sis5595_data *data, u8 reg);
 static void sis5595_write_value(struct sis5595_data *data, u8 reg, u8 value);
@@ -659,7 +659,7 @@ exit_remove_files:
 	return err;
 }
 
-static int __devexit sis5595_remove(struct platform_device *pdev)
+static int sis5595_remove(struct platform_device *pdev)
 {
 	struct sis5595_data *data = platform_get_drvdata(pdev);
 
diff --git a/drivers/hwmon/smsc47b397.c b/drivers/hwmon/smsc47b397.c
index 9100a27..81348fa 100644
--- a/drivers/hwmon/smsc47b397.c
+++ b/drivers/hwmon/smsc47b397.c
@@ -228,7 +228,7 @@ static const struct attribute_group smsc47b397_group = {
 	.attrs = smsc47b397_attributes,
 };
 
-static int __devexit smsc47b397_remove(struct platform_device *pdev)
+static int smsc47b397_remove(struct platform_device *pdev)
 {
 	struct smsc47b397_data *data = platform_get_drvdata(pdev);
 
diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index bd8e4af..b10c3d3 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -216,7 +216,7 @@ fail_restore_config:
 	return status;
 }
 
-static int __devexit tmp102_remove(struct i2c_client *client)
+static int tmp102_remove(struct i2c_client *client)
 {
 	struct tmp102 *tmp102 = i2c_get_clientdata(client);
 
diff --git a/drivers/hwmon/twl4030-madc-hwmon.c b/drivers/hwmon/twl4030-madc-hwmon.c
index 6b42f41..149d44a 100644
--- a/drivers/hwmon/twl4030-madc-hwmon.c
+++ b/drivers/hwmon/twl4030-madc-hwmon.c
@@ -120,7 +120,7 @@ err_sysfs:
 	return ret;
 }
 
-static int __devexit twl4030_madc_hwmon_remove(struct platform_device *pdev)
+static int twl4030_madc_hwmon_remove(struct platform_device *pdev)
 {
 	hwmon_device_unregister(&pdev->dev);
 	sysfs_remove_group(&pdev->dev.kobj, &twl4030_madc_group);
diff --git a/drivers/hwmon/ultra45_env.c b/drivers/hwmon/ultra45_env.c
index 4a06fc0..fb3e693 100644
--- a/drivers/hwmon/ultra45_env.c
+++ b/drivers/hwmon/ultra45_env.c
@@ -291,7 +291,7 @@ out_free:
 	goto out;
 }
 
-static int __devexit env_remove(struct platform_device *op)
+static int env_remove(struct platform_device *op)
 {
 	struct env *p = platform_get_drvdata(op);
 
diff --git a/drivers/hwmon/vexpress.c b/drivers/hwmon/vexpress.c
index 1b77957..86d7f6d 100644
--- a/drivers/hwmon/vexpress.c
+++ b/drivers/hwmon/vexpress.c
@@ -196,7 +196,7 @@ error:
 	return err;
 }
 
-static int __devexit vexpress_hwmon_remove(struct platform_device *pdev)
+static int vexpress_hwmon_remove(struct platform_device *pdev)
 {
 	struct vexpress_hwmon_data *data = platform_get_drvdata(pdev);
 	const struct of_device_id *match;
diff --git a/drivers/hwmon/via-cputemp.c b/drivers/hwmon/via-cputemp.c
index b86ad79..76f157b 100644
--- a/drivers/hwmon/via-cputemp.c
+++ b/drivers/hwmon/via-cputemp.c
@@ -192,7 +192,7 @@ exit_remove:
 	return err;
 }
 
-static int __devexit via_cputemp_remove(struct platform_device *pdev)
+static int via_cputemp_remove(struct platform_device *pdev)
 {
 	struct via_cputemp_data *data = platform_get_drvdata(pdev);
 
diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
index 9d6e27e..e0e14a9 100644
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -339,7 +339,7 @@ struct via686a_data {
 static struct pci_dev *s_bridge;	/* pointer to the (only) via686a */
 
 static int via686a_probe(struct platform_device *pdev);
-static int __devexit via686a_remove(struct platform_device *pdev);
+static int via686a_remove(struct platform_device *pdev);
 
 static inline int via686a_read_value(struct via686a_data *data, u8 reg)
 {
@@ -728,7 +728,7 @@ exit_remove_files:
 	return err;
 }
 
-static int __devexit via686a_remove(struct platform_device *pdev)
+static int via686a_remove(struct platform_device *pdev)
 {
 	struct via686a_data *data = platform_get_drvdata(pdev);
 
diff --git a/drivers/hwmon/vt1211.c b/drivers/hwmon/vt1211.c
index ae02edb..7517030 100644
--- a/drivers/hwmon/vt1211.c
+++ b/drivers/hwmon/vt1211.c
@@ -1217,7 +1217,7 @@ EXIT_DEV_REMOVE_SILENT:
 	return err;
 }
 
-static int __devexit vt1211_remove(struct platform_device *pdev)
+static int vt1211_remove(struct platform_device *pdev)
 {
 	struct vt1211_data *data = platform_get_drvdata(pdev);
 
diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
index a86ef1b..a56355c 100644
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -176,7 +176,7 @@ struct vt8231_data {
 
 static struct pci_dev *s_bridge;
 static int vt8231_probe(struct platform_device *pdev);
-static int __devexit vt8231_remove(struct platform_device *pdev);
+static int vt8231_remove(struct platform_device *pdev);
 static struct vt8231_data *vt8231_update_device(struct device *dev);
 static void vt8231_init_device(struct vt8231_data *data);
 
@@ -851,7 +851,7 @@ exit_remove_files:
 	return err;
 }
 
-static int __devexit vt8231_remove(struct platform_device *pdev)
+static int vt8231_remove(struct platform_device *pdev)
 {
 	struct vt8231_data *data = platform_get_drvdata(pdev);
 	int i;
diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 0d4caab..0e8ffd6 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -2605,7 +2605,7 @@ exit:
 	return err;
 }
 
-static int __devexit w83627ehf_remove(struct platform_device *pdev)
+static int w83627ehf_remove(struct platform_device *pdev)
 {
 	struct w83627ehf_data *data = platform_get_drvdata(pdev);
 
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 94b38b0..81f4865 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -399,7 +399,7 @@ struct w83627hf_data {
 
 
 static int w83627hf_probe(struct platform_device *pdev);
-static int __devexit w83627hf_remove(struct platform_device *pdev);
+static int w83627hf_remove(struct platform_device *pdev);
 
 static int w83627hf_read_value(struct w83627hf_data *data, u16 reg);
 static int w83627hf_write_value(struct w83627hf_data *data, u16 reg, u16 value);
@@ -1581,7 +1581,7 @@ static int w83627hf_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int __devexit w83627hf_remove(struct platform_device *pdev)
+static int w83627hf_remove(struct platform_device *pdev)
 {
 	struct w83627hf_data *data = platform_get_drvdata(pdev);
 
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index 54674a5..93bd286 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -1824,7 +1824,7 @@ w83781d_isa_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int __devexit
+static int
 w83781d_isa_remove(struct platform_device *pdev)
 {
 	struct w83781d_data *data = platform_get_drvdata(pdev);
diff --git a/drivers/hwmon/wm831x-hwmon.c b/drivers/hwmon/wm831x-hwmon.c
index 81e7166..df6ceaf 100644
--- a/drivers/hwmon/wm831x-hwmon.c
+++ b/drivers/hwmon/wm831x-hwmon.c
@@ -189,7 +189,7 @@ err_sysfs:
 	return ret;
 }
 
-static int __devexit wm831x_hwmon_remove(struct platform_device *pdev)
+static int wm831x_hwmon_remove(struct platform_device *pdev)
 {
 	struct wm831x_hwmon *hwmon = platform_get_drvdata(pdev);
 
diff --git a/drivers/hwmon/wm8350-hwmon.c b/drivers/hwmon/wm8350-hwmon.c
index 1fd6417..64bf75c 100644
--- a/drivers/hwmon/wm8350-hwmon.c
+++ b/drivers/hwmon/wm8350-hwmon.c
@@ -114,7 +114,7 @@ err:
 	return ret;
 }
 
-static int __devexit wm8350_hwmon_remove(struct platform_device *pdev)
+static int wm8350_hwmon_remove(struct platform_device *pdev)
 {
 	struct wm8350 *wm8350 = platform_get_drvdata(pdev);
 
-- 
1.8.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
