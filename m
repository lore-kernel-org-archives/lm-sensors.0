From: <michael.hennerich@analog.com>
Date: Thu, 13 Oct 2011 08:43:31 +0000
Subject: [lm-sensors] [PATCH V2] hwmon:lm75 add support for the Analog
Message-Id: <1318495411-20399-1-git-send-email-michael.hennerich@analog.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Changes since V1:

Remove depreciated ADT75 device detection support.
The ADT75, like some other LM75 derivatives needs to be instantiated
using methods 1,2 or 4.
For more information see Documentation/i2c/instantiating-devices.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 Documentation/hwmon/lm75 |    5 +++++
 drivers/hwmon/Kconfig    |    1 +
 drivers/hwmon/lm75.c     |    2 ++
 3 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/lm75 b/Documentation/hwmon/lm75
index a179040..8d40d0f 100644
--- a/Documentation/hwmon/lm75
+++ b/Documentation/hwmon/lm75
@@ -32,6 +32,11 @@ Supported chips:
     Addresses scanned: I2C 0x48 - 0x4f
     Datasheet: Publicly available at the Microchip website
                http://www.microchip.com/
+  * Analog Devices ADT75
+    Prefix: 'adt75'
+    Addresses scanned: I2C 0x48 - 0x4f
+    Datasheet: Publicly available at the Analog Devices website
+               http://www.analog.com/adt75

 Author: Frodo Looijaard <frodol@dds.nl>

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 0b62c3c..497fd14 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -531,6 +531,7 @@ config SENSORS_LM75
 	  If you say yes here you get support for one common type of
 	  temperature sensor chip, with models including:

+		- Analog Devices ADT75
 		- Dallas Semiconductor DS75 and DS1775
 		- Maxim MAX6625 and MAX6626
 		- Microchip MCP980x
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index ef902d5..669481b 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -35,6 +35,7 @@
  */

 enum lm75_type {		/* keep sorted in alphabetical order */
+	adt75,
 	ds1775,
 	ds75,
 	lm75,
@@ -213,6 +214,7 @@ static int lm75_remove(struct i2c_client *client)
 }

 static const struct i2c_device_id lm75_ids[] = {
+	{ "adt75", adt75, },
 	{ "ds1775", ds1775, },
 	{ "ds75", ds75, },
 	{ "lm75", lm75, },
--
1.7.0.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
