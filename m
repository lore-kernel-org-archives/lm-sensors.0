From: Nate Case <ncase@xes-inc.com>
Date: Mon, 08 Jun 2009 22:22:20 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ds1621) Add support for DS1631
Message-Id: <1244499740-19328-1-git-send-email-ncase@xes-inc.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

DS1631 is very similar to DS1621, with the additional capability to
provide higher resolution temperature readings.  The ds1621 driver does
not currently support the DS1631 or the higher resolution readings.
However, according to Dallas/Maxim AN176, the DS1631 can be used in
DS1621 mode as long as 0xEE is used to initiate temperature conversions
instead of the DS1631-specific 0x51 command.  Therefore, we can function
with a DS1631 simply by adding it to the device ID table.

Signed-off-by: Nate Case <ncase@xes-inc.com>
---
 drivers/hwmon/Kconfig  |    4 ++--
 drivers/hwmon/ds1621.c |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index d73f5f4..3315568 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -275,11 +275,11 @@ config SENSORS_ATXP1
 	  will be called atxp1.
 
 config SENSORS_DS1621
-	tristate "Dallas Semiconductor DS1621 and DS1625"
+	tristate "Dallas Semiconductor DS1621/DS1625/DS1631"
 	depends on I2C
 	help
 	  If you say yes here you get support for Dallas Semiconductor
-	  DS1621 and DS1625 sensor chips.
+	  DS1621/DS1625/DS1631 sensor chips.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called ds1621.
diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index 53f88f5..9b4114c 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -311,6 +311,7 @@ static int ds1621_remove(struct i2c_client *client)
 static const struct i2c_device_id ds1621_id[] = {
 	{ "ds1621", ds1621 },
 	{ "ds1625", ds1621 },
+	{ "ds1631", ds1621 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ds1621_id);
-- 
1.6.0.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
