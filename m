From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: [PATCH 2.6] I2C: More verbose w83l785ts driver
Message-Id: <20041120120543.77bf9e64.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This simple patch increases the verbosity of the w83l785ts hardware
monitoring driver. I wrote it months ago in the hope it would help solve
a reported problem [1]. Not sure whether it did (no news from user since
July), but the extra debug info may help in the future and doesn't hurt
otherwise, so let's have this in for every user (not that many AFAIK),
just in case.

This is obviously non-critical and can be delayed until after 2.6.10 is
released ;)

Please apply,
thanks.

[1] http://bugzilla.kernel.org/show_bug.cgi?id(99

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.10-rc2/drivers/i2c/chips/w83l785ts.c.orig
+++ linux-2.6.10-rc2/drivers/i2c/chips/w83l785ts.c
@@ -280,14 +280,17 @@
 	 * default value requested by the caller. */
 	for (i = 1; i <= MAX_RETRIES; i++) {
 		value = i2c_smbus_read_byte_data(client, reg);
-		if (value >= 0)
+		if (value >= 0) {
+			dev_dbg(&client->dev, "Read 0x%02x from register "
+				"0x%02x.\n", value, reg);
 			return value;
+		}
 		dev_dbg(&client->dev, "Read failed, will retry in %d.\n", i);
 		msleep(i);
 	}
 
-	dev_err(&client->dev, "Couldn't read value from register. "
-		"Please report.\n");
+	dev_err(&client->dev, "Couldn't read value from register 0x%02x. "
+		"Please report.\n", reg);
 	return defval;
 }
 

-- 
Jean Delvare
http://khali.linux-fr.org/
