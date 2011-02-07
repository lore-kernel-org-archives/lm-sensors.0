From: Andrew Lutomirski <luto@mit.edu>
Date: Mon, 07 Feb 2011 20:32:23 +0000
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <AANLkTi=eDoC9kF8J+pFzjU09de7qnQn3ZQfdob_kPJWX@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205175852.GA26672@ericsson.com>
In-Reply-To: <20110205175852.GA26672@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 7, 2011 at 3:26 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> Hi Andrew,
>
> On Mon, 2011-02-07 at 14:53 -0500, Andrew Lutomirski wrote:
> [ ... ]
>> >
>> > Anyway, please try again. I updated the code to fix the pwmX_enable bug.
>>
>> Mostly works.
>>
>> If I set pwm2_enable to 1, then pwm2 controls the fan.
>>
>> If I try to set pwm2_enable to 5, I get:
>>
>> # echo 5 >pwm2_enable
>> bash: echo: write error: Invalid argument
>>
> For now that is on purpose. Problem is that if SmartFanIV mode was not
> initialized by the BIOS, it probably won't work. There are lots of
> parameters which have to be configured. So one can not just let users
> enable it without forcing them to configure all the other parameters ..
> which is currently not possible with the sysfs ABI.

I guess what you'd want is a "set lots of parameters all at once" interface.

>
> So this is really a one-way street for now.
>
> Nuvoton's position on this matter is that fan control should be left to
> the board vendor to prevent system damage, ie that users should not try
> to configure it at all other than through the BIOS. They might have a
> point.

Fair enough.  I actually plan to let BIOS configure everything, since
it seems to work nicely.  But as long as there is a driver that offers
fan control, might as well have it work properly.  (I care a lot more
about the sensors than the fan control.)

Should there be a "read-only" module option?

--Andy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
