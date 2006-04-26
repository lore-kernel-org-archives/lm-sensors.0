From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 26 Apr 2006 20:50:32 +0000
Subject: [lm-sensors] [PATCH] scx200_acb: Fix return on init error
Message-Id: <20060426225032.12794c0d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This should go in 2.6.17.

Content-Disposition: inline; filename=i2c-scx200_acb-fix-return-on-init-error.patch

The scx200_acb driver shouldn't return failure after initialization
if it successfully registered at least one i2c_adapter, else we are
leaking resources. The driver was OK in that respect up to 2.6.16, a
recent change broke it.

This is part of the fix to bug #6445.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Cc: Ben Gardner <bgardner at wabtec.com>
---
 drivers/i2c/busses/scx200_acb.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.17-rc2.orig/drivers/i2c/busses/scx200_acb.c	2006-04-03 20:12:42.000000000 +0200
+++ linux-2.6.17-rc2/drivers/i2c/busses/scx200_acb.c	2006-04-26 18:59:23.000000000 +0200
@@ -524,6 +524,9 @@
 	} else if (pci_dev_present(divil_pci))
 		rc = scx200_add_cs553x();
 
+	/* If at least one bus was created, init must succeed */
+	if (scx200_acb_list)
+		return 0;
 	return rc;
 }
 


-- 
Jean Delvare

