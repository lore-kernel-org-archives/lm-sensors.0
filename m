From: Adrian Bunk <bunk@stusta.de>
Date: Thu, 05 Jul 2007 23:23:06 +0000
Subject: [lm-sensors] [2.6 patch] make coretemp_device_remove() static
Message-Id: <20070705232306.GY3492@stusta.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: r.marek@assembler.cz
Cc: lm-sensors@lm-sensors.org, mhoffman@lightlink.com, linux-kernel@vger.kernel.org

coretemp_device_remove() can become static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---
--- linux-2.6.22-rc6-mm1/drivers/hwmon/coretemp.c.old	2007-07-04 20:46:05.000000000 +0200
+++ linux-2.6.22-rc6-mm1/drivers/hwmon/coretemp.c	2007-07-04 20:46:20.000000000 +0200
@@ -318,7 +318,7 @@
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-void coretemp_device_remove(unsigned int cpu)
+static void coretemp_device_remove(unsigned int cpu)
 {
 	struct pdev_entry *p, *n;
 	mutex_lock(&pdev_list_mutex);


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
