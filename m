From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sat, 16 Jul 2005 03:37:02 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.13-rc3 1/3] hwmon: kfree fixes
Message-Id: <20050716013650.GB4265@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch fixes several instances of hwmon drivers kfree'ing the
"wrong" pointer; the existing code works somewhat by accident.

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

Index: linux-2.6.13-rc3/drivers/hwmon/adm1026.c
=================================--- linux-2.6.13-rc3.orig/drivers/hwmon/adm1026.c
+++ linux-2.6.13-rc3/drivers/hwmon/adm1026.c
@@ -325,7 +325,7 @@ int adm1026_attach_adapter(struct i2c_ad
 int adm1026_detach_client(struct i2c_client *client)
 {
 	i2c_detach_client(client);
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -1691,7 +1691,7 @@ int adm1026_detect(struct i2c_adapter *a
 
 	/* Error out and cleanup code */
 exitfree:
-	kfree(new_client);
+	kfree(data);
 exit:
 	return err;
 }
Index: linux-2.6.13-rc3/drivers/hwmon/adm1031.c
=================================--- linux-2.6.13-rc3.orig/drivers/hwmon/adm1031.c
+++ linux-2.6.13-rc3/drivers/hwmon/adm1031.c
@@ -834,7 +834,7 @@ static int adm1031_detect(struct i2c_ada
 	return 0;
 
 exit_free:
-	kfree(new_client);
+	kfree(data);
 exit:
 	return err;
 }
@@ -845,7 +845,7 @@ static int adm1031_detach_client(struct 
 	if ((ret = i2c_detach_client(client)) != 0) {
 		return ret;
 	}
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
Index: linux-2.6.13-rc3/drivers/hwmon/adm9240.c
=================================--- linux-2.6.13-rc3.orig/drivers/hwmon/adm9240.c
+++ linux-2.6.13-rc3/drivers/hwmon/adm9240.c
@@ -616,7 +616,7 @@ static int adm9240_detect(struct i2c_ada
 
 	return 0;
 exit_free:
-	kfree(new_client);
+	kfree(data);
 exit:
 	return err;
 }
Index: linux-2.6.13-rc3/drivers/hwmon/smsc47b397.c
=================================--- linux-2.6.13-rc3.orig/drivers/hwmon/smsc47b397.c
+++ linux-2.6.13-rc3/drivers/hwmon/smsc47b397.c
@@ -298,7 +298,7 @@ static int smsc47b397_detect(struct i2c_
 	return 0;
 
 error_free:
-	kfree(new_client);
+	kfree(data);
 error_release:
 	release_region(addr, SMSC_EXTENT);
 	return err;
Index: linux-2.6.13-rc3/drivers/hwmon/smsc47m1.c
=================================--- linux-2.6.13-rc3.orig/drivers/hwmon/smsc47m1.c
+++ linux-2.6.13-rc3/drivers/hwmon/smsc47m1.c
@@ -495,7 +495,7 @@ static int smsc47m1_detect(struct i2c_ad
 	return 0;
 
 error_free:
-	kfree(new_client);
+	kfree(data);
 error_release:
 	release_region(address, SMSC_EXTENT);
 	return err;

-- 
Mark M. Hoffman
mhoffman@lightlink.com

