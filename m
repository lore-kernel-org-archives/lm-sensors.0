From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 24 May 2006 07:06:43 +0000
Subject: [lm-sensors] [PATCH] i2c: Incorrect section use in scx200_acb
Message-Id: <20060524090643.b0c8a288.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix an incorrect section use in i2c bus driver scx200_acb.

WARNING: drivers/i2c/busses/scx200_acb.o - Section mismatch:
reference to .init.text: from .text after 'scx200_add_cs553x'
(at offset 0x709)

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/busses/scx200_acb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17-rc4.orig/drivers/i2c/busses/scx200_acb.c	2006-05-23 17:07:11.000000000 +0200
+++ linux-2.6.17-rc4/drivers/i2c/busses/scx200_acb.c	2006-05-23 18:47:48.000000000 +0200
@@ -491,7 +491,7 @@
 
 #define MSR_LBAR_SMB		0x5140000B
 
-static int scx200_add_cs553x(void)
+static int __init scx200_add_cs553x(void)
 {
 	u32	low, hi;
 	u32	smb_base;


-- 
Jean Delvare

