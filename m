From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Sat, 19 Oct 2013 08:55:15 +0000
Subject: [lm-sensors] [patch] hwmon: (nct6775) Remove an unused variable
Message-Id: <20131019085515.GC9312@longonot.mountain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

We don't actually use "j" for anything.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 7a1b6a7..d17325d 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -939,7 +939,7 @@ nct6775_create_attr_group(struct device *dev, struct sensor_template_group *tg,
 	struct sensor_device_attribute_2 *a2;
 	struct attribute **attrs;
 	struct sensor_device_template **t;
-	int i, j, count;
+	int i, count;
 
 	if (repeat <= 0)
 		return ERR_PTR(-EINVAL);
@@ -970,7 +970,7 @@ nct6775_create_attr_group(struct device *dev, struct sensor_template_group *tg,
 
 	for (i = 0; i < repeat; i++) {
 		t = tg->templates;
-		for (j = 0; *t != NULL; j++) {
+		while (*t != NULL) {
 			snprintf(su->name, sizeof(su->name),
 				 (*t)->dev_attr.attr.name, tg->base + i);
 			if ((*t)->s2) {

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
