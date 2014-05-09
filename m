From: LABBE Corentin <clabbe.montjoie@gmail.com>
Date: Fri, 09 May 2014 12:04:01 +0000
Subject: [lm-sensors] [PATCH] hwmon: change my email
Message-Id: <1399637041-5046-1-git-send-email-clabbe.montjoie@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1399557932-24346-1-git-send-email-clabbe.montjoie@gmail.com>
In-Reply-To: <1399557932-24346-1-git-send-email-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/hwmon/adm1029.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
index d19c790..78339e8 100644
--- a/drivers/hwmon/adm1029.c
+++ b/drivers/hwmon/adm1029.c
@@ -1,7 +1,7 @@
 /*
  * adm1029.c - Part of lm_sensors, Linux kernel modules for hardware monitoring
  *
- * Copyright (C) 2006 Corentin LABBE <corentin.labbe@geomatys.fr>
+ * Copyright (C) 2006 Corentin LABBE <clabbe.montjoie@gmail.com>
  *
  * Based on LM83 Driver by Jean Delvare <jdelvare@suse.de>
  *
@@ -449,6 +449,6 @@ static struct adm1029_data *adm1029_update_device(struct device *dev)
 
 module_i2c_driver(adm1029_driver);
 
-MODULE_AUTHOR("Corentin LABBE <corentin.labbe@geomatys.fr>");
+MODULE_AUTHOR("Corentin LABBE <clabbe.montjoie@gmail.com>");
 MODULE_DESCRIPTION("adm1029 driver");
 MODULE_LICENSE("GPL v2");
-- 
1.8.5.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
