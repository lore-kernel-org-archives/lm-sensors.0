From: gregkh@suse.de (Greg KH)
Date: Tue, 12 Jul 2005 00:04:36 +0000
Subject: [lm-sensors] [PATCH] I2C: m41t00: fix incorrect kfree
Message-Id: <1121119376361@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11211193763732@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Cc: khali@linux-fr.org

[PATCH] I2C: m41t00: fix incorrect kfree

Here is a simple path fixing an incorrect kfree in the m41t00 i2c chip
driver. The current code happens to work by accident, but the freed
pointer isn't the one which was allocated in the first place, which
could cause problems later.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 5da69ba42aa42a479c0f5d8cb8351ebb6b51c12e
tree 3a0f32c3fbc961bb5f6b39c22c573fa8acd7c443
parent 2146fec20c38d926f0d88413977f941f42a14588
author Jean Delvare <khali@linux-fr.org> Fri, 01 Jul 2005 14:28:15 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 11 Jul 2005 14:10:36 -0700

 drivers/i2c/chips/m41t00.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/chips/m41t00.c b/drivers/i2c/chips/m41t00.c
--- a/drivers/i2c/chips/m41t00.c
+++ b/drivers/i2c/chips/m41t00.c
@@ -207,7 +207,7 @@ m41t00_detach(struct i2c_client *client)
 	int	rc;
 
 	if ((rc = i2c_detach_client(client)) = 0) {
-		kfree(i2c_get_clientdata(client));
+		kfree(client);
 		tasklet_kill(&m41t00_tasklet);
 	}
 	return rc;

