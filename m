From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 18 Nov 2007 16:43:54 +0000
Subject: Re: [lm-sensors] switching from at91 to gpio driver
Message-Id: <20071118174354.1c238226@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20071115T225659-359@post.gmane.org>
In-Reply-To: <loom.20071115T225659-359@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sergei,

On Thu, 15 Nov 2007 23:10:51 +0000 (UTC), Sergei Sharonov wrote:
> I switched from at91 i2c driver (hardware controller) to i2c-gpio driver in
> kernel 2.6.23.1. All chip drivers failed to hook into i2c-gpio. The problem was
> traced to the fact that in case of i2c-gpio adapter->class is not set to
> I2C_CLASS_HWMON whereas in case of i2c-at91 it is. Chip driver (e.g. lm92)
> checks for it in xxx_attach_adapter() function and does not call i2c_probe() if
> it is not set.
> Skipping the check allows lm92 driver to function.
> 
> Now, is it a bug or there is a place where I can tell i2c-gpio driver to set
> class?

Thanks for reporting, good catch. I'm adding the i2c list in Cc, as
well as the author of the i2c-gpio driver and one of its users.

Indeed there needs to be a way to set the class of i2c-gpio buses to
I2C_CLASS_HWMON. We could change the driver to set the class to
I2C_CLASS_HWMON for all buses by default, but that's not very flexible.
It would IMHO make more sense to add a field to struct
i2c_gpio_platform_data, and let each user of i2c-gpio set the class to
whatever they want.

Maybe you, Haavard or Atsushi can submit a patch doing this? I'd be
happy to review and merge it quickly.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
