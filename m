From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH] I2C: Change of i2c co-maintainer
Message-Id: <1109968597146@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11099685971064@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: khali@linux-fr.org

ChangeSet 1.2115, 2005/03/02 16:13:14-08:00, khali@linux-fr.org

[PATCH] I2C: Change of i2c co-maintainer

Since I am working more actively than Philip (or anyone else, for that
matter) on the i2c subsystem these days, it would probably make sense
that I am listed as the co-maintainer instead of him.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Acked-by: Philip Edelbrock <phil@netroedge.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 MAINTAINERS |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	2005-03-04 12:22:45 -08:00
+++ b/MAINTAINERS	2005-03-04 12:22:45 -08:00
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

