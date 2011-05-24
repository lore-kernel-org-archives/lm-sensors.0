From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 May 2011 19:48:23 +0000
Subject: [lm-sensors] [PATCH 1/5] hwmon: (pmbus) Initialize sysfs attributes
Message-Id: <1306267814-31505-2-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Initialize sysfs attrs before device_create_file() call to suppress
lockdep_init_map() warning:

WARNING: at kernel/lockdep.c:2701 lockdep_init_map+0x12d/0x140()

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/pmbus_core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/pmbus_core.c b/drivers/hwmon/pmbus_core.c
index 98799ba..354770e 100644
--- a/drivers/hwmon/pmbus_core.c
+++ b/drivers/hwmon/pmbus_core.c
@@ -707,6 +707,7 @@ do {									\
 	struct sensor_device_attribute *a				\
 	    = &data->_type##s[data->num_##_type##s].attribute;		\
 	BUG_ON(data->num_attributes >= data->max_attributes);		\
+	sysfs_attr_init(&a->dev_attr.attr);				\
 	a->dev_attr.attr.name = _name;					\
 	a->dev_attr.attr.mode = _mode;					\
 	a->dev_attr.show = _show;					\
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
