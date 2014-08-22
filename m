From: Johannes Pointner <johannes.pointner@gmail.com>
Date: Fri, 22 Aug 2014 11:50:23 +0000
Subject: Re: [lm-sensors] iio: iio_channel_get: ntc_thermistor isn't working since patch for of_iio_channel_g
Message-Id: <CAJKbBDDrzA6SBBFO+ZLGz6pwmXZ1MzsTSmwy=wVS+c9veCrLYg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAJKbBDBCEVfB-f6W1NbpPhuyduYB4KQMoT=9=wF4yny3a6weKA@mail.gmail.com>
	<20140821132556.GA24224@roeck-us.net>
In-Reply-To: <20140821132556.GA24224@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, lm-sensors@lm-sensors.org

Hello Guenter,

thank you for your quick answer.

2014-08-21 15:25 GMT+02:00 Guenter Roeck <linux@roeck-us.net>:
> On Thu, Aug 21, 2014 at 09:29:56AM +0200, Johannes Pointner wrote:
>> Hello,
>>
>> I found out that since this patch https://lkml.org/lkml/2014/6/11/201,
>> which fixes the return values in this function, the ntc_thermistor
>> driver isn't working anymore for me.
>> The problem is that before the driver asked for probe deferral because
>> the adc driver isn't loaded at this point and now the probe fails in
>> the function iio_channel_get_sys and returns -ENODEV.
>> My question is: Who is in this case responsible to request a deferral?
>> The driver or the subsystem?
>>
> Unless I am missing something, iio_get_channel() should request probe deferral.
> There is no other way for the driver to know that the adc driver is not loaded
> yet.

Yes, I missed that. In the function __of_iio_channel_get the subsystem
returns a -EPROBE_DEFER.

>
> The problem here may be that the devicetree entry for the ntc_thermistor driver
> may not be correct. The above referenced patch fixes a bug in that area, and
> devicetree data is now better validated.
>
But the problem is, that this statement:
if (np && !of_get_property(np, "io-channel-ranges", NULL))
            return NULL;
overrides the -EPROBE_DEFER. Before the fix there was a break
statement and the -EPROBE_DEFER was returned.

Do I have made a mistake in the devicetree if I put the ntc
declaration directly under the root node?

> Guenter

Thanks in advance!

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
