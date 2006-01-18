From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 18 Jan 2006 21:53:09 +0000
Subject: [lm-sensors] [PATCH 08/17] i2c: scx200_acb minimal documentation
Message-Id: <20060118225309.708129dd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Ben Gardner <bgardner at wabtec.com>
Content-Disposition: inline; filename=i2c-scx200_acb-07-docs.patch

scx200_acb: Minimal documentation update

Signed-off-by: Ben Gardner <bgardner at wabtec.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/i2c/busses/scx200_acb |    5 +++--
 drivers/i2c/busses/Kconfig          |    5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

--- linux-2.6.15-git.orig/Documentation/i2c/busses/scx200_acb	2006-01-08 19:26:27.000000000 +0100
+++ linux-2.6.15-git/Documentation/i2c/busses/scx200_acb	2006-01-11 20:22:55.000000000 +0100
@@ -6,9 +6,10 @@
 -----------------
 
 * base: int
-  Base addresses for the ACCESS.bus controllers
+  Base addresses for the ACCESS.bus controllers on SCx200 and SC1100 devices
 
 Description
 -----------
 
-Enable the use of the ACCESS.bus controllers of a SCx200 processor.
+Enable the use of the ACCESS.bus controller on the Geode SCx200 and
+SC1100 processors and the CS5535 and CS5536 Geode companion devices.
--- linux-2.6.15-git.orig/drivers/i2c/busses/Kconfig	2006-01-11 20:08:39.000000000 +0100
+++ linux-2.6.15-git/drivers/i2c/busses/Kconfig	2006-01-11 20:22:55.000000000 +0100
@@ -389,10 +389,11 @@
 	  also be specified with a module parameter.
 
 config SCx200_ACB
-	tristate "NatSemi SCx200 ACCESS.bus"
+	tristate "Geode ACCESS.bus support"
 	depends on I2C && PCI
 	help
-	  Enable the use of the ACCESS.bus controllers of a SCx200 processor.
+	  Enable the use of the ACCESS.bus controllers on the Geode SCx200 and
+	  SC1100 processors and the CS5535 and CS5536 Geode companion devices.
 
 	  If you don't know what to do here, say N.
 

-- 
Jean Delvare

