From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 28 May 2015 16:15:56 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (nct6683) Add missing sysfs attibute initialization
Message-Id: <1432829756-14595-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The following error message is seen when loading the nct6683 driver
with DEBUG_LOCK_ALLOC enabled.

BUG: key ffff88040b2f0030 not in .data!
------------[ cut here ]------------
WARNING: CPU: 0 PID: 186 at kernel/locking/lockdep.c:2988
				lockdep_init_map+0x469/0x630()
DEBUG_LOCKS_WARN_ON(1)

Caused by a missing call to sysfs_attr_init() when initializing
sysfs attributes.

Reported-by: Alexey Orishko <alexey.orishko@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6683.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
index f3830db02d46..37f01702d081 100644
--- a/drivers/hwmon/nct6683.c
+++ b/drivers/hwmon/nct6683.c
@@ -439,6 +439,7 @@ nct6683_create_attr_group(struct device *dev, struct sensor_template_group *tg,
 				 (*t)->dev_attr.attr.name, tg->base + i);
 			if ((*t)->s2) {
 				a2 = &su->u.a2;
+				sysfs_attr_init(&a2->dev_attr.attr);
 				a2->dev_attr.attr.name = su->name;
 				a2->nr = (*t)->u.s.nr + i;
 				a2->index = (*t)->u.s.index;
@@ -449,6 +450,7 @@ nct6683_create_attr_group(struct device *dev, struct sensor_template_group *tg,
 				*attrs = &a2->dev_attr.attr;
 			} else {
 				a = &su->u.a1;
+				sysfs_attr_init(&a->dev_attr.attr);
 				a->dev_attr.attr.name = su->name;
 				a->index = (*t)->u.index + i;
 				a->dev_attr.attr.mode -- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
