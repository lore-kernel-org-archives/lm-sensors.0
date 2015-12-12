From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sat, 12 Dec 2015 16:36:39 +0000
Subject: [lm-sensors] [PATCH] hwmon: constify sensor_template_group structures
Message-Id: <1449938199-26314-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.com>
Cc: kernel-janitors@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

The sensor_template_group structures are never modified, so declare them as
const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/hwmon/nct6683.c |   11 ++++++-----
 drivers/hwmon/nct6775.c |   11 ++++++-----
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
index 37f0170..6cf392c 100644
--- a/drivers/hwmon/nct6683.c
+++ b/drivers/hwmon/nct6683.c
@@ -394,7 +394,8 @@ struct sensor_template_group {
 };
 
 static struct attribute_group *
-nct6683_create_attr_group(struct device *dev, struct sensor_template_group *tg,
+nct6683_create_attr_group(struct device *dev,
+			  const struct sensor_template_group *tg,
 			  int repeat)
 {
 	struct sensor_device_attribute_2 *a2;
@@ -703,7 +704,7 @@ static struct sensor_device_template *nct6683_attributes_in_template[] = {
 	NULL
 };
 
-static struct sensor_template_group nct6683_in_template_group = {
+static const struct sensor_template_group nct6683_in_template_group = {
 	.templates = nct6683_attributes_in_template,
 	.is_visible = nct6683_in_is_visible,
 };
@@ -774,7 +775,7 @@ static struct sensor_device_template *nct6683_attributes_fan_template[] = {
 	NULL
 };
 
-static struct sensor_template_group nct6683_fan_template_group = {
+static const struct sensor_template_group nct6683_fan_template_group = {
 	.templates = nct6683_attributes_fan_template,
 	.is_visible = nct6683_fan_is_visible,
 	.base = 1,
@@ -902,7 +903,7 @@ static struct sensor_device_template *nct6683_attributes_temp_template[] = {
 	NULL
 };
 
-static struct sensor_template_group nct6683_temp_template_group = {
+static const struct sensor_template_group nct6683_temp_template_group = {
 	.templates = nct6683_attributes_temp_template,
 	.is_visible = nct6683_temp_is_visible,
 	.base = 1,
@@ -938,7 +939,7 @@ static struct sensor_device_template *nct6683_attributes_pwm_template[] = {
 	NULL
 };
 
-static struct sensor_template_group nct6683_pwm_template_group = {
+static const struct sensor_template_group nct6683_pwm_template_group = {
 	.templates = nct6683_attributes_pwm_template,
 	.is_visible = nct6683_pwm_is_visible,
 	.base = 1,
diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index d7ebdf8..d087a8e 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -1045,7 +1045,8 @@ struct sensor_template_group {
 };
 
 static struct attribute_group *
-nct6775_create_attr_group(struct device *dev, struct sensor_template_group *tg,
+nct6775_create_attr_group(struct device *dev,
+			  const struct sensor_template_group *tg,
 			  int repeat)
 {
 	struct attribute_group *group;
@@ -1827,7 +1828,7 @@ static struct sensor_device_template *nct6775_attributes_in_template[] = {
 	NULL
 };
 
-static struct sensor_template_group nct6775_in_template_group = {
+static const struct sensor_template_group nct6775_in_template_group = {
 	.templates = nct6775_attributes_in_template,
 	.is_visible = nct6775_in_is_visible,
 };
@@ -2046,7 +2047,7 @@ static struct sensor_device_template *nct6775_attributes_fan_template[] = {
 	NULL
 };
 
-static struct sensor_template_group nct6775_fan_template_group = {
+static const struct sensor_template_group nct6775_fan_template_group = {
 	.templates = nct6775_attributes_fan_template,
 	.is_visible = nct6775_fan_is_visible,
 	.base = 1,
@@ -2255,7 +2256,7 @@ static struct sensor_device_template *nct6775_attributes_temp_template[] = {
 	NULL
 };
 
-static struct sensor_template_group nct6775_temp_template_group = {
+static const struct sensor_template_group nct6775_temp_template_group = {
 	.templates = nct6775_attributes_temp_template,
 	.is_visible = nct6775_temp_is_visible,
 	.base = 1,
@@ -3117,7 +3118,7 @@ static struct sensor_device_template *nct6775_attributes_pwm_template[] = {
 	NULL
 };
 
-static struct sensor_template_group nct6775_pwm_template_group = {
+static const struct sensor_template_group nct6775_pwm_template_group = {
 	.templates = nct6775_attributes_pwm_template,
 	.is_visible = nct6775_pwm_is_visible,
 	.base = 1,


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
