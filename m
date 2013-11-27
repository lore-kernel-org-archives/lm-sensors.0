From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 27 Nov 2013 18:04:46 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (lm90) Unregister hwmon device if interrupt setup fails
Message-Id: <1385575486-8732-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Commit 109b1283fb (hwmon: (lm90) Add support to handle IRQ) introduced
interrupt support. Its error handling code fails to unregister the already
registered hwmon device.

Fixes: 109b1283fb532ac773a076748ffccf76a7067cab
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 4c4c142..8b8f3aa 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1610,12 +1610,14 @@ static int lm90_probe(struct i2c_client *client,
 						"lm90", client);
 		if (err < 0) {
 			dev_err(dev, "cannot request IRQ %d\n", client->irq);
-			goto exit_remove_files;
+			goto exit_unregister;
 		}
 	}
 
 	return 0;
 
+exit_unregister:
+	hwmon_device_unregister(data->hwmon_dev);
 exit_remove_files:
 	lm90_remove_files(client, data);
 exit_restore:
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
