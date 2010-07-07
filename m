From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 07 Jul 2010 12:58:41 +0000
Subject: [lm-sensors] [PATCH] hwmon: (pc87360) Fix device resource
Message-Id: <20100707145841.58052281@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It's not OK to call platform_device_add_resources() multiple times
in a row. Despite its name, this functions sets the resources, it
doesn't add them. So we have to prepare an array with all the
resources, and then call platform_device_add_resources() once.

Before this fix, only the last I/O resource would be actually
registered. The other I/O resources were leaked.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Jim Cromie <jim.cromie@gmail.com>
Cc: stable@kernel.org
---
Jim, do you still have your system with a PC8736x device? If you do,
can you please test this fix and report? Thanks.

 drivers/hwmon/pc87360.c |   30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

--- linux-2.6.35-rc4.orig/drivers/hwmon/pc87360.c	2010-05-17 18:20:27.000000000 +0200
+++ linux-2.6.35-rc4/drivers/hwmon/pc87360.c	2010-07-07 14:11:03.000000000 +0200
@@ -1610,11 +1610,8 @@ static struct pc87360_data *pc87360_upda
 
 static int __init pc87360_device_add(unsigned short address)
 {
-	struct resource res = {
-		.name	= "pc87360",
-		.flags	= IORESOURCE_IO,
-	};
-	int err, i;
+	struct resource res[3];
+	int err, i, res_count;
 
 	pdev = platform_device_alloc("pc87360", address);
 	if (!pdev) {
@@ -1623,22 +1620,27 @@ static int __init pc87360_device_add(uns
 		goto exit;
 	}
 
+	memset(res, 0, 3 * sizeof(struct resource));
 	for (i = 0; i < 3; i++) {
 		if (!extra_isa[i])
 			continue;
-		res.start = extra_isa[i];
-		res.end = extra_isa[i] + PC87360_EXTENT - 1;
+		res[res_count].start = extra_isa[i];
+		res[res_count].end = extra_isa[i] + PC87360_EXTENT - 1;
+		res[res_count].name = "pc87360",
+		res[res_count].flags = IORESOURCE_IO,
 
-		err = acpi_check_resource_conflict(&res);
+		err = acpi_check_resource_conflict(&res[res_count]);
 		if (err)
 			goto exit_device_put;
 
-		err = platform_device_add_resources(pdev, &res, 1);
-		if (err) {
-			printk(KERN_ERR "pc87360: Device resource[%d] "
-			       "addition failed (%d)\n", i, err);
-			goto exit_device_put;
-		}
+		res_count++;
+	}
+
+	err = platform_device_add_resources(pdev, res, res_count);
+	if (err) {
+		printk(KERN_ERR "pc87360: Device resources addition failed "
+		       "(%d)\n", err);
+		goto exit_device_put;
 	}
 
 	err = platform_device_add(pdev);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
