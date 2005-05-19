From: mgreer@mvista.com (Mark A. Greer)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: [PATCH 2.6.12-rc1] I2C: Fix breakage in m41t00 i2c rtc driver
Message-Id: <422E4313.6000004@mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Remove setting of deleted i2c_client structure member.

The latest include/linux/i2c.h:i2c_client structure no longer has an 
'id' member.  This patch removes the setting of that no longer existing 
member.

Please apply.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--
-------------- next part --------------
diff -Nru a/drivers/i2c/chips/m41t00.c b/drivers/i2c/chips/m41t00.c
--- a/drivers/i2c/chips/m41t00.c	2005-03-08 17:18:24 -07:00
+++ b/drivers/i2c/chips/m41t00.c	2005-03-08 17:18:24 -07:00
@@ -184,7 +184,6 @@
 
 	memset(client, 0, sizeof(struct i2c_client));
 	strncpy(client->name, M41T00_DRV_NAME, I2C_NAME_SIZE);
-	client->id = m41t00_driver.id;
 	client->flags = I2C_DF_NOTIFY;
 	client->addr = addr;
 	client->adapter = adap;
