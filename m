From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 03 Aug 2015 18:36:38 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for Maxim MAX31790
Message-Id: <55BFB4B6.5060203@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1438195783-26978-1-git-send-email-corone.il.han@gmail.com>
In-Reply-To: <1438195783-26978-1-git-send-email-corone.il.han@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/03/2015 10:49 AM, Il Han wrote:
> Hi,
>
> Thank you for your review.
> I am modifying the driver on your advice.
> I am going to commit it soon again.
> I also added the comments below.
>

Please don't top-post.

Comments inline.

Thanks,
Guenter

[ ... ]

>     Given that the sr range is 3 bit, an array would be simpler.
>
>     static const u8 sr[8] = { 1, 2, 4, 8, 16, 32, 32, 32 };
>
>     u8 get_speed_range(u8 fan_dynamics)
>     {
>              return sr[MAX31790_FAN_DYNAMICS_SR(fan_dynamics)];
>     }
>
>
> OK.
>
>
>     It might be useful to report the configured speed range
>     as fanX_div, and make it configurable.
>
>
> But it's not a divisor.
> So I added fanX_period so that it is configurable, instead of the fanX_div.
>
... which is not a standard attribute and thus not acceptable. Maybe we need
to determine how to map the value from one to another in a meaningful way.

>     You use direct values for everything but the pulse count. Might as well just use '2'
>     for that as well. It is quite useless, though, since
>              (2 * (data->tach[attr->index] >> 5))
>     is identical to
>              (data->tach[attr->index] >> 4)
>     which you might as well use directly.
>
>
> But, isn't there a case that the number of tachometer pulse per revolution is not 2?
>
See Documentation/hwmon/sysfs-interface.

>
>     Valid range for pwmX is 0..255. Please report this range and adjust
>     reported / configured values accordingly.
>
>
> In this chip, the range for PWM is 0..511. (9 bits of the PWMOUT Target Duty Cycle register.)
>
Again, see Documentation/hwmon/sysfs-interface. You have to stick with the ABI
and adjust internally. Make the sysfs attribute 0..255 and write, for example,
(written value * 2) into the chip.

>         +
>         +static const struct i2c_device_id max31790_id[] = {
>         +       { "max31790", max31790 },
>
>
>     You don't use the 'max31790' in the probe function (nor would there be
>     a reason to do so).
>
>
> I'm sorry. I don't understand what you've said.
> I refered to source code of many other drivers to understand it.
> But I didn't catch that.
> Could you let me know what you mean?
>

Drivers which don't support more than one chip just have something like

static const struct i2c_device_id max31790_id[] = {
	{ "max31790", 0 },
	{ }
};

> Doesn't it register the device with the name, client->name?
>
Sure, but that doesn't mean you need the enum (which you don't use anyway).

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
