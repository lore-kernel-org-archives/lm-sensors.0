From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 21 Jan 2006 09:05:41 +0000
Subject: [lm-sensors] scx200_acb compilation breakage
Message-Id: <20060121100541.7db4835f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060120210612.6bcb6e8e.khali@linux-fr.org>
In-Reply-To: <20060120210612.6bcb6e8e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

> The scx200/CS5535/etc only exist with/on the Geode processor, which is
> x86.
> So, I think the best option is to make it depend on X86.

OK, here's a patch then:

scx200_acb is only useful on a few Geode-based systems, and won't
compile on non-x86 systems due to the lack of asm/msr.h, as reported
by Andrew Morton. Thus, we should make that driver depend on X86.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/busses/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16-rc1.orig/drivers/i2c/busses/Kconfig	2006-01-20 19:50:19.000000000 +0100
+++ linux-2.6.16-rc1/drivers/i2c/busses/Kconfig	2006-01-21 09:57:55.000000000 +0100
@@ -390,7 +390,7 @@
 
 config SCx200_ACB
 	tristate "Geode ACCESS.bus support"
-	depends on I2C && PCI
+	depends on I2C && PCI && X86
 	help
 	  Enable the use of the ACCESS.bus controllers on the Geode SCx200 and
 	  SC1100 processors and the CS5535 and CS5536 Geode companion devices.

I'll post it shortly on LKML as a reply to Andrew's 2.6.16-rc1-mm2
announce.

Thanks,
-- 
Jean Delvare

