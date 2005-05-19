From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:04 +0000
Subject: lm77 on national sc1100
Message-Id: <200407051244.i65CiDK0026157@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>> Doesn't look safe to me. We don't know exactly if 6 and 7 return the
>> last read value or the value of the last read register. The latter
>> sounds much more probable, and since current reading may change, it's
>> not safe. Better rely on limit registers (like you do right after).
>
> I actually tested this, and 6 and 7 return the last read value, not the
> value of the last read register.

Aha, interesting. How can you be sure?

From the datasheet:
>
>D0: Shutdown - when set to 1, the LM77 goes to low power shutdown mode.
>Power up default of 0.
>D1: Interrupt mode - 0 is Comparator Interrupt mode, 1 is Event
>Interrupt mode. Power up default of 0.
>D2, D3: T_CRIT_A and INT polarity - 0 is active low, 1 is active high.
>Outputs are open-drain. Power up default of 0.
>D4: Fault Queue - when set to 1, the Fault Queue is enabled. Power up
>default of 0.
>
>Since the power up default is 0x0 for the whole configuration register,
>maybe this whole initialization can be skipped. What do you think?

Something (BIOS) might have put the chip in "shutdown mode". That same
something may have change some parameters to fit the hardware
configuration (such as polarities) and we want to preserve that. So I'd
suggest you read the config byte, check whether bit 0 is set, and if it
is, rewrite the exact same config byte except for bit 0 which you'd
clear.

>I understand that the current interface operates with absolute limits,
>but are you sure that the hysteresis should be treated the same way as
>temperature limits? The way I see it, hysteresis is not a limit, but
>rather a "delay", a relative value per se. Quoting Webster:
>
>  Hysteresis (n): A lagging or retardation of the effect, as if
>   from velocity or internal friction; a temporary resistance to
>   change from a condition previously induced, observed in magnetism,
>   thermoelectricity, etc., on reversal of polarity.
>
>It's just my $0.02 - I think it makes more sense if it's kept as a
>relative value (and the interface is more sensible this way, IMHO). But
>I'm not a native English speaker, nor do I know much about physics and
>stuff like this, so please feel free to correct me. And I can of course
>make the change, if you don't agree.

We have two dozens other chips which have hysteresis limits, most of
which store them (in their registers) as absolute values. For this
reason, it was first decided (6 years ago or so) that the interface
would use absolute values. Since it is important that every driver
sticks to a common interface, the few chips which use relative values
inside still export absolute values outside. The choice itself didn't
matter much (you always represent the same temperature), what is
important is that a standard had to be defined and needs to be respected.

So, absolute limits for everyone, including hysteresis limits. Of course,
it's of the driver's responsability to do the correct thing when the
user changes a value. Setting the critical limit should preserve (from
the user's absolute point of view) the associated hysteresis limit
(i.e. change the hysteresis register value). The user isn't supposed to
know the driver's internals. Sometimes you cannot hide it entirely, but
we should do as much as we can.

Note that I'm not sure that all our drivers do that properly though.

Thanks,
Jean Delvare
