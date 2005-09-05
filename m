From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:48:07 +0000
Subject: [lm-sensors] [PATCH] I2C: fix max6875 build error
Message-Id: <11259567643476@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: fix max6875 build error

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit a8decc658a8800e61f13b9240125f2a34d7fd3f5
tree d7e10599ca2b1ba2e992dd11c327fabdd2c45039
parent 93ffa435147abd47ebd7d7d24176b3c653aef940
author Greg Kroah-Hartman <gregkh@suse.de> Wed, 27 Jul 2005 12:43:03 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:04 -0700

 drivers/i2c/chips/max6875.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/chips/max6875.c b/drivers/i2c/chips/max6875.c
--- a/drivers/i2c/chips/max6875.c
+++ b/drivers/i2c/chips/max6875.c
@@ -93,8 +93,7 @@ static void max6875_update_slice(struct 
 	if (!(data->valid & (1 << slice)) ||
 	    time_after(jiffies, data->last_updated[slice])) {
 
-		dev_dbg(&client->dev, "Starting update of slice %u\n",
-			slice, blk->base);
+		dev_dbg(&client->dev, "Starting update of slice %u\n", slice);
 
 		data->valid &= ~(1 << slice);
 

