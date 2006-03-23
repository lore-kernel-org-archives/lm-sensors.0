From: gregkh@suse.de (Greg KH)
Date: Thu, 23 Mar 2006 22:43:50 +0000
Subject: [lm-sensors] [PATCH 11/36] i2c: scx200_acb minimal documentation
Message-Id: <11431538301689-git-send-email-gregkh@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

scx200_acb: Minimal documentation update

Signed-off-by: Ben Gardner <bgardner at wabtec.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---

 Documentation/i2c/busses/scx200_acb |    5 +++--
 drivers/i2c/busses/Kconfig          |    5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

a417bbd33b2ed7a3b2bc78cbadb820079d453328
diff --git a/Documentation/i2c/busses/scx200_acb b/Documentation/i2c/busses/scx200_acb
index 08c8cd1..f50e699 100644
--- a/Documentation/i2c/busses/scx200_acb
+++ b/Documentation/i2c/busses/scx200_acb
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
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index ff92735..1a3bf42 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -389,10 +389,11 @@ config SCx200_I2C_SDA
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
1.2.4



