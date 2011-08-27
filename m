From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 27 Aug 2011 18:54:10 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (pmbus) Always call
Message-Id: <1314471251-10472-2-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Always call _pmbus_read_byte() instead of pmbus_read_byte() in PMBus core
driver. With this change, device specific read functions can be implemented for
all registers.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/pmbus/pmbus_core.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index b1320cf..c722ba9 100644
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
 			return -EINVAL;
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
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
