From: Sergei Sharonov <sergei.sharonov@halliburton.com>
Date: Thu, 15 Nov 2007 23:10:51 +0000
Subject: [lm-sensors] switching from at91 to gpio driver
Message-Id: <loom.20071115T225659-359@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I switched from at91 i2c driver (hardware controller) to i2c-gpio driver in
kernel 2.6.23.1. All chip drivers failed to hook into i2c-gpio. The problem was
traced to the fact that in case of i2c-gpio adapter->class is not set to
I2C_CLASS_HWMON whereas in case of i2c-at91 it is. Chip driver (e.g. lm92)
checks for it in xxx_attach_adapter() function and does not call i2c_probe() if
it is not set.
Skipping the check allows lm92 driver to function.

Now, is it a bug or there is a place where I can tell i2c-gpio driver to set
class?

Thanks,

Sergei Sharonov


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
