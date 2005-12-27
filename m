From: gardner.ben@gmail.com (Ben Gardner)
Date: Tue, 27 Dec 2005 20:07:28 +0000
Subject: [lm-sensors] [PATCH 7/7] i2c: scx200_acb - documentation update
Message-Id: <808c8e9d0512271207i1806c6cch7a113e6ab75f3523@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <808c8e9d0512191100jaa8005fjc8977a1268675e92@mail.gmail.com>
In-Reply-To: <808c8e9d0512191100jaa8005fjc8977a1268675e92@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

scx200_acb: Minimal documentation update

Signed-off-by: Ben Gardner <bgardner at wabtec.com>
---
New and improved - now includes Kconfig updates!
-------------- next part --------------
 Documentation/i2c/busses/scx200_acb |    5 +++--
 drivers/i2c/busses/Kconfig          |    5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

--- linux-2.6.15-rc5-mm3.orig/Documentation/i2c/busses/scx200_acb
+++ linux-2.6.15-rc5-mm3/Documentation/i2c/busses/scx200_acb
@@ -6,9 +6,10 @@ Module Parameters
 -----------------
 
 * base: int
-  Base addresses for the ACCESS.bus controllers
+  Base addresses for the ACCESS.bus controllers on SCx200 and SC1100 devices
 
 Description
 -----------
 
-Enable the use of the ACCESS.bus controllers of a SCx200 processor.
+Enable the use of the ACCESS.bus controller on the Geode SCx200 and
+SC1100 processors and the CS5535 and CS5536 Geode companion devices.
--- linux-2.6.15-rc5-mm3.orig/drivers/i2c/busses/Kconfig
+++ linux-2.6.15-rc5-mm3/drivers/i2c/busses/Kconfig
@@ -398,10 +398,11 @@ config SCx200_I2C_SDA
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
 
