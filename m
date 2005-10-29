From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:14:59 +0000
Subject: [lm-sensors] [PATCH] i2c: Adjust i2c_probe() for busses without
Message-Id: <11305336583202@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Adjust i2c_probe() for busses without SMBUS_QUICK

Move the check for SMBUS_QUICK in i2c_probe() after the forced
addresses have been handled. This makes it possible for a driver to
leave the probed address lists empty, only providing forced addresses,
and get i2c_probe to work even if the bus doesn't support SMBUS_QUICK.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

 drivers/i2c/i2c-core.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

---
commit 4366dc946c01305cff49b07dabb806d2364f1edb
tree 0cc9f6a086d47f3b8688f2f8c8ce6d924be97d03
parent cb929eae78ec0b243dbf58039bce4af354f6020c
author Jean Delvare <khali@linux-fr.org> Sun, 25 Sep 2005 16:50:06 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:07 -0700

 drivers/i2c/i2c-core.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 45aa0e5..b55097d 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -706,10 +706,6 @@ int i2c_probe(struct i2c_adapter *adapte
 	int i, err;
 	int adap_id = i2c_adapter_id(adapter);
 
-	/* Forget it if we can't probe using SMBUS_QUICK */
-	if (! i2c_check_functionality(adapter,I2C_FUNC_SMBUS_QUICK))
-		return -1;
-
 	/* Force entries are done first, and are not affected by ignore
 	   entries */
 	if (address_data->forces) {
@@ -736,6 +732,17 @@ int i2c_probe(struct i2c_adapter *adapte
 		}
 	}
 
+	/* Stop here if we can't use SMBUS_QUICK */
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_QUICK)) {
+		if (address_data->probe[0] = I2C_CLIENT_END
+		 && address_data->normal_i2c[0] = I2C_CLIENT_END)
+		 	return 0;
+
+		dev_warn(&adapter->dev, "SMBus Quick command not supported, "
+			 "can't probe for chips\n");
+		return -1;
+	}
+
 	/* Probe entries are done second, and are not affected by ignore
 	   entries either */
 	for (i = 0; address_data->probe[i] != I2C_CLIENT_END; i += 2) {

