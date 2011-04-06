From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 06 Apr 2011 23:41:32 +0000
Subject: [lm-sensors] [PATCH 4/7] hwmon: (pmbus) Use device specific
Message-Id: <1302133295-17302-5-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fan control implementation tends to be device specific, so start using
the device specific function call to read fan configuration registers.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Reviewed-by: Tom Grennan <tom.grennan@ericsson.com>
---
 drivers/hwmon/pmbus_core.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/pmbus_core.c b/drivers/hwmon/pmbus_core.c
index 43ec105..98799ba 100644
--- a/drivers/hwmon/pmbus_core.c
+++ b/drivers/hwmon/pmbus_core.c
@@ -1295,9 +1295,7 @@ static void pmbus_add_fan_attributes(struct i2c_client *client,
 				break;
 
 			if (!pmbus_check_word_register(client, page,
-						       pmbus_fan_registers[f])
-			    || !pmbus_check_byte_register(client, page,
-						pmbus_fan_config_registers[f]))
+						       pmbus_fan_registers[f]))
 				break;
 
 			/*
@@ -1305,7 +1303,7 @@ static void pmbus_add_fan_attributes(struct i2c_client *client,
 			 * Each fan configuration register covers multiple fans,
 			 * so we have to do some magic.
 			 */
-			regval = pmbus_read_byte_data(client, page,
+			regval = _pmbus_read_byte_data(client, page,
 				pmbus_fan_config_registers[f]);
 			if (regval < 0 ||
 			    (!(regval & (PB_FAN_1_INSTALLED >> ((f & 1) * 4)))))
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
