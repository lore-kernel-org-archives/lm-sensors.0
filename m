From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [PATCH] i2c driver fixes for 2.6.4
Message-Id: <10793913903814@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20040315224853.GA18325@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1557.61.1, 2004/02/17 14:03:35-08:00, perrye@linuxmail.org

[PATCH] I2C:  i2c-voodoo3.c needs I2C_ADAP_CLASS_TV_ANALOG

The Voodoo3 i2c bus has either a bt869 tv-out chip, or also a tv tuner,
decoder and msp3400.  Without I2C_ADAP_CLASS_TV_ANALOG, the i2c clients
would have to do a strcmp of the adapter name to distiguish between the
i2c and ddc adapters.  Yes, they should be able to tell if the chip at a
given address is what they are looking for, but in the case of the v3tv
module, which is the v4l device, in the 2.4 kerenl I've got it set to
create a dummy client, and the strcmp is the only way to distinguish the
i2c from the ddc.  In the 2.6 kernel, class can be defined, simplifying
things for the v3tv module.


 drivers/i2c/busses/i2c-voodoo3.c |    2 ++
 1 files changed, 2 insertions(+)


diff -Nru a/drivers/i2c/busses/i2c-voodoo3.c b/drivers/i2c/busses/i2c-voodoo3.c
--- a/drivers/i2c/busses/i2c-voodoo3.c	Mon Mar 15 14:37:55 2004
+++ b/drivers/i2c/busses/i2c-voodoo3.c	Mon Mar 15 14:37:55 2004
@@ -171,6 +171,7 @@
 
 static struct i2c_adapter voodoo3_i2c_adapter = {
 	.owner		= THIS_MODULE,
+	.class		= I2C_ADAP_CLASS_TV_ANALOG, 
 	.name		= "I2C Voodoo3/Banshee adapter",
 	.algo_data	= &voo_i2c_bit_data,
 };
@@ -187,6 +188,7 @@
 
 static struct i2c_adapter voodoo3_ddc_adapter = {
 	.owner		= THIS_MODULE,
+	.class		= I2C_ADAP_CLASS_DDC, 
 	.name		= "DDC Voodoo3/Banshee adapter",
 	.algo_data	= &voo_ddc_bit_data,
 };

