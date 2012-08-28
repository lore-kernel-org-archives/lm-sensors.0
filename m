From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 28 Aug 2012 11:50:05 +0000
Subject: Re: [lm-sensors] Configuration file for Intel DG31GL
Message-Id: <20120828135005.007adf9b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <op.wix88zhxn283x7@verdi>
In-Reply-To: <op.wix88zhxn283x7@verdi>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Warren,

On Sun, 12 Aug 2012 16:40:01 -0600, Warren Post wrote:
> I can't claim to know what I'm doing, but I have cobbled together a =20
> configuration file for my Intel DG31GL that meets my needs and thought I'=
d =20
> share it with the community:

Comments in-line below:

> ***config file begins***
>=20
> # lm_sensors configuration file for the Intel DG31GL motherboard
> # 2011-01-02, Warren Post <warren@copaninvest.com>
> # Comments welcome
>=20
> # Winbond configuration adapted from Hans de Goede's work at:
> # http://www.lm-sensors.org/wiki/Configurations/ASRock/AM2NF3-VSTA

Boards from different vendors can be wired very differently. Even more
so when one is for an AMD CPU and the other for an Intel CPU.

I think you'd rather start from scratch, using the BIOS and/or an
accurate voltmeter as a reference.

> chip "w83627dhg-*"
>=20
>      label in0 "VCore"
>      label in1 "VCore2"

Most certainly not, current CPUs have a single VCore.

>      label in2 "AVCC"
>      label in3 "3VCC"
>      label in6 "12V"
>      label in7 "VSB"
>      label in8 "VBAT"

You're missing a label line for in9? Or the compute line below is wrong.

> # +12V and +5V use dividers recommended by datasheet
>      compute in6 @*(1+(56/10)),  @/(1+(56/10))
>      compute in9 @*(1+(22/10)),  @/(1+(22/10))
>=20
> # in4 and in5 are not used (they seem to be hooked up to 3.3v/2, but thats
> # already monitored)

That comment was from the original file, does it really apply to you?
You should uncomment the two ignore statements below and see what you
get.

>=20
>      ignore in4
>      ignore in5
>=20
> # we need to set all voltage limits (hurray for a well written BIOS)
> # Note you may need to adapt in0 and in1 depending on your CPU

This is also from the original configuration file. Did you check if it
really applies to your board?

>=20
>      set in0_min   0.9
>      set in0_max   1.5
>      set in1_min   0.9
>      set in1_max   1.7       # Supress alarm; default value 1.5
>      set in2_min   3.3*0.95
>      set in2_max   3.3*1.05
>      set in3_min   3.3*0.95
>      set in3_max   3.3*1.05
>      set in6_min   0         # Supress alarm; default value 12.0*0.9

That's a bad idea. Plus the fact you needed this suggests that either
in6 isn't +12V or the scaling factor is wrong.

>      set in6_max   12.0*1.1
>      set in7_min   3.3*0.95
>      set in7_max   3.3*1.05
>      set in8_min   3.0
>      set in8_max   3.3*1.05
>=20
> # Fans
>=20
>     ignore fan1    # No sensors available for case fans
>     label fan2     "CPU Fan"
>     ignore fan3
>     ignore fan4
>     ignore fan5

I'd be very surprised. Maybe your fans don't support it, or some fan
headers are unused in your setup, but every Intel board I've seen so
far had case can headers with monitoring.

>=20
> # Fan minumums
>=20
>     set fan2_min    1000
>=20
> # Temperatures
>=20
>     label temp1     "Sys Temp"
>     label temp2     "CPU Temp"
>     label temp3     "CPU2 Temp"
>     ignore temp3    # Suppress alarm

There's little point in setting a label (and limits) for temp3 if you
believe it's not wired.

>=20
>     set temp1_max       100  # Supress alarm; default value 45
>     set temp1_max_hyst  100  # Supress alarm; default value 40
>=20
>     set temp2_max       100  # Supress alarm; default value 45
>     set temp2_max_hyst  100  # Supress alarm; default value 40

That's rather bad. For one thing max_hyst should always be a few
degrees lower than max. And 100=B0C seems way too high.

>=20
>     set temp3_max       45
>     set temp3_max_hyst  40
>=20
>=20
> ***config file ends***
>=20
>=20
> With my thanks for the lm_sensors project,

You're welcome, and thanks for your contribution. However I think your
configuration file isn't ready yet to be published in our wiki.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
