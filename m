From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 09 Dec 2009 16:25:23 +0000
Subject: Re: [lm-sensors] Application using i2c-imx.c
Message-Id: <20091209172523.269ef315@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <2655c0a70912080328w33f34840x5e0702ce750cec70@mail.gmail.com>
In-Reply-To: <2655c0a70912080328w33f34840x5e0702ce750cec70@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Javier,

On Wed, 9 Dec 2009 17:12:12 +0100, Javier Zugasti wrote:
> 2009/12/9 Jean Delvare <khali@linux-fr.org>
> > With the lm73 driver you're using, access to the LM73 chip is done
> > through sysfs, very easily. You would have to go through ioctls
> > on /dev/i2c* nodes only if you did _not_ have a kernel driver for the
> > LM73.
> >
> > OK. I'm going to go through the usage of sysfs and see how it goes. But I
> guess it won't until the i2c-adapter appears, right?

Correct. You have to figure out why your I2C adapter isn't
instantiated. This isn't exactly on-topic on this mailing list...

You claim you'd use i2c-imx, how do you know? Did you actually build
that driver? If it is modular, did you load the module?  Which machine
model are you using? i2c-imx is a platform driver, so the i2c-imx
device must be instantiated explicitly by the machine init code.

If you can't figure it out, it might be better to ask on list dedicated
to arm or even imx if there's one.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
