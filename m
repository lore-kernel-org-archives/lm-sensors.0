From: rdunlap@xenotime.net (Randy.Dunlap)
Date: Thu, 25 May 2006 17:01:38 +0000
Subject: [lm-sensors] [PATCH] scx200_acb: fix section mismatch warning
Message-Id: <20060525100138.cb9e53c5.rdunlap@xenotime.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ismail@pardus.org.tr, khali@linux-fr.org, akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

From: Randy Dunlap <rdunlap at xenotime.net>

Fix section mismatch warning reported by ?smail D?nmez:
WARNING: drivers/i2c/busses/scx200_acb.o - Section mismatch: reference
to .init.text: from .text after 'scx200_add_cs553x' (at offset 0x528)

Signed-off-by: Randy Dunlap <rdunlap at xenotime.net>
---
 drivers/i2c/busses/scx200_acb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2617-rc5.orig/drivers/i2c/busses/scx200_acb.c
+++ linux-2617-rc5/drivers/i2c/busses/scx200_acb.c
@@ -491,7 +491,7 @@ static struct pci_device_id divil_pci[] 
 
 #define MSR_LBAR_SMB		0x5140000B
 
-static int scx200_add_cs553x(void)
+static __init int scx200_add_cs553x(void)
 {
 	u32	low, hi;
 	u32	smb_base;


---

