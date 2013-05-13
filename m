From: =?iso-8859-1?Q?Jean-Fran=E7ois_Dagenais?= <jeff.dagenais@gmail.com>
Date: Mon, 13 May 2013 13:54:47 +0000
Subject: Re: [lm-sensors] i2c multimaster and the device driver detect function
Message-Id: <E43DA0E6-A130-4837-8343-EEC182A12EE6@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130212164811.GV8668@pengutronix.de> <3D8D1B67-2846-4B78-B402-6B9FD1CB10E6@gmail.com> <20130508175417.GB29689@roeck-us.net> <FCF1B5D0-FF63-40D5-B7B4-D5969628AAD3@gmail.com> <20130509035313.GA26817@roeck-us.net> <3322BACE-9434-4249-8621-C1AD0D340A8A@gmail.com> <20130513101150.0c9e4d30@endymion.delvare>
In-Reply-To: <20130513101150.0c9e4d30-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org

Salut Jean, merci de participer!

On 2013-05-13, at 4:11 AM, Jean Delvare wrote:

> 
> Guenter is right. You never have to disable auto-detection in the slave
> drivers (jc42 etc.) All these slave drivers do is claim "I _can_ do
> auto-detection", not "I _will_ do auto-detection." It's always up to the
> I2C adapter driver, whether auto-detection will happen or not. And it
> is disabled by default. So if you don't want it, just do not enable it
> in the bus driver. You can even set it per adapter, when the driver
> controls more than one adapter, and per bus segment, when multiplexing
> is taking place.

I am just wondering where the clean hook is for doing this. From what I can
gather, the master driver(s I've seen) declare ".class = I2C_CLASS_HWMON |
I2C_CLASS_SPD," pretty statically. Is it just that they are missing this
flexibility? Something along the lines of patching the pdata of such a master
driver to provide a 'class' variable in pdata? If so, one would have to take
into account the existing users of the master which expect the previous class
setting which may not be '0', thus requiring patching the existing upstreamed
users...  Suggestions?

> [...]
> It might be a little late now, but you may want to look into the
> PCA9541, for which Guenter has written a driver.

Thanks for that. Unfortunately, I am bound to existing hardware on this
platform. I will keep it in mind for future designs though.

Since my first post, I have stumbled on more problems with multimaster. Namely,
the master drivers are not consistent with the way they deal with arbitration
loss. I've all but re-written i2c-xiic, and dealt with arblost by catching
BusNotBusy interrupt and retrying the transfer. But the same cannot be said
about i2c-kempld (Kontron's in-PLD i2c master). Even if I manage to get the
kempld driver to handle this correctly, xiic still has some issues. The IP core
seems to enter a state when scanning unpopulated addresses (i2cdetect) for which
only a soft reset is required to recover, but this means it looses track of the
peer start-stop sequences and it's detection of the bus being busy or not.

I have decided to abandon the multimaster option for now as the hurdles are too
great. The only time I need another i2c master is when I need to hot reset the
fpga which houses the xiic core. (the reset pin is driven from gpo on an i2c i/o
expander). I will therefore handle this special case in userspace by unloading
i2c-xiic, then loading i2c-kempld. The slaves are arch declared on hard-coded
bus 0, so this should just work.

Thanks for all your help!
/jfd




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
