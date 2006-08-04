From: aris@cathedrallabs.org (Aristeu Sergio Rozanski Filho)
Date: Fri, 04 Aug 2006 14:11:31 +0000
Subject: [lm-sensors] [PATCH] Apple Motion Sensor driver
Message-Id: <20060804141130.GA28732@cathedrallabs.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060802191520.GA2260@hansmi.ch>
In-Reply-To: <20060802191520.GA2260@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > That's a potentially very long busy wait.
> 
> I would like if Aristeu or Stelian could fix this, because I don't own
> the I??C hardware myself. Thus I left it untouched in the patch below.
what about the attached patch? Running right now a kernel with the
original patch + Michael fixes + this one and no problems so far.

-- 
Aristeu

-------------- next part --------------
Index: ppc-2.6/drivers/hwmon/ams/ams-i2c.c
=================================--- ppc-2.6.orig/drivers/hwmon/ams/ams-i2c.c	2006-08-04 10:47:57.000000000 -0300
+++ ppc-2.6/drivers/hwmon/ams/ams-i2c.c	2006-08-04 10:48:26.000000000 -0300
@@ -85,11 +85,11 @@
 static int ams_i2c_cmd(enum ams_i2c_cmd cmd)
 {
 	s32 result;
-	int i;
+	int remaining = HZ/20;
 
 	ams_i2c_write(AMS_COMMAND, cmd);
-	for (i = 0; i < 10; i++) {
-		mdelay(5);
+	while (remaining) {
+		remaining = schedule_timeout(remaining);
 		result = ams_i2c_read(AMS_COMMAND);
 		if (result = 0 || result & 0x80)
 			return 0;
