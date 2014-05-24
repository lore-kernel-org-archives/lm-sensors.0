From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 24 May 2014 15:21:23 +0000
Subject: [lm-sensors] [PATCH] hwmon: (nct6775) Fix probe unwind paths to properly unregister platform devices
Message-Id: <1400944883.17840.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Call platform_device_unregister() rather than platform_device_put() to
unregister successfully registered platform devices.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/nct6775.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 38d5a63..59d9a3f 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -4160,7 +4160,7 @@ static int __init sensors_nct6775_init(void)
 		pdev[i] = platform_device_alloc(DRVNAME, address);
 		if (!pdev[i]) {
 			err = -ENOMEM;
-			goto exit_device_put;
+			goto exit_device_unregister;
 		}
 
 		err = platform_device_add_data(pdev[i], &sio_data,
@@ -4198,9 +4198,11 @@ static int __init sensors_nct6775_init(void)
 	return 0;
 
 exit_device_put:
-	for (i = 0; i < ARRAY_SIZE(pdev); i++) {
+	platform_device_put(pdev[i]);
+exit_device_unregister:
+	while (--i >= 0) {
 		if (pdev[i])
-			platform_device_put(pdev[i]);
+			platform_device_unregister(pdev[i]);
 	}
 exit_unregister:
 	platform_driver_unregister(&nct6775_driver);
-- 
1.8.3.2




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
