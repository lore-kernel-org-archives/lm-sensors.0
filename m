From: gregkh@suse.de (Greg Kroah-Hartman)
Date: Mon, 12 Dec 2005 20:01:05 +0000
Subject: [lm-sensors] [patch 1/4] i2c: Fix i2c-mv64xxx compilation error
Message-Id: <20051212200105.GB27657@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051212192030.873030000@press.kroah.org>
In-Reply-To: <20051212200044.GA27657@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, mgreer@mvista.com, khali@linux-fr.org

From: "Mark A. Greer" <mgreer at mvista.com>

The busses/i2c-mv64xxx.c driver doesn't currently compile because of an
incorrect argument to dev_err().  This patch fixes that.

Signed-off-by: Mark A. Greer <mgreer at mvista.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/busses/i2c-mv64xxx.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- greg-2.6.orig/drivers/i2c/busses/i2c-mv64xxx.c
+++ greg-2.6/drivers/i2c/busses/i2c-mv64xxx.c
@@ -529,14 +529,15 @@ mv64xxx_i2c_probe(struct platform_device
 	i2c_set_adapdata(&drv_data->adapter, drv_data);
 
 	if (request_irq(drv_data->irq, mv64xxx_i2c_intr, 0,
-		MV64XXX_I2C_CTLR_NAME, drv_data)) {
-
-		dev_err(dev, "mv64xxx: Can't register intr handler "
-			"irq: %d\n", drv_data->irq);
+			MV64XXX_I2C_CTLR_NAME, drv_data)) {
+		dev_err(&drv_data->adapter.dev,
+			"mv64xxx: Can't register intr handler irq: %d\n",
+			drv_data->irq);
 		rc = -EINVAL;
 		goto exit_unmap_regs;
 	} else if ((rc = i2c_add_adapter(&drv_data->adapter)) != 0) {
-		dev_err(dev, "mv64xxx: Can't add i2c adapter, rc: %d\n", -rc);
+		dev_err(&drv_data->adapter.dev,
+			"mv64xxx: Can't add i2c adapter, rc: %d\n", -rc);
 		goto exit_free_irq;
 	}
 

--

