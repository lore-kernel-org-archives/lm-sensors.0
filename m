From: Yong Wang <yong.y.wang@linux.intel.com>
Date: Tue, 14 Sep 2010 02:33:51 +0000
Subject: [lm-sensors] [PATCH] hwmon/emc1403: remove unnecessary
Message-Id: <20100914023351.GA27145@ywang-moblin2.bj.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Alan Cox <alan@linux.intel.com>, Kalhan Trisal <kalhan.trisal@intel.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

It is unnecessary to call hwmon_device_unregister in error handling
before hwmon_device_register is called.

Signed-off-by: Yong Wang <yong.y.wang@intel.com>
---
 drivers/hwmon/emc1403.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index 5b58b20..8dee3f3 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -308,7 +308,6 @@ static int emc1403_probe(struct i2c_client *client,
 	res = sysfs_create_group(&client->dev.kobj, &m_thermal_gr);
 	if (res) {
 		dev_warn(&client->dev, "create group failed\n");
-		hwmon_device_unregister(data->hwmon_dev);
 		goto thermal_error1;
 	}
 	data->hwmon_dev = hwmon_device_register(&client->dev);
-- 
1.5.5.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
