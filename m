From: Martin Peres <martin.peres@free.fr>
Date: Sun, 13 Feb 2011 12:18:44 +0000
Subject: [lm-sensors] hwmon API update
Message-Id: <4D57CC24.1040306@free.fr>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070100090608000701020600"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: nouveau <Nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--------------070100090608000701020600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I am working on power management on the nouveau driver and I need a way 
to get data out of and send commands to the i2c drivers from the kernel 
space.

We can already change the clocks of the card, but we need a way to 
monitor the temperature and bump the fan speed if needed.
Another problem with letting users mess with the i2c driver by 
themselves is that some cards use the i2c driver for fan management 
while others don't. This is why I would like to introduce nouveau as an 
hwmon driver, exporting the temperature, fan management and clock speeds 
so as we can use the thermal zone to monitor the temperature and react 
when needed.

So far, we use:
- w83l785ts
- w83781d
- adt7473 (most common one)
- f75375
- lm99

With the help of Matthew Garret, I updated his previous proposal for an 
in-kernel API for hwmon. The patch should apply cleanly on Linux 
2.6.38-rc4. This patch only provides the API, no modification to the 
drivers has been completed yet.

Looking forward to your review and feedback.

Martin

--------------070100090608000701020600
Content-Type: text/x-patch;
 name="0001-hwmon-API-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-hwmon-API-update.patch"

From 059b647b7b8bd98c04cf48b4062048b8ae963593 Mon Sep 17 00:00:00 2001
From: Martin Peres <martin.peres@ensi-bourges.fr>
Date: Sun, 13 Feb 2011 11:35:17 +0100
Subject: [PATCH] hwmon API update

Original creator: Matthew Garrett <mjg@redhat.com>

Signed-off-by: Martin Peres <martin.peres@ensi-bourges.fr>
---
 drivers/acpi/power_meter.c            |    2 +-
 drivers/gpu/drm/nouveau/nouveau_drv.h |    2 +-
 drivers/gpu/drm/nouveau/nouveau_pm.c  |    8 +-
 drivers/gpu/drm/radeon/radeon.h       |    2 +-
 drivers/gpu/drm/radeon/radeon_pm.c    |    9 +-
 drivers/hwmon/abituguru.c             |    2 +-
 drivers/hwmon/abituguru3.c            |    2 +-
 drivers/hwmon/ad7414.c                |    2 +-
 drivers/hwmon/ad7418.c                |    2 +-
 drivers/hwmon/adcxx.c                 |    2 +-
 drivers/hwmon/adm1021.c               |    2 +-
 drivers/hwmon/adm1025.c               |    2 +-
 drivers/hwmon/adm1026.c               |    2 +-
 drivers/hwmon/adm1029.c               |    2 +-
 drivers/hwmon/adm1031.c               |    2 +-
 drivers/hwmon/adm9240.c               |    2 +-
 drivers/hwmon/ads7828.c               |    2 +-
 drivers/hwmon/ads7871.c               |    2 +-
 drivers/hwmon/adt7411.c               |    2 +-
 drivers/hwmon/adt7462.c               |    2 +-
 drivers/hwmon/adt7470.c               |    4 +-
 drivers/hwmon/adt7475.c               |    2 +-
 drivers/hwmon/amc6821.c               |    2 +-
 drivers/hwmon/applesmc.c              |    2 +-
 drivers/hwmon/asb100.c                |    2 +-
 drivers/hwmon/asc7621.c               |    2 +-
 drivers/hwmon/asus_atk0110.c          |   22 ++--
 drivers/hwmon/atxp1.c                 |    2 +-
 drivers/hwmon/coretemp.c              |    2 +-
 drivers/hwmon/dme1737.c               |    2 +-
 drivers/hwmon/ds1621.c                |    2 +-
 drivers/hwmon/emc1403.c               |    2 +-
 drivers/hwmon/emc2103.c               |    4 +-
 drivers/hwmon/f71805f.c               |    2 +-
 drivers/hwmon/f71882fg.c              |    2 +-
 drivers/hwmon/f75375s.c               |    2 +-
 drivers/hwmon/fschmd.c                |    2 +-
 drivers/hwmon/g760a.c                 |    2 +-
 drivers/hwmon/gl518sm.c               |    2 +-
 drivers/hwmon/gl520sm.c               |    2 +-
 drivers/hwmon/gpio-fan.c              |    2 +-
 drivers/hwmon/hwmon.c                 |  253 ++++++++++++++++++++++++++++++++-
 drivers/hwmon/i5k_amb.c               |    2 +-
 drivers/hwmon/ibmaem.c                |    2 +-
 drivers/hwmon/ibmpex.c                |    2 +-
 drivers/hwmon/it87.c                  |    2 +-
 drivers/hwmon/jc42.c                  |    2 +-
 drivers/hwmon/jz4740-hwmon.c          |    2 +-
 drivers/hwmon/k10temp.c               |    2 +-
 drivers/hwmon/k8temp.c                |    2 +-
 drivers/hwmon/lm63.c                  |    2 +-
 drivers/hwmon/lm70.c                  |    2 +-
 drivers/hwmon/lm73.c                  |    6 +-
 drivers/hwmon/lm75.c                  |    4 +-
 drivers/hwmon/lm77.c                  |    2 +-
 drivers/hwmon/lm78.c                  |    2 +-
 drivers/hwmon/lm80.c                  |    2 +-
 drivers/hwmon/lm83.c                  |    2 +-
 drivers/hwmon/lm85.c                  |    2 +-
 drivers/hwmon/lm87.c                  |    2 +-
 drivers/hwmon/lm90.c                  |    2 +-
 drivers/hwmon/lm92.c                  |    2 +-
 drivers/hwmon/lm93.c                  |    2 +-
 drivers/hwmon/lm95241.c               |    2 +-
 drivers/hwmon/ltc4215.c               |    2 +-
 drivers/hwmon/ltc4245.c               |    2 +-
 drivers/hwmon/ltc4261.c               |    2 +-
 drivers/hwmon/max1111.c               |    2 +-
 drivers/hwmon/max1619.c               |    2 +-
 drivers/hwmon/max6650.c               |    2 +-
 drivers/hwmon/mc13783-adc.c           |    2 +-
 drivers/hwmon/pc87360.c               |    2 +-
 drivers/hwmon/pc87427.c               |    2 +-
 drivers/hwmon/pcf8591.c               |    2 +-
 drivers/hwmon/pkgtemp.c               |    2 +-
 drivers/hwmon/s3c-hwmon.c             |    2 +-
 drivers/hwmon/sht15.c                 |    2 +-
 drivers/hwmon/sis5595.c               |    2 +-
 drivers/hwmon/smm665.c                |    2 +-
 drivers/hwmon/smsc47b397.c            |    2 +-
 drivers/hwmon/smsc47m1.c              |    2 +-
 drivers/hwmon/smsc47m192.c            |    2 +-
 drivers/hwmon/thmc50.c                |    2 +-
 drivers/hwmon/tmp102.c                |    2 +-
 drivers/hwmon/tmp401.c                |    2 +-
 drivers/hwmon/tmp421.c                |    2 +-
 drivers/hwmon/ultra45_env.c           |    2 +-
 drivers/hwmon/via-cputemp.c           |    2 +-
 drivers/hwmon/via686a.c               |    2 +-
 drivers/hwmon/vt1211.c                |    2 +-
 drivers/hwmon/vt8231.c                |    2 +-
 drivers/hwmon/w83627ehf.c             |    2 +-
 drivers/hwmon/w83627hf.c              |    2 +-
 drivers/hwmon/w83781d.c               |    2 +-
 drivers/hwmon/w83791d.c               |    2 +-
 drivers/hwmon/w83792d.c               |    2 +-
 drivers/hwmon/w83793.c                |    2 +-
 drivers/hwmon/w83795.c                |    2 +-
 drivers/hwmon/w83l785ts.c             |    2 +-
 drivers/hwmon/w83l786ng.c             |    2 +-
 drivers/hwmon/wm831x-hwmon.c          |    2 +-
 drivers/input/touchscreen/ads7846.c   |    4 +-
 drivers/platform/x86/compal-laptop.c  |    2 +-
 drivers/platform/x86/eeepc-laptop.c   |   10 +-
 drivers/platform/x86/thinkpad_acpi.c  |    2 +-
 drivers/thermal/thermal_sys.c         |   20 ++--
 include/linux/hwmon.h                 |  137 ++++++++++++++++++-
 include/linux/mfd/wm8350/core.h       |    2 +-
 include/linux/thermal.h               |    2 +-
 109 files changed, 528 insertions(+), 147 deletions(-)

