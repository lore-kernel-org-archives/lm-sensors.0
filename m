From: <atull@opensource.altera.com>
Date: Wed, 15 Oct 2014 18:55:08 +0000
Subject: [lm-sensors] [PATCH v6 2/4] pmbus: core: add helpers for byte write and read modify write
Message-Id: <1413399310-19277-3-git-send-email-atull@opensource.altera.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1413399310-19277-1-git-send-email-atull@opensource.altera.com>
In-Reply-To: <1413399310-19277-1-git-send-email-atull@opensource.altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net, jdelvare@suse.de
Cc: lm-sensors@lm-sensors.org, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, delicious.quinoa@gmail.com, dinguyen@opensource.altera.com, yvanderv@opensource.altera.com, Alan Tull <atull@opensource.altera.com>

From: Alan Tull <atull@opensource.altera.com>

Add two helper functions:
 * pmbus_write_byte_data  = paged byte write
 * pmbus_update_byte_data = paged byte read/modify/write

Signed-off-by: Alan Tull <atull@opensource.altera.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Mark Brown <broonie@kernel.org>
---
v2: add prototypes for the two new functions
---
 drivers/hwmon/pmbus/pmbus.h      |    4 ++++
 drivers/hwmon/pmbus/pmbus_core.c |   31 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index fa9beb3..3ae79a7 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -375,6 +375,10 @@ int pmbus_read_word_data(struct i2c_client *client, u8 page, u8 reg);
 int pmbus_write_word_data(struct i2c_client *client, u8 page, u8 reg, u16 word);
 int pmbus_read_byte_data(struct i2c_client *client, int page, u8 reg);
 int pmbus_write_byte(struct i2c_client *client, int page, u8 value);
+int pmbus_write_byte_data(struct i2c_client *client, int page, u8 reg,
+			  u8 value);
+int pmbus_update_byte_data(struct i2c_client *client, int page, u8 reg,
+			   u8 mask, u8 value);
 void pmbus_clear_faults(struct i2c_client *client);
 bool pmbus_check_byte_register(struct i2c_client *client, int page, int reg);
 bool pmbus_check_word_register(struct i2c_client *client, int page, int reg);
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 291d11f..d6c3701 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -253,6 +253,37 @@ int pmbus_read_byte_data(struct i2c_client *client, int page, u8 reg)
 }
 EXPORT_SYMBOL_GPL(pmbus_read_byte_data);
 
+int pmbus_write_byte_data(struct i2c_client *client, int page, u8 reg, u8 value)
+{
+	int rv;
+
+	rv = pmbus_set_page(client, page);
+	if (rv < 0)
+		return rv;
+
+	return i2c_smbus_write_byte_data(client, reg, value);
+}
+EXPORT_SYMBOL_GPL(pmbus_write_byte_data);
+
+int pmbus_update_byte_data(struct i2c_client *client, int page, u8 reg,
+			   u8 mask, u8 value)
+{
+	unsigned int tmp;
+	int rv;
+
+	rv = pmbus_read_byte_data(client, page, reg);
+	if (rv < 0)
+		return rv;
+
+	tmp = (rv & ~mask) | (value & mask);
+
+	if (tmp != rv)
+		rv = pmbus_write_byte_data(client, page, reg, tmp);
+
+	return rv;
+}
+EXPORT_SYMBOL_GPL(pmbus_update_byte_data);
+
 /*
  * _pmbus_read_byte_data() is similar to pmbus_read_byte_data(), but checks if
  * a device specific mapping function exists and calls it if necessary.
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
