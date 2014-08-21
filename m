From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 21 Aug 2014 13:25:56 +0000
Subject: Re: [lm-sensors] iio: iio_channel_get: ntc_thermistor isn't working since patch for of_iio_channel_g
Message-Id: <20140821132556.GA24224@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAJKbBDBCEVfB-f6W1NbpPhuyduYB4KQMoT=9=wF4yny3a6weKA@mail.gmail.com>
In-Reply-To: <CAJKbBDBCEVfB-f6W1NbpPhuyduYB4KQMoT=9=wF4yny3a6weKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Johannes Pointner <johannes.pointner@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, lm-sensors@lm-sensors.org

On Thu, Aug 21, 2014 at 09:29:56AM +0200, Johannes Pointner wrote:
> Hello,
> 
> I found out that since this patch https://lkml.org/lkml/2014/6/11/201,
> which fixes the return values in this function, the ntc_thermistor
> driver isn't working anymore for me.
> The problem is that before the driver asked for probe deferral because
> the adc driver isn't loaded at this point and now the probe fails in
> the function iio_channel_get_sys and returns -ENODEV.
> My question is: Who is in this case responsible to request a deferral?
> The driver or the subsystem?
> 
Unless I am missing something, iio_get_channel() should request probe deferral.
There is no other way for the driver to know that the adc driver is not loaded
yet.

The problem here may be that the devicetree entry for the ntc_thermistor driver
may not be correct. The above referenced patch fixes a bug in that area, and
devicetree data is now better validated.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
