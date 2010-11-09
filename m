From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Tue, 09 Nov 2010 15:15:10 +0000
Subject: [lm-sensors] [PATCH 10/11] hwmon: applesmc: Silence driver
Message-Id: <1289315711-3011-11-git-send-email-rydberg@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <1289315711-3011-1-git-send-email-rydberg@euromail.se>
In-Reply-To: <1289315711-3011-1-git-send-email-rydberg@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>, Jean Delvare <khali@linux-fr.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

Make the driver report a single line on success.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hwmon/applesmc.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index b907c20..576dcb4 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -1270,8 +1270,6 @@ static int __init applesmc_init(void)
 		goto out_light_ledclass;
 	}
 
-	pr_info("driver successfully loaded\n");
-
 	return 0;
 
 out_light_ledclass:
@@ -1312,8 +1310,6 @@ static void __exit applesmc_exit(void)
 	platform_device_unregister(pdev);
 	platform_driver_unregister(&applesmc_driver);
 	release_region(APPLESMC_DATA_PORT, APPLESMC_NR_PORTS);
-
-	pr_info("driver unloaded\n");
 }
 
 module_init(applesmc_init);
-- 
1.7.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
