From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 29 Apr 2011 08:25:08 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (lm85) Fix error paths in probe
Message-Id: <20110429102508.07e31e59@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We must remove all files we created, even in error cases.

Fixes second part of kernel bug #34072:
https://bugzilla.kernel.org/show_bug.cgi?id4072

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/lm85.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.39-rc5.orig/drivers/hwmon/lm85.c	2011-04-29 09:50:12.000000000 +0200
+++ linux-2.6.39-rc5/drivers/hwmon/lm85.c	2011-04-29 10:12:56.000000000 +0200
@@ -1331,11 +1331,11 @@ static int lm85_probe(struct i2c_client
 	if (data->type != emc6d103s) {
 		err = sysfs_create_group(&client->dev.kobj, &lm85_group_minctl);
 		if (err)
-			goto err_kfree;
+			goto err_remove_files;
 		err = sysfs_create_group(&client->dev.kobj,
 					 &lm85_group_temp_off);
 		if (err)
-			goto err_kfree;
+			goto err_remove_files;
 	}
 
 	/* The ADT7463/68 have an optional VRM 10 mode where pin 21 is used


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
