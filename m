From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Apr 2011 12:24:02 +0000
Subject: Re: [lm-sensors] testing "w83627ehf" and "k10temp" on ASRock E350M1
Message-Id: <20110407142402.13905012@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D9CA530.9030100@yandex.ru>
In-Reply-To: <4D9CA530.9030100@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, 07 Apr 2011 13:11:44 +0400, Aleksej Serdjukov wrote:
> (sorry, the CCs seem to have confused Thunderbird)
> On 2011-04-07 11:26, Jean Delvare wrote:
>  > Hi Aleksej, Guenter,
>  >
>  > On Wed, 6 Apr 2011 15:54:56 -0700, Guenter Roeck wrote:
>  >> On Wed, Apr 06, 2011 at 01:38:56PM -0400, Aleksej Serdjukov wrote:
>  >>> Today, however, while the CPU was not loaded much, the fan appeared =
to
>  >>> be full speed again (at least according to the sensors applet).
>  >
>  > It's always nice to get user reports, but...
>=20
> The wiki says the driver "needs testing" (though as of 2011-02-01).  I=20
> thought that at least AUXTIN being negative was something worth reporting.

Yes, support for the NCT677x is relatively recent, so reports are
definitely welcome.

Negative temperature are relatively common and usually mean that the
thermal sensor in question is missing (temperature monitoring channel
is unused.) Nothing to worry about, just ignore the reading. We will
only investigate if you have an evidence that the temperature value
should be reported correctly (the BIOS or another OS is reporting it.)

>  > what is your problem exactly? Do you have an actual question?
>=20
> My problem is the noise the fan is making at full-on speed. I want it to =

> be reasonably quiet, but I don't know why it is following the speed=20
> chosen (between 1 and 9) and not just trying to keep the chosen CPU=20
> temperature; and why yesterday it suddenly got to maximum without me=20
> changing the setting or the non-temp1 temperatures being ordinary.

You should have explained this upfront!

> Since k10temp shown 60-65=B0C, I set the fan speed to full and posted her=
e.
>=20
> Also, the only clear statement about temperatures of E-350 I found is=20
> that the maximum is 90. Reviews talk about 30 or 50. Where should I stop =

> with the quietness?

Where did you get the maximum temperature from? The k10temp driver
seems to disagree - it says 75=B0C max.

