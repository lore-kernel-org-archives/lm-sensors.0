From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 12 Aug 2007 18:47:32 +0000
Subject: [lm-sensors] [PATCH] hwmon: (smsc47m1) restore missing name
Message-Id: <11869444523998-git-send-email-mhoffman@lightlink.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>

The smsc47m1 driver no longer creates the name attribute used by
libsensors to identify chip types. It was lost during the conversion
to a platform driver. I was fooled by the fact that we do have a
group with all attributes, but only to delete them all at once. The
group is not used to create the attributes, so we have to explicitly
create the name attribute.

This fixes lm-sensors ticket #2236:
http://lm-sensors.org/ticket/2236

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
---
 drivers/hwmon/smsc47m1.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index 338ee4f..d318196 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -585,6 +585,8 @@ static int __devinit smsc47m1_probe(struct platform_device *pdev)
 
 	if ((err = device_create_file(dev, &dev_attr_alarms)))
 		goto error_remove_files;
+	if ((err = device_create_file(dev, &dev_attr_name)))
+		goto error_remove_files;
 
 	data->class_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->class_dev)) {
-- 
1.5.2.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
