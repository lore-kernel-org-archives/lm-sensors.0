From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 00:15:42 +0000
Subject: [lm-sensors] [PATCH] hwmon: Missing class check in two hwmon drivers
Message-Id: <11305336621727@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: Missing class check in two hwmon drivers

The atxp1 and ds1621 drivers should make sure they do not probe
non-hwmon i2c adapters.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ddec748f328af6b67e4d0ce0248a8e9f36751827
tree ce99658260e0a5f3d56e67d5d33ce8e498947990
parent 7ab83a9137ccd3e092fb6ad0cb105b4d1fb617ae
author Jean Delvare <khali@linux-fr.org> Mon, 17 Oct 2005 23:02:42 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:11 -0700

 drivers/hwmon/atxp1.c  |    2 ++
 drivers/hwmon/ds1621.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
index deb4d34..441324f 100644
--- a/drivers/hwmon/atxp1.c
+++ b/drivers/hwmon/atxp1.c
@@ -253,6 +253,8 @@ static DEVICE_ATTR(gpio2, S_IRUGO | S_IW
 
 static int atxp1_attach_adapter(struct i2c_adapter *adapter)
 {
+	if (!(adapter->class & I2C_CLASS_HWMON))
+		return 0;
 	return i2c_probe(adapter, &addr_data, &atxp1_detect);
 };
 
diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index b0199e0..e1ff22c 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -180,6 +180,8 @@ static DEVICE_ATTR(temp1_max, S_IWUSR | 
 
 static int ds1621_attach_adapter(struct i2c_adapter *adapter)
 {
+	if (!(adapter->class & I2C_CLASS_HWMON))
+		return 0;
 	return i2c_probe(adapter, &addr_data, ds1621_detect);
 }
 

