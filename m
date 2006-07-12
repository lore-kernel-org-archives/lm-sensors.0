From: greg@kroah.com (Greg KH)
Date: Wed, 12 Jul 2006 23:27:17 +0000
Subject: [lm-sensors] [PATCH 5/13] [PATCH] i2c-powermac: Fix master_xfer
Message-Id: <11527468582828-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

Fix the value returned by the i2c-powermac's master_xfer method.
It should return the number of messages processed successfully, but
instead returns the number of data bytes in the first (and only)
processed message.

Also explicitly mention the master_xfer convention so that future
implementations get it right directly.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Acked-by: Benjamin Herrenschmidt <benh at kernel.crashing.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/busses/i2c-powermac.c |    4 +---
 include/linux/i2c.h               |    2 ++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index 2a0b3be..53bb435 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -148,8 +148,6 @@ static int i2c_powermac_master_xfer(	str
 	int			read;
 	int			addrdir;
 
-	if (num != 1)
-		return -EINVAL;
 	if (msgs->flags & I2C_M_TEN)
 		return -EINVAL;
 	read = (msgs->flags & I2C_M_RD) != 0;
@@ -166,7 +164,7 @@ static int i2c_powermac_master_xfer(	str
 	rc = pmac_i2c_xfer(bus, addrdir, 0, 0, msgs->buf, msgs->len);
  bail:
 	pmac_i2c_close(bus);
-	return rc < 0 ? rc : msgs->len;
+	return rc < 0 ? rc : 1;
 }
 
 static u32 i2c_powermac_func(struct i2c_adapter * adapter)
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 526ddc8..eb0628a 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -193,6 +193,8 @@ struct i2c_algorithm {
 	   to NULL. If an adapter algorithm can do SMBus access, set 
 	   smbus_xfer. If set to NULL, the SMBus protocol is simulated
 	   using common I2C messages */
+	/* master_xfer should return the number of messages successfully
+	   processed, or a negative value on error */
 	int (*master_xfer)(struct i2c_adapter *adap,struct i2c_msg *msgs, 
 	                   int num);
 	int (*smbus_xfer) (struct i2c_adapter *adap, u16 addr, 
-- 
1.4.1


