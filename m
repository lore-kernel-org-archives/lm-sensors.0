From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:47:08 +0000
Subject: [lm-sensors] [PATCH] I2C: Fix sgi_xfer return value
Message-Id: <11259567711229@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: Fix sgi_xfer return value

The sgi_xfer function returns 0 on success instead of the number of
transfered messages as it is supposed to. This patch fixes that.

Let's just hope that no client chip driver was relying on this
misbehavior.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit a89923fff79f8eeed0ccdf51e13453754e48a71e
tree 8fbf4d2ad1fce9452404b081035b30c579f3753a
parent d1b2f0a9754d3087ee29b3e88b8f20f2d30090d3
author Jean Delvare <khali@linux-fr.org> Fri, 02 Sep 2005 21:28:00 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:26:54 -0700

 drivers/i2c/algos/i2c-algo-sgi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-sgi.c b/drivers/i2c/algos/i2c-algo-sgi.c
--- a/drivers/i2c/algos/i2c-algo-sgi.c
+++ b/drivers/i2c/algos/i2c-algo-sgi.c
@@ -149,7 +149,7 @@ static int sgi_xfer(struct i2c_adapter *
 			err = i2c_write(adap, p->buf, p->len);
 	}
 
-	return err;
+	return (err < 0) ? err : i;
 }
 
 static u32 sgi_func(struct i2c_adapter *adap)

