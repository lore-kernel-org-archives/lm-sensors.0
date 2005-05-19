From: gregkh@suse.de (Greg KH)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: [PATCH] I2C: Fix breakage in m41t00 i2c rtc driver
Message-Id: <11123113924150@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11123113922923@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: mgreer@mvista.com

ChangeSet 1.2334, 2005/03/31 14:09:00-08:00, mgreer@mvista.com

[PATCH] I2C: Fix breakage in m41t00 i2c rtc driver

Remove setting of deleted i2c_client structure member.

The latest include/linux/i2c.h:i2c_client structure no longer has an
'id' member.  This patch removes the setting of that no longer existing
member.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/m41t00.c |    1 -
 1 files changed, 1 deletion(-)


diff -Nru a/drivers/i2c/chips/m41t00.c b/drivers/i2c/chips/m41t00.c
--- a/drivers/i2c/chips/m41t00.c	2005-03-31 15:17:53 -08:00
+++ b/drivers/i2c/chips/m41t00.c	2005-03-31 15:17:53 -08:00
@@ -184,7 +184,6 @@
 
 	memset(client, 0, sizeof(struct i2c_client));
 	strncpy(client->name, M41T00_DRV_NAME, I2C_NAME_SIZE);
-	client->id = m41t00_driver.id;
 	client->flags = I2C_DF_NOTIFY;
 	client->addr = addr;
 	client->adapter = adap;

