From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 13 Jan 2009 12:08:45 +0000
Subject: Re: [lm-sensors] Error getting sensor data: w83627ehf/#34
Message-Id: <20090113130845.3641ae1e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4958C1F3.9020108@tobias.preclik.de>
In-Reply-To: <4958C1F3.9020108@tobias.preclik.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hallo Tobias,

On Tue, 13 Jan 2009 12:20:46 +0100, Tobias Preclik wrote:
> thank you for your detailed explanation. The problem seemed to be fan4
> indeed. I updated lm-sensors to 3.0.2 though it is still marked as
> unstable (and hard-masked because barely any applications can deal with
> it) in Gentoo.

FWIW, lm-sensors 3.0.2 (and later) are actually very stable. The only
problem is - as you noticed already - the lack of application support.
But I expect this to be solved by the end of 2009.

>               But now sensord starts without complaints and the fan4 is
> automatically non-existent. But still the values reported by lm-sensors
> seem bogus. Especially +5V and temperatures values:
>=20
> w83627ehf-isa-0290
> Adapter: ISA adapter
> VCore:       +1.59 V  (min =3D  +0.00 V, max =3D  +1.85 V)
> +12V:       +12.04 V  (min =3D +10.82 V, max =3D +13.20 V)
> AVCC:        +3.38 V  (min =3D  +3.14 V, max =3D  +3.47 V)
> 3VCC:        +3.36 V  (min =3D  +3.14 V, max =3D  +3.47 V)
> +5V:         +4.30 V  (min =3D  +4.76 V, max =3D  +5.25 V)   ALARM
> VSB:         +3.38 V  (min =3D  +3.14 V, max =3D  +3.47 V)
> VBAT:        +3.28 V  (min =3D  +3.14 V, max =3D  +3.47 V)
> CPU Fan:    2481 RPM  (min =3D 1704 RPM, div =3D 8)
> Sys Temp:    +27.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM  =
sensor =3D thermistor
> CPU Temp:     +9.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
> AUX Temp:    +77.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  ALARM  =
sensor =3D thermistor
>=20
> How should I go about tweaking the temperature and voltage computations?
> Should I measure the 5V lines or just fiddle about the resistor values
> and pretend the raw voltage value is 5V?

Voltage configuration is motherboard-specific and can be a little
difficult to figure out. A general advice is to check the values
reported in the BIOS and see how sensors.conf can be tweaked to come up
to approximately the same result. I agree that your +5V is pretty low
with the default scaling factor, and that's rather unlikely to be true.
See what your BIOS says. The other Asus boards using this chip use:

   compute in5 @*(1+(22/10)),  @/(1+(22/10))

One trick that worked many times for me is to wait a bit in the BIOS
until the reported voltage changes. If your PSU isn't perfect, this
should happen. Then you have 2 different values for +5V, and the
difference between them is equal to the ADC's LSB value * the scaling
factor. The W83627EHF's has an ADC LSB value of 8 mV, so you can deduce
the scaling factor.

> What about the temperature values? The CPU temperature seems to be too
> low (though the room is admittedly cooled). Unfortunately the
> /proc/acpi/thermal_zone directory remains empty on this machine and I
> cannot easily doublecheck the temperature. Maybe I should check the
> values reported in the system BIOS...
>
> What about the sys and aux temperatures? I seriously doubt that anything
> is 77.5=B0C hot in that machine while idling. I guess the sys temp is a
> dead input because the rrdcgi charts show a perfectly constant value of
> 27.0=B0C. Is that reasonable? Which temperature sensors do "sys temp" and
> "aux temp" correspond to anyway?

First of all: don't trust the labels, they are again
motherboard-dependent and the default might not match your system.

What CPU do you have in the machine? Maybe you can get either the
k8temp or the coretemp driver to work.

I don't have much to propose for this part, sorry. But it would be
interesting to know what temperature labels and values your BIOS
displays.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
