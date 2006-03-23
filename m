From: gregkh@suse.de (Greg KH)
Date: Thu, 23 Mar 2006 22:43:50 +0000
Subject: [lm-sensors] [PATCH 12/36] I2C: fix sx200_acb build on other arches
Message-Id: <1143153830454-git-send-email-gregkh@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

scx200_acb is only useful on a few Geode-based systems, and won't
compile on non-x86 systems due to the lack of asm/msr.h, as reported
by Andrew Morton. Thus, we should make that driver depend on X86.

Signed-off-by: Jean Delvare <khali at linux-fr.org>

---

 drivers/i2c/busses/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

cdf263f1c59cad9b1567e759890b9be044972856
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 1a3bf42..7d2705a 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -390,7 +390,7 @@ config SCx200_I2C_SDA
 
 config SCx200_ACB
 	tristate "Geode ACCESS.bus support"
-	depends on I2C && PCI
+	depends on X86_32 && I2C && PCI
 	help
 	  Enable the use of the ACCESS.bus controllers on the Geode SCx200 and
 	  SC1100 processors and the CS5535 and CS5536 Geode companion devices.
-- 
1.2.4



