From: adobriyan@gmail.com (Alexey Dobriyan)
Date: Thu, 25 Aug 2005 23:41:09 +0000
Subject: [lm-sensors] [PATCH] drivers/hwmon/*: kfree() correct pointers
Message-Id: <20050825214913.GA31605@mipter.zuzino.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050825205629.22372.qmail@lwn.net>
In-Reply-To: <20050825205629.22372.qmail@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <greg@kroah.com>, Jean Delvare <khali@linux-fr.org>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Jonathan Corbet <corbet@lwn.net>

The adm9240 driver, in adm9240_detect(), allocates a structure.  The
error path attempts to kfree() ->client field of it (second one),
resulting in an oops (or slab corruption) if the hardware is not present.

->client field in adm1026, adm1031, smsc47b397 and smsc47m1 is the first in
${HWMON}_data structure, but fix them too.

Signed-off-by: Jonathan Corbet <corbet@lwn.net
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/hwmon/adm1026.c    |    2 +-
 drivers/hwmon/adm1031.c    |    2 +-
 drivers/hwmon/adm9240.c    |    2 +-
 drivers/hwmon/smsc47b397.c |    2 +-
 drivers/hwmon/smsc47m1.c   |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff -uprN linux-vanilla/drivers/hwmon/adm1026.c linux-hwmon/drivers/hwmon/adm1026.c
--- linux-vanilla/drivers/hwmon/adm1026.c	2005-08-25 18:57:18.000000000 +0400
+++ linux-hwmon/drivers/hwmon/adm1026.c	2005-08-26 01:16:07.000000000 +0400
@@ -1691,7 +1691,7 @@ int adm1026_detect(struct i2c_adapter *a
 
 	/* Error out and cleanup code */
 exitfree:
-	kfree(new_client);
+	kfree(data);
 exit:
 	return err;
 }
diff -uprN linux-vanilla/drivers/hwmon/adm1031.c linux-hwmon/drivers/hwmon/adm1031.c
--- linux-vanilla/drivers/hwmon/adm1031.c	2005-08-25 18:57:18.000000000 +0400
+++ linux-hwmon/drivers/hwmon/adm1031.c	2005-08-26 01:16:26.000000000 +0400
@@ -834,7 +834,7 @@ static int adm1031_detect(struct i2c_ada
 	return 0;
 
 exit_free:
-	kfree(new_client);
+	kfree(data);
 exit:
 	return err;
 }
diff -uprN linux-vanilla/drivers/hwmon/adm9240.c linux-hwmon/drivers/hwmon/adm9240.c
--- linux-vanilla/drivers/hwmon/adm9240.c	2005-08-25 18:57:18.000000000 +0400
+++ linux-hwmon/drivers/hwmon/adm9240.c	2005-08-26 01:16:40.000000000 +0400
@@ -616,7 +616,7 @@ static int adm9240_detect(struct i2c_ada
 
 	return 0;
 exit_free:
-	kfree(new_client);
+	kfree(data);
 exit:
 	return err;
 }
diff -uprN linux-vanilla/drivers/hwmon/smsc47b397.c linux-hwmon/drivers/hwmon/smsc47b397.c
--- linux-vanilla/drivers/hwmon/smsc47b397.c	2005-08-25 18:57:18.000000000 +0400
+++ linux-hwmon/drivers/hwmon/smsc47b397.c	2005-08-26 01:21:11.000000000 +0400
@@ -298,7 +298,7 @@ static int smsc47b397_detect(struct i2c_
 	return 0;
 
 error_free:
-	kfree(new_client);
+	kfree(data);
 error_release:
 	release_region(addr, SMSC_EXTENT);
 	return err;
diff -uprN linux-vanilla/drivers/hwmon/smsc47m1.c linux-hwmon/drivers/hwmon/smsc47m1.c
--- linux-vanilla/drivers/hwmon/smsc47m1.c	2005-08-25 18:57:18.000000000 +0400
+++ linux-hwmon/drivers/hwmon/smsc47m1.c	2005-08-26 01:21:28.000000000 +0400
@@ -495,7 +495,7 @@ static int smsc47m1_detect(struct i2c_ad
 	return 0;
 
 error_free:
-	kfree(new_client);
+	kfree(data);
 error_release:
 	release_region(address, SMSC_EXTENT);
 	return err;

