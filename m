From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: [PATCH 2.6] I2C: use chip driver name to request regions
Message-Id: <20041210205547.1fc6299f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Domen,

> Trivial patch against 2.6.10-rc3-bk2.
> When request_region is called name is set to "", use module name.

Correct. I even think we should do the same for other chip drivers. For
now they all use an arbitrary string. Using the driver's name would be
both more consistent and more efficient (spares some bytes of memory).

Greg, how does it look?

(Note that my patch does NOT include Domen's one, which would have to be
applied separately.)

Thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

diff -ruN linux-2.6.10-rc3/drivers/i2c/chips.orig/lm78.c linux-2.6.10-rc3/drivers/i2c/chips/lm78.c
--- linux-2.6.10-rc3/drivers/i2c/chips.orig/lm78.c	2004-12-05 17:33:04.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/chips/lm78.c	2004-12-10 19:39:43.000000000 +0100
@@ -462,7 +462,7 @@
 
 	/* Reserve the ISA region */
 	if (is_isa)
-		if (!request_region(address, LM78_EXTENT, "lm78")) {
+		if (!request_region(address, LM78_EXTENT, lm78_driver.name)) {
 			err = -EBUSY;
 			goto ERROR0;
 		}
diff -ruN linux-2.6.10-rc3/drivers/i2c/chips.orig/pc87360.c linux-2.6.10-rc3/drivers/i2c/chips/pc87360.c
--- linux-2.6.10-rc3/drivers/i2c/chips.orig/pc87360.c	2004-12-05 17:33:04.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/chips/pc87360.c	2004-12-10 19:39:34.000000000 +0100
@@ -756,7 +756,8 @@
 
 	for (i = 0; i < 3; i++) {
 		if (((data->address[i] = extra_isa[i]))
-		 && !request_region(extra_isa[i], PC87360_EXTENT, "pc87360")) {
+		 && !request_region(extra_isa[i], PC87360_EXTENT,
+		 		    pc87360_driver.name)) {
 			dev_err(&new_client->dev, "Region 0x%x-0x%x already "
 				"in use!\n", extra_isa[i],
 				extra_isa[i]+PC87360_EXTENT-1);
diff -ruN linux-2.6.10-rc3/drivers/i2c/chips.orig/smsc47m1.c linux-2.6.10-rc3/drivers/i2c/chips/smsc47m1.c
--- linux-2.6.10-rc3/drivers/i2c/chips.orig/smsc47m1.c	2004-12-05 17:33:04.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/chips/smsc47m1.c	2004-12-10 19:39:17.000000000 +0100
@@ -400,7 +400,7 @@
 		return 0;
 	}
 
-	if (!request_region(address, SMSC_EXTENT, "smsc47m1")) {
+	if (!request_region(address, SMSC_EXTENT, smsc47m1_driver.name)) {
 		dev_err(&adapter->dev, "Region 0x%x already in use!\n", address);
 		return -EBUSY;
 	}
diff -ruN linux-2.6.10-rc3/drivers/i2c/chips.orig/via686a.c linux-2.6.10-rc3/drivers/i2c/chips/via686a.c
--- linux-2.6.10-rc3/drivers/i2c/chips.orig/via686a.c	2004-12-05 17:33:04.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/chips/via686a.c	2004-12-10 19:39:07.000000000 +0100
@@ -613,7 +613,7 @@
 	}
 
 	/* Reserve the ISA region */
-	if (!request_region(address, VIA686A_EXTENT, "via686a-sensor")) {
+	if (!request_region(address, VIA686A_EXTENT, via686a_driver.name)) {
 		dev_err(&adapter->dev,"region 0x%x already in use!\n",
 		       address);
 		return -ENODEV;
diff -ruN linux-2.6.10-rc3/drivers/i2c/chips.orig/w83627hf.c linux-2.6.10-rc3/drivers/i2c/chips/w83627hf.c
--- linux-2.6.10-rc3/drivers/i2c/chips.orig/w83627hf.c	2004-12-05 17:33:04.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/chips/w83627hf.c	2004-12-10 19:38:55.000000000 +0100
@@ -984,7 +984,7 @@
 	if(force_addr)
 		address = force_addr & ~(WINB_EXTENT - 1);
 
-	if (!request_region(address, WINB_EXTENT, "w83627hf")) {
+	if (!request_region(address, WINB_EXTENT, w83627hf_driver.name)) {
 		err = -EBUSY;
 		goto ERROR0;
 	}
diff -ruN linux-2.6.10-rc3/drivers/i2c/chips.orig/w83781d.c linux-2.6.10-rc3/drivers/i2c/chips/w83781d.c
--- linux-2.6.10-rc3/drivers/i2c/chips.orig/w83781d.c	2004-12-05 17:33:04.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/chips/w83781d.c	2004-12-10 19:38:41.000000000 +0100
@@ -1065,7 +1065,8 @@
 	}
 	
 	if (is_isa)
-		if (!request_region(address, W83781D_EXTENT, "w83781d")) {
+		if (!request_region(address, W83781D_EXTENT,
+				    w83781d_driver.name)) {
 			dev_dbg(&adapter->dev, "Request of region "
 				"0x%x-0x%x for w83781d failed\n", address,
 				address + W83781D_EXTENT - 1);


-- 
Jean Delvare
http://khali.linux-fr.org/
