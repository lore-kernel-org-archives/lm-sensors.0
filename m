From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 03 Sep 2011 02:27:49 +0000
Subject: [lm-sensors] [PATCH v2 3/4] hwmon: (pmbus) Always call
Message-Id: <1315016870-10579-4-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Always call _pmbus_read_byte() instead of pmbus_read_byte() in PMBus core
driver. With this change, device specific read functions can be implemented for
all registers.

Since the device specific read_byte function is now always called, we need to be
more careful with page validations. Only fail if the passed page number is larger
than 0, since -1 means "current page".

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
v2: Be more careful with page validation for byte access functions.
    Specifically, always accept -1 as valid page number in device specific code,
    and don't select the page if the page number is -1.

 drivers/hwmon/pmbus/adm1275.c    |    2 +-
 drivers/hwmon/pmbus/lm25066.c    |    4 ++--
 drivers/hwmon/pmbus/max34440.c   |   10 ++++++----
 drivers/hwmon/pmbus/max8688.c    |    2 +-
 drivers/hwmon/pmbus/pmbus_core.c |   10 +++++-----
 drivers/hwmon/pmbus/ucd9000.c    |    4 ++--
 6 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index fa18112..980a4d9 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -144,7 +144,7 @@ static int adm1275_read_byte_data(struct i2c_client *client, int page, int reg)
 	const struct adm1275_data *data = to_adm1275_data(info);
 	int mfr_status, ret;
 
-	if (page)
+	if (page > 0)
 		return -ENXIO;
 
 	switch (reg) {
diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index a72bb9f..84a37f0 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -166,8 +166,8 @@ static int lm25066_write_byte(struct i2c_client *client, int page, u8 value)
 	if (page > 1)
 		return -ENXIO;
 
-	if (page = 0)
-		return pmbus_write_byte(client, 0, value);
+	if (page <= 0)
+		return pmbus_write_byte(client, page, value);
 
 	return 0;
 }
diff --git a/drivers/hwmon/pmbus/max34440.c b/drivers/hwmon/pmbus/max34440.c
index c824365..beaf5a8 100644
--- a/drivers/hwmon/pmbus/max34440.c
+++ b/drivers/hwmon/pmbus/max34440.c
@@ -93,12 +93,14 @@ static int max34440_write_word_data(struct i2c_client *client, int page,
 
 static int max34440_read_byte_data(struct i2c_client *client, int page, int reg)
 {
-	int ret;
+	int ret = 0;
 	int mfg_status;
 
-	ret = pmbus_set_page(client, page);
-	if (ret < 0)
-		return ret;
+	if (page >= 0) {
+		ret = pmbus_set_page(client, page);
+		if (ret < 0)
+			return ret;
+	}
 
 	switch (reg) {
 	case PMBUS_STATUS_IOUT:
diff --git a/drivers/hwmon/pmbus/max8688.c b/drivers/hwmon/pmbus/max8688.c
index 7113f11..e2b74bb 100644
--- a/drivers/hwmon/pmbus/max8688.c
+++ b/drivers/hwmon/pmbus/max8688.c
@@ -101,7 +101,7 @@ static int max8688_read_byte_data(struct i2c_client *client, int page, int reg)
 	int ret = 0;
 	int mfg_status;
 
-	if (page)
+	if (page > 0)
 		return -ENXIO;
 
 	switch (reg) {
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index cefbd85..1798f52 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -316,9 +316,9 @@ static int pmbus_check_status_cml(struct i2c_client *client)
 {
 	int status, status2;
 
-	status = pmbus_read_byte_data(client, -1, PMBUS_STATUS_BYTE);
+	status = _pmbus_read_byte_data(client, -1, PMBUS_STATUS_BYTE);
 	if (status < 0 || (status & PB_STATUS_CML)) {
-		status2 = pmbus_read_byte_data(client, -1, PMBUS_STATUS_CML);
+		status2 = _pmbus_read_byte_data(client, -1, PMBUS_STATUS_CML);
 		if (status2 < 0 || (status2 & PB_CML_FAULT_INVALID_COMMAND))
 			return -EIO;
 	}
@@ -371,8 +371,8 @@ static struct pmbus_data *pmbus_update_device(struct device *dev)
 
 		for (i = 0; i < info->pages; i++)
 			data->status[PB_STATUS_BASE + i]
-			    = pmbus_read_byte_data(client, i,
-						   PMBUS_STATUS_BYTE);
+			    = _pmbus_read_byte_data(client, i,
+						    PMBUS_STATUS_BYTE);
 		for (i = 0; i < info->pages; i++) {
 			if (!(info->func[i] & PMBUS_HAVE_STATUS_VOUT))
 				continue;
@@ -1589,7 +1589,7 @@ static int pmbus_identify_common(struct i2c_client *client,
 	int vout_mode = -1, exponent;
 
 	if (pmbus_check_byte_register(client, 0, PMBUS_VOUT_MODE))
-		vout_mode = pmbus_read_byte_data(client, 0, PMBUS_VOUT_MODE);
+		vout_mode = _pmbus_read_byte_data(client, 0, PMBUS_VOUT_MODE);
 	if (vout_mode >= 0 && vout_mode != 0xff) {
 		/*
 		 * Not all chips support the VOUT_MODE command,
diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
index 1536db6..4ff6cf2 100644
--- a/drivers/hwmon/pmbus/ucd9000.c
+++ b/drivers/hwmon/pmbus/ucd9000.c
@@ -74,7 +74,7 @@ static int ucd9000_read_byte_data(struct i2c_client *client, int page, int reg)
 
 	switch (reg) {
 	case PMBUS_FAN_CONFIG_12:
-		if (page)
+		if (page > 0)
 			return -ENXIO;
 
 		ret = ucd9000_get_fan_config(client, 0);
@@ -88,7 +88,7 @@ static int ucd9000_read_byte_data(struct i2c_client *client, int page, int reg)
 		ret = fan_config;
 		break;
 	case PMBUS_FAN_CONFIG_34:
-		if (page)
+		if (page > 0)
 			return -ENXIO;
 
 		ret = ucd9000_get_fan_config(client, 2);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
