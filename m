From: Dean Nelson <dnelson@redhat.com>
Date: Mon, 25 Jul 2011 19:52:07 +0000
Subject: [lm-sensors] [PATCH] hwmon: (KConfig) avoid building drivers for
Message-Id: <20110725195206.4097.45688.email-sent-by-dnelson@localhost6.localdomain6>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

A modprobe of hwmon drivers that read/write ISA addresses on a powerpc results
in a kernel Oops. These read/writes are being done via the inb()/in_8() and
outb()/out_8() macros.

This patch prevents these drivers from being built for powerpc.

Signed-off-by: Dean Nelson <dnelson@redhat.com>
Cc: stable@kernel.org
---
 drivers/hwmon/Kconfig |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 5f888f7..f2e8126 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -315,6 +315,7 @@ config SENSORS_I5K_AMB
 
 config SENSORS_F71805F
 	tristate "Fintek F71805F/FG, F71806F/FG and F71872F/FG"
+	depends on !PPC
 	help
 	  If you say yes here you get support for hardware monitoring
 	  features of the Fintek F71805F/FG, F71806F/FG and F71872F/FG
@@ -325,6 +326,7 @@ config SENSORS_F71805F
 
 config SENSORS_F71882FG
 	tristate "Fintek F71882FG and compatibles"
+	depends on !PPC
 	help
 	  If you say yes here you get support for hardware monitoring
 	  features of many Fintek Super-I/O (LPC) chips. The currently
@@ -448,6 +450,7 @@ config SENSORS_IBMPEX
 
 config SENSORS_IT87
 	tristate "ITE IT87xx and compatibles"
+	depends on !PPC
 	select HWMON_VID
 	help
 	  If you say yes here you get support for ITE IT8705F, IT8712F,
@@ -769,6 +772,7 @@ config SENSORS_MAX6650
 
 config SENSORS_PC87360
 	tristate "National Semiconductor PC87360 family"
+	depends on !PPC
 	select HWMON_VID
 	help
 	  If you say yes here you get access to the hardware monitoring
@@ -782,6 +786,7 @@ config SENSORS_PC87360
 
 config SENSORS_PC87427
 	tristate "National Semiconductor PC87427"
+	depends on !PPC
 	help
 	  If you say yes here you get access to the hardware monitoring
 	  functions of the National Semiconductor PC87427 Super-I/O chip.
@@ -933,7 +938,7 @@ config SENSORS_S3C_RAW
 
 config SENSORS_SIS5595
 	tristate "Silicon Integrated Systems Corp. SiS5595"
-	depends on PCI
+	depends on PCI && !PPC
 	help
 	  If you say yes here you get support for the integrated sensors in
 	  SiS5595 South Bridges.
@@ -958,7 +963,7 @@ config SENSORS_SMM665
 
 config SENSORS_DME1737
 	tristate "SMSC DME1737, SCH311x and compatibles"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C && EXPERIMENTAL && !PPC
 	select HWMON_VID
 	help
 	  If you say yes here you get support for the hardware monitoring
@@ -1000,6 +1005,7 @@ config SENSORS_EMC6W201
 
 config SENSORS_SMSC47M1
 	tristate "SMSC LPC47M10x and compatibles"
+	depends on !PPC
 	help
 	  If you say yes here you get support for the integrated fan
 	  monitoring and control capabilities of the SMSC LPC47B27x,
@@ -1033,7 +1039,7 @@ config SENSORS_SMSC47M192
 
 config SENSORS_SMSC47B397
 	tristate "SMSC LPC47B397-NC"
-	depends on EXPERIMENTAL
+	depends on EXPERIMENTAL && !PPC
 	help
 	  If you say yes here you get support for the SMSC LPC47B397-NC
 	  sensor chip.
@@ -1159,6 +1165,7 @@ config SENSORS_VIA686A
 
 config SENSORS_VT1211
 	tristate "VIA VT1211"
+	depends on !PPC
 	select HWMON_VID
 	help
 	  If you say yes here then you get support for hardware monitoring
@@ -1271,6 +1278,7 @@ config SENSORS_W83L786NG
 
 config SENSORS_W83627HF
 	tristate "Winbond W83627HF, W83627THF, W83637HF, W83687THF, W83697HF"
+	depends on !PPC
 	select HWMON_VID
 	help
 	  If you say yes here you get support for the Winbond W836X7 series
@@ -1282,6 +1290,7 @@ config SENSORS_W83627HF
 
 config SENSORS_W83627EHF
 	tristate "Winbond W83627EHF/EHG/DHG, W83667HG, NCT6775F, NCT6776F"
+	depends on !PPC
 	select HWMON_VID
 	help
 	  If you say yes here you get support for the hardware

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
