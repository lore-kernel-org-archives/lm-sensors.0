From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 27 Jul 2005 21:40:20 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: missing new lines in i2c-core messages
Message-Id: <20050727214013.1293db87.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, all,

Two log messages lack their trailing new line in i2c-core. I'd swear I had
fixed them already, but it seems not. Bonus: improved coding style.

Thanks Greg :)

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/i2c-core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.13-rc3.orig/drivers/i2c/i2c-core.c	2005-07-27 20:53:46.000000000 +0200
+++ linux-2.6.13-rc3/drivers/i2c/i2c-core.c	2005-07-27 21:08:28.000000000 +0200
@@ -231,8 +231,8 @@
 		if (driver->detach_adapter)
 			if ((res = driver->detach_adapter(adap))) {
 				dev_warn(&adap->dev, "can't detach adapter "
-					 "while detaching driver %s: driver not "
-					 "detached!", driver->name);
+					 "while detaching driver %s: driver "
+					 "not detached!\n", driver->name);
 				goto out_unlock;
 			}
 	}
@@ -460,8 +460,8 @@
 		res = adapter->client_unregister(client);
 		if (res) {
 			dev_err(&client->dev,
-			       "client_unregister [%s] failed, "
-			       "client not detached", client->name);
+				"client_unregister [%s] failed, "
+				"client not detached\n", client->name);
 			goto out;
 		}
 	}


-- 
Jean Delvare
