From: aris@cathedrallabs.org (Aristeu Sergio Rozanski Filho)
Date: Fri, 04 Aug 2006 20:39:32 +0000
Subject: [lm-sensors] [PATCH] Apple Motion Sensor driver
Message-Id: <20060804203932.GK28732@cathedrallabs.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060802191520.GA2260@hansmi.ch>
In-Reply-To: <20060802191520.GA2260@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> This guarantees a minimum wait time of 5msec after writing the value.
> Looking at the specs[1], this should be done. Your code doesn't do that:
I doubt that if it's possible to retrying after a fail the hardware will
bother if we try to do the first read in less than 5ms... but here it
goes. two versions, feel free to choose.

Index: ppc-2.6/drivers/hwmon/ams/ams-i2c.c
=================================--- ppc-2.6.orig/drivers/hwmon/ams/ams-i2c.c	2006-08-04 10:47:57.000000000 -0300
+++ ppc-2.6/drivers/hwmon/ams/ams-i2c.c	2006-08-04 17:18:50.000000000 -0300
@@ -85,14 +85,15 @@
 static int ams_i2c_cmd(enum ams_i2c_cmd cmd)
 {
 	s32 result;
-	int i;
+	int remaining = HZ/20;
 
 	ams_i2c_write(AMS_COMMAND, cmd);
-	for (i = 0; i < 10; i++) {
-		mdelay(5);
+	mdelay(5);
+	while (remaining) {
 		result = ams_i2c_read(AMS_COMMAND);
 		if (result = 0 || result & 0x80)
 			return 0;
+		remaining = schedule_timeout(remaining);
 	}
 	return -1;
 }


Index: ppc-2.6/drivers/hwmon/ams/ams-i2c.c
=================================--- ppc-2.6.orig/drivers/hwmon/ams/ams-i2c.c	2006-08-04 10:47:57.000000000 -0300
+++ ppc-2.6/drivers/hwmon/ams/ams-i2c.c	2006-08-04 17:34:14.000000000 -0300
@@ -85,11 +85,18 @@
 static int ams_i2c_cmd(enum ams_i2c_cmd cmd)
 {
 	s32 result;
-	int i;
+	int remaining = HZ/20, tmp;
 
 	ams_i2c_write(AMS_COMMAND, cmd);
-	for (i = 0; i < 10; i++) {
-		mdelay(5);
+	while (remaining) {
+		tmp = remaining;
+		while(1) {
+			remaining = schedule_timeout(remaining);
+			/* wait at least 5ms */
+			if (!remaining || tmp - remaining > HZ/200)
+				break;
+		}
+
 		result = ams_i2c_read(AMS_COMMAND);
 		if (result = 0 || result & 0x80)
 			return 0;