>  >>> But the new sensors-detect was also mentioning "k10temp" (and the old
>  >>> one in Debian didn't work), so today I installed a new k10temp, and =
it
>  >>> showed 60=B0C for something.
>  >
>  > Please note that the internal sensors in AMD CPUs have never need
>  > considered accurate. Some models are better than others but it general
>=20
> So can I ignore it when choosing fan speed? Or see that it doesn't go to =

> the 90=B0C maximum?

In your specific case, the k10temp driver seems to report reasonable
values so there is no reason to ignore it.

>  >>> in1:         +1.03 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
>  >>
>  >> 	Possibly 12V (*12)
>  >>
>  >>> AVCC:        +3.33 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>  >>> +3.3V:       +3.33 V  (min =3D  +2.98 V, max =3D  +3.63 V)
>  >>> in4:         +1.39 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
>  >>> in5:         +1.86 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
>  >>
>  >> No idea what in4/in5 might be.
>  >
>  > DDR3 runs at +1.8V so in5 could be Vdimm. Best is to check what the
>  > BIOS is printing, and compare.
>=20
> Settings in UEFI:
> DRAM : 1.507
> +1V  : 1.10
> FCH  : 1.10
> +1.8V: 1.85

Err, sorry I messed up. DDR3 is definitely +1.5V, +1.8V was DDR2. Not
sure what I was up to this morning. But anyway, in5 seems to match
+1.8V in UEFI, whatever it is used for.

Are these settings as in "you can decide the values"? Or measurements?
It is strange that there is no match for DRAM, +1V nor FCH in the
sensors output.

> =3D=3D START COMPARISON #1 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D>=20
> UEFI's H/W pane said:
>=20
> CPU Temp: 44  (got there from 40 since reboot)
> M/B Temp: 44  (got there from 43 since reboot)
>=20
> Vcore: 1.304 V
> +12 V: 12.196 V
> +5.00: 4.992 V
> +3.30: 3.328 V
>
> sensors after boot:
>=20
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:       +57.5=B0C  (high =3D +70.0=B0C, crit =3D +75.0=B0C)
>=20
> nct6775-isa-0290
> Adapter: ISA adapter
> Vcore:       +1.13 V  (min =3D  +0.00 V, max =3D  +1.74 V)

Does this value increase if you put much load on the CPU? It's quite
different from the 1.304 V reported by UEFI.

> in1:         +1.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> AVCC:        +3.33 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> +3.3V:       +3.33 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> in4:         +1.38 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in5:         +1.86 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in6:         +1.66 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> 3VSB:        +3.44 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> Vbat:        +3.39 V  (min =3D  +2.70 V, max =3D  +3.30 V)   ALARM
> fan1:          0 RPM  (min =3D    0 RPM, div =3D 64)
> fan2:       4963 RPM  (min =3D    0 RPM, div =3D 8)  ALARM
> fan3:          0 RPM  (min =3D    0 RPM, div =3D 128)
> fan4:          0 RPM  (div =3D 128)
> SYSTIN:      +45.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM  =
sensor =3D=20
> thermistor
> CPUTIN:      +43.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
> AUXTIN:       -8.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
> cpu0_vid:   +0.000 V
>=20
> =3D=3D END #1 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20
>=20
> =3D=3D START COMPARISON #2 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D>=20
>=20
> UEFI's H/W Monitor pane said:
>=20
> VCore: 1.304
> +12  : 12.144

Previous value printed for +12V was 12.196. 12.196 - 12.144 =3D 0.052.
Assuming this difference represents one LSB at the register level,
which has a weight of 8 mV on the W83627EHF-compatible chips, this
means a scaling factor of ~6.5. 12.144 / 6.5 =3D 1.868. Which seems to
match in5. So I'm no longer sure if in5 is +12V or +1.8V...

> +5   : 4.9?2
> +3.3 : 3.328
>=20
>=20
> sensors after boot:
>=20
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:       +63.0=B0C  (high =3D +70.0=B0C, crit =3D +75.0=B0C)
>=20
> nct6775-isa-0290
> Adapter: ISA adapter
> Vcore:       +1.08 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> in1:         +1.02 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> AVCC:        +3.33 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> +3.3V:       +3.33 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> in4:         +1.39 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in5:         +1.86 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in6:         +1.66 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> 3VSB:        +3.44 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> Vbat:        +3.39 V  (min =3D  +2.70 V, max =3D  +3.30 V)   ALARM
> fan1:          0 RPM  (min =3D    0 RPM, div =3D 32)
> fan2:       5113 RPM  (min =3D    0 RPM, div =3D 8)  ALARM
> fan3:          0 RPM  (min =3D    0 RPM, div =3D 128)
> fan4:          0 RPM  (div =3D 128)
> SYSTIN:      +53.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM  =
sensor =3D=20
> thermistor
> CPUTIN:      +50.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
> AUXTIN:       -9.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
> cpu0_vid:   +0.000 V
>=20
> =3D=3D END #2 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20
>  >>> in6:         +1.66 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
>  >>
>  >> 	This one might be 5V (*3)
>=20
> UEFI: +5.00: 4.992 V
>=20
> 4.992 / 3 =3D 1.664
> 1.66 * 3 =3D 4.98

This is one possibility, yes. It could be confirmed by capturing at
least one other +5V value in UEFI.

>=20
>=20
>  >>> SYSTIN:      +51.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  AL=
ARM=20
> sensor =3D  thermistor
>  >>> CPUTIN:      +45.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  se=
nsor =3D=20
> thermistor
>  >
>  > These temperatures look reasonable to me. Find out which is the CPU
>  > temperature by putting some load on the CPU: the CPU temperature will
>  > raise faster and higher. You should also set appropriate limits for
>  > temp1 and write them to the chip with "sensors -s".
>=20
> CPUTIN and temp1 slowly increased (CPUTIN from 44-46 to 48-49, temp1=20
> from 56 to 67-69).

69=B0C is dangerously close to the limits. Which is odd given the high
fan speed. Are you sure the case gets enough cooling from the outside /
can get the hot air evacuated properly?

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
