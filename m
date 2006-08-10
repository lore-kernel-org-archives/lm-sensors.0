From: linux-kernel@hansmi.ch (Michael Hanselmann)
Date: Thu, 10 Aug 2006 18:33:32 +0000
Subject: [lm-sensors] [PATCH] Apple Motion Sensor driver
Message-Id: <20060810183332.GB10257@hansmi.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060802191520.GA2260@hansmi.ch>
In-Reply-To: <20060802191520.GA2260@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Aug 06, 2006 at 01:41:02PM +0200, Johannes Berg wrote:
> On Wed, 2006-08-02 at 21:15 +0200, Michael Hanselmann wrote:

> > +config SENSORS_AMS
> > +       tristate "Apple Motion Sensor driver"
> > +       depends on HWMON && PPC_PMAC && INPUT && EXPERIMENTAL

> This causes the build failure, because now SENSORS_AMS can be 'y' while 

Andrew, can you please apply the patch below? It fixes wrong Kconfig
dependencies.

Signed-off-by: Michael Hanselmann <linux-kernel at hansmi.ch>

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

