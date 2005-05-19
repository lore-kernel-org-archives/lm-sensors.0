From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: [PATCH] i2c driver fixes for 2.6.1
Message-Id: <10745567642211@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10745567643883@kroah.com>
References: <1074556757661@kroah.com>
In-Reply-To: <1074556757661@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1474.98.17, 2004/01/16 14:12:27-08:00, khali@linux-fr.org

[PATCH] I2C: clean up ISA dependancies

Quoting myself:

> 1* Elektor depends on ISA.
> 2* ELV and Velleman do not depend on ISA.
> 3* i2c-isa is M by default, and has an additional help text
> 4* via686a autoselects i2c-isa
> 5* i2c-isa doesn't depend on ISA

Here's the patch:


 drivers/i2c/busses/Kconfig |    6 +++---
 drivers/i2c/chips/Kconfig  |    1 +
 2 files changed, 4 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Jan 19 15:30:05 2004
+++ b/drivers/i2c/busses/Kconfig	Mon Jan 19 15:30:05 2004
@@ -49,7 +49,7 @@
 
 config I2C_ELEKTOR
 	tristate "Elektor ISA card"
-	depends on I2C_ALGOPCF && BROKEN_ON_SMP
+	depends on I2C_ALGOPCF && ISA && BROKEN_ON_SMP
 	help
 	  This supports the PCF8584 ISA bus I2C adapter.  Say Y if you own
 	  such an adapter.
@@ -59,7 +59,7 @@
 
 config I2C_ELV
 	tristate "ELV adapter"
-	depends on I2C_ALGOBIT && ISA
+	depends on I2C_ALGOBIT
 	help
 	  This supports parallel-port I2C adapters called ELV.  Say Y if you
 	  own such an adapter.
@@ -321,7 +321,7 @@
 
 config I2C_VELLEMAN
 	tristate "Velleman K8000 adapter"
-	depends on I2C_ALGOBIT && ISA
+	depends on I2C_ALGOBIT
 	help
 	  This supports the Velleman K8000 parallel-port I2C adapter.  Say Y
 	  if you own such an adapter.
diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	Mon Jan 19 15:30:05 2004
+++ b/drivers/i2c/chips/Kconfig	Mon Jan 19 15:30:05 2004
@@ -117,6 +117,7 @@
 	tristate "VIA686A"
 	depends on I2C && EXPERIMENTAL
 	select I2C_SENSOR
+	select I2C_ISA
 	help
 	  If you say yes here you get support for the integrated sensors in
 	  Via 686A/B South Bridges.

