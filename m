From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 05 Jun 2007 12:58:13 +0000
Subject: [lm-sensors] [PATCH] MMH is now maintaining the hwmon subsystem
Message-Id: <11810482932884-git-send-email-mhoffman@lightlink.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman is taking over for Jean Delvare as maintainer of the hwmon
subsystem.  He is also the author/maintainer for several existing drivers.

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
---
 MAINTAINERS |   30 +++++++++++++++++++++++++++---
 1 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f3b5a39..e0255f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -630,6 +630,12 @@ W:	http://sourceforge.net/projects/acpi4asus
 W:	http://xf.iksaif.net/acpi4asus
 S:	Maintained
 
+ASUS ASB100 HARDWARE MONITOR DRIVER
+P:	Mark M. Hoffman
+M:	mhoffman@lightlink.com
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+
 ASUS LAPTOP EXTRAS DRIVER
 P:	Corentin Chary
 M:	corentincj@iksaif.net
@@ -1590,11 +1596,11 @@ W:	http://gigaset307x.sourceforge.net/
 S:	Maintained
 
 HARDWARE MONITORING
-P:	Jean Delvare
-M:	khali@linux-fr.org
+P:	Mark M. Hoffman
+M:	mhoffman@lightlink.com
 L:	lm-sensors@lm-sensors.org
 W:	http://www.lm-sensors.org/
-T:	quilt http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/
+T:	git lm-sensors.org:/kernel/mhoffman/hwmon-2.6.git
 S:	Maintained
 
 HARDWARE RANDOM NUMBER GENERATOR CORE
@@ -1730,6 +1736,12 @@ P:	William Irwin
 M:	wli@holomorphy.com
 S:	Maintained
 
+I2C/SMBUS STUB DRIVER
+P:	Mark M. Hoffman
+M:	mhoffman@lightlink.com
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+
 I2C SUBSYSTEM
 P:	Jean Delvare
 M:	khali@linux-fr.org
@@ -3228,6 +3240,12 @@ W:	http://www.brownhat.org/sis900.html
 L:	netdev@vger.kernel.org
 S:	Maintained
 
+SIS 96X I2C/SMBUS DRIVER
+P:	Mark M. Hoffman
+M:	mhoffman@lightlink.com
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+
 SIS FRAMEBUFFER DRIVER
 P:	Thomas Winischhofer
 M:	thomas@winischhofer.net
@@ -3245,6 +3263,12 @@ P:	Nicolas Pitre
 M:	nico@cam.org
 S:	Maintained
 
+SMSC47B397 HARDWARE MONITOR DRIVER
+P:	Mark M. Hoffman
+M:	mhoffman@lightlink.com
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+
 SOFTMAC LAYER (IEEE 802.11)
 P:	Johannes Berg
 M:	johannes@sipsolutions.net
-- 
1.5.0.6


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
