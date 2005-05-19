From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: [PATCH 2.6] I2C: via686a cleanups
Message-Id: <20050402204447.3d2b7644.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here comes a small cleanup patch for the via686a driver. I noticed the
following two non-fatal problems:

1* The device parent is explicitely set, but it's not needed because the
i2c core will do as the client is registered.

2* snprintf is used where strlcpy would suffice.

Fixing them brings the via686a driver in line with what other similar
drivers do.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.12-rc1-bk5/drivers/i2c/chips/via686a.c.orig	2005-04-02 11:04:19.000000000 +0200
+++ linux-2.6.12-rc1-bk5/drivers/i2c/chips/via686a.c	2005-04-02 11:37:32.000000000 +0200
@@ -651,10 +651,9 @@
 	new_client->adapter = adapter;
 	new_client->driver = &via686a_driver;
 	new_client->flags = 0;
-	new_client->dev.parent = &adapter->dev;
 
 	/* Fill in the remaining client fields and put into the global list */
-	snprintf(new_client->name, I2C_NAME_SIZE, client_name);
+	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
 
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);


-- 
Jean Delvare
