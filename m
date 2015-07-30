From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Thu, 30 Jul 2015 16:18:39 +0000
Subject: [lm-sensors] [PATCH 14/27] hwmon: (nct7904) Export I2C module alias information
Message-Id: <1438273132-20926-15-git-send-email-javier@osg.samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Jean Delvare <jdelvare@suse.com>, lm-sensors@lm-sensors.org

The I2C core always reports the MODALIAS uevent as "i2c:<client name"
regardless if the driver was matched using the I2C id_table or the
of_match_table. So the driver needs to export the I2C table and this
be built into the module or udev won't have the necessary information
to auto load the correct module when the device is added.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/hwmon/nct7904.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 6153df735e82..08ff89d222e5 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -575,6 +575,7 @@ static const struct i2c_device_id nct7904_id[] = {
 	{"nct7904", 0},
 	{}
 };
+MODULE_DEVICE_TABLE(i2c, nct7904_id);
 
 static struct i2c_driver nct7904_driver = {
 	.class = I2C_CLASS_HWMON,
-- 
2.4.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
