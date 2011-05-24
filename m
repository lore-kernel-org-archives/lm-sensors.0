From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 May 2011 19:48:47 +0000
Subject: [lm-sensors] [PATCH 4/5] hwmon: (ibmpex) Initialize sysfs attributes
Message-Id: <1306267814-31505-5-git-send-email-guenter.roeck@ericsson.com>
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

 drivers/hwmon/ibmpex.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/ibmpex.c b/drivers/hwmon/ibmpex.c
index 06d4eaf..41dbf81 100644
--- a/drivers/hwmon/ibmpex.c
+++ b/drivers/hwmon/ibmpex.c
@@ -358,6 +358,7 @@ static int create_sensor(struct ibmpex_bmc_data *data, int type,
 	else if (type = POWER_SENSOR)
 		sprintf(n, power_sensor_name_templates[func], "power", counter);
 
+	sysfs_attr_init(&data->sensors[sensor].attr[func].dev_attr.attr);
 	data->sensors[sensor].attr[func].dev_attr.attr.name = n;
 	data->sensors[sensor].attr[func].dev_attr.attr.mode = S_IRUGO;
 	data->sensors[sensor].attr[func].dev_attr.show = ibmpex_show_sensor;
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
