From: greg@kroah.com (Greg KH)
Date: Wed, 12 Jul 2006 23:27:19 +0000
Subject: [lm-sensors] [PATCH 7/13] [PATCH] i2c: New mailing list
Message-Id: <1152746865674-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

We have a new mailing list dedicated to linux i2c:
http://lists.lm-sensors.org/mailman/listinfo/i2c

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 Documentation/i2c/busses/i2c-sis96x |    4 ++--
 MAINTAINERS                         |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-sis96x b/Documentation/i2c/busses/i2c-sis96x
index 00a009b..08d7b2d 100644
--- a/Documentation/i2c/busses/i2c-sis96x
+++ b/Documentation/i2c/busses/i2c-sis96x
@@ -42,8 +42,8 @@ I suspect that this driver could be made
 chipsets as well: 635, and 635T. If anyone owns a board with those chips
 AND is willing to risk crashing & burning an otherwise well-behaved kernel
 in the name of progress... please contact me at <mhoffman at lightlink.com> or
-via the project's mailing list: <lm-sensors at lm-sensors.org>.  Please
-send bug reports and/or success stories as well.
+via the project's mailing list: <i2c at lm-sensors.org>.  Please send bug
+reports and/or success stories as well.
 
 
 TO DOs
diff --git a/MAINTAINERS b/MAINTAINERS
index 645a9f8..6699394 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -274,7 +274,7 @@ S:	Maintained
 ALI1563 I2C DRIVER
 P:	Rudolf Marek
 M:	r.marek at sh.cvut.cz
-L:	lm-sensors at lm-sensors.org
+L:	i2c at lm-sensors.org
 S:	Maintained
 
 ALPHA PORT
@@ -1249,7 +1249,7 @@ S:	Maintained
 I2C SUBSYSTEM
 P:	Jean Delvare
 M:	khali at linux-fr.org
-L:	lm-sensors at lm-sensors.org
+L:	i2c at lm-sensors.org
 W:	http://www.lm-sensors.nu/
 T:	quilt kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/
 S:	Maintained
@@ -2093,7 +2093,7 @@ S:      Maintained
 OPENCORES I2C BUS DRIVER
 P:	Peter Korsgaard
 M:	jacmet at sunsite.dk
-L:	lm-sensors at lm-sensors.org
+L:	i2c at lm-sensors.org
 S:	Maintained
 
 ORACLE CLUSTER FILESYSTEM 2 (OCFS2)
@@ -3132,7 +3132,7 @@ S:	Maintained
 VIAPRO SMBUS DRIVER
 P:	Jean Delvare
 M:	khali at linux-fr.org
-L:	lm-sensors at lm-sensors.org
+L:	i2c at lm-sensors.org
 S:	Maintained
 
 UCLINUX (AND M68KNOMMU)
-- 
1.4.1


