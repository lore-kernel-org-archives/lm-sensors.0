From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 12 Oct 2014 17:20:59 +0000
Subject: Re: [lm-sensors] Fan Control on 6027R TRF running Debian Wheezy
Message-Id: <543AB87B.8020508@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <5437E87B.8030206@truthbox.ch>
In-Reply-To: <5437E87B.8030206@truthbox.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 10/12/2014 10:15 AM, Phil Pokorny wrote:
> On Sun, Oct 12, 2014 at 9:12 AM, Felix Schulthess <fsch@truthbox.ch> wrote:
>
>>> You cannot control the fan speeds. They are managed by the onboard
>>> controller. You can choose one of several profiles in the bios but that
>>> is it.
>>
>> That explains a lot. Thank you for your help, I am going to do some
>> further research in this direction and read up on FreeIPMI.
>>
>> Still, if I can't control the fan speeds but they are instead controlled
>> by some onboard controller, then how could the installation on the
>> fancontrol and lm-sensors mess up the control loop so bad? This still
>> keeps me wondering.
>>
>
> You can't control the fan speeds because there is already another device on
> the motherboard that is tasked with the job of controlling them.  As you
> found, you can poke the control chips, but that doesn't mean you can
> control the speeds predictably.  Imagine two cooks in a kitchen trying to
> cook different meals with the same ingredients.  They come and go in the
> kitchen unaware of the others meddling and confused why things are changing
> when they are away.  You end up with no food.  Only one cook in the kitchen.
>
> It's also possible that when you ran SDT it's default config was to change
> the BIOS/BMC setting on the fans speeds to full speed.  As you found it was
> a permanent change to the setting, not some strange interaction between
> lm_sensors and sdt and the BMC.
>
>
>> Maybe, the sensors somehow blocked the CPU temperature readout. This
>> could have caused the superdoctor program to resort to some failsafe
>> behavior (i.e. spinning the fans up to max RPM). Just wondering.
>
>
> Also possible.
>
No idea how that could happen, unless there is a means for an application
or kernel module to block access to specific CPU registers. That would be
news to me, though.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
