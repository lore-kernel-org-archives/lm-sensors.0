From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 05 Jul 2006 16:05:15 +0000
Subject: [lm-sensors] [PATCH 1/5] hwmon: New maintainer for w83791d
Message-Id: <20060705180515.97a0691d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Charles Spirakis <bezaur at gmail.com>
Content-Disposition: inline; filename=hwmon-w83791d-maintainer.patch

Add Charles Spirakis as the maintainer for the w83791d sensor chip
driver.

Signed-off-by: Charles Spirakis <bezaur at gmail.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---

 MAINTAINERS |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-2.6.17-git.orig/MAINTAINERS	2006-07-05 10:25:22.000000000 +0200
+++ linux-2.6.17-git/MAINTAINERS	2006-07-05 10:25:27.000000000 +0200
@@ -3168,6 +3168,12 @@
 L:	lm-sensors at lm-sensors.org
 S:	Maintained
 
+W83791D HARDWARE MONITORING DRIVER
+P:	Charles Spirakis
+M:	bezaur at gmail.com
+L:	lm-sensors at lm-sensors.org
+S:	Maintained
+
 W83L51xD SD/MMC CARD INTERFACE DRIVER
 P:	Pierre Ossman
 M:	drzeus-wbsd at drzeus.cx

-- 
Jean Delvare

