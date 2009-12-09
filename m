From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 09 Dec 2009 15:46:40 +0000
Subject: Re: [lm-sensors] Application using i2c-imx.c
Message-Id: <20091209164640.412a2db1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <2655c0a70912080328w33f34840x5e0702ce750cec70@mail.gmail.com>
In-Reply-To: <2655c0a70912080328w33f34840x5e0702ce750cec70@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Javier,

What about NOT TOP-POSTING, as I requested once already?

On Wed, 9 Dec 2009 16:29:34 +0100, Javier Zugasti wrote:
> Thank you very much for your reply Jean.
> I patched the kernel tree with the patch you linked me to and then selected
> the hwmon and lm73 option in the menuconfig options (together with the i2c
> of course).
> 
> After that I used a cross-compiler to compile the kernel for my board and
> transferred the images to my board and started my linux there.
> 
> I assume the system supports i2c now.
> No i2c devices appear in the /dev directory or in /sys/bus/i2c/devices

Which kernel are you running? I2C adapters only show
in /sys/bus/i2c/devices since kernel 2.6.32. For older kernels you
would look for them in /sys/class/i2c-adapter.

Assuming you run an older kernel, please list the entries
under /sys/class/i2c-adapter.

, but
> the lm73 appears in /sys/bus/i2c/drivers and i2c appears in the file
> /proc/devices:
> 
> cat /proc/devices
> Character devices:
> ...
> *89 i2c*
> ...

This means i2c-dev is loaded, but you shouldn't need it, see below.

> So now, how can I write an application in the user space that reads the
> temperature from the lm73? Do I have to use IOCTL calls or how do I do it?

With the lm73 driver you're using, access to the LM73 chip is done
through sysfs, very easily. You would have to go through ioctls
on /dev/i2c* nodes only if you did _not_ have a kernel driver for the
LM73.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
