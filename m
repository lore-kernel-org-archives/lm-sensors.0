From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 12 Jun 2006 19:46:04 +0000
Subject: [lm-sensors] [PATCH 04/14] scx200_acb: Mark scx200_acb_probe __init
Message-Id: <20060612214604.3050e740.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-scx200_acb-mark-scx200_acb_probe-init.patch

In i2c bus driver scx200_acb, function scx200_acb_probe can be
tagged __init.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/busses/scx200_acb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17-rc6.orig/drivers/i2c/busses/scx200_acb.c	2006-06-11 14:51:21.000000000 +0200
+++ linux-2.6.17-rc6/drivers/i2c/busses/scx200_acb.c	2006-06-11 14:54:02.000000000 +0200
@@ -384,7 +384,7 @@
 static struct scx200_acb_iface *scx200_acb_list;
 static DECLARE_MUTEX(scx200_acb_list_mutex);
 
-static int scx200_acb_probe(struct scx200_acb_iface *iface)
+static __init int scx200_acb_probe(struct scx200_acb_iface *iface)
 {
 	u8 val;
 

-- 
Jean Delvare

