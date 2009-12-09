From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 09 Dec 2009 16:49:37 +0000
Subject: Re: [lm-sensors] Application using i2c-imx.c
Message-Id: <20091209174937.61e4ae14@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <2655c0a70912080328w33f34840x5e0702ce750cec70@mail.gmail.com>
In-Reply-To: <2655c0a70912080328w33f34840x5e0702ce750cec70@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 9 Dec 2009 17:39:33 +0100, Javier Zugasti wrote:
> 2009/12/9 Jean Delvare <khali@linux-fr.org>
> > You claim you'd use i2c-imx, how do you know? Did you actually build
> > that driver? If it is modular, did you load the module?  Which machine
> > model are you using? i2c-imx is a platform driver, so the i2c-imx
> > device must be instantiated explicitly by the machine init code.
>
> Well, in the I2C support from menuconfig I selected the following options:
> 
> <*> I2C support --->
>       <*> I2C device interface
>               I2C Hardware Bus Support --->
>                    <*> IMX I2C interface
> 
> Should I just select I2C support and then use sysfs as you suggested before?

No, this suggestion of mine was unrelated.

> Could this be the reason why my I2C adapter isn't instantiated?

No. If the driver is properly build in, then I suspect that the device
itself is missing. Just check in /sys/devices/platform/ if it's there
or not. If not then something's missing in your machine init data.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
