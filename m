From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 15 Nov 2011 04:14:34 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (pmbus) Fix two issues
Message-Id: <20111115041434.GA29403@ericsson.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
List-Id: <lm-sensors.vger.kernel.org>
References: <1321249266-17071-1-git-send-email-Yuantian.Tang@freescale.com>
In-Reply-To: <1321249266-17071-1-git-send-email-Yuantian.Tang@freescale.com>
To: lm-sensors@vger.kernel.org

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Nov 14, 2011 at 09:58:03PM -0500, Tang Yuantian-B29983 wrote:
> 
> 
> > -----Original Message-----
> > From: Guenter Roeck [mailto:guenter.roeck@ericsson.com]
> > Hmm ... looking into the code, I2C_FUNC_SMBUS_READ_BLOCK_DATA is missing
> > from I2C_FUNC_SMBUS_EMUL.
> > Now that is interesting.
> > 
> > If you change mpc_functionality() to
> > 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
> > I2C_FUNC_SMBUS_READ_BLOCK_DATA; I bet your problem will disappear.
> > 
> > Jean, any idea why I2C_FUNC_SMBUS_EMUL doesn't include
> > I2C_FUNC_SMBUS_READ_BLOCK_DATA ?
> > 
> [Yuantian:] unfortunately no, Even I add I2C_FUNC_SMBUS_READ_BLOCK_DATA support,
> The return value is not correct.
> 
Actually, you are right. The i2c-mpc driver would also have to handle the I2C_M_RECV_LEN
flag, where the 1st received byte indicates the receive length. That would probably require
a change in mpc_read(), telling it that the first byte to be received is the length.
Something like the attached. Completely untested, of course ...

Guenter

--ew6BAiZeqk4r7MaW
Content-Type: text/x-diff; charset="us-ascii"
Content-Disposition: attachment; filename="mpc.patch"

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 107397a..77aade7 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -454,7 +454,7 @@ static int mpc_write(struct mpc_i2c *i2c, int target,
 }
 
 static int mpc_read(struct mpc_i2c *i2c, int target,
-		    u8 *data, int length, int restart)
+		    u8 *data, int length, int restart, bool block)
 {
 	unsigned timeout = i2c->adap.timeout;
 	int i, result;
@@ -470,7 +470,7 @@ static int mpc_read(struct mpc_i2c *i2c, int target,
 		return result;
 
 	if (length) {
-		if (length == 1)
+		if (length == 1 && !block)
 			writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA | CCR_TXAK);
 		else
 			writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA);
@@ -479,17 +479,28 @@ static int mpc_read(struct mpc_i2c *i2c, int target,
 	}
 
 	for (i = 0; i < length; i++) {
+		u8 byte;
+
 		result = i2c_wait(i2c, timeout, 0);
 		if (result < 0)
 			return result;
 
+		byte = readb(i2c->base + MPC_I2C_DR);
+		/*
+		 * Adjust length if first received byte is length
+		 */
+		if (i == 0 && block) {
+			if (byte == 0 || byte > I2C_SMBUS_BLOCK_MAX)
+				return -EPROTO;
+			length += byte;
+		}
+		data[i] = byte;
 		/* Generate txack on next to last byte */
 		if (i == length - 2)
 			writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA | CCR_TXAK);
 		/* Do not generate stop on last byte */
 		if (i == length - 1)
 			writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA | CCR_MTX);
-		data[i] = readb(i2c->base + MPC_I2C_DR);
 	}
 
 	return length;
@@ -532,12 +543,17 @@ static int mpc_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 			"Doing %s %d bytes to 0x%02x - %d of %d messages\n",
 			pmsg->flags & I2C_M_RD ? "read" : "write",
 			pmsg->len, pmsg->addr, i + 1, num);
-		if (pmsg->flags & I2C_M_RD)
-			ret =
-			    mpc_read(i2c, pmsg->addr, pmsg->buf, pmsg->len, i);
-		else
+		if (pmsg->flags & I2C_M_RD) {
+			bool block = pmsg->flags & I2C_M_RECV_LEN;
+
+			ret = mpc_read(i2c, pmsg->addr, pmsg->buf, pmsg->len, i,
+				       block);
+			if (block && ret > 0)
+				pmsg->len = ret;
+		} else {
 			ret =
 			    mpc_write(i2c, pmsg->addr, pmsg->buf, pmsg->len, i);
+		}
 	}
 	mpc_i2c_stop(i2c);
 	return (ret < 0) ? ret : num;
@@ -545,7 +561,8 @@ static int mpc_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 
 static u32 mpc_functionality(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
+	  | I2C_FUNC_SMBUS_READ_BLOCK_DATA;
 }
 
 static const struct i2c_algorithm mpc_algo = {

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--ew6BAiZeqk4r7MaW--
