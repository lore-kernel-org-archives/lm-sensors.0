From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 Feb 2008 10:17:26 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83l785ts) Don't ask the user to
Message-Id: <20080212111726.23db114f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

There's nothing we can do about read errors on the W83L785TS-S, so
don't ask the user to report them.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/w83l785ts |    3 ++-
 drivers/hwmon/w83l785ts.c     |    4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

--- linux-2.6.25-rc1.orig/Documentation/hwmon/w83l785ts	2008-02-12 11:11:05.000000000 +0100
+++ linux-2.6.25-rc1/Documentation/hwmon/w83l785ts	2008-02-12 11:11:10.000000000 +0100
@@ -33,7 +33,8 @@ Known Issues
 ------------
 
 On some systems (Asus), the BIOS is known to interfere with the driver
-and cause read errors. The driver will retry a given number of times
+and cause read errors. Or maybe the W83L785TS-S chip is simply unreliable,
+we don't really know. The driver will retry a given number of times
 (5 by default) and then give up, returning the old value (or 0 if
 there is no old value). It seems to work well enough so that you should
 not notice anything. Thanks to James Bolt for helping test this feature.
--- linux-2.6.25-rc1.orig/drivers/hwmon/w83l785ts.c	2008-02-11 09:48:54.000000000 +0100
+++ linux-2.6.25-rc1/drivers/hwmon/w83l785ts.c	2008-02-12 11:11:33.000000000 +0100
@@ -301,8 +301,8 @@ static u8 w83l785ts_read_value(struct i2
 		msleep(i);
 	}
 
-	dev_err(&client->dev, "Couldn't read value from register 0x%02x. "
-		"Please report.\n", reg);
+	dev_err(&client->dev, "Couldn't read value from register 0x%02x.\n",
+		reg);
 	return defval;
 }
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
