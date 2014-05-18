From: Himangi Saraogi <himangi774@gmail.com>
Date: Sun, 18 May 2014 06:44:56 +0000
Subject: [lm-sensors] [PATCH] hwmon: Introduce the use of the managed version of kzalloc
Message-Id: <20140518063256.GA7599@himangi-Dell>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr

This patch moves data allocated using kzalloc to managed data allocated
using devm_kzalloc and cleans now unnecessary kfrees in probe and remove
functions. Also, the unnecessary label out_free is removed.

The following Coccinelle semantic patch was used for making the change:

@platform@
identifier p, probefn, removefn;
@@
struct platform_driver p = {
  .probe = probefn,
  .remove = removefn,
};

@prb@
identifier platform.probefn, pdev;
expression e, e1, e2;
@@
probefn(struct platform_device *pdev, ...) {
  <+...
- e = kzalloc(e1, e2)
+ e = devm_kzalloc(&pdev->dev, e1, e2)
  ...
?-kfree(e);
  ...+>
}

@rem depends on prb@
identifier platform.removefn;
expression e;
@@
removefn(...) {
  <...
- kfree(e);
  ...>
}

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
---
Not compile tested.

To send to: Jean Delvare <jdelvare@suse.de>,Guenter Roeck <linux@roeck-us.net>,
lm-sensors@lm-sensors.org,linux-kernel@vger.kernel.org

 drivers/hwmon/ultra45_env.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/ultra45_env.c b/drivers/hwmon/ultra45_env.c
index fb3e693..92564b8 100644
--- a/drivers/hwmon/ultra45_env.c
+++ b/drivers/hwmon/ultra45_env.c
@@ -252,7 +252,7 @@ static const struct attribute_group env_group = {
 
 static int env_probe(struct platform_device *op)
 {
-	struct env *p = kzalloc(sizeof(*p), GFP_KERNEL);
+	struct env *p = devm_kzalloc(&op->dev, sizeof(*p), GFP_KERNEL);
 	int err = -ENOMEM;
 
 	if (!p)
@@ -262,7 +262,7 @@ static int env_probe(struct platform_device *op)
 
 	p->regs = of_ioremap(&op->resource[0], 0, REG_SIZE, "pic16f747");
 	if (!p->regs)
-		goto out_free;
+		goto out;
 
 	err = sysfs_create_group(&op->dev.kobj, &env_group);
 	if (err)
@@ -285,9 +285,7 @@ out_sysfs_remove_group:
 
 out_iounmap:
 	of_iounmap(&op->resource[0], p->regs, REG_SIZE);
-
-out_free:
-	kfree(p);
+	
 	goto out;
 }
 
@@ -299,7 +297,6 @@ static int env_remove(struct platform_device *op)
 		sysfs_remove_group(&op->dev.kobj, &env_group);
 		hwmon_device_unregister(p->hwmon_dev);
 		of_iounmap(&op->resource[0], p->regs, REG_SIZE);
-		kfree(p);
 	}
 
 	return 0;
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
