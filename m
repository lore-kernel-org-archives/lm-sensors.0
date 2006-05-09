From: greg@kroah.com (Greg KH)
Date: Tue, 09 May 2006 20:08:24 +0000
Subject: [lm-sensors] [PATCH 1/3] scx200_acb: Fix return on init error
Message-Id: <1147205306130-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

The scx200_acb driver shouldn't return failure after initialization
if it successfully registered at least one i2c_adapter, else we are
leaking resources. The driver was OK in that respect up to 2.6.16, a
recent change broke it.

This is part of the fix to bug #6445.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Cc: Ben Gardner <bgardner at wabtec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---

 drivers/i2c/busses/scx200_acb.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

6f9c2963888e60e46a9e0bd09a25740abce29262
diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
index 8bd305e..f2dae68 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -524,6 +524,9 @@ static int __init scx200_acb_init(void)
 	} else if (pci_dev_present(divil_pci))
 		rc = scx200_add_cs553x();
 
+	/* If at least one bus was created, init must succeed */
+	if (scx200_acb_list)
+		return 0;
 	return rc;
 }
 
-- 
1.3.2


