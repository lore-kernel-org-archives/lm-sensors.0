From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 02 Sep 2005 21:28:08 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: Fix sgi_xfer return value
Message-Id: <20050902212800.44dad5ea.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all, Greg,

The sgi_xfer function returns 0 on success instead of the number of
transfered messages as it is supposed to. This patch fixes that.

Let's just hope that no client chip driver was relying on this
misbehavior.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/algos/i2c-algo-sgi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.13.orig/drivers/i2c/algos/i2c-algo-sgi.c	2005-08-29 20:55:01.000000000 +0200
+++ linux-2.6.13/drivers/i2c/algos/i2c-algo-sgi.c	2005-09-02 21:20:08.000000000 +0200
@@ -149,7 +149,7 @@
 			err = i2c_write(adap, p->buf, p->len);
 	}
 
-	return err;
+	return (err < 0) ? err : i;
 }
 
 static u32 sgi_func(struct i2c_adapter *adap)


-- 
Jean Delvare