diff --git a/drivers/acpi/power_meter.c b/drivers/acpi/power_meter.c
index 66f6729..0532825 100644
--- a/drivers/acpi/power_meter.c
+++ b/drivers/acpi/power_meter.c
@@ -89,7 +89,7 @@ struct acpi_power_meter_resource {
 	struct acpi_device	*acpi_dev;
 	acpi_bus_id		name;
 	struct mutex		lock;
-	struct device		*hwmon_dev;
+	struct hwmon_device	*hwmon_dev;
 	struct acpi_power_meter_capabilities	caps;
 	acpi_string		model_number;
 	acpi_string		serial_number;
diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
index 8f64918..e870edd 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drv.h
+++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
@@ -483,7 +483,7 @@ struct nouveau_pm_engine {
 	struct nouveau_pm_level boot;
 	struct nouveau_pm_level *cur;
 
-	struct device *hwmon;
+	struct hwmon_device *hwmon;
 	struct notifier_block acpi_nb;
 
 	int (*clock_get)(struct drm_device *, u32 id);
diff --git a/drivers/gpu/drm/nouveau/nouveau_pm.c b/drivers/gpu/drm/nouveau/nouveau_pm.c
index f05c0cd..ee56928 100644
--- a/drivers/gpu/drm/nouveau/nouveau_pm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_pm.c
@@ -408,7 +408,7 @@ nouveau_hwmon_init(struct drm_device *dev)
 #ifdef CONFIG_HWMON
 	struct drm_nouveau_private *dev_priv = dev->dev_private;
 	struct nouveau_pm_engine *pm = &dev_priv->engine.pm;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	int ret;
 
 	if (!pm->temp_get)
@@ -421,8 +421,8 @@ nouveau_hwmon_init(struct drm_device *dev)
 			"Unable to register hwmon device: %d\n", ret);
 		return ret;
 	}
-	dev_set_drvdata(hwmon_dev, dev);
-	ret = sysfs_create_group(&dev->pdev->dev.kobj, &hwmon_attrgroup);
+	dev_set_drvdata(hwmon_dev->dev, dev);
+	ret = sysfs_create_group(&hwmon_dev->dev->kobj, &hwmon_attrgroup);
 	if (ret) {
 		NV_ERROR(dev,
 			"Unable to create hwmon sysfs file: %d\n", ret);
@@ -443,7 +443,7 @@ nouveau_hwmon_fini(struct drm_device *dev)
 	struct nouveau_pm_engine *pm = &dev_priv->engine.pm;
 
 	if (pm->hwmon) {
-		sysfs_remove_group(&dev->pdev->dev.kobj, &hwmon_attrgroup);
+		sysfs_remove_group(&pm->hwmon->dev->kobj, &hwmon_attrgroup);
 		hwmon_device_unregister(pm->hwmon);
 	}
 #endif
diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 56c48b6..7e59e46 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -842,7 +842,7 @@ struct radeon_pm {
 	struct radeon_pm_profile profiles[PM_PROFILE_MAX];
 	/* internal thermal controller on rv6xx+ */
 	enum radeon_int_thermal_type int_thermal_type;
-	struct device	        *int_hwmon_dev;
+	struct hwmon_device        *int_hwmon_dev;
 };
 
 
diff --git a/drivers/gpu/drm/radeon/radeon_pm.c b/drivers/gpu/drm/radeon/radeon_pm.c
index 2aed03b..6805ecf 100644
--- a/drivers/gpu/drm/radeon/radeon_pm.c
+++ b/drivers/gpu/drm/radeon/radeon_pm.c
@@ -492,13 +492,13 @@ static int radeon_hwmon_init(struct radeon_device *rdev)
 				"Unable to register hwmon device: %d\n", err);
 			break;
 		}
