From: "Ian Dobson" <i.dobson@planet-ian.com>
Date: Tue, 08 Feb 2011 18:03:15 +0000
Subject: Re: [lm-sensors] tempX_source sysfs attribute needed ?
Message-Id: <F0B97EFE773347FA921085FC12287474@portable2>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110208171026.GE13717@ericsson.com>
In-Reply-To: <20110208171026.GE13717@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org



--------------------------------------------------
From: "Guenter Roeck" <guenter.roeck@ericsson.com>
Sent: Tuesday, February 08, 2011 6:10 PM
To: <lm-sensors@lm-sensors.org>
Subject: [lm-sensors] tempX_source sysfs attribute needed ?

> Hi all,
>
> in the recent months, I have seen two instances where a sysfs attribute
> identifying the source associated with a temperature sensor would have=20
> been
> helpful.
>
> One is max6639. For this chip, the source of the second temperature=20
> channel
> can be configured to be local or remote.
>
> The others are W83677HG-B, NCT6775F, and NCT6776F. Those chips have four =

> to six
> temperature channels with a configurable source.
>
> Current approach is to stick with whatever is configured by the BIOS for =

> the Nuvoton
> chips, and to use the local source for the max6639 driver. For the Nuvoto=
n=20
> chips,
> my prototype driver for NCT6775F and NCT6776F reports the temperature=20
> source
> in tempX_label.
>
> Possible solutions might be:
> - Stick with the current situation, ie do nothing.
> - Use module parameters. Doesn't really work well for max6639 since it=20
> affects
>  all instances of the driver, and if the driver is built into the kernel.
> - Use platform data. Might work for max6639, but not for the Nuvoton=20
> chips.
> - Define a new sysfs attribute to make the temperature source=20
> configurable,
>  and to report the current selection.
>
> Any thoughts/comments ?
>
> Thanks,
> Guenter
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

Hi Guenter,

I actually think it's a good idea (tempX_label), I've already seen that=20
sensors can use this information if you don't have a label defined in=20
sensors3.conf. It actually makes is alot easier to configure the=20
sensors3.conf file correctly. I'm not sure if _label is the correct name, i=
t=20
really describes the source of the signal.

Also with the nuv chips what happens if you change the source for a=20
temperature input that's used by smartfan? The BIOS should know what's best=
=20
and playing with the fan control inputs could cause all sorts of problems. =

During my hacking in the nct6776f driver I managed to screw up the smartfan=
=20
control so much that the temperature setpoint for one of the fans was 90=B0=
c=20
and the fan stopped.

Regards
Ian Dobson
=20


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
