From: gregkh@suse.de (Greg KH)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: [PATCH] i2c: i2c-mv64xxx - set adapter owner and class fields
Message-Id: <11123113962602@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1112311396681@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: mgreer@mvista.com

ChangeSet 1.2351, 2005/03/31 14:33:14-08:00, mgreer@mvista.com

[PATCH] i2c: i2c-mv64xxx - set adapter owner and class fields

This patch adds the correct values for the 'owner' and 'class' fields of
the adapter structure in the mv64xxx i2c bus driver.  The missing class
field caused some i2c chip drivers to refuse to attempt a probe on the
mv64xxx i2c bus.

Signed-off-by: Chris Elston <chris.elston@radstone.co.uk>
Signed-off-by: Mark A. Greer <mgreer@mvista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/busses/i2c-mv64xxx.c |    2 ++
 1 files changed, 2 insertions(+)


diff -Nru a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
--- a/drivers/i2c/busses/i2c-mv64xxx.c	2005-03-31 15:15:49 -08:00
+++ b/drivers/i2c/busses/i2c-mv64xxx.c	2005-03-31 15:15:49 -08:00
@@ -525,6 +525,8 @@
 	drv_data->irq = platform_get_irq(pd, 0);
 	drv_data->adapter.id = I2C_ALGO_MV64XXX | I2C_HW_MV64XXX;
 	drv_data->adapter.algo = &mv64xxx_i2c_algo;
+	drv_data->adapter.owner = THIS_MODULE;
+	drv_data->adapter.class = I2C_CLASS_HWMON;
 	drv_data->adapter.timeout = pdata->timeout;
 	drv_data->adapter.retries = pdata->retries;
 	dev_set_drvdata(dev, drv_data);

