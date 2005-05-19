From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: Linux 2.6 and CONFIG_ISA
Message-Id: <20040116191502.348b1830.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1074005072.400404506dd11@imp.gcu.info>
In-Reply-To: <1074005072.400404506dd11@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting myself:

> 1* Elektor depends on ISA.
> 2* ELV and Velleman do not depend on ISA.
> 3* i2c-isa is M by default, and has an additional help text
> 4* via686a autoselects i2c-isa
> 5* i2c-isa doesn't depend on ISA

Here's the patch:

diff -ru linux-2.6.1-g1/drivers/i2c/busses/Kconfig linux-2.6.1-g1-k1/drivers/i2c/busses/Kconfig
--- linux-2.6.1-g1/drivers/i2c/busses/Kconfig	2004-01-16 11:03:45.000000000 +0100
+++ linux-2.6.1-g1-k1/drivers/i2c/busses/Kconfig	2004-01-16 11:52:21.000000000 +0100
@@ -48,7 +48,7 @@
 
 config I2C_ELEKTOR
 	tristate "Elektor ISA card"
-	depends on I2C_ALGOPCF && BROKEN_ON_SMP
+	depends on I2C_ALGOPCF && ISA && BROKEN_ON_SMP
 	help
 	  This supports the PCF8584 ISA bus I2C adapter.  Say Y if you own
 	  such an adapter.
@@ -58,7 +58,7 @@
 
 config I2C_ELV
 	tristate "ELV adapter"
-	depends on I2C_ALGOBIT && ISA
+	depends on I2C_ALGOBIT
 	help
 	  This supports parallel-port I2C adapters called ELV.  Say Y if you
 	  own such an adapter.
@@ -107,11 +107,16 @@
 
 config I2C_ISA
 	tristate "ISA Bus support"
-	depends on I2C && ISA && EXPERIMENTAL
+	depends on I2C && EXPERIMENTAL
+	default m
 	help
 	  If you say yes to this option, support will be included for i2c
 	  interfaces that are on the ISA bus.
 
+	  The ISA bus exists in your computer even if you don't have ISA slots.
+	  It is very common to find hardware monitoring chips there, so you
+	  should say yes here.
+
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-isa.
 
@@ -320,7 +325,7 @@
 
 config I2C_VELLEMAN
 	tristate "Velleman K8000 adapter"
-	depends on I2C_ALGOBIT && ISA
+	depends on I2C_ALGOBIT
 	help
 	  This supports the Velleman K8000 parallel-port I2C adapter.  Say Y
 	  if you own such an adapter.
diff -ru linux-2.6.1-g1/drivers/i2c/chips/Kconfig linux-2.6.1-g1-k1/drivers/i2c/chips/Kconfig
--- linux-2.6.1-g1/drivers/i2c/chips/Kconfig	2004-01-16 11:03:45.000000000 +0100
+++ linux-2.6.1-g1-k1/drivers/i2c/chips/Kconfig	2004-01-16 11:52:21.000000000 +0100
@@ -116,6 +116,7 @@
 	tristate "VIA686A"
 	depends on I2C && EXPERIMENTAL
 	select I2C_SENSOR
+	select I2C_ISA
 	help
 	  If you say yes here you get support for the integrated sensors in
 	  Via 686A/B South Bridges.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