-		dev_set_drvdata(rdev->pm.int_hwmon_dev, rdev->ddev);
-		err = sysfs_create_group(&rdev->pm.int_hwmon_dev->kobj,
+		dev_set_drvdata(rdev->pm.int_hwmon_dev->dev, rdev->ddev);
+		err = sysfs_create_group(&rdev->pm.int_hwmon_dev->dev->kobj,
 					 &hwmon_attrgroup);
 		if (err) {
 			dev_err(rdev->dev,
 				"Unable to create hwmon sysfs file: %d\n", err);
-			hwmon_device_unregister(rdev->dev);
+			hwmon_device_unregister(rdev->pm.int_hwmon_dev);
 		}
 		break;
 	default:
@@ -511,7 +511,8 @@ static int radeon_hwmon_init(struct radeon_device *rdev)
 static void radeon_hwmon_fini(struct radeon_device *rdev)
 {
 	if (rdev->pm.int_hwmon_dev) {
-		sysfs_remove_group(&rdev->pm.int_hwmon_dev->kobj, &hwmon_attrgroup);
+		sysfs_remove_group(&rdev->pm.int_hwmon_dev->dev->kobj,
+					&hwmon_attrgroup);
 		hwmon_device_unregister(rdev->pm.int_hwmon_dev);
 	}
 }
diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
index 8f07a9d..b4a9c68 100644
--- a/drivers/hwmon/abituguru.c
+++ b/drivers/hwmon/abituguru.c
@@ -179,7 +179,7 @@ MODULE_PARM_DESC(verbose, "How verbose should the driver be? (0-3):\n"
    The structure is dynamically allocated, at the same time when a new
    abituguru device is allocated. */
 struct abituguru_data {
-	struct device *hwmon_dev;	/* hwmon registered device */
+	struct hwmon_device *hwmon_dev;	/* hwmon registered device */
 	struct mutex update_lock;	/* protect access to data and uGuru */
 	unsigned long last_updated;	/* In jiffies */
 	unsigned short addr;		/* uguru base address */
diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index 48d21e2..bfe0b6b 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -134,7 +134,7 @@ struct abituguru3_motherboard_info {
    The structure is dynamically allocated, at the same time when a new
    abituguru3 device is allocated. */
 struct abituguru3_data {
-	struct device *hwmon_dev;	/* hwmon registered device */
+	struct hwmon_device *hwmon_dev;	/* hwmon registered device */
 	struct mutex update_lock;	/* protect access to data and uGuru */
 	unsigned short addr;		/* uguru base address */
 	char valid;			/* !=0 if following fields are valid */
diff --git a/drivers/hwmon/ad7414.c b/drivers/hwmon/ad7414.c
index 86d822a..ad8f790 100644
--- a/drivers/hwmon/ad7414.c
+++ b/drivers/hwmon/ad7414.c
@@ -39,7 +39,7 @@
 static u8 AD7414_REG_LIMIT[] = { AD7414_REG_T_HIGH, AD7414_REG_T_LOW };
 
 struct ad7414_data {
-	struct device		*hwmon_dev;
+	struct hwmon_device	*hwmon_dev;
 	struct mutex		lock;	/* atomic read data updates */
 	char			valid;	/* !=0 if following fields are valid */
 	unsigned long		next_update;	/* In jiffies */
diff --git a/drivers/hwmon/ad7418.c b/drivers/hwmon/ad7418.c
index ffc781f..9cb73b1 100644
--- a/drivers/hwmon/ad7418.c
+++ b/drivers/hwmon/ad7418.c
@@ -44,7 +44,7 @@ static const u8 AD7418_REG_TEMP[] = { AD7418_REG_TEMP_IN,
 					AD7418_REG_TEMP_OS };
 
 struct ad7418_data {
-	struct device		*hwmon_dev;
+	struct hwmon_device	*hwmon_dev;
 	struct attribute_group	attrs;
 	enum chips		type;
 	struct mutex		lock;
diff --git a/drivers/hwmon/adcxx.c b/drivers/hwmon/adcxx.c
index fbdc765..d8bf516 100644
--- a/drivers/hwmon/adcxx.c
+++ b/drivers/hwmon/adcxx.c
@@ -50,7 +50,7 @@
 #define DRVNAME		"adcxx"
 
 struct adcxx {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex lock;
 	u32 channels;
 	u32 reference; /* in millivolts */
diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
index 1ad0a88..f7b3d2f 100644
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -77,7 +77,7 @@ clearing it.  Weird, ey?   --Phil  */
 
 /* Each client has this additional data */
 struct adm1021_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	enum chips type;
 
 	struct mutex update_lock;
diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
index 60befc0..1309456 100644
--- a/drivers/hwmon/adm1025.c
+++ b/drivers/hwmon/adm1025.c
@@ -141,7 +141,7 @@ static struct i2c_driver adm1025_driver = {
  */
 
 struct adm1025_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
index be0fdd5..ae8a353 100644
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -256,7 +256,7 @@ struct pwm_data {
 };
 
 struct adm1026_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 
 	struct mutex update_lock;
 	int valid;		/* !=0 if following fields are valid */
diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
index 0b8a3b1..ef142b1 100644
--- a/drivers/hwmon/adm1029.c
+++ b/drivers/hwmon/adm1029.c
@@ -144,7 +144,7 @@ static struct i2c_driver adm1029_driver = {
  */
 
 struct adm1029_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;		/* zero until following fields are valid */
 	unsigned long last_updated;	/* in jiffies */
diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
index 0683e6b..0026309 100644
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -74,7 +74,7 @@ typedef u8 auto_chan_table_t[8][2];
 
 /* Each client has this additional data */
 struct adm1031_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	int chip_type;
 	char valid;		/* !=0 if following fields are valid */
diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
index 9e234b9..3e39e65 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -160,7 +160,7 @@ static struct i2c_driver adm9240_driver = {
 
 /* per client data */
 struct adm9240_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;
 	unsigned long last_updated_measure;
diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
index c42c5a6..d0e5310 100644
--- a/drivers/hwmon/ads7828.c
+++ b/drivers/hwmon/ads7828.c
@@ -61,7 +61,7 @@ static unsigned int ads7828_lsb_resol; /* resolution of the ADC sample lsb */
 
 /* Each client has this additional data */
 struct ads7828_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock; /* mutex protect updates */
 	char valid; /* !=0 if following fields are valid */
 	unsigned long last_updated; /* In jiffies */
diff --git a/drivers/hwmon/ads7871.c b/drivers/hwmon/ads7871.c
index 5231934..9c8ac00 100644
--- a/drivers/hwmon/ads7871.c
+++ b/drivers/hwmon/ads7871.c
@@ -70,7 +70,7 @@
 #define DEVICE_NAME	"ads7871"
 
 struct ads7871_data {
-	struct device	*hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex	update_lock;
 };
 
diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
index f13c843..ac3dbc0 100644
--- a/drivers/hwmon/adt7411.c
+++ b/drivers/hwmon/adt7411.c
@@ -52,7 +52,7 @@ struct adt7411_data {
 	struct mutex update_lock;
 	unsigned long next_update;
 	int vref_cached;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 };
 
 /*
diff --git a/drivers/hwmon/adt7462.c b/drivers/hwmon/adt7462.c
index 2af0c7b..9462317 100644
--- a/drivers/hwmon/adt7462.c
+++ b/drivers/hwmon/adt7462.c
@@ -203,7 +203,7 @@ static const unsigned short normal_i2c[] = { 0x58, 0x5C, I2C_CLIENT_END };
 	(((value) & prefix##_MASK) >> prefix##_SHIFT)
 
 struct adt7462_data {
-	struct device		*hwmon_dev;
+	struct hwmon_device	*hwmon_dev;
 	struct attribute_group	attrs;
 	struct mutex		lock;
 	char			sensors_valid;
diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index c6d1ce0..8ecda75 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -143,7 +143,7 @@ static const unsigned short normal_i2c[] = { 0x2C, 0x2E, 0x2F, I2C_CLIENT_END };
 #define FAN_DATA_VALID(x)	((x) && (x) != FAN_PERIOD_INVALID)
 
 struct adt7470_data {
-	struct device		*hwmon_dev;
+	struct hwmon_device	*hwmon_dev;
 	struct attribute_group	attrs;
 	struct mutex		lock;
 	char			sensors_valid;
@@ -1287,7 +1287,7 @@ static int adt7470_probe(struct i2c_client *client,
 
 	init_completion(&data->auto_update_stop);
 	data->auto_update = kthread_run(adt7470_update_thread, client,
-					dev_name(data->hwmon_dev));
+					dev_name(data->hwmon_dev->dev));
 	if (IS_ERR(data->auto_update)) {
 		err = PTR_ERR(data->auto_update);
 		goto exit_unregister;
diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index b5fcd87..4d5cd8d 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -160,7 +160,7 @@ static const struct i2c_device_id adt7475_id[] = {
 MODULE_DEVICE_TABLE(i2c, adt7475_id);
 
 struct adt7475_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex lock;
 
 	unsigned long measure_updated;
diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 4033974..9b9421c 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -191,7 +191,7 @@ static struct i2c_driver amc6821_driver = {
   */
 
 struct amc6821_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 4c07436..3c77802 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -150,7 +150,7 @@ static s16 rest_x;
 static s16 rest_y;
 static u8 backlight_state[2];
 
-static struct device *hwmon_dev;
+static struct hwmon_device *hwmon_dev;
 static struct input_polled_dev *applesmc_idev;
 
 /*
diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
index c02a052..3768cd3 100644
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -178,7 +178,7 @@ static u8 DIV_TO_REG(long val)
    data is pointed to by client->data. The structure itself is
    dynamically allocated, at the same time the client itself is allocated. */
 struct asb100_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex lock;
 
 	struct mutex update_lock;
diff --git a/drivers/hwmon/asc7621.c b/drivers/hwmon/asc7621.c
index d2596ce..675f4ef 100644
--- a/drivers/hwmon/asc7621.c
+++ b/drivers/hwmon/asc7621.c
@@ -88,7 +88,7 @@ static struct asc7621_chip asc7621_chips[] = {
 
 struct asc7621_data {
 	struct i2c_client client;
-	struct device *class_dev;
+	struct hwmon_device *class_dev;
 	struct mutex update_lock;
 	int valid;		/* !=0 if following fields are valid */
 	unsigned long last_high_reading;	/* In jiffies */
diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index b5e8920..2839920 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -100,7 +100,7 @@ enum atk_pack_member {
 
 
 struct atk_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	acpi_handle atk_handle;
 	struct acpi_device *acpi_dev;
 
@@ -1189,24 +1189,24 @@ static int atk_create_files(struct atk_data *data)
 
 	list_for_each_entry(s, &data->sensor_list, list) {
 		sysfs_attr_init(&s->input_attr.attr);
-		err = device_create_file(data->hwmon_dev, &s->input_attr);
+		err = device_create_file(data->hwmon_dev->dev, &s->input_attr);
 		if (err)
 			return err;
 		sysfs_attr_init(&s->label_attr.attr);
-		err = device_create_file(data->hwmon_dev, &s->label_attr);
+		err = device_create_file(data->hwmon_dev->dev, &s->label_attr);
 		if (err)
 			return err;
 		sysfs_attr_init(&s->limit1_attr.attr);
-		err = device_create_file(data->hwmon_dev, &s->limit1_attr);
+		err = device_create_file(data->hwmon_dev->dev, &s->limit1_attr);
 		if (err)
 			return err;
 		sysfs_attr_init(&s->limit2_attr.attr);
-		err = device_create_file(data->hwmon_dev, &s->limit2_attr);
+		err = device_create_file(data->hwmon_dev->dev, &s->limit2_attr);
 		if (err)
 			return err;
 	}
 
-	err = device_create_file(data->hwmon_dev, &atk_name_attr);
+	err = device_create_file(data->hwmon_dev->dev, &atk_name_attr);
 
 	return err;
 }
@@ -1216,12 +1216,12 @@ static void atk_remove_files(struct atk_data *data)
 	struct atk_sensor_data *s;
 
 	list_for_each_entry(s, &data->sensor_list, list) {
-		device_remove_file(data->hwmon_dev, &s->input_attr);
-		device_remove_file(data->hwmon_dev, &s->label_attr);
-		device_remove_file(data->hwmon_dev, &s->limit1_attr);
-		device_remove_file(data->hwmon_dev, &s->limit2_attr);
+		device_remove_file(data->hwmon_dev->dev, &s->input_attr);
+		device_remove_file(data->hwmon_dev->dev, &s->label_attr);
+		device_remove_file(data->hwmon_dev->dev, &s->limit1_attr);
+		device_remove_file(data->hwmon_dev->dev, &s->limit2_attr);
 	}
-	device_remove_file(data->hwmon_dev, &atk_name_attr);
+	device_remove_file(data->hwmon_dev->dev, &atk_name_attr);
 }
 
 static void atk_free_sensors(struct atk_data *data)
diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
index 33cc143..c629a56 100644
--- a/drivers/hwmon/atxp1.c
+++ b/drivers/hwmon/atxp1.c
@@ -70,7 +70,7 @@ static struct i2c_driver atxp1_driver = {
 };
 
 struct atxp1_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	unsigned long last_updated;
 	u8 valid;
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 194ca0a..b986918 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -51,7 +51,7 @@ typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL,
 static struct coretemp_data *coretemp_update_device(struct device *dev);
 
 struct coretemp_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	const char *name;
 	u32 id;
diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
index d9c5927..f1c414e 100644
--- a/drivers/hwmon/dme1737.c
+++ b/drivers/hwmon/dme1737.c
@@ -201,7 +201,7 @@ static const u8 DME1737_BIT_ALARM_FAN[] = {10, 11, 12, 13, 22, 23};
 
 struct dme1737_data {
 	struct i2c_client *client;	/* for I2C devices only */
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	const char *name;
 	unsigned int addr;		/* for ISA devices only */
 
diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index e113634..b04be94 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -71,7 +71,7 @@ static const u8 DS1621_REG_TEMP[3] = {
 
 /* Each client has this additional data */
 struct ds1621_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;			/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index 5dea9fa..1f71d42 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -39,7 +39,7 @@
 #define THERMAL_REVISION_REG	0xff
 
 struct thermal_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex mutex;
 	/* Cache the hyst value so we don't keep re-reading it. In theory
 	   we could cache it forever as nobody else should be writing it. */
diff --git a/drivers/hwmon/emc2103.c b/drivers/hwmon/emc2103.c
index af914ad..f7b0c64 100644
--- a/drivers/hwmon/emc2103.c
+++ b/drivers/hwmon/emc2103.c
@@ -64,7 +64,7 @@ struct temperature {
 };
 
 struct emc2103_data {
-	struct device		*hwmon_dev;
+	struct hwmon_device	*hwmon_dev;
 	struct mutex		update_lock;
 	bool			valid;		/* registers are valid */
 	bool			fan_rpm_control;
@@ -646,7 +646,7 @@ emc2103_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	}
 
 	dev_info(&client->dev, "%s: sensor '%s'\n",
-		 dev_name(data->hwmon_dev), client->name);
+		 dev_name(data->hwmon_dev->dev), client->name);
 
 	return 0;
 
diff --git a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
index 92f9497..0dfa26b 100644
--- a/drivers/hwmon/f71805f.c
+++ b/drivers/hwmon/f71805f.c
@@ -169,7 +169,7 @@ struct f71805f_auto_point {
 struct f71805f_data {
 	unsigned short addr;
 	const char *name;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 
 	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 3f49dd3..1ae513c 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -124,7 +124,7 @@ struct f71882fg_sio_data {
 struct f71882fg_data {
 	unsigned short addr;
 	enum chips type;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 
 	struct mutex update_lock;
 	int temp_start;			/* temp numbering start (0 or 1) */
diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index 95cbfb3..61235d3 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -87,7 +87,7 @@ enum chips { f75373, f75375 };
 
 struct f75375_data {
 	unsigned short addr;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 
 	const char *name;
 	int kind;
diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
index aa6d8b6..d187284 100644
--- a/drivers/hwmon/fschmd.c
+++ b/drivers/hwmon/fschmd.c
@@ -261,7 +261,7 @@ static struct i2c_driver fschmd_driver = {
 
 struct fschmd_data {
 	struct i2c_client *client;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	struct mutex watchdog_lock;
 	struct list_head list; /* member of the watchdog_data_list */
diff --git a/drivers/hwmon/g760a.c b/drivers/hwmon/g760a.c
index 1d6a6fa..2f27467 100644
--- a/drivers/hwmon/g760a.c
+++ b/drivers/hwmon/g760a.c
@@ -44,7 +44,7 @@ enum g760a_regs {
 
 struct g760a_data {
 	struct i2c_client *client;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 
 	/* board specific parameters */
diff --git a/drivers/hwmon/gl518sm.c b/drivers/hwmon/gl518sm.c
index e7ae574..7177c8c 100644
--- a/drivers/hwmon/gl518sm.c
+++ b/drivers/hwmon/gl518sm.c
@@ -113,7 +113,7 @@ static inline u8 FAN_TO_REG(long rpm, int div)
 
 /* Each client has this additional data */
 struct gl518_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	enum chips type;
 
 	struct mutex update_lock;
diff --git a/drivers/hwmon/gl520sm.c b/drivers/hwmon/gl520sm.c
index ec58802..ac2511d 100644
--- a/drivers/hwmon/gl520sm.c
+++ b/drivers/hwmon/gl520sm.c
@@ -106,7 +106,7 @@ static struct i2c_driver gl520_driver = {
 
 /* Client data */
 struct gl520_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;		/* zero until the following fields are valid */
 	unsigned long last_updated;	/* in jiffies */
diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index f141a1d..0a9211c 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -34,7 +34,7 @@
 
 struct gpio_fan_data {
 	struct platform_device	*pdev;
-	struct device		*hwmon_dev;
+	struct hwmon_device	*hwmon_dev;
 	struct mutex		lock; /* lock GPIOs operations. */
 	int			num_ctrl;
 	unsigned		*ctrl;
diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index a61e781..5e83453 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -30,6 +30,9 @@ static struct class *hwmon_class;
 static DEFINE_IDR(hwmon_idr);
 static DEFINE_SPINLOCK(idr_lock);
 
+static LIST_HEAD(hwmon_list);
+static DEFINE_SPINLOCK(hwmon_list_lock);
+
 /**
  * hwmon_device_register - register w/ hwmon
  * @dev: the device to register
@@ -39,9 +42,10 @@ static DEFINE_SPINLOCK(idr_lock);
  *
  * Returns the pointer to the new device.
  */
-struct device *hwmon_device_register(struct device *dev)
+struct hwmon_device *hwmon_device_register(struct device *dev)
 {
 	struct device *hwdev;
+	struct hwmon_device *hwmon;
 	int id, err;
 
 again:
@@ -65,9 +69,21 @@ again:
 		spin_lock(&idr_lock);
 		idr_remove(&hwmon_idr, id);
 		spin_unlock(&idr_lock);
+		return (struct hwmon_device *)hwdev;
 	}
 
-	return hwdev;
+	hwmon = kzalloc(sizeof(struct hwmon_device), GFP_KERNEL);
+	if (!hwmon)
+		return ERR_PTR(-ENOMEM);
+
+	hwmon->dev = hwdev;
+	hwmon->sensor_dev = dev;
+
+	spin_lock(&hwmon_list_lock);
+	list_add_tail(&hwmon->node, &hwmon_list);
+	spin_unlock(&hwmon_list_lock);
+
+	return hwmon;
 }
 
 /**
@@ -75,20 +91,251 @@ again:
  *
  * @dev: the class device to destroy
  */
-void hwmon_device_unregister(struct device *dev)
+void hwmon_device_unregister(struct hwmon_device *hwmon)
 {
 	int id;
+	struct device *dev = hwmon->dev;
 
 	if (likely(sscanf(dev_name(dev), HWMON_ID_FORMAT, &id) == 1)) {
+		spin_lock(&hwmon_list_lock);
+		list_del(&hwmon->node);
+		spin_unlock(&hwmon_list_lock);
 		device_unregister(dev);
 		spin_lock(&idr_lock);
 		idr_remove(&hwmon_idr, id);
 		spin_unlock(&idr_lock);
+		kfree(hwmon);
 	} else
 		dev_dbg(dev->parent,
 			"hwmon_device_unregister() failed: bad class ID!\n");
 }
 
+/**
+ * hwmon_get_device - return the hwmon structure associated with a device
+ *
+ * @dev: the device with hwmon capabilities
+ */
+
+struct hwmon_device *hwmon_get_device(struct device *dev)
+{
+	struct hwmon_device *hwmon_dev = NULL;
+	struct hwmon_device *ret = NULL;
+
+	spin_lock(&hwmon_list_lock);
+	list_for_each_entry(hwmon_dev, &hwmon_list, node) {
+		if (hwmon_dev->sensor_dev == dev) {
+			ret = hwmon_dev;
+			break;
+		}
+	}
+	spin_unlock(&hwmon_list_lock);
+	return ret;
+}
+EXPORT_SYMBOL(hwmon_get_device);
+
+/**
+ * hwmon_get_name - return the chip name
+ *
+ * @hwmon: the hwmon device
+ */
+
+int hwmon_get_name(struct hwmon_device *hwmon, char *name, size_t length)
+{
+	if (hwmon->ops.get_name)
+		return hwmon->ops.get_name(hwmon, name, length);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(hwmon_get_name);
+
+/**
+ * hwmon_get_update_rate - return the rate at which the chip will update
+ * readings
+ *
+ * @hwmon: the hwmon device
+ */
+
+int hwmon_get_update_rate(struct hwmon_device *hwmon, int *rate)
+{
+	if (hwmon->ops.get_update_rate)
+		return hwmon->ops.get_update_rate(hwmon, rate);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(hwmon_get_update_rate);
+
+/**
+ * hwmon_temp_reset_history - Reset temp_lowest and temp_highest for all sensors
+ *
+ * @hwmon: the hwmon device
+ */
+int hwmon_temp_reset_history(struct hwmon_device *hwmon)
+{
+	if (hwmon->ops.temp_reset_history)
+		return hwmon->ops.temp_reset_history(hwmon);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(hwmon_temp_reset_history);
+
+/**
+ * hwmon_get_temp - return the temperature of a given channel on the hwmon dev
+ *
+ * @dev: the hwmon device
+ * @channel: the channel to return
+ * @temp: integer to return the temperature in
+ */
+
+int hwmon_get_temp(struct hwmon_device *hwmon, int channel,
+			enum hwmon_attr attr, int *temp)
+{
+	if (hwmon->ops.get_temp)
+		return hwmon->ops.get_temp(hwmon, channel, attr, temp);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(hwmon_get_temp);
+
+/**
+ * hwmon_get_fan - return the speed of a given fan on the hwmon dev
+ *
+ * @dev: the hwmon device
+ * @fan: the fan to return
+ * @speed: integer to return the speed in
+ */
+
+int hwmon_get_fan(struct hwmon_device *hwmon, int fan,
+		enum hwmon_attr attr, int *speed)
+{
+	if (hwmon->ops.get_fan)
+		return hwmon->ops.get_fan(hwmon, fan, attr, speed);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(hwmon_get_fan);
+
+/**
+ * hwmon_set_fan - return the speed of a given fan on the hwmon dev
+ *
+ * @dev: the hwmon device
+ * @fan: the fan to set
+ * @speed: desired speed
+ */
+
+int hwmon_set_fan(struct hwmon_device *hwmon, int fan,
+		enum hwmon_attr attr, int speed)
+{
+	if (hwmon->ops.set_fan)
+		return hwmon->ops.set_fan(hwmon, fan, attr, speed);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(hwmon_set_fan);
+
+/**
+ * hwmon_get_voltage - return the voltage of a given channel on the hwmon dev
+ *
+ * @dev: the hwmon device
+ * @channel: the channel to return
+ * @mv: integer to return the voltage in
+ */
+
+int hwmon_get_voltage(struct hwmon_device *hwmon, int channel,
+		enum hwmon_attr attr, int *value)
+{
+	if (hwmon->ops.get_voltage)
+		return hwmon->ops.get_voltage(hwmon, channel, attr, value);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(hwmon_get_voltage);
+
+/**
+ * hwmon_get_current - return the current of a given channel on the hwmon dev
+ *
+ * @dev: the hwmon device
+ * @channel: the channel to return
+ * @ma: integer to return the current in
+ */
+
+int hwmon_get_current(struct hwmon_device *hwmon, int channel,
+		enum hwmon_attr attr, int *value)
+{
+	if (hwmon->ops.get_current)
+		return hwmon->ops.get_current(hwmon, channel, attr, value);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(hwmon_get_current);
+
+/**
+ * hwmon_get_power - return the power of a given channel on the hwmon dev
+ *
+ * @dev: the hwmon device
+ * @channel: the channel to return
+ * @uw: integer to return the power in
+ */
+
+int hwmon_get_power(struct hwmon_device *hwmon, int channel,
+		enum hwmon_attr attr, int *value)
+{
+	if (hwmon->ops.get_power)
+		return hwmon->ops.get_power(hwmon, channel, attr, value);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(hwmon_get_power);
+
+/**
+ * hwmon_get_energy - return the energy of a given channel on the hwmon dev
+ *
+ * @dev: the hwmon device
+ * @channel: the channel to return
+ * @energy: uj to return the energy in
+ */
+
+int hwmon_get_energy(struct hwmon_device *hwmon, int channel,
+		enum hwmon_attr attr, int *value)
+{
+	if (hwmon->ops.get_energy)
+		return hwmon->ops.get_energy(hwmon, channel, attr, value);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(hwmon_get_energy);
+
+int hwmon_get_trip_point(struct hwmon_device *hwmon,
+		enum hwmon_trip_point_entity ent1, int probe,
+		int trip_point, enum hwmon_trip_point_entity ent2,
+		int *value)
+{
+	if (hwmon->ops.set_trip_point && ent1 != hwmon_trip_point_temp_hyst) {
+		return hwmon->ops.get_trip_point(hwmon,
+						ent1, probe,
+						trip_point, ent2,
+						value);
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(hwmon_get_trip_point);
+
+int hwmon_set_trip_point(struct hwmon_device *hwmon,
+		enum hwmon_trip_point_entity ent1, int probe,
+		int trip_point, enum hwmon_trip_point_entity ent2,
+		int value)
+{
+	if (hwmon->ops.set_trip_point && ent1 != hwmon_trip_point_temp_hyst) {
+		return hwmon->ops.set_trip_point(hwmon,
+						ent1, probe,
+						trip_point, ent2,
+						value);
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(hwmon_set_trip_point);
+
 static void __init hwmon_pci_quirks(void)
 {
 #if defined CONFIG_X86 && defined CONFIG_PCI
diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
index c4c40be..3e631b1 100644
--- a/drivers/hwmon/i5k_amb.c
+++ b/drivers/hwmon/i5k_amb.c
@@ -106,7 +106,7 @@ struct i5k_device_attribute {
 };
 
 struct i5k_amb_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 
 	unsigned long amb_base;
 	unsigned long amb_len;
diff --git a/drivers/hwmon/ibmaem.c b/drivers/hwmon/ibmaem.c
index bc6e2ab..f3a0510 100644
--- a/drivers/hwmon/ibmaem.c
+++ b/drivers/hwmon/ibmaem.c
@@ -137,7 +137,7 @@ struct aem_rw_sensor_template {
 struct aem_data {
 	struct list_head	list;
 
-	struct device		*hwmon_dev;
+	struct hwmon_device	*hwmon_dev;
 	struct platform_device	*pdev;
 	struct mutex		lock;
 	char			valid;
diff --git a/drivers/hwmon/ibmpex.c b/drivers/hwmon/ibmpex.c
index 06d4eaf..c90a7f2 100644
--- a/drivers/hwmon/ibmpex.c
+++ b/drivers/hwmon/ibmpex.c
@@ -80,7 +80,7 @@ struct ibmpex_sensor_data {
 
 struct ibmpex_bmc_data {
 	struct list_head	list;
-	struct device		*hwmon_dev;
+	struct hwmon_device	*hwmon_dev;
 	struct device		*bmc_device;
 	struct mutex		lock;
 	char			valid;
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 316b648..6931f37 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -225,7 +225,7 @@ struct it87_sio_data {
 /* For each registered chip, we need to keep some data in memory.
    The structure is dynamically allocated. */
 struct it87_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	enum chips type;
 	u8 revision;
 
diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index 340fc78..b9ca5bd 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -135,7 +135,7 @@ static struct jc42_chips jc42_chips[] = {
 
 /* Each client has this additional data */
 struct jc42_data {
-	struct device	*hwmon_dev;
+	struct hwmon_device	*hwmon_dev;
 	struct mutex	update_lock;	/* protect register access */
 	bool		extended;	/* true if extended range supported */
 	bool		valid;
diff --git a/drivers/hwmon/jz4740-hwmon.c b/drivers/hwmon/jz4740-hwmon.c
index 1c8b3d9..65e8622 100644
--- a/drivers/hwmon/jz4740-hwmon.c
+++ b/drivers/hwmon/jz4740-hwmon.c
@@ -33,7 +33,7 @@ struct jz4740_hwmon {
 	int irq;
 
 	struct mfd_cell *cell;
-	struct device *hwmon;
+	struct hwmon_device *hwmon;
 
 	struct completion read_completion;
 
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index da5a240..224f6a6 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -132,7 +132,7 @@ static bool __devinit has_erratum_319(struct pci_dev *pdev)
 static int __devinit k10temp_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *id)
 {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	u32 reg_caps, reg_htc;
 	int unreliable = has_erratum_319(pdev);
 	int err;
diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index 418496f..8434752 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -39,7 +39,7 @@
 #define SEL_CORE	0x04
 
 struct k8temp_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	const char *name;
 	char valid;		/* zero until following fields are valid */
diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index 776aeb3..fbe27cc 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -161,7 +161,7 @@ static struct i2c_driver lm63_driver = {
  */
 
 struct lm63_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index 3b84fb5..0865bdd 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -45,7 +45,7 @@
 #define LM70_CHIP_TMP121	1	/* TI TMP121/TMP123 */
 
 struct lm70 {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex lock;
 	unsigned int chip;
 };
diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
index 29b9030..b8fafe2 100644
--- a/drivers/hwmon/lm73.c
+++ b/drivers/hwmon/lm73.c
@@ -105,7 +105,7 @@ static const struct attribute_group lm73_group = {
 static int
 lm73_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	int status;
 
 	/* Register sysfs hooks */
@@ -121,7 +121,7 @@ lm73_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	i2c_set_clientdata(client, hwmon_dev);
 
 	dev_info(&client->dev, "%s: sensor '%s'\n",
-		 dev_name(hwmon_dev), client->name);
+		 dev_name(hwmon_dev->dev), client->name);
 
 	return 0;
 
@@ -132,7 +132,7 @@ exit_remove:
 
 static int lm73_remove(struct i2c_client *client)
 {
-	struct device *hwmon_dev = i2c_get_clientdata(client);
+	struct hwmon_device *hwmon_dev = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm73_group);
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index f36eb80..418d0e4 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -67,7 +67,7 @@ static const u8 LM75_REG_TEMP[3] = {
 
 /* Each client has this additional data */
 struct lm75_data {
-	struct device		*hwmon_dev;
+	struct hwmon_device	*hwmon_dev;
 	struct mutex		update_lock;
 	u8			orig_conf;
 	char			valid;		/* !=0 if registers are valid */
@@ -190,7 +190,7 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	}
 
 	dev_info(&client->dev, "%s: sensor '%s'\n",
-		 dev_name(data->hwmon_dev), client->name);
+		 dev_name(data->hwmon_dev->dev), client->name);
 
 	return 0;
 
diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
index b28a297..7352494 100644
--- a/drivers/hwmon/lm77.c
+++ b/drivers/hwmon/lm77.c
@@ -49,7 +49,7 @@ static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b,
 
 /* Each client has this additional data */
 struct lm77_data {
-	struct device 		*hwmon_dev;
+	struct hwmon_device	*hwmon_dev;
 	struct mutex		update_lock;
 	char			valid;
 	unsigned long		last_updated;	/* In jiffies */
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index 4cb24ea..bffefbc 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -117,7 +117,7 @@ static inline int TEMP_FROM_REG(s8 val)
 
 struct lm78_data {
 	struct i2c_client *client;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex lock;
 	enum chips type;
 
diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index 18a0e6c..e76d741 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -105,7 +105,7 @@ static inline long TEMP_FROM_REG(u16 temp)
  */
 
 struct lm80_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
index 8290476..4dc4b48 100644
--- a/drivers/hwmon/lm83.c
+++ b/drivers/hwmon/lm83.c
@@ -149,7 +149,7 @@ static struct i2c_driver lm83_driver = {
  */
 
 struct lm83_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 1e22984..8aeeb22 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -299,7 +299,7 @@ struct lm85_autofan {
 /* For each registered chip, we need to keep some data in memory.
    The structure is dynamically allocated. */
 struct lm85_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	const int *freq_map;
 	enum chips type;
 
diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
index f1e6e75..9acfe59 100644
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -188,7 +188,7 @@ static struct i2c_driver lm87_driver = {
  */
 
 struct lm87_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* In jiffies */
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 812781c..bf6be41 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -269,7 +269,7 @@ static const struct lm90_params lm90_params[] = {
  */
 
 struct lm90_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
index 7c31e62..63d10f1 100644
--- a/drivers/hwmon/lm92.c
+++ b/drivers/hwmon/lm92.c
@@ -93,7 +93,7 @@ static struct i2c_driver lm92_driver;
 
 /* Client data (each client gets its own) */
 struct lm92_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
index 3b43df4..f37a82d 100644
--- a/drivers/hwmon/lm93.c
+++ b/drivers/hwmon/lm93.c
@@ -204,7 +204,7 @@ struct block1_t {
  * Client-specific data
  */
 struct lm93_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 
 	struct mutex update_lock;
 	unsigned long last_updated;	/* In jiffies */
diff --git a/drivers/hwmon/lm95241.c b/drivers/hwmon/lm95241.c
index 1a6dfb6..81e7d4b 100644
--- a/drivers/hwmon/lm95241.c
+++ b/drivers/hwmon/lm95241.c
@@ -88,7 +88,7 @@ static const u8 lm95241_reg_address[] = {
 
 /* Client data (each client gets its own) */
 struct lm95241_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	unsigned long last_updated, interval;	/* in jiffies */
 	char valid;		/* zero until following fields are valid */
diff --git a/drivers/hwmon/ltc4215.c b/drivers/hwmon/ltc4215.c
index c7e6d8e..bc6754c 100644
--- a/drivers/hwmon/ltc4215.c
+++ b/drivers/hwmon/ltc4215.c
@@ -32,7 +32,7 @@ enum ltc4215_cmd {
 };
 
 struct ltc4215_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 
 	struct mutex update_lock;
 	bool valid;
diff --git a/drivers/hwmon/ltc4245.c b/drivers/hwmon/ltc4245.c
index 6593083..cb59ebf 100644
--- a/drivers/hwmon/ltc4245.c
+++ b/drivers/hwmon/ltc4245.c
@@ -50,7 +50,7 @@ enum ltc4245_cmd {
 };
 
 struct ltc4245_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 
 	struct mutex update_lock;
 	bool valid;
diff --git a/drivers/hwmon/ltc4261.c b/drivers/hwmon/ltc4261.c
index 4b50601..82c233c 100644
--- a/drivers/hwmon/ltc4261.c
+++ b/drivers/hwmon/ltc4261.c
@@ -54,7 +54,7 @@
 #define FAULT_OC	(1<<2)
 
 struct ltc4261_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 
 	struct mutex update_lock;
 	bool valid;
diff --git a/drivers/hwmon/max1111.c b/drivers/hwmon/max1111.c
index 12a54aa..553f69f 100644
--- a/drivers/hwmon/max1111.c
+++ b/drivers/hwmon/max1111.c
@@ -35,7 +35,7 @@
 
 struct max1111_data {
 	struct spi_device	*spi;
-	struct device		*hwmon_dev;
+	struct hwmon_device	*hwmon_dev;
 	struct spi_message	msg;
 	struct spi_transfer	xfer[2];
 	uint8_t *tx_buf;
diff --git a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
index 022ded0..d77e19d 100644
--- a/drivers/hwmon/max1619.c
+++ b/drivers/hwmon/max1619.c
@@ -115,7 +115,7 @@ static struct i2c_driver max1619_driver = {
  */
 
 struct max1619_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
index 9a11532..7d5ec97 100644
--- a/drivers/hwmon/max6650.c
+++ b/drivers/hwmon/max6650.c
@@ -148,7 +148,7 @@ static struct i2c_driver max6650_driver = {
 
 struct max6650_data
 {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
index d5226c9..a6b143a 100644
--- a/drivers/hwmon/mc13783-adc.c
+++ b/drivers/hwmon/mc13783-adc.c
@@ -32,7 +32,7 @@
 
 struct mc13783_adc_priv {
 	struct mc13783 *mc13783;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 };
 
 static ssize_t mc13783_adc_show_name(struct device *dev, struct device_attribute
diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 3d99b88..5d44b26 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -188,7 +188,7 @@ static inline u8 PWM_TO_REG(int val, int inv)
 
 struct pc87360_data {
 	const char *name;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex lock;
 	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
diff --git a/drivers/hwmon/pc87427.c b/drivers/hwmon/pc87427.c
index 8da2181..f71e156 100644
--- a/drivers/hwmon/pc87427.c
+++ b/drivers/hwmon/pc87427.c
@@ -50,7 +50,7 @@ static struct platform_device *pdev;
    device is using banked registers) and the register cache (needed to keep
    the data in the registers and the cache in sync at any time). */
 struct pc87427_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex lock;
 	int address[2];
 	const char *name;
diff --git a/drivers/hwmon/pcf8591.c b/drivers/hwmon/pcf8591.c
index 731b09a..0229e8e 100644
--- a/drivers/hwmon/pcf8591.c
+++ b/drivers/hwmon/pcf8591.c
@@ -71,7 +71,7 @@ MODULE_PARM_DESC(input_mode,
 #define REG_TO_SIGNED(reg)	(((reg) & 0x80)?((reg) - 256):(reg))
 
 struct pcf8591_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 
 	u8 control;
diff --git a/drivers/hwmon/pkgtemp.c b/drivers/hwmon/pkgtemp.c
index 21c817d..0e50091 100644
--- a/drivers/hwmon/pkgtemp.c
+++ b/drivers/hwmon/pkgtemp.c
@@ -49,7 +49,7 @@ enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL, SHOW_NAME };
 static struct pkgtemp_data *pkgtemp_update_device(struct device *dev);
 
 struct pkgtemp_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	const char *name;
 	u32 id;
diff --git a/drivers/hwmon/s3c-hwmon.c b/drivers/hwmon/s3c-hwmon.c
index 92b42db..5104da3 100644
--- a/drivers/hwmon/s3c-hwmon.c
+++ b/drivers/hwmon/s3c-hwmon.c
@@ -53,7 +53,7 @@ struct s3c_hwmon_attr {
 struct s3c_hwmon {
 	struct mutex		lock;
 	struct s3c_adc_client	*client;
-	struct device		*hwmon_dev;
+	struct hwmon_device	*hwmon_dev;
 
 	struct s3c_hwmon_attr	attrs[8];
 };
diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index a610e78..c612f6c 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -107,7 +107,7 @@ struct sht15_data {
 	unsigned long			last_updat;
 	struct mutex			read_lock;
 	struct device			*dev;
-	struct device			*hwmon_dev;
+	struct hwmon_device		*hwmon_dev;
 	struct regulator		*reg;
 	struct notifier_block		nb;
 	int				supply_uV;
diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index 47d7ce9..9c2f099 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -166,7 +166,7 @@ static inline u8 DIV_TO_REG(int val)
 struct sis5595_data {
 	unsigned short addr;
 	const char *name;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex lock;
 
 	struct mutex update_lock;
diff --git a/drivers/hwmon/smm665.c b/drivers/hwmon/smm665.c
index 425df5b..f9eda4a 100644
--- a/drivers/hwmon/smm665.c
+++ b/drivers/hwmon/smm665.c
@@ -139,7 +139,7 @@ enum chips { smm465, smm665, smm665c, smm764, smm766 };
 struct smm665_data {
 	enum chips type;
 	int conversion_time;		/* ADC conversion time */
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	bool valid;
 	unsigned long last_updated;	/* in jiffies */
diff --git a/drivers/hwmon/smsc47b397.c b/drivers/hwmon/smsc47b397.c
index 9fb7516..6e27c05 100644
--- a/drivers/hwmon/smsc47b397.c
+++ b/drivers/hwmon/smsc47b397.c
@@ -101,7 +101,7 @@ static u8 smsc47b397_reg_temp[] = {0x25, 0x26, 0x27, 0x80};
 struct smsc47b397_data {
 	unsigned short addr;
 	const char *name;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex lock;
 
 	struct mutex update_lock;
diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index f44a89a..8e04513 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -124,7 +124,7 @@ struct smsc47m1_data {
 	unsigned short addr;
 	const char *name;
 	enum chips type;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 
 	struct mutex update_lock;
 	unsigned long last_updated;	/* In jiffies */
diff --git a/drivers/hwmon/smsc47m192.c b/drivers/hwmon/smsc47m192.c
index 40b2667..bdfa22a 100644
--- a/drivers/hwmon/smsc47m192.c
+++ b/drivers/hwmon/smsc47m192.c
@@ -93,7 +93,7 @@ static inline int TEMP_FROM_REG(s8 val)
 }
 
 struct smsc47m192_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
diff --git a/drivers/hwmon/thmc50.c b/drivers/hwmon/thmc50.c
index 7dfb4de..28e725d 100644
--- a/drivers/hwmon/thmc50.c
+++ b/drivers/hwmon/thmc50.c
@@ -67,7 +67,7 @@ static const u8 THMC50_REG_TEMP_DEFAULT[] = { 0x17, 0x18, 0x18 };
 
 /* Each client has this additional data */
 struct thmc50_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 
 	struct mutex update_lock;
 	enum chips type;
diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index 93187c3..6970670 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -48,7 +48,7 @@
 #define	TMP102_THIGH_REG		0x03
 
 struct tmp102 {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex lock;
 	u16 config_orig;
 	unsigned long last_update;
diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index ad8d535..baf7b08 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -107,7 +107,7 @@ MODULE_DEVICE_TABLE(i2c, tmp401_id);
  */
 
 struct tmp401_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
index 0517a8f..52a35d5 100644
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -69,7 +69,7 @@ static const struct i2c_device_id tmp421_id[] = {
 MODULE_DEVICE_TABLE(i2c, tmp421_id);
 
 struct tmp421_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;
 	unsigned long last_updated;
diff --git a/drivers/hwmon/ultra45_env.c b/drivers/hwmon/ultra45_env.c
index d863e13..e370fb0 100644
--- a/drivers/hwmon/ultra45_env.c
+++ b/drivers/hwmon/ultra45_env.c
@@ -58,7 +58,7 @@ struct env {
 	void __iomem	*regs;
 	spinlock_t	lock;
 
-	struct device	*hwmon_dev;
+	struct hwmon_device	*hwmon_dev;
 };
 
 static u8 env_read(struct env *p, u8 ireg)
diff --git a/drivers/hwmon/via-cputemp.c b/drivers/hwmon/via-cputemp.c
index 0d18de4..7066ec8 100644
--- a/drivers/hwmon/via-cputemp.c
+++ b/drivers/hwmon/via-cputemp.c
@@ -46,7 +46,7 @@ enum { SHOW_TEMP, SHOW_LABEL, SHOW_NAME };
  */
 
 struct via_cputemp_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	const char *name;
 	u32 id;
 	u32 msr;
diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
index 25e9166..3665e61 100644
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -297,7 +297,7 @@ static inline long TEMP_FROM_REG10(u16 val)
 struct via686a_data {
 	unsigned short addr;
 	const char *name;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
diff --git a/drivers/hwmon/vt1211.c b/drivers/hwmon/vt1211.c
index 49163d4..eda2cb4 100644
--- a/drivers/hwmon/vt1211.c
+++ b/drivers/hwmon/vt1211.c
@@ -115,7 +115,7 @@ static const u8 bitalarmfan[]	= {6, 7};
 struct vt1211_data {
 	unsigned short addr;
 	const char *name;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 
 	struct mutex update_lock;
 	char valid;			/* !=0 if following fields are valid */
diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
index db3b2e8..29934f8 100644
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -151,7 +151,7 @@ struct vt8231_data {
 	const char *name;
 
 	struct mutex update_lock;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 073eabe..2d7aff86 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -286,7 +286,7 @@ struct w83627ehf_data {
 	int addr;	/* IO base of hw monitor block */
 	const char *name;
 
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex lock;
 
 	const u8 *REG_FAN_START_OUTPUT;
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index bde50e3..2399802 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -350,7 +350,7 @@ static inline u8 DIV_TO_REG(long val)
 struct w83627hf_data {
 	unsigned short addr;
 	const char *name;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex lock;
 	enum chips type;
 
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index eed43a0..67e9206 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -206,7 +206,7 @@ DIV_TO_REG(long val, enum chips type)
 
 struct w83781d_data {
 	struct i2c_client *client;
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex lock;
 	enum chips type;
 
diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index 400a88b..be0a2ca 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -277,7 +277,7 @@ static u8 div_to_reg(int nr, long val)
 }
 
 struct w83791d_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 
 	char valid;			/* !=0 if following fields are valid */
diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index 63841f8..4c71e84 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -269,7 +269,7 @@ DIV_TO_REG(long val)
 }
 
 struct w83792d_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 
 	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index e3bdedf..4e9a58f 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -213,7 +213,7 @@ static inline s8 TEMP_TO_REG(long val, s8 min, s8 max)
 
 struct w83793_data {
 	struct i2c_client *lm75[2];
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;			/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
diff --git a/drivers/hwmon/w83795.c b/drivers/hwmon/w83795.c
index 845232d..cfe7370 100644
--- a/drivers/hwmon/w83795.c
+++ b/drivers/hwmon/w83795.c
@@ -331,7 +331,7 @@ static u8 pwm_freq_to_reg(unsigned long val, u16 clkin)
 enum chip_types {w83795g, w83795adg};
 
 struct w83795_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	unsigned long last_updated;	/* In jiffies */
 	enum chip_types chip_type;
diff --git a/drivers/hwmon/w83l785ts.c b/drivers/hwmon/w83l785ts.c
index 20781de..38aa18e 100644
--- a/drivers/hwmon/w83l785ts.c
+++ b/drivers/hwmon/w83l785ts.c
@@ -110,7 +110,7 @@ static struct i2c_driver w83l785ts_driver = {
  */
 
 struct w83l785ts_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
diff --git a/drivers/hwmon/w83l786ng.c b/drivers/hwmon/w83l786ng.c
index 0254e18..403e6ca 100644
--- a/drivers/hwmon/w83l786ng.c
+++ b/drivers/hwmon/w83l786ng.c
@@ -120,7 +120,7 @@ DIV_TO_REG(long val)
 }
 
 struct w83l786ng_data {
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;			/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
diff --git a/drivers/hwmon/wm831x-hwmon.c b/drivers/hwmon/wm831x-hwmon.c
index 97b1f83..a42e69d 100644
--- a/drivers/hwmon/wm831x-hwmon.c
+++ b/drivers/hwmon/wm831x-hwmon.c
@@ -31,7 +31,7 @@
 
 struct wm831x_hwmon {
 	struct wm831x *wm831x;
-	struct device *classdev;
+	struct hwmon_device *classdev;
 };
 
 static ssize_t show_name(struct device *dev,
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 14ea54b..2d6faa9 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -98,7 +98,7 @@ struct ads7846 {
 
 #if defined(CONFIG_HWMON) || defined(CONFIG_HWMON_MODULE)
 	struct attribute_group	*attr_group;
-	struct device		*hwmon;
+	struct hwmon_device	*hwmon;
 #endif
 
 	u16			model;
@@ -492,7 +492,7 @@ static struct attribute_group ads7845_attr_group = {
 
 static int ads784x_hwmon_register(struct spi_device *spi, struct ads7846 *ts)
 {
-	struct device *hwmon;
+	struct hwmon_device *hwmon;
 	int err;
 
 	/* hwmon sensors need a reference voltage */
diff --git a/drivers/platform/x86/compal-laptop.c b/drivers/platform/x86/compal-laptop.c
index 034572b..795cc49 100644
--- a/drivers/platform/x86/compal-laptop.c
+++ b/drivers/platform/x86/compal-laptop.c
@@ -171,7 +171,7 @@
 /* ======= */
 struct compal_data{
 	/* Fan control */
-	struct device *hwmon_dev;
+	struct hwmon_device *hwmon_dev;
 	int pwm_enable; /* 0:full on, 1:set by pwm1, 2:control by moterboard */
 	unsigned char curr_pwm;
 
diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 49d9ad7..ea5509f 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -166,7 +166,7 @@ struct eeepc_laptop {
 
 	struct platform_device *platform_device;
 	struct acpi_device *device;		/* the device we are in */
-	struct device *hwmon_device;
+	struct hwmon_device *hwmon_device;
 	struct backlight_device *backlight_device;
 
 	struct input_dev *inputdev;
@@ -1074,12 +1074,12 @@ static struct attribute_group hwmon_attribute_group = {
 
 static void eeepc_hwmon_exit(struct eeepc_laptop *eeepc)
 {
-	struct device *hwmon;
+	struct hwmon_device *hwmon;
 
 	hwmon = eeepc->hwmon_device;
 	if (!hwmon)
 		return;
-	sysfs_remove_group(&hwmon->kobj,
+	sysfs_remove_group(&hwmon->dev->kobj,
 			   &hwmon_attribute_group);
 	hwmon_device_unregister(hwmon);
 	eeepc->hwmon_device = NULL;
@@ -1087,7 +1087,7 @@ static void eeepc_hwmon_exit(struct eeepc_laptop *eeepc)
 
 static int eeepc_hwmon_init(struct eeepc_laptop *eeepc)
 {
-	struct device *hwmon;
+	struct hwmon_device *hwmon;
 	int result;
 
 	hwmon = hwmon_device_register(&eeepc->platform_device->dev);
@@ -1097,7 +1097,7 @@ static int eeepc_hwmon_init(struct eeepc_laptop *eeepc)
 		return PTR_ERR(hwmon);
 	}
 	eeepc->hwmon_device = hwmon;
-	result = sysfs_create_group(&hwmon->kobj,
+	result = sysfs_create_group(&hwmon->dev->kobj,
 				    &hwmon_attribute_group);
 	if (result)
 		eeepc_hwmon_exit(eeepc);
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index dd59958..9995d0f 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -924,7 +924,7 @@ static char *next_cmd(char **cmds)
 
 static struct platform_device *tpacpi_pdev;
 static struct platform_device *tpacpi_sensors_pdev;
-static struct device *tpacpi_hwmon;
+static struct hwmon_device *tpacpi_hwmon;
 static struct input_dev *tpacpi_inputdev;
 static struct mutex tpacpi_inputdev_send_mutex;
 static LIST_HEAD(tpacpi_all_drivers);
diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 7d0e63c..f93ae52 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -510,8 +510,8 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 		result = PTR_ERR(hwmon->device);
 		goto free_mem;
 	}
-	dev_set_drvdata(hwmon->device, hwmon);
-	result = device_create_file(hwmon->device, &dev_attr_name);
+	dev_set_drvdata(hwmon->device->dev, hwmon);
+	result = device_create_file(hwmon->device->dev, &dev_attr_name);
 	if (result)
 		goto unregister_hwmon_device;
 
@@ -525,7 +525,7 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 	tz->temp_input.attr.attr.mode = 0444;
 	tz->temp_input.attr.show = temp_input_show;
 	sysfs_attr_init(&tz->temp_input.attr.attr);
-	result = device_create_file(hwmon->device, &tz->temp_input.attr);
+	result = device_create_file(hwmon->device->dev, &tz->temp_input.attr);
 	if (result)
 		goto unregister_hwmon_device;
 
@@ -538,7 +538,7 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 			tz->temp_crit.attr.attr.mode = 0444;
 			tz->temp_crit.attr.show = temp_crit_show;
 			sysfs_attr_init(&tz->temp_crit.attr.attr);
-			result = device_create_file(hwmon->device,
+			result = device_create_file(hwmon->device->dev,
 						    &tz->temp_crit.attr);
 			if (result)
 				goto unregister_hwmon_device;
@@ -554,10 +554,10 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 	return 0;
 
  unregister_hwmon_device:
-	device_remove_file(hwmon->device, &tz->temp_crit.attr);
-	device_remove_file(hwmon->device, &tz->temp_input.attr);
+	device_remove_file(hwmon->device->dev, &tz->temp_crit.attr);
+	device_remove_file(hwmon->device->dev, &tz->temp_input.attr);
 	if (new_hwmon_device) {
-		device_remove_file(hwmon->device, &dev_attr_name);
+		device_remove_file(hwmon->device->dev, &dev_attr_name);
 		hwmon_device_unregister(hwmon->device);
 	}
  free_mem:
@@ -573,8 +573,8 @@ thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 	struct thermal_hwmon_device *hwmon = tz->hwmon;
 
 	tz->hwmon = NULL;
-	device_remove_file(hwmon->device, &tz->temp_input.attr);
-	device_remove_file(hwmon->device, &tz->temp_crit.attr);
+	device_remove_file(hwmon->device->dev, &tz->temp_input.attr);
+	device_remove_file(hwmon->device->dev, &tz->temp_crit.attr);
 
 	mutex_lock(&thermal_list_lock);
 	list_del(&tz->hwmon_node);
@@ -585,7 +585,7 @@ thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 	list_del(&hwmon->node);
 	mutex_unlock(&thermal_list_lock);
 
-	device_remove_file(hwmon->device, &dev_attr_name);
+	device_remove_file(hwmon->device->dev, &dev_attr_name);
 	hwmon_device_unregister(hwmon->device);
 	kfree(hwmon);
 }
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 6b6ee70..1cc5424 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -16,9 +16,142 @@
 
 #include <linux/device.h>
 
-struct device *hwmon_device_register(struct device *dev);
+struct hwmon_device;
 
-void hwmon_device_unregister(struct device *dev);
+enum hwmon_attr {
+	hwmon_attr_input = 0,
+	hwmon_attr_min,
+	hwmon_attr_max,
+	hwmon_attr_type,
+	hwmon_attr_offset,
+	hwmon_attr_label,
+	hwmon_attr_lowest,
+	hwmon_attr_highest,
+	hwmon_attr_vid,
+	hwmon_attr_vrm,
+	hwmon_attr_div,
+	hwmon_attr_target,
+	hwmon_attr_enable,
+	hwmon_attr_mode,
+	hwmon_attr_freq,
+	hwmon_attr_auto_channels_temp,
+	hwmon_attr_max_hyst,
+	hwmon_attr_crit,
+	hwmon_attr_crit_hyst,
+	hwmon_attr_reset_history,
+	hwmon_attr_average,
+	hwmon_attr_average_interval,
+	hwmon_attr_average_interval_min,
+	hwmon_attr_average_interval_max,
+	hwmon_attr_average_highest,
+	hwmon_attr_average_lowest,
+	hwmon_attr_average_max,
+	hwmon_attr_average_min,
+	hwmon_attr_input_highest,
+	hwmon_attr_input_lowest,
+	hwmon_attr_accuracy,
+	hwmon_attr_alarm,
+	hwmon_attr_cap,
+	hwmon_attr_cap_hyst,
+	hwmon_attr_cap_max,
+	hwmon_attr_cap_min,
+	hwmon_attr_min_alarm,
+	hwmon_attr_max_alarm,
+	hwmon_attr_crit_alarm,
+	hwmon_attr_fault,
+	hwmon_attr_beep,
+};
+
+enum hwmon_trip_point_entity {
+	hwmon_trip_point_pwm = 0,
+	hwmon_trip_point_temp,
+	hwmon_trip_point_temp_hyst,
+};
+
+struct hwmon_device_ops {
+	int (*get_name) (struct hwmon_device *, char *name, size_t length);
+	int (*get_update_rate) (struct hwmon_device *, int *rate);
+	int (*temp_reset_history) (struct hwmon_device *);
+
+	int (*get_temp) (struct hwmon_device *, int probe,
+			enum hwmon_attr attr, int *value);
+	int (*set_temp) (struct hwmon_device *, int probe,
+			enum hwmon_attr attr, int value);
+	int (*get_fan) (struct hwmon_device *, int fan,
+			enum hwmon_attr attr, int *value);
+	int (*set_fan) (struct hwmon_device *, int fan,
+			enum hwmon_attr attr, int value);
+	int (*get_voltage) (struct hwmon_device *, int probe,
+			enum hwmon_attr attr, int *value);
+	int (*set_voltage) (struct hwmon_device *, int probe,
+			enum hwmon_attr attr, int value);
+	int (*get_current) (struct hwmon_device *, int probe,
+			enum hwmon_attr attr, int *value);
+	int (*set_current) (struct hwmon_device *, int probe,
+			enum hwmon_attr attr, int value);
+	int (*get_power) (struct hwmon_device *, int probe,
+			enum hwmon_attr attr, int *value);
+	int (*set_power) (struct hwmon_device *, int probe,
+			enum hwmon_attr attr, int value);
+	int (*get_energy) (struct hwmon_device *, int probe,
+			enum hwmon_attr attr, int *value);
+	int (*get_intrusion) (struct hwmon_device *, int probe,
+			enum hwmon_attr attr, int *value);
+	int (*set_intrusion) (struct hwmon_device *, int probe,
+			enum hwmon_attr attr, int value);
+	int (*get_trip_point) (struct hwmon_device *,
+			enum hwmon_trip_point_entity, int probe,
+			int trip_point, enum hwmon_trip_point_entity,
+			int *value);
+	int (*set_trip_point) (struct hwmon_device *,
+			enum hwmon_trip_point_entity, int probe,
+			int trip_point, enum hwmon_trip_point_entity,
+			int value);
+};
+
+struct hwmon_device {
+	struct device *dev;
+	struct device *sensor_dev;
+	struct list_head node;
+	struct hwmon_device_ops ops;
+};
+
+struct hwmon_device *hwmon_device_register(struct device *dev);
+
+void hwmon_device_unregister(struct hwmon_device *dev);
+
+struct hwmon_device *hwmon_get_device(struct device *dev);
+
+int hwmon_get_name(struct hwmon_device *, char *name, size_t length);
+int hwmon_get_update_rate(struct hwmon_device *, int *rate);
+int hwmon_temp_reset_history(struct hwmon_device *);
+
+int hwmon_get_temp(struct hwmon_device *, int channel,
+		enum hwmon_attr flag, int *value);
+int hwmon_set_temp(struct hwmon_device *, int channel,
+		enum hwmon_attr attr, int value);
+int hwmon_get_fan(struct hwmon_device *, int fan,
+		enum hwmon_attr attr, int *value);
+int hwmon_set_fan(struct hwmon_device *, int fan,
+		enum hwmon_attr attr, int value);
+int hwmon_get_voltage(struct hwmon_device *, int channel,
+		enum hwmon_attr attr, int *value);
+int hwmon_set_voltage(struct hwmon_device *, int channel,
+		enum hwmon_attr attr, int value);
+int hwmon_get_current(struct hwmon_device *, int channel,
+		enum hwmon_attr attr, int *value);
+int hwmon_set_current(struct hwmon_device *, int channel,
+		enum hwmon_attr attr, int value);
+int hwmon_get_power(struct hwmon_device *, int channel,
+		enum hwmon_attr attr, int *value);
+int hwmon_set_power(struct hwmon_device *, int channel,
+		enum hwmon_attr attr, int value);
+int hwmon_get_energy(struct hwmon_device *, int channel,
+		enum hwmon_attr attr, int *value);
+int hwmon_get_intrusion(struct hwmon_device *, int probe,
+		enum hwmon_attr attr, int *value);
+int hwmon_set_intrusion(struct hwmon_device *, int probe,
+		enum hwmon_attr attr, int value);
 
 /* Scale user input to sensible values */
 static inline int SENSORS_LIMIT(long value, long low, long high)
diff --git a/include/linux/mfd/wm8350/core.h b/include/linux/mfd/wm8350/core.h
index 98fcc97..50aac40 100644
--- a/include/linux/mfd/wm8350/core.h
+++ b/include/linux/mfd/wm8350/core.h
@@ -605,7 +605,7 @@ struct wm8350;
 
 struct wm8350_hwmon {
 	struct platform_device *pdev;
-	struct device *classdev;
+	struct hwmon_device *classdev;
 };
 
 struct wm8350 {
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 8651556..558a118 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -89,7 +89,7 @@ struct thermal_cooling_device {
 /* thermal zone devices with the same type share one hwmon device */
 struct thermal_hwmon_device {
 	char type[THERMAL_NAME_LENGTH];
-	struct device *device;
+	struct hwmon_device *device;
 	int count;
 	struct list_head tz_list;
 	struct list_head node;
-- 
1.7.4


--------------070100090608000701020600
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------070100090608000701020600--
