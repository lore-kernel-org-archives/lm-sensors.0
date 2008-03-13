From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Thu, 13 Mar 2008 01:18:16 +0000
Subject: [lm-sensors] [PATCH] ibmpex: Update Kconfig to list more supported
Message-Id: <20080313011816.GB5731@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors <lm-sensors@lm-sensors.org>, linux-kernel <linux-kernel@vger.kernel.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>

Enhanced the list of supported machines.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/hwmon/Kconfig |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 368879f..4dc76bc 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -337,8 +337,9 @@ config SENSORS_IBMPEX
 	help
 	  If you say yes here you get support for the temperature and
 	  power sensors in various IBM System X servers that support
-	  PowerExecutive.  So far this includes the x3550, x3650, x3655,
-	  x3755, and certain HS20 blades.
+	  PowerExecutive.  So far this includes the x3350, x3550, x3650,
+	  x3655, and x3755; the x3800, x3850, and x3950 models that have
+	  PCI Express; and some of the HS2x, LS2x, and QS2x blades.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called ibmpex.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
