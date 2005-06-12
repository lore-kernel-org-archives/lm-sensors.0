From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 12 Jun 2005 08:24:23 +0000
Subject: [lm-sensors] i2c_set/get_clientdata inconsistencies
Message-Id: <20050612082400.78699b29.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David, Mark,

I noticed that a few Linux i2c chip drivers do not use
i2c_set_clientdata and i2c_get_clientdata in a consistent manner.

The isp1301_omap and tps65010 drivers do call i2c_set_clientdata at
client registration time, but then never call i2c_get_clientdata, not
even at release time, instead using container_of directly.

The m41t00 chip driver does not have private data, so it doesn't call
i2c_set_clientdata, but nevertheless uses i2c_get_clientdata at release
time. This can't be correct.

Here are my proposed fixes. I'm quite confident I am right for the
m41t00 driver, not quite so for the other two, and I can't test any of
them anyway, so please review and comment.

Thanks.

 drivers/i2c/chips/isp1301_omap.c |    4 ++--
 drivers/i2c/chips/m41t00.c       |    2 +-
 drivers/i2c/chips/tps65010.c     |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.12-rc6.orig/drivers/i2c/chips/isp1301_omap.c	2005-06-11 23:25:29.000000000 +0200
+++ linux-2.6.12-rc6/drivers/i2c/chips/isp1301_omap.c	2005-06-12 08:03:11.000000000 +0200
@@ -1197,7 +1197,7 @@
 {
 	struct isp1301	*isp;
 
-	isp = container_of(dev, struct isp1301, client.dev);
+	isp = i2c_get_clientdata(to_i2c_client(dev));
 
 	/* ugly -- i2c hijacks our memory hook to wait_for_completion() */
 	if (isp->i2c_release)
@@ -1211,7 +1211,7 @@
 {
 	struct isp1301	*isp;
 
-	isp = container_of(i2c, struct isp1301, client);
+	isp = i2c_get_clientdata(i2c);
 
 	isp1301_clear_bits(isp, ISP1301_INTERRUPT_FALLING, ~0);
 	isp1301_clear_bits(isp, ISP1301_INTERRUPT_RISING, ~0);
--- linux-2.6.12-rc6.orig/drivers/i2c/chips/m41t00.c	2005-06-11 23:25:29.000000000 +0200
+++ linux-2.6.12-rc6/drivers/i2c/chips/m41t00.c	2005-06-11 23:26:22.000000000 +0200
@@ -207,7 +207,7 @@
 	int	rc;
 
 	if ((rc = i2c_detach_client(client)) = 0) {
-		kfree(i2c_get_clientdata(client));
+		kfree(client);
 		tasklet_kill(&m41t00_tasklet);
 	}
 	return rc;
--- linux-2.6.12-rc6.orig/drivers/i2c/chips/tps65010.c	2005-06-07 20:31:25.000000000 +0200
+++ linux-2.6.12-rc6/drivers/i2c/chips/tps65010.c	2005-06-12 07:36:32.000000000 +0200
@@ -465,7 +465,7 @@
 {
 	struct tps65010		*tps;
 
-	tps = container_of(client, struct tps65010, client);
+	tps = i2c_get_clientdata(client);
 #ifdef	CONFIG_ARM
 	if (machine_is_omap_h2())
 		omap_free_gpio(58);


-- 
Jean Delvare
