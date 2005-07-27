From: gregkh@suse.de (gregkh@suse.de)
Date: Wed, 27 Jul 2005 00:01:00 +0000
Subject: [lm-sensors] patch i2c-hwmon-class-01.patch added to gregkh-2.6 tree
Message-Id: <1DxXTM-3oj-00@press.kroah.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: I2C hwmon: kfree fixes

to my gregkh-2.6 tree.  Its filename is

     i2c-hwmon-class-01.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/

Patches currently in gregkh-2.6 which might be from mhoffman@lightlink.com are

i2c/i2c-hwmon-class-01.patch
i2c/i2c-hwmon-class-02.patch
i2c/i2c-hwmon-class-03.patch


From mhoffman@lightlink.com Fri Jul 15 18:37:06 2005
Date: Fri, 15 Jul 2005 21:36:50 -0400
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Greg KH <greg@kroah.com>
Cc: Jean Delvare <khali@linux-fr.org>,
	Yani Ioannou <yani.ioannou@gmail.com>,
	lm-sensors <lm-sensors@lm-sensors.org>
Subject: I2C hwmon: kfree fixes
Message-ID: <20050716013650.GB4265@jupiter.solarsys.private>

This patch fixes several instances of hwmon drivers kfree'ing the
"wrong" pointer; the existing code works somewhat by accident.

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/hwmon/adm1026.c    |    4 ++--
 drivers/hwmon/adm1031.c    |    4 ++--
 drivers/hwmon/adm9240.c    |    2 +-
 drivers/hwmon/smsc47b397.c |    2 +-
 drivers/hwmon/smsc47m1.c   |    2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

--- gregkh-2.6.orig/drivers/hwmon/adm1026.c	2005-07-26 14:53:45.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/adm1026.c	2005-07-26 14:56:38.000000000 -0700
@@ -325,7 +325,7 @@
 int adm1026_detach_client(struct i2c_client *client)
 {
 	i2c_detach_client(client);
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -1691,7 +1691,7 @@
 
 	/* Error out and cleanup code */
 exitfree:
-	kfree(new_client);
+	kfree(data);
 exit:
 	return err;
 }
--- gregkh-2.6.orig/drivers/hwmon/adm1031.c	2005-07-13 09:45:05.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/adm1031.c	2005-07-26 14:56:38.000000000 -0700
@@ -834,7 +834,7 @@
 	return 0;
 
 exit_free:
-	kfree(new_client);
+	kfree(data);
 exit:
 	return err;
 }
@@ -845,7 +845,7 @@
 	if ((ret = i2c_detach_client(client)) != 0) {
 		return ret;
 	}
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
--- gregkh-2.6.orig/drivers/hwmon/adm9240.c	2005-07-13 09:45:05.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/adm9240.c	2005-07-26 14:56:38.000000000 -0700
@@ -616,7 +616,7 @@
 
 	return 0;
 exit_free:
-	kfree(new_client);
+	kfree(data);
 exit:
 	return err;
 }
--- gregkh-2.6.orig/drivers/hwmon/smsc47b397.c	2005-07-13 09:45:05.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/smsc47b397.c	2005-07-26 14:56:38.000000000 -0700
@@ -298,7 +298,7 @@
 	return 0;
 
 error_free:
-	kfree(new_client);
+	kfree(data);
 error_release:
 	release_region(addr, SMSC_EXTENT);
 	return err;
--- gregkh-2.6.orig/drivers/hwmon/smsc47m1.c	2005-07-13 09:45:05.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/smsc47m1.c	2005-07-26 14:56:38.000000000 -0700
@@ -495,7 +495,7 @@
 	return 0;
 
 error_free:
-	kfree(new_client);
+	kfree(data);
 error_release:
 	release_region(address, SMSC_EXTENT);
 	return err;
