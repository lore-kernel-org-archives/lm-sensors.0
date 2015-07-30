From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Thu, 30 Jul 2015 16:18:43 +0000
Subject: [lm-sensors] [PATCH 18/27] hwmon: (g762) Export OF module alias information
Message-Id: <1438273132-20926-19-git-send-email-javier@osg.samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org

The I2C core always reports the MODALIAS uevent as "i2c:<client name"
regardless if the driver was matched using the I2C id_table or the
of_match_table. So technically there's no need for a driver to export
the OF table since currently it's not used.

In fact, the I2C device ID table is mandatory for I2C drivers since
a i2c_device_id is passed to the driver's probe function even if the
I2C core used the OF table to match the driver.

And since the I2C core uses different tables, OF-only drivers needs to
have duplicated data that has to be kept in sync and also the dev node
compatible manufacturer prefix is stripped when reporting the MODALIAS.

To avoid the above, the I2C core behavior may be changed in the future
to not require an I2C device table for OF-only drivers and report the
OF module alias. So, it's better to also export the OF table to prevent
breaking module autoloading if that happens.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/hwmon/g762.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
index 3d845947f584..b96a2a9e4df7 100644
--- a/drivers/hwmon/g762.c
+++ b/drivers/hwmon/g762.c
@@ -582,6 +582,7 @@ static const struct of_device_id g762_dt_match[] = {
 	{ .compatible = "gmt,g763" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, g762_dt_match);
 
 /*
  * Grab clock (a required property), enable it, get (fixed) clock frequency
-- 
2.4.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
