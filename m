From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:49:13 +0000
Subject: [lm-sensors] [PATCH] hwmon: separate maintainer
Message-Id: <11259567713428@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: separate maintainer

Now that the hardware monitoring drivers are no more part of the i2c
subsystem, they probably deserve their own entry in MAINTAINERS.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 5b5439652af79106b792faf79b2c1e787e143ba0
tree 4ad52bac0fcc4cff98f22e3cb6c0abbcacfc1c70
parent 020789e9cb688ac8b15a9950d25fe45492b23398
author Jean Delvare <khali@linux-fr.org> Mon, 15 Aug 2005 19:51:02 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:35 -0700

 MAINTAINERS |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -933,6 +933,13 @@ M:	khc@pm.waw.pl
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
@@ -1014,7 +1021,7 @@ P:	William Irwin
 M:	wli@holomorphy.com
 S:	Maintained
 
-I2C AND SENSORS DRIVERS
+I2C SUBSYSTEM
 P:	Greg Kroah-Hartman
 M:	greg@kroah.com
 P:	Jean Delvare

