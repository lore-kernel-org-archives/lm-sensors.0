From: obi@saftware.de (Andreas Oberritter)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: [PATCH] possible bug in i2c-algo-bit's inb function
Message-Id: <E1D5GN2-0000Bi-KG@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com, simon@tk.uni-linz.ac.at

Hi,

while writing a driver for a cardbus card which is supposed to use the
bit-banging algorithm I noticed that communication with the I2C slave
(Philips TDA10046) would fail without this patch. It forces SDA to high
for every bit in i2c_inb() instead of once per byte. Can this patch go
into the mainline kernel or will this break other drivers? I am using
Kernel version 2.6.10.

Signed-off-by: Andreas Oberritter <obi@saftware.de>

--- linux-2.6/drivers/i2c/algos/i2c-algo-bit.c.orig	2005-02-27 04:39:33.663444536 +0100
+++ linux-2.6/drivers/i2c/algos/i2c-algo-bit.c	2005-02-27 04:39:54.978204200 +0100
@@ -197,8 +197,8 @@ static int i2c_inb(struct i2c_adapter *i
 	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
 
 	/* assert: scl is low */
-	sdahi(adap);
 	for (i=0;i<8;i++) {
+		sdahi(adap);
 		if (sclhi(adap)<0) { /* timeout */
 			DEB2(printk(KERN_DEBUG " i2c_inb: timeout at bit #%d\n", 7-i));
 			return -ETIMEDOUT;
