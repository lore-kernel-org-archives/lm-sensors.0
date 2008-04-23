From: Juerg Haefliger <juergh@gmail.com>
Date: Wed, 23 Apr 2008 05:24:56 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon (dme1737): skip detection if forced
Message-Id: <480EC828.8080105@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000808090508000204070803"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------000808090508000204070803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Skip the checking of the device ID register in the hwmon register block 
if the force_id option is used.

Signed-off-by: Juerg Haefliger <juergh at gmail.com>


--------------000808090508000204070803
Content-Type: text/x-patch;
 name="dme1737-skip-detection-if-forced.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="dme1737-skip-detection-if-forced.patch"

Skip the checking of the device ID register in the hwmon register block if
the force_id option is used.

Signed-off-by: Juerg Haefliger <juergh at gmail.com>

Index: linux/drivers/hwmon/dme1737.c
===================================================================
--- linux.orig/drivers/hwmon/dme1737.c	2008-04-22 22:02:45.000000000 -0700
+++ linux/drivers/hwmon/dme1737.c	2008-04-22 22:09:10.000000000 -0700
@@ -2360,13 +2360,16 @@
 	client->addr = res->start;
 	platform_set_drvdata(pdev, data);
 
-	company = dme1737_read(client, DME1737_REG_COMPANY);
-	device = dme1737_read(client, DME1737_REG_DEVICE);
-
-	if (!((company == DME1737_COMPANY_SMSC) &&
-	      (device == SCH311X_DEVICE))) {
-		err = -ENODEV;
-		goto exit_kfree;
+	/* Skip chip detection if module is loaded with force_id parameter */
+	if (!force_id) {
+		company = dme1737_read(client, DME1737_REG_COMPANY);
+		device = dme1737_read(client, DME1737_REG_DEVICE);
+
+		if (!((company == DME1737_COMPANY_SMSC) &&
+		      (device == SCH311X_DEVICE))) {
+			err = -ENODEV;
+			goto exit_kfree;
+		}
 	}
 	data->type = -1;
 

--------------000808090508000204070803
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------000808090508000204070803--
