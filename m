From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Mon, 13 May 2013 06:01:43 +0000
Subject: [lm-sensors] [PATCH] hwmon: fix error return code in abituguru_probe()
Message-Id: <CAPgLHd87mUGwSfX31YLLkL-+72AcrW6szwZiqbfqRZvfvFHBDA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hdegoede@redhat.com, khali@linux-fr.org, linux@roeck-us.net
Cc: yongjun_wei@trendmicro.com.cn, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/hwmon/abituguru.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
index df0b699..2ebd6ce 100644
--- a/drivers/hwmon/abituguru.c
+++ b/drivers/hwmon/abituguru.c
@@ -1414,14 +1414,18 @@ static int abituguru_probe(struct platform_device *pdev)
 	pr_info("found Abit uGuru\n");
 
 	/* Register sysfs hooks */
-	for (i = 0; i < sysfs_attr_i; i++)
-		if (device_create_file(&pdev->dev,
-				&data->sysfs_attr[i].dev_attr))
+	for (i = 0; i < sysfs_attr_i; i++) {
+		res = device_create_file(&pdev->dev,
+					 &data->sysfs_attr[i].dev_attr);
+		if (res)
 			goto abituguru_probe_error;
-	for (i = 0; i < ARRAY_SIZE(abituguru_sysfs_attr); i++)
-		if (device_create_file(&pdev->dev,
-				&abituguru_sysfs_attr[i].dev_attr))
+	}
+	for (i = 0; i < ARRAY_SIZE(abituguru_sysfs_attr); i++) {
+		res = device_create_file(&pdev->dev,
+					 &abituguru_sysfs_attr[i].dev_attr);
+		if (res)
 			goto abituguru_probe_error;
+	}
 
 	data->hwmon_dev = hwmon_device_register(&pdev->dev);
 	if (!IS_ERR(data->hwmon_dev))


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
