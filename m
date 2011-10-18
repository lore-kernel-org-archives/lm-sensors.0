From: Linus Walleij <linus.walleij@stericsson.com>
Date: Tue, 18 Oct 2011 09:10:35 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: add notifiers to hwmon
Message-Id: <1318929035-15847-1-git-send-email-linus.walleij@stericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Daniel Willerud <daniel.willerud@stericsson.com>

We already have support for sysfs notifications when temperatures
measured by the ABx500 sensors exceed certain thresholds.
However we have in-kernel code that need to be notified when
such changes occur as well. So this patch adds a simple
notification mechanism to broadcast HWMON events in the kernel.

Reviewed-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Signed-off-by: Daniel Willerud <daniel.willerud@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/hwmon/hwmon.c |   21 ++++++++++++++++++++-
 include/linux/hwmon.h |    5 +++++
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index a61e781..b3c62f8 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -21,6 +21,7 @@
 #include <linux/gfp.h>
 #include <linux/spinlock.h>
 #include <linux/pci.h>
+#include <linux/notifier.h>
 
 #define HWMON_ID_PREFIX "hwmon"
 #define HWMON_ID_FORMAT HWMON_ID_PREFIX "%d"
@@ -29,7 +30,7 @@ static struct class *hwmon_class;
 
 static DEFINE_IDR(hwmon_idr);
 static DEFINE_SPINLOCK(idr_lock);
-
+static BLOCKING_NOTIFIER_HEAD(hwmon_notifier_list);
 /**
  * hwmon_device_register - register w/ hwmon
  * @dev: the device to register
@@ -89,6 +90,24 @@ void hwmon_device_unregister(struct device *dev)
 			"hwmon_device_unregister() failed: bad class ID!\n");
 }
 
+int hwmon_notifier_register(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&hwmon_notifier_list, nb);
+}
+EXPORT_SYMBOL(hwmon_notifier_register);
+
+int hwmon_notifier_unregister(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&hwmon_notifier_list, nb);
+}
+EXPORT_SYMBOL(hwmon_notifier_unregister);
+
+void hwmon_notify(unsigned long val, void *v)
+{
+	blocking_notifier_call_chain(&hwmon_notifier_list, val, v);
+}
+EXPORT_SYMBOL(hwmon_notify);
+
 static void __init hwmon_pci_quirks(void)
 {
 #if defined CONFIG_X86 && defined CONFIG_PCI
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 6b6ee70..8e891b5 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -15,11 +15,16 @@
 #define _HWMON_H_
 
 #include <linux/device.h>
+#include <linux/notifier.h>
 
 struct device *hwmon_device_register(struct device *dev);
 
 void hwmon_device_unregister(struct device *dev);
 
+int hwmon_notifier_register(struct notifier_block *nb);
+int hwmon_notifier_unregister(struct notifier_block *nb);
+void hwmon_notify(unsigned long val, void *v);
+
 /* Scale user input to sensible values */
 static inline int SENSORS_LIMIT(long value, long low, long high)
 {
-- 
1.7.3.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
