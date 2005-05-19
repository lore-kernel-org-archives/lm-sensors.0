From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: [PATCH 2.6] Change of i2c co-maintainer
Message-Id: <20050302195106.4bf0b1ec.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>, Philip Edelbrock <phil@netroedge.com>

Hi Greg, all,

Since I am working more actively than Philip (or anyone else, for that
matter) on the i2c subsystem these days, it would probably make sense
that I am listed as the co-maintainer instead of him.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.11-rc5/MAINTAINERS.orig	2005-02-25 20:25:45.000000000 +0100
+++ linux-2.6.11-rc5/MAINTAINERS	2005-03-02 19:50:04.000000000 +0100
@@ -991,8 +991,8 @@
 I2C AND SENSORS DRIVERS
 P:	Greg Kroah-Hartman
 M:	greg@kroah.com
-P:	Philip Edelbrock
-M:	phil@netroedge.com
+P:	Jean Delvare
+M:	khali@linux-fr.org
 L:	sensors@stimpy.netroedge.com
 W:	http://www.lm-sensors.nu/
 S:	Maintained


-- 
Jean Delvare
