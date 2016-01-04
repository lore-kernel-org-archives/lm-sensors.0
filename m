From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Mon, 04 Jan 2016 16:36:01 +0000
Subject: [lm-sensors] [PATCH] hwmon: ibmaem: constify aem_rw_sensor_template and aem_ro_sensor_template struc
Message-Id: <1451925361-21182-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.com>
Cc: kernel-janitors@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

The aem_rw_sensor_template and aem_ro_sensor_template structures are never
modified, so declare them as const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/hwmon/ibmaem.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/ibmaem.c b/drivers/hwmon/ibmaem.c
index 7a8a6fb..1f64378 100644
--- a/drivers/hwmon/ibmaem.c
+++ b/drivers/hwmon/ibmaem.c
@@ -920,8 +920,8 @@ static ssize_t aem_set_power_period(struct device *dev,
 
 /* Discover sensors on an AEM device */
 static int aem_register_sensors(struct aem_data *data,
-				struct aem_ro_sensor_template *ro,
-				struct aem_rw_sensor_template *rw)
+				const struct aem_ro_sensor_template *ro,
+				const struct aem_rw_sensor_template *rw)
 {
 	struct device *dev = &data->pdev->dev;
 	struct sensor_device_attribute *sensors = data->sensors;
@@ -1020,19 +1020,19 @@ static void aem_remove_sensors(struct aem_data *data)
 /* Sensor probe functions */
 
 /* Description of AEM1 sensors */
-static struct aem_ro_sensor_template aem1_ro_sensors[] = {
+static const struct aem_ro_sensor_template aem1_ro_sensors[] = {
 {"energy1_input",  aem_show_energy, 0},
 {"power1_average", aem_show_power,  0},
 {NULL,		   NULL,	    0},
 };
 
-static struct aem_rw_sensor_template aem1_rw_sensors[] = {
+static const struct aem_rw_sensor_template aem1_rw_sensors[] = {
 {"power1_average_interval", aem_show_power_period, aem_set_power_period, 0},
 {NULL,			    NULL,                  NULL,                 0},
 };
 
 /* Description of AEM2 sensors */
-static struct aem_ro_sensor_template aem2_ro_sensors[] = {
+static const struct aem_ro_sensor_template aem2_ro_sensors[] = {
 {"energy1_input",	  aem_show_energy,	0},
 {"energy2_input",	  aem_show_energy,	1},
 {"power1_average",	  aem_show_power,	0},
@@ -1050,7 +1050,7 @@ static struct aem_ro_sensor_template aem2_ro_sensors[] = {
 {NULL,                    NULL,                 0},
 };
 
-static struct aem_rw_sensor_template aem2_rw_sensors[] = {
+static const struct aem_rw_sensor_template aem2_rw_sensors[] = {
 {"power1_average_interval", aem_show_power_period, aem_set_power_period, 0},
 {"power2_average_interval", aem_show_power_period, aem_set_power_period, 1},
 {NULL,			    NULL,                  NULL,                 0},


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
