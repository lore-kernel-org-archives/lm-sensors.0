From: greg@kroah.com (Greg KH)
Date: Wed, 27 Sep 2006 01:01:42 +0000
Subject: [lm-sensors] [PATCH 11/30] i2c-au1550: Add I2C support for Au1200
Message-Id: <11593189553268-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Domen Puncer <domen.puncer at ultra.si>

i2c-au1550: Add I2C support for Au1200

Signed-off-by: Domen Puncer <domen.puncer at ultra.si>
Signed-off-by: Ralf Baechle <ralf at linux-mips.org>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/busses/Kconfig      |    6 +++---
 drivers/i2c/busses/i2c-au1550.c |    3 +--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 884320e..404508c 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -75,11 +75,11 @@ config I2C_AMD8111
 	  will be called i2c-amd8111.
 
 config I2C_AU1550
-	tristate "Au1550 SMBus interface"
-	depends on I2C && SOC_AU1550
+	tristate "Au1550/Au1200 SMBus interface"
+	depends on I2C && (SOC_AU1550 || SOC_AU1200)
 	help
 	  If you say yes to this option, support will be included for the
-	  Au1550 SMBus interface.
+	  Au1550 and Au1200 SMBus interface.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-au1550.
diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
index 7140eb0..7a005dd 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -34,8 +34,7 @@ #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
 
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-pb1x00/pb1550.h>
+#include <asm/mach-au1x00/au1xxx.h>
 #include <asm/mach-au1x00/au1xxx_psc.h>
 
 #include "i2c-au1550.h"
-- 
1.4.2.1


