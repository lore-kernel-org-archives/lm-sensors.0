From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 08 Oct 2005 00:20:34 +0000
Subject: [lm-sensors] [PATCH 14/16] i2c: Drop meaningless use of
Message-Id: <20051008001952.08a96d53.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I2C_DF_NOTIFY is an i2c_driver flag, using it as an i2c_client flag
doesn't make any sense.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Acked-by: Mark A. Greer <mgreer@mvista.com>
Acked-by: Randy Vinson <rvinson@mvista.com>

 drivers/i2c/chips/ds1374.c  |    1 -
 drivers/i2c/chips/m41t00.c  |    1 -
 drivers/i2c/chips/rtc8564.c |    2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

--- linux-2.6.14-rc3.orig/drivers/i2c/chips/ds1374.c	2005-10-07 20:08:15.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/chips/ds1374.c	2005-10-07 22:08:27.000000000 +0200
@@ -199,7 +199,6 @@
 
 	memset(client, 0, sizeof(struct i2c_client));
 	strncpy(client->name, DS1374_DRV_NAME, I2C_NAME_SIZE);
-	client->flags = I2C_DF_NOTIFY;
 	client->addr = addr;
 	client->adapter = adap;
 	client->driver = &ds1374_driver;
--- linux-2.6.14-rc3.orig/drivers/i2c/chips/m41t00.c	2005-10-07 20:08:15.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/chips/m41t00.c	2005-10-07 22:08:27.000000000 +0200
@@ -180,7 +180,6 @@
 
 	memset(client, 0, sizeof(struct i2c_client));
 	strncpy(client->name, M41T00_DRV_NAME, I2C_NAME_SIZE);
-	client->flags = I2C_DF_NOTIFY;
 	client->addr = addr;
 	client->adapter = adap;
 	client->driver = &m41t00_driver;
--- linux-2.6.14-rc3.orig/drivers/i2c/chips/rtc8564.c	2005-10-07 20:08:15.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/chips/rtc8564.c	2005-10-07 22:08:27.000000000 +0200
@@ -158,7 +158,7 @@
 
 	strlcpy(new_client->name, "RTC8564", I2C_NAME_SIZE);
 	i2c_set_clientdata(new_client, d);
-	new_client->flags = I2C_CLIENT_ALLOW_USE | I2C_DF_NOTIFY;
+	new_client->flags = I2C_CLIENT_ALLOW_USE;
 	new_client->addr = addr;
 	new_client->adapter = adap;
 	new_client->driver = &rtc8564_driver;

-- 
Jean Delvare
