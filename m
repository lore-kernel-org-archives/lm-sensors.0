From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: [PATCH 2.6] I2C: Kill i2c_client.id (4/5)
Message-Id: <20050116204630.7296f884.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050116194653.17c96499.khali@linux-fr.org>
In-Reply-To: <20050116194653.17c96499.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@stimpy.netroedge.com>

> (4/5) Deprecate i2c_client.id.

Now that i2c_client.id has no more users in the kernel (none that I
could find at least) we could remove that struct member. I however think
that it's better to only deprecate it at the moment, in case I missed
users or any of the other patches are delayed for some reason. We could
then delete the id member definitely in a month or so.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

diff -ruN linux-2.6.11-rc1.orig/include/linux/i2c.h linux-2.6.11-rc1/include/linux/i2c.h
--- linux-2.6.11-rc1.orig/include/linux/i2c.h	2004-12-24 22:34:01.000000000 +0100
+++ linux-2.6.11-rc1/include/linux/i2c.h	2005-01-16 18:41:51.000000000 +0100
@@ -144,7 +144,7 @@
  * function is mainly used for lookup & other admin. functions.
  */
 struct i2c_client {
-	int id;
+	__attribute__ ((deprecated)) int id;
 	unsigned int flags;		/* div., see below		*/
 	unsigned int addr;		/* chip address - NOTE: 7bit 	*/
 					/* addresses are stored in the	*/


-- 
Jean Delvare
http://khali.linux-fr.org/
