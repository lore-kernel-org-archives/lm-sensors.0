From: gregkh@suse.de (gregkh@suse.de)
Date: Thu, 28 Jul 2005 08:28:04 +0000
Subject: [lm-sensors] patch i2c-missing-newlines.patch added to gregkh-2.6
Message-Id: <1Dy1rZ-48I-00@press.kroah.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: I2C: missing new lines in i2c-core messages

to my gregkh-2.6 tree.  Its filename is

     i2c-missing-newlines.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/

Patches currently in gregkh-2.6 which might be from khali@linux-fr.org are

i2c/i2c-max6875-documentation-update.patch
i2c/i2c-max6875-simplify.patch
i2c/i2c-hwmon-class-01.patch
i2c/i2c-hwmon-class-02.patch
i2c/i2c-hwmon-class-03.patch
i2c/i2c-missing-space.patch
i2c/i2c-nforce2-cleanup.patch
i2c/i2c-hwmon-split-01.patch
i2c/i2c-hwmon-split-02.patch
i2c/i2c-hwmon-split-03.patch
i2c/i2c-hwmon-split-04.patch
i2c/i2c-hwmon-split-05.patch
i2c/i2c-hwmon-split-06.patch
i2c/i2c-hwmon-split-07.patch
i2c/i2c-hwmon-split-08.patch
i2c/i2c-hwmon-split-09.patch
i2c/i2c-max6875-cleanup.patch
i2c/i2c-max6875-documentation-cleanup.patch
i2c/i2c-max6875-kobj_to_i2c_client.patch
i2c/i2c-24rf08-corruption-prevention.patch
i2c/i2c-missing-newlines.patch
i2c/i2c-refactor-message.patch
i2c/i2c-use-time_after.patch


From khali@linux-fr.org Wed Jul 27 12:50:16 2005
Date: Wed, 27 Jul 2005 21:40:13 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: LM Sensors <lm-sensors@lm-sensors.org>
Subject: I2C: missing new lines in i2c-core messages
Message-Id: <20050727214013.1293db87.khali@linux-fr.org>

Two log messages lack their trailing new line in i2c-core. I'd swear I had
fixed them already, but it seems not. Bonus: improved coding style.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/i2c/i2c-core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- gregkh-2.6.orig/drivers/i2c/i2c-core.c	2005-07-27 23:22:49.000000000 -0700
+++ gregkh-2.6/drivers/i2c/i2c-core.c	2005-07-27 23:23:49.000000000 -0700
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
@@ -456,8 +456,8 @@
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
