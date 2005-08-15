From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 15 Aug 2005 19:50:53 +0000
Subject: [lm-sensors] [PATHC 2.6] hwmon: separate maintainer
Message-Id: <20050815195102.0bdcfcfb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Now that the hardware monitoring drivers are no more part of the i2c
subsystem, they probably deserve their own entry in MAINTAINERS.

I wouldn't mind someone seconding me on this, as it is quite obvious
that there is too much work for me alone, at least as long as it is
done on my spare time.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 MAINTAINERS |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletion(-)

--- linux-2.6.13-rc6.orig/MAINTAINERS	2005-08-14 22:27:54.000000000 +0200
+++ linux-2.6.13-rc6/MAINTAINERS	2005-08-14 22:29:03.000000000 +0200
@@ -933,6 +933,13 @@
 W:	http://www.kernel.org/pub/linux/utils/net/hdlc/
 S:	Maintained
 
+HARDWARE MONITORING
+P:	Jean Delvare
+M:	khali@linux-fr.org
+L:	lm-sensors@lm-sensors.org
+W:	http://www.lm-sensors.nu/
+S:	Maintained
+
 HARMONY SOUND DRIVER
 P:	Kyle McMartin
 M:	kyle@parisc-linux.org
@@ -1007,7 +1014,7 @@
 M:	wli@holomorphy.com
 S:	Maintained
 
-I2C AND SENSORS DRIVERS
+I2C SUBSYSTEM
 P:	Greg Kroah-Hartman
 M:	greg@kroah.com
 P:	Jean Delvare


-- 
Jean Delvare
