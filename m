From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: [PATCH] i2c driver fixes for 2.6.2-rc2
Message-Id: <10752464533223@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1075246453858@kroah.com>
References: <10752464532280@kroah.com>
In-Reply-To: <10752464532280@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1474.148.3, 2004/01/23 17:14:52-08:00, khali@linux-fr.org

[PATCH] I2C: Fix bus reset in i2c-philips-par

This patch fixes the bus reset in i2c-philips-par when it is loaded with
type!=0. For now, the reset is always made as is type=0. I guess that
this driver will be abandoned in a while, but it probably doesn't hurt
to fix that.


 drivers/i2c/busses/i2c-philips-par.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-philips-par.c b/drivers/i2c/busses/i2c-philips-par.c
--- a/drivers/i2c/busses/i2c-philips-par.c	Tue Jan 27 15:27:08 2004
+++ b/drivers/i2c/busses/i2c-philips-par.c	Tue Jan 27 15:27:08 2004
@@ -184,8 +184,8 @@
 		return;
 	}
 	/* reset hardware to sane state */
-	bit_lp_setsda(port, 1);
-	bit_lp_setscl(port, 1);
+	adapter->bit_lp_data.setsda(port, 1);
+	adapter->bit_lp_data.setscl(port, 1);
 	parport_release(adapter->pdev);
 
 	if (i2c_bit_add_bus(&adapter->adapter) < 0) {

