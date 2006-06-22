From: greg@kroah.com (Greg KH)
Date: Thu, 22 Jun 2006 18:27:59 +0000
Subject: [lm-sensors] [PATCH 33/44] [PATCH] scx200_acb: Mark
Message-Id: <11510010271908-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

In i2c bus driver scx200_acb, function scx200_acb_probe can be
tagged __init.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/busses/scx200_acb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
index 09b4586..22a3eda 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -384,7 +384,7 @@ static struct i2c_algorithm scx200_acb_a
 static struct scx200_acb_iface *scx200_acb_list;
 static DECLARE_MUTEX(scx200_acb_list_mutex);
 
-static int scx200_acb_probe(struct scx200_acb_iface *iface)
+static __init int scx200_acb_probe(struct scx200_acb_iface *iface)
 {
 	u8 val;
 
-- 
1.4.0


