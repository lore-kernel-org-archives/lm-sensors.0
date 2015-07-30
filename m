From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 30 Jul 2015 16:35:17 +0000
Subject: Re: [lm-sensors] [PATCH 00/27] Export I2C and OF module aliases in missing drivers
Message-Id: <20150730163517.GA13165@dtor-ws>
List-Id: <lm-sensors.vger.kernel.org>
References: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1438273132-20926-1-git-send-email-javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sjoe

Hi Javier,

On Thu, Jul 30, 2015 at 06:18:25PM +0200, Javier Martinez Canillas wrote:
> Hello,
> 
> Short version:
> 
> This series add the missing MODULE_DEVICE_TABLE() for OF and I2C tables
> to export that information so modules have the correct aliases built-in
> and autoloading works correctly.
> 
> Longer version:
> 
> Currently it's mandatory for I2C drivers to have an I2C device ID table
> regardless if the device was registered using platform data or OF. This
> is because the I2C core needs an I2C device ID table for two reasons:
> 
> 1) Match the I2C client with a I2C device ID so a struct i2c_device_id
>    is passed to the I2C driver probe() function.
> 
> 2) Export the module aliases from the I2C device ID table so userspace
>    can auto-load the correct module. This is because i2c_device_uevent
>    always reports a MODALIAS of the form i2c:<client->name>.

Why are we not fixing this? We emit specially carved uevent for
ACPI-based devices, why not the same for OF? Platform bus does this...

Thanks.

-- 
Dmitry

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
