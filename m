From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 May 2011 19:48:29 +0000
Subject: [lm-sensors] [PATCH 2/5] hwmon: (asus_atk0110) Initialize sysfs
Message-Id: <1306267814-31505-3-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Initialize dynamically allocated sysfs attributes before device_create_file()
call to suppress lockdep_init_map() warning if lockdep debugging is enabled.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
Compile tested only.

 drivers/hwmon/asus_atk0110.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index b5e8920..2f46a29 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -268,6 +268,7 @@ static struct device_attribute atk_name_attr  static void atk_init_attribute(struct device_attribute *attr, char *name,
 		sysfs_show_func show)
 {
+	sysfs_attr_init(&attr->attr);
 	attr->attr.name = name;
 	attr->attr.mode = 0444;
 	attr->show = show;
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
