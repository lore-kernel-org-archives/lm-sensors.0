From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 27 Jun 2010 11:36:01 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (coretemp) Properly label the
Message-Id: <20100627133601.3644b03a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Don't assume that CPU entry number and core ID always match. It
worked in the simple cases (single CPU, no HT) but fails on
multi-CPU systems.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Huaxu Wan <huaxu.wan@intel.com>
---
 drivers/hwmon/coretemp.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.35-rc3.orig/drivers/hwmon/coretemp.c	2010-06-27 10:14:51.000000000 +0200
+++ linux-2.6.35-rc3/drivers/hwmon/coretemp.c	2010-06-27 10:19:19.000000000 +0200
@@ -53,6 +53,7 @@ struct coretemp_data {
 	struct mutex update_lock;
 	const char *name;
 	u32 id;
+	u16 core_id;
 	char valid;		/* zero until following fields are valid */
 	unsigned long last_updated;	/* in jiffies */
 	int temp;
@@ -75,7 +76,7 @@ static ssize_t show_name(struct device *
 	if (attr->index = SHOW_NAME)
 		ret = sprintf(buf, "%s\n", data->name);
 	else	/* show label */
-		ret = sprintf(buf, "Core %d\n", data->id);
+		ret = sprintf(buf, "Core %d\n", data->core_id);
 	return ret;
 }
 
@@ -304,6 +305,7 @@ static int __devinit coretemp_probe(stru
 	}
 
 	data->id = pdev->id;
+	data->core_id = c->cpu_core_id;
 	data->name = "coretemp";
 	mutex_init(&data->update_lock);
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
