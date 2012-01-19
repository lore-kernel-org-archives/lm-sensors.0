From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:53 +0000
Subject: [lm-sensors] [PATCH 59/82] hwmon: (sht21) Fix multi-line comments
Message-Id: <1327017376-20466-60-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/sht21.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/sht21.c b/drivers/hwmon/sht21.c
index 1539878..f6ad386 100644
--- a/drivers/hwmon/sht21.c
+++ b/drivers/hwmon/sht21.c
@@ -1,4 +1,5 @@
-/* Sensirion SHT21 humidity and temperature sensor driver
+/*
+ * Sensirion SHT21 humidity and temperature sensor driver
  *
  * Copyright (C) 2010 Urs Fleisch <urs.fleisch@sensirion.com>
  *
@@ -34,7 +35,7 @@
 #define SHT21_TRIG_T_MEASUREMENT_HM  0xe3
 #define SHT21_TRIG_RH_MEASUREMENT_HM 0xe5
 
-/**
+/*
  * struct sht21 - SHT21 device specific data
  * @hwmon_dev: device registered with hwmon
  * @lock: mutex to protect measurement values
@@ -52,7 +53,7 @@ struct sht21 {
 	int humidity;
 };
 
-/**
+/*
  * sht21_temp_ticks_to_millicelsius() - convert raw temperature ticks to
  * milli celsius
  * @ticks: temperature ticks value received from sensor
@@ -67,7 +68,7 @@ static inline int sht21_temp_ticks_to_millicelsius(int ticks)
 	return ((21965 * ticks) >> 13) - 46850;
 }
 
-/**
+/*
  * sht21_rh_ticks_to_per_cent_mille() - convert raw humidity ticks to
  * one-thousandths of a percent relative humidity
  * @ticks: humidity ticks value received from sensor
@@ -82,7 +83,7 @@ static inline int sht21_rh_ticks_to_per_cent_mille(int ticks)
 	return ((15625 * ticks) >> 13) - 6000;
 }
 
-/**
+/*
  * sht21_update_measurements() - get updated measurements from device
  * @client: I2C client device
  *
@@ -119,7 +120,7 @@ out:
 	return ret >= 0 ? 0 : ret;
 }
 
-/**
+/*
  * sht21_show_temperature() - show temperature measurement value in sysfs
  * @dev: device
  * @attr: device attribute
@@ -140,7 +141,7 @@ static ssize_t sht21_show_temperature(struct device *dev,
 	return sprintf(buf, "%d\n", sht21->temperature);
 }
 
-/**
+/*
  * sht21_show_humidity() - show humidity measurement value in sysfs
  * @dev: device
  * @attr: device attribute
@@ -177,7 +178,7 @@ static const struct attribute_group sht21_attr_group = {
 	.attrs = sht21_attributes,
 };
 
-/**
+/*
  * sht21_probe() - probe device
  * @client: I2C client device
  * @id: device ID
@@ -232,7 +233,7 @@ fail_free:
 	return err;
 }
 
-/**
+/*
  * sht21_remove() - remove device
  * @client: I2C client device
  */
@@ -261,7 +262,7 @@ static struct i2c_driver sht21_driver = {
 	.id_table    = sht21_id,
 };
 
-/**
+/*
  * sht21_init() - initialize driver
  *
  * Called when kernel is booted or module is inserted.
@@ -273,7 +274,7 @@ static int __init sht21_init(void)
 }
 module_init(sht21_init);
 
-/**
+/*
  * sht21_init() - clean up driver
  *
  * Called when module is removed.
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
