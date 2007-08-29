From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 29 Aug 2007 08:39:57 +0000
Subject: [lm-sensors] [PATCH] hwmon: End of I/O region off-by-one
Message-Id: <20070829103957.69691bff@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix an off-by-one error in the I/O region declaration of two
hardware monitoring drivers (lm78 and w83781d.) We were requesting
one extra port at the end of the region.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Mark, can you please apply this fix quickly? It should probably go to
2.6.22-stable as well, as in theory it could prevent drivers from
loading.

Personal note: having different conventions for declaring resources and
requesting them really sucks :(

 drivers/hwmon/lm78.c    |    2 +-
 drivers/hwmon/w83781d.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.23-rc4.orig/drivers/hwmon/lm78.c	2007-08-08 16:53:14.000000000 +0200
+++ linux-2.6.23-rc4/drivers/hwmon/lm78.c	2007-08-28 18:17:22.000000000 +0200
@@ -882,7 +882,7 @@ static int __init lm78_isa_device_add(un
 {
 	struct resource res = {
 		.start	= address,
-		.end	= address + LM78_EXTENT,
+		.end	= address + LM78_EXTENT - 1,
 		.name	= "lm78",
 		.flags	= IORESOURCE_IO,
 	};
--- linux-2.6.23-rc4.orig/drivers/hwmon/w83781d.c	2007-08-28 12:56:37.000000000 +0200
+++ linux-2.6.23-rc4/drivers/hwmon/w83781d.c	2007-08-28 18:17:15.000000000 +0200
@@ -1748,7 +1748,7 @@ w83781d_isa_device_add(unsigned short ad
 {
 	struct resource res = {
 		.start	= address,
-		.end	= address + W83781D_EXTENT,
+		.end	= address + W83781D_EXTENT - 1,
 		.name	= "w83781d",
 		.flags	= IORESOURCE_IO,
 	};


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
