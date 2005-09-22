From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 22 Sep 2005 21:47:13 +0000
Subject: [lm-sensors] [PATCH] (1/7) i2c-viapro: New maintainer
Message-Id: <20050922214758.3052c5e1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, all,

I am taking over the maintenance of the i2c-viapro SMBus driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 MAINTAINERS |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-2.6.14-rc2.orig/MAINTAINERS	2005-09-21 23:01:11.000000000 +0200
+++ linux-2.6.14-rc2/MAINTAINERS	2005-09-21 23:05:42.000000000 +0200
@@ -2679,6 +2679,12 @@
 M:	rl@hellgate.ch
 S:	Maintained
 
+VIAPRO SMBUS DRIVER
+P:	Jean Delvare
+M:	khali@linux-fr.org
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+
 UCLINUX (AND M68KNOMMU)
 P:	Greg Ungerer
 M:	gerg@uclinux.org

-- 
Jean Delvare
