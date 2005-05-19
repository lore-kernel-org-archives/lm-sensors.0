From: matthew@wil.cx (Matthew Wilcox)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: [PATCH] Some I2C chipsets are architecture-specific
Message-Id: <20050307153256.GG28741@parcelfarce.linux.theplanet.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Some of the i2c chipsets look architecture specific, so don't trouble
other architectures with these questions.  It's quite possible I'm
mistaken, so please double-check.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

Index: ./drivers/i2c/chips/Kconfig
=================================RCS file: /var/cvs/linux-2.6/drivers/i2c/chips/Kconfig,v
retrieving revision 1.17
diff -u -p -r1.17 Kconfig
--- ./drivers/i2c/chips/Kconfig	12 Jan 2005 20:16:25 -0000	1.17
+++ ./drivers/i2c/chips/Kconfig	7 Mar 2005 04:52:24 -0000
@@ -53,7 +53,7 @@ config SENSORS_ADM1031
 
 config SENSORS_ASB100
 	tristate "Asus ASB100 Bach"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C && X86 && EXPERIMENTAL
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for the ASB100 Bach sensor
@@ -266,7 +266,7 @@ config SENSORS_SMSC47M1
 
 config SENSORS_VIA686A
 	tristate "VIA686A"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on I2C && X86 && PCI && EXPERIMENTAL
 	select I2C_SENSOR
 	select I2C_ISA
 	help

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
