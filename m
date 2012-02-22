From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 22 Feb 2012 16:19:31 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ads1015) Fix file leak in probe function
Message-Id: <1329927571-31574-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

An error while creating sysfs attribute files in the driver's probe function
results in an error abort, but already created files are not removed. This patch
fixes the problem.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Dirk Eibach <eibach@gdsys.de>
---
 drivers/hwmon/ads1015.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/ads1015.c b/drivers/hwmon/ads1015.c
index eedca3c..1a1f058 100644
--- a/drivers/hwmon/ads1015.c
+++ b/drivers/hwmon/ads1015.c
@@ -271,7 +271,7 @@ static int ads1015_probe(struct i2c_client *client,
 			continue;
 		err = device_create_file(&client->dev, &ads1015_in[k].dev_attr);
 		if (err)
-			goto exit_free;
+			goto exit_remove;
 	}
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
