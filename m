From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 25 Sep 2005 16:30:09 +0000
Subject: [lm-sensors] [PATCH] (5/13) hwmon: Discard bogus comment about init
Message-Id: <20050925162938.71c87823.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Discard a common out-of-date comment in 5 hardware monitoring drivers.
The hardware monitoring chip drivers are no more setting sensor limits
at initialization time, for quite some time already.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/hwmon/lm78.c     |    1 -
 drivers/hwmon/via686a.c  |    1 -
 drivers/hwmon/w83627hf.c |    1 -
 drivers/hwmon/w83781d.c  |    1 -
 drivers/hwmon/w83792d.c  |    1 -
 5 files changed, 5 deletions(-)

--- linux-2.6.14-rc2.orig/drivers/hwmon/lm78.c	2005-09-25 09:03:35.000000000 +0200
+++ linux-2.6.14-rc2/drivers/hwmon/lm78.c	2005-09-25 14:36:30.000000000 +0200
@@ -726,7 +726,6 @@
 		return i2c_smbus_write_byte_data(client, reg, value);
 }
 
-/* Called when we have found a new LM78. It should set limits, etc. */
 static void lm78_init_client(struct i2c_client *client)
 {
 	u8 config = lm78_read_value(client, LM78_REG_CONFIG);
--- linux-2.6.14-rc2.orig/drivers/hwmon/via686a.c	2005-09-25 14:34:19.000000000 +0200
+++ linux-2.6.14-rc2/drivers/hwmon/via686a.c	2005-09-25 14:36:30.000000000 +0200
@@ -712,7 +712,6 @@
 	return 0;
 }
 
-/* Called when we have found a new VIA686A. Set limits, etc. */
 static void via686a_init_client(struct i2c_client *client)
 {
 	u8 reg;
--- linux-2.6.14-rc2.orig/drivers/hwmon/w83627hf.c	2005-09-25 09:03:35.000000000 +0200
+++ linux-2.6.14-rc2/drivers/hwmon/w83627hf.c	2005-09-25 14:36:30.000000000 +0200
@@ -1275,7 +1275,6 @@
 	return 0;
 }
 
-/* Called when we have found a new W83781D. It should set limits, etc. */
 static void w83627hf_init_client(struct i2c_client *client)
 {
 	struct w83627hf_data *data = i2c_get_clientdata(client);
--- linux-2.6.14-rc2.orig/drivers/hwmon/w83781d.c	2005-09-25 09:03:35.000000000 +0200
+++ linux-2.6.14-rc2/drivers/hwmon/w83781d.c	2005-09-25 14:36:30.000000000 +0200
@@ -1451,7 +1451,6 @@
 	return 0;
 }
 
-/* Called when we have found a new W83781D. It should set limits, etc. */
 static void
 w83781d_init_client(struct i2c_client *client)
 {
--- linux-2.6.14-rc2.orig/drivers/hwmon/w83792d.c	2005-09-25 09:03:35.000000000 +0200
+++ linux-2.6.14-rc2/drivers/hwmon/w83792d.c	2005-09-25 14:36:30.000000000 +0200
@@ -1429,7 +1429,6 @@
 	return 0;
 }
 
-/* Called when we have found a new W83792D. It should set limits, etc. */
 static void
 w83792d_init_client(struct i2c_client *client)
 {

-- 
Jean Delvare
