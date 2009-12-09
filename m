From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 09 Dec 2009 08:04:03 +0000
Subject: Re: [lm-sensors] Application using i2c-imx.c
Message-Id: <20091209090403.31a08a3b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <2655c0a70912080328w33f34840x5e0702ce750cec70@mail.gmail.com>
In-Reply-To: <2655c0a70912080328w33f34840x5e0702ce750cec70@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Javier,

On Tue, 8 Dec 2009 12:28:07 +0100, Javier Zugasti wrote:
> I wanted to ask if someone has used the i2c-imx driver functionalities to
> communicate with a LM sensor. I haven't found a single example in the web
> and I am very inexperienced with Linux.

You don't really have to care. Almost all I2C-based hwmon drivers
should work on top of any I2C bus driver. Exceptions are very rare (and
would suggest broken hardware design.)

> If so, could you please let me have a look to the application code so that I
> can understand how to communicate with my LM73 using the functions from the
> mentioned driver?

You don't have to do anything, drivers for this already exist. The lm73
driver isn't upstream yet, but it will be in a few days. For now you
can pick the patch from there:

ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/hwmon-lm73-new-driver.patch

After patching your kernel tree, simply load the i2c-imx and lm73
drivers. Then either declare the lm73 device as part of your platform
data, or instantiate it from user-space using
the /sys/bus/i2c/devices/i2c-<n>/new_device file, where <n> is to be
replaced with the relevant i2c-imx's bus number (probably 0, if you
have a single I2C bus on your system.) And you should be done.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
