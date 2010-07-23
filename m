From: Chen Gong <gong.chen@linux.intel.com>
Date: Fri, 23 Jul 2010 02:09:26 +0000
Subject: [lm-sensors] [PATCH V3 1/3] hwmon: (coretemp) update hotplug
Message-Id: <1279850968-12154-2-git-send-email-gong.chen@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

this patch fixes an unnecessary driver unregister.
Because even none of online cpus supports coretemp, we can't
assume new onlined cpu doesn't support it either. If related
driver is unregistered there we have no chance to use coretemp
from then on.

Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
---
 drivers/hwmon/coretemp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 05344af..a3bad59 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -566,7 +566,9 @@ exit_devices_unreg:
 	}
 	mutex_unlock(&pdev_list_mutex);
 exit_driver_unreg:
+#ifndef CONFIG_HOTPLUG_CPU
 	platform_driver_unregister(&coretemp_driver);
+#endif
 exit:
 	return err;
 }
-- 
1.7.2.rc3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
