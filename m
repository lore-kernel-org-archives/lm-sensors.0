From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [patch 1/1] Remove redundancy from i2c-core.c
Message-Id: <20050507225846.2c22597d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, Andrew, Corey,

> Andrew, please drop this from your tree.  Jean is working on a better
> version of this patch, and I'll just wait for him.

Here it is, sorry for the delay (I took a few days off AFK, made be some
good). "Better" here means that I made some coding style cleanups, which
were missing from Corey's original patch, nothing more. 

Thanks.

---

Call i2c_transfer() from i2c_master_send() and i2c_master_recv() to
avoid the redundant code that was in all three functions.  It also
removes unnecessary debug statements as suggested by Jean Delvare.

This is important for the non-blocking interfaces because they will
have to handle a non-blocking interface in this area.  Having it in
one place greatly simplifies the changes.

Signed-off-by: Corey Minyard <minyard@acm.org>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/i2c-core.c |   64 +++++++++++++++----------------------------------
 1 files changed, 20 insertions(+), 44 deletions(-)

--- linux-2.6.12-rc4.orig/drivers/i2c/i2c-core.c	2005-05-07 18:57:00.000000000 +0200
+++ linux-2.6.12-rc4/drivers/i2c/i2c-core.c	2005-05-07 18:59:10.000000000 +0200
@@ -611,27 +611,16 @@
 	struct i2c_adapter *adap=client->adapter;
 	struct i2c_msg msg;
 
-	if (client->adapter->algo->master_xfer) {
-		msg.addr   = client->addr;
-		msg.flags = client->flags & I2C_M_TEN;
-		msg.len = count;
-		msg.buf = (char *)buf;
+	msg.addr = client->addr;
+	msg.flags = client->flags & I2C_M_TEN;
+	msg.len = count;
+	msg.buf = (char *)buf;
 	
-		dev_dbg(&client->adapter->dev, "master_send: writing %d bytes.\n",
-			count);
-	
-		down(&adap->bus_lock);
-		ret = adap->algo->master_xfer(adap,&msg,1);
-		up(&adap->bus_lock);
-
-		/* if everything went ok (i.e. 1 msg transmitted), return #bytes
-		 * transmitted, else error code.
-		 */
-		return (ret = 1 )? count : ret;
-	} else {
-		dev_err(&client->adapter->dev, "I2C level transfers not supported\n");
-		return -ENOSYS;
-	}
+	ret = i2c_transfer(adap, &msg, 1);
+
+	/* If everything went ok (i.e. 1 msg transmitted), return #bytes
+	   transmitted, else error code. */
+	return (ret = 1) ? count : ret;
 }
 
 int i2c_master_recv(struct i2c_client *client, char *buf ,int count)
@@ -639,31 +628,18 @@
 	struct i2c_adapter *adap=client->adapter;
 	struct i2c_msg msg;
 	int ret;
-	if (client->adapter->algo->master_xfer) {
-		msg.addr   = client->addr;
-		msg.flags = client->flags & I2C_M_TEN;
-		msg.flags |= I2C_M_RD;
-		msg.len = count;
-		msg.buf = buf;
 
-		dev_dbg(&client->adapter->dev, "master_recv: reading %d bytes.\n",
-			count);
-	
-		down(&adap->bus_lock);
-		ret = adap->algo->master_xfer(adap,&msg,1);
-		up(&adap->bus_lock);
-	
-		dev_dbg(&client->adapter->dev, "master_recv: return:%d (count:%d, addr:0x%02x)\n",
-			ret, count, client->addr);
-	
-		/* if everything went ok (i.e. 1 msg transmitted), return #bytes
-	 	* transmitted, else error code.
-	 	*/
-		return (ret = 1 )? count : ret;
-	} else {
-		dev_err(&client->adapter->dev, "I2C level transfers not supported\n");
-		return -ENOSYS;
-	}
+	msg.addr = client->addr;
+	msg.flags = client->flags & I2C_M_TEN;
+	msg.flags |= I2C_M_RD;
+	msg.len = count;
+	msg.buf = buf;
+
+	ret = i2c_transfer(adap, &msg, 1);
+
+	/* If everything went ok (i.e. 1 msg transmitted), return #bytes
+	   transmitted, else error code. */
+	return (ret = 1) ? count : ret;
 }
 
 

-- 
Jean Delvare
