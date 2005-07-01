From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 01 Jul 2005 14:29:08 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: m41t00: fix incorrect kfree
Message-Id: <20050701142815.751f28d2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here is a simple path fixing an incorrect kfree in the m41t00 i2c chip
driver. The current code happens to work by accident, but the freed
pointer isn't the one which was allocated in the first place, which
could cause problems later.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/chips/m41t00.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.13-rc1.orig/drivers/i2c/chips/m41t00.c	2005-06-29 18:29:43.000000000 +0200
+++ linux-2.6.13-rc1/drivers/i2c/chips/m41t00.c	2005-06-29 18:46:05.000000000 +0200
@@ -207,7 +207,7 @@
 	int	rc;
 
 	if ((rc = i2c_detach_client(client)) = 0) {
-		kfree(i2c_get_clientdata(client));
+		kfree(client);
 		tasklet_kill(&m41t00_tasklet);
 	}
 	return rc;

-- 
Jean Delvare
