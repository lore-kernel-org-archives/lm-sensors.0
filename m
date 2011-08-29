From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 29 Aug 2011 13:14:45 +0000
Subject: [lm-sensors] [PATCH] hwmon: (smsc47b397) Fix checkpatch errors
Message-Id: <20110829151445.4ac12918@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Guenter, this doesn't fix the warning you reported earlier, but
probably good to apply nevertheless.

 drivers/hwmon/smsc47b397.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- linux-3.1-rc3.orig/drivers/hwmon/smsc47b397.c	2011-08-29 14:44:07.000000000 +0200
+++ linux-3.1-rc3/drivers/hwmon/smsc47b397.c	2011-08-29 14:54:22.000000000 +0200
@@ -113,7 +113,7 @@ struct smsc47b397_data {
 	u8 temp[4];
 };
 
-static int smsc47b397_read_value(struct smsc47b397_data* data, u8 reg)
+static int smsc47b397_read_value(struct smsc47b397_data *data, u8 reg)
 {
 	int res;
 
@@ -265,7 +265,8 @@ static int __devinit smsc47b397_probe(st
 		return -EBUSY;
 	}
 
-	if (!(data = kzalloc(sizeof(struct smsc47b397_data), GFP_KERNEL))) {
+	data = kzalloc(sizeof(struct smsc47b397_data), GFP_KERNEL);
+	if (!data) {
 		err = -ENOMEM;
 		goto error_release;
 	}
@@ -276,7 +277,8 @@ static int __devinit smsc47b397_probe(st
 	mutex_init(&data->update_lock);
 	platform_set_drvdata(pdev, data);
 
-	if ((err = sysfs_create_group(&dev->kobj, &smsc47b397_group)))
+	err = sysfs_create_group(&dev->kobj, &smsc47b397_group);
+	if (err)
 		goto error_free;
 
 	data->hwmon_dev = hwmon_device_register(dev);
@@ -345,7 +347,7 @@ static int __init smsc47b397_find(unsign
 	superio_enter();
 	id = force_id ? force_id : superio_inb(SUPERIO_REG_DEVID);
 
-	switch(id) {
+	switch (id) {
 	case 0x81:
 		name = "SCH5307-NS";
 		break;
@@ -379,7 +381,8 @@ static int __init smsc47b397_init(void)
 	unsigned short address;
 	int ret;
 
-	if ((ret = smsc47b397_find(&address)))
+	ret = smsc47b397_find(&address);
+	if (ret)
 		return ret;
 
 	ret = platform_driver_register(&smsc47b397_driver);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
