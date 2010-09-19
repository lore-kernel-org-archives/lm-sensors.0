From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 19 Sep 2010 19:40:24 +0000
Subject: Re: [lm-sensors] New/undocumented ABI attributes in w83795 driver
Message-Id: <20100919214024.181e5d8a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100919163321.GA30847@ericsson.com>
In-Reply-To: <20100919163321.GA30847@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sun, 19 Sep 2010 09:33:22 -0700, Guenter Roeck wrote:
> I had a closer look into the w83795 driver - this time trying to ignore
> coding style problems ;) - and noticed that there are several attributes
> which are not defined in the ABI.

Correct. I've seen them too, but they are not in the part of the driver
I carefully reviewed and tested yet. I think most (all?) of them are in
the automatic fan speed control area. The few ones which were in the
monitoring part of the driver, I have fixed already, hopefully.

> I don't mind extending the ABI - done it several times myself recently,
> after all - but this is pretty much creating a new fan / pwm control ABI.
> Or, after looking into other drivers, it is using and possibly extending 
> undocumented ABI attributes defined in other drivers.

The W83795G/ADG offers 3 different models of automatic fan speed
control: the traditional temperature input / PWM output trip points,
plus speed target and temperature target. Most drivers only implement
the former, but for example the f71805f driver supports the speed
target.

I agree that these extra fan control modes lack a standard ABI. Even the
pwm[1-n]_enable file description needs to be extended to support more
than one automatic control mode in a standard way.

> Are we ready for that, ie are you sure that the ABI extensions are sane 
> and fit the requirements of other drivers ? If yes, should this ABI be documented ?

No, I'm not sure of anything. The plan would be to define the ABI
first, and then ensure that the w83795 driver complies with it (which
it most certainly won't.) This is somewhere on my to-do list. Now that
the board with the W83795ADG is in my workstation, my work on the
driver will certainly accelerate.

Note that I drove the definition of the current automatic fan speed
control ABI as it exists now, and there were heated discussions back
then, it took a long time to get where we are and even that left many
developers unhappy. This is probably the main reason why I never
followed up with the other modes.

> Also, do you plan to write Documentation/hwmon/w83795 ? That seems to be missing 
> in your patchset.

Such a file was provided by Wei Song when he contributed the driver
originally. I still have to convert that to a patch, review it and add
it to the series. If I remember correctly, it was essentially a
description of the non-standard ABI implemented by the driver, so it
will be a good read before working on said ABI.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
