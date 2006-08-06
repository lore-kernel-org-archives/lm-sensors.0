From: linux-kernel@hansmi.ch (Michael Hanselmann)
Date: Sun, 06 Aug 2006 14:38:38 +0000
Subject: [lm-sensors] [PATCH] Apple Motion Sensor driver
Message-Id: <20060806143838.GA3208@hansmi.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060802191520.GA2260@hansmi.ch>
In-Reply-To: <20060802191520.GA2260@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Aug 06, 2006 at 01:41:02PM +0200, Johannes Berg wrote:
> On Wed, 2006-08-02 at 21:15 +0200, Michael Hanselmann wrote:
> I'm not sure if that's possible to solve at all.

I think it is, see patch below. However, the solution is not that
pretty.

> 	depends on HWMON && PPC_PMAC && INPUT && ADB_PMU && I2C && EXPERIMENTAL

This would not allow users to build the AMS stuff without having I2C in
he kernel -- which is not really required.

What do you think about this patch?

---
diff -Nrup --exclude-from linux-exclude-from linux-2.6.18-rc3.orig/drivers/hwmon/Kconfig linux-2.6.18-rc3/drivers/hwmon/Kconfig
--- linux-2.6.18-rc3.orig/drivers/hwmon/Kconfig	2006-08-06 14:26:13.000000000 +0200
+++ linux-2.6.18-rc3/drivers/hwmon/Kconfig	2006-08-06 16:31:11.000000000 +0200
@@ -96,12 +96,14 @@ config SENSORS_ADM9240
 
 config SENSORS_AMS
 	tristate "Apple Motion Sensor driver"
-	depends on HWMON && PPC_PMAC && INPUT && EXPERIMENTAL
-	default y
+	depends on HWMON && PPC_PMAC && !PPC64 && INPUT && ((ADB_PMU && I2C = y) || (ADB_PMU && !I2C) || I2C) && EXPERIMENTAL
 	help
 	  Support for the motion sensor included in PowerBooks. Includes
 	  implementations for PMU and I2C.
 
+	  This driver can also be built as a module. If so, the module
+	  will be called ams.
+
 config SENSORS_AMS_PMU
 	bool "PMU variant"
 	depends on SENSORS_AMS && ADB_PMU
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060806/51eddd2b/attachment.bin 
