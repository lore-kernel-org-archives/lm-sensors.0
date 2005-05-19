From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: [PATCH 2.6] Fix SCx200 dependancies
Message-Id: <20031224173043.4904eaf2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

The following patch fixes incorrect dependencies (as far as I can see)
for the SCx200 modules. A similar patch (with even more fixes) is also
needed for Linux 2.4, and will be part of my next wave to Marcelo. Note
that I don't have the necessary hardware to actually test anything, but
a quick look at the code doesn't leave much place for doubt IMHO.
Comments welcome.

--- linux-2.6.0/drivers/i2c/busses/Kconfig.orig	2003-12-18 03:59:28.000000000 +0100
+++ linux-2.6.0/drivers/i2c/busses/Kconfig	2003-12-24 11:55:17.000000000 +0100
@@ -201,7 +201,7 @@
 
 config SCx200_I2C
 	tristate "NatSemi SCx200 I2C using GPIO pins"
-	depends on SCx200 && I2C_ALGOBIT
+	depends on SCx200_GPIO && I2C_ALGOBIT
 	help
 	  Enable the use of two GPIO pins of a SCx200 processor as an I2C bus.
 
@@ -228,7 +228,7 @@
 
 config SCx200_ACB
 	tristate "NatSemi SCx200 ACCESS.bus"
-	depends on I2C_ALGOBIT!=n && I2C
+	depends on I2C
 	help
 	  Enable the use of the ACCESS.bus controllers of a SCx200 processor.
 


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
