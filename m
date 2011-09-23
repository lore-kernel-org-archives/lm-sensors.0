From: "Jan Beulich" <JBeulich@suse.com>
Date: Fri, 23 Sep 2011 10:35:00 +0000
Subject: [lm-sensors] [PATCH] coretemp: don't use kernel assigned CPU number
Message-Id: <4E7C7CF40200007800057865@nat28.tlf.novell.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

... as that has the potential to conflict with (particularly soft) CPU
hot removal and re-adding.

Signed-off-by: Jan Beulich <jbeulich@suse.com>

---
 drivers/hwmon/coretemp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 3.1-rc7-coretemp.orig/drivers/hwmon/coretemp.c
+++ 3.1-rc7-coretemp/drivers/hwmon/coretemp.c
@@ -724,7 +724,7 @@ static int __cpuinit coretemp_device_add
 
 	mutex_lock(&pdev_list_mutex);
 
-	pdev = platform_device_alloc(DRVNAME, cpu);
+	pdev = platform_device_alloc(DRVNAME, TO_PHYS_ID(cpu));
 	if (!pdev) {
 		err = -ENOMEM;
 		pr_err("Device allocation failed\n");




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
