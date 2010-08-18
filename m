From: Florian Fainelli <ffainelli@freebox.fr>
Date: Wed, 18 Aug 2010 12:33:50 +0000
Subject: [lm-sensors] [PATCH] i2c-tools: do not fail opening bus if /dev/i2c
Message-Id: <201008181433.50995.ffainelli@freebox.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In case /dev/i2c is not a directory, open_i2c_dev will fail opening
/dev/i2c/<i2cbus> but only handles the ENOENT errno, while we should also
handle ENOTDIR errno because this is the returned error code. The patch
attached fixes the issue.

Signed-off-by: Florian Fainelli <ffainelli@freebox.fr>
--
Index: tools/i2cbusses.c
=================================--- tools/.svn/text-base/i2cbusses.c.svn-base	2010-08-18 14:22:18.000000000 +0200
+++ /tmp/tempfile.2.tmp	2010-08-18 14:33:12.000000000 +0200
@@ -378,7 +378,7 @@
 	sprintf(filename, "/dev/i2c/%d", i2cbus);
 	file = open(filename, O_RDWR);
 
-	if (file < 0 && errno = ENOENT) {
+	if (file < 0 && (errno = ENOENT || errno = ENOTDIR)) {
 		sprintf(filename, "/dev/i2c-%d", i2cbus);
 		file = open(filename, O_RDWR);
 	}


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
