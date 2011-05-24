From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 May 2011 19:48:47 +0000
Subject: [lm-sensors] [PATCH 5/5] hwmon: (s3c) Initialize sysfs attributes
Message-Id: <1306267814-31505-6-git-send-email-guenter.roeck@ericsson.com>
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

 drivers/hwmon/s3c-hwmon.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/s3c-hwmon.c b/drivers/hwmon/s3c-hwmon.c
index 92b42db..731d1f3 100644
--- a/drivers/hwmon/s3c-hwmon.c
+++ b/drivers/hwmon/s3c-hwmon.c
@@ -232,6 +232,7 @@ static int s3c_hwmon_create_attr(struct device *dev,
 
 	attr = &attrs->in;
 	attr->index = channel;
+	sysfs_attr_init(&attr->dev_attr.attr);
 	attr->dev_attr.attr.name  = attrs->in_name;
 	attr->dev_attr.attr.mode  = S_IRUGO;
 	attr->dev_attr.show = s3c_hwmon_ch_show;
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
