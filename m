From: Axel Lin <axel.lin@gmail.com>
Date: Mon, 16 Aug 2010 01:31:17 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ads7871) Fix ads7871_probe error path
Message-Id: <1281922277.26991.3.camel@mola>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Paul Thomas <pthomas8589@gmail.com>, Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org

We need to call hwmon_device_unregister() if an error is detected after
sucessfully register hwmon device.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hwmon/ads7871.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/ads7871.c b/drivers/hwmon/ads7871.c
index b300a20..303db92 100644
--- a/drivers/hwmon/ads7871.c
+++ b/drivers/hwmon/ads7871.c
@@ -201,11 +201,13 @@ static int __devinit ads7871_probe(struct spi_device *spi)
 	we need to make sure we really have a chip*/
 	if (val != ret) {
 		err = -ENODEV;
-		goto error_remove;
+		goto error_unregister;
 	}
 
 	return 0;
 
+error_unregister:
+	hwmon_device_unregister(pdata->hwmon_dev);
 error_remove:
 	sysfs_remove_group(&spi->dev.kobj, &ads7871_group);
 error_free:
-- 
1.7.2




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
