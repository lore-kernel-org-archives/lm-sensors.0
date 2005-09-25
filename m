From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 25 Sep 2005 16:50:38 +0000
Subject: [lm-sensors] [PATCH] (9/13) i2c: Adjust i2c_probe() for busses
Message-Id: <20050925165006.53b182e7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Move the check for SMBUS_QUICK in i2c_probe() after the forced
addresses have been handled. This makes it possible for a driver to
leave the probed address lists empty, only providing forced addresses,
and get i2c_probe to work even if the bus doesn't support SMBUS_QUICK.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/i2c-core.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- linux-2.6.14-rc2.orig/drivers/i2c/i2c-core.c	2005-09-25 09:03:34.000000000 +0200
+++ linux-2.6.14-rc2/drivers/i2c/i2c-core.c	2005-09-25 14:51:24.000000000 +0200
@@ -706,10 +706,6 @@
 	int i, err;
 	int adap_id = i2c_adapter_id(adapter);
 
-	/* Forget it if we can't probe using SMBUS_QUICK */
-	if (! i2c_check_functionality(adapter,I2C_FUNC_SMBUS_QUICK))
-		return -1;
-
 	/* Force entries are done first, and are not affected by ignore
 	   entries */
 	if (address_data->forces) {
@@ -736,6 +732,17 @@
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

-- 
Jean Delvare
