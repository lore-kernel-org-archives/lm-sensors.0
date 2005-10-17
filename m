From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 17 Oct 2005 23:02:26 +0000
Subject: [lm-sensors] [PATCH 07/14] hwmon: Missing class check in two hwmon
Message-Id: <20051017230242.1b29cbd6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-missing-driver-class.patch

The atxp1 and ds1621 drivers should make sure they do not probe
non-hwmon i2c adapters.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

---
 drivers/hwmon/atxp1.c  |    2 ++
 drivers/hwmon/ds1621.c |    2 ++
 2 files changed, 4 insertions(+)

--- linux-2.6.14-rc3.orig/drivers/hwmon/atxp1.c	2005-10-12 10:30:04.000000000 +0200
+++ linux-2.6.14-rc3/drivers/hwmon/atxp1.c	2005-10-12 15:30:42.000000000 +0200
@@ -253,6 +253,8 @@
 
 static int atxp1_attach_adapter(struct i2c_adapter *adapter)
 {
+	if (!(adapter->class & I2C_CLASS_HWMON))
+		return 0;
 	return i2c_probe(adapter, &addr_data, &atxp1_detect);
 };
 
--- linux-2.6.14-rc3.orig/drivers/hwmon/ds1621.c	2005-10-12 10:30:04.000000000 +0200
+++ linux-2.6.14-rc3/drivers/hwmon/ds1621.c	2005-10-12 15:30:29.000000000 +0200
@@ -180,6 +180,8 @@
 
 static int ds1621_attach_adapter(struct i2c_adapter *adapter)
 {
+	if (!(adapter->class & I2C_CLASS_HWMON))
+		return 0;
 	return i2c_probe(adapter, &addr_data, ds1621_detect);
 }
 

-- 
Jean Delvare
