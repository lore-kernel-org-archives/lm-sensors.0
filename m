From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Jun 2008 12:04:01 +0000
Subject: Re: [lm-sensors] [Bug?] W83697: Broken readings for fan speed 10%
Message-Id: <20080613140401.225e792e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080531220339.05dc83fd@neptune.home>
In-Reply-To: <20080531220339.05dc83fd@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, 12 Jun 2008 20:37:54 +0200, Bruno Pr=E9mont wrote:
> On Thu, 12 June 2008 Jean Delvare <khali@linux-fr.org> wrote:
> > Your chip doesn't actually have these dividers. Changing them appears
> > to work because the driver _thinks_ the dividers exist and it somehow
> > compensates with the missing support for 16-bit counter registers. But
> > the value you get is still wrong!
>=20
> At least writing to the divider touches something and influences the resu=
lt

The problem is that you wrote to register bits marked as reserved in
the datasheet when you changed the divider values. Maybe they have the
same behavior of the older chips had, but maybe not. What is sure is
that the (current) driver will interpret things as if the register
meaning did not change. The result is undefined. This is the reason why
I told you shouldn't trust the values even if they appear to be
correct. It seems it works in your case, but we can't rely on it.

> (...)
> Eventually I will look into this in the future, would be nice to keep/res=
tore
> alarms, divider, pwm settings and other configurations of chips on
> resume (be it from S3/Suspend to RAM or from suspend to disk)

Thinking about it, I see no reason why these settings would be lost on
suspend-to-ram. Suspend-to-disk certainly will need some care.

> So on my system the interpretation seems to change around div=3D3 or div=
=3D4
> (at least for fan's current speed)

There's no such thing as div=3D3, div values are always power of 2. But
yes, with a greater divider, the count result fits in 8 bits and this
gives you the correct fan speed. I didn't expect it.

> > Please also tell me which of fan1, fan2 and fan3 is the case fan and
> > which is the CPU fan. Seeing the output of "sensors" on this machine
> > would help.
>=20
> # isadump 0xe85 0xe86
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 11 10 00 00 00 00 00 00 00 80 40 1b 07 32 6c 02=20
> 10: ff ff ff 33 83 01 02 40 00 00 00 ff ff ff ff ff=20
> 20: 49 33 bc b6 4e 6f 5c b8 cc 14 2f 19 ba f1 f1 f1=20
> 30: ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00=20
> 40: 7f ff 7f ff 7f ff ff ff 2d ff ff ff ff ff ff ff=20
> 50: ff 23 7f 7f 7f 00 60 63 90 56 fd 12 00 00 00 00=20
> 60: 7f 7f 7f 00 00 64 ff ff 7f 7f 7f 00 00 64 ff ff=20
> 70: 7f 7f 7f 00 00 64 ff ff ff ff ff ff ff ff ff ff=20
> 80: 00 00 00 00 ff ff ff ff 00 00 ff c0 02 00 99 99=20
> 90: 7f 7f 7f 00 00 7f ff ff 7f 7f 7f 00 00 7f ff ff=20
> a0: 00 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff=20
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20

Thanks for the dump.

Looking at register 0x0c, I see that 16-bit mode is enabled for all of
fan1, fan2 and fan3. I also see that your attempt to set fan1_div and
fan2_div changed the value of register 0x0b (as is expected for older
chips) and apparently had some result (contrary to what I expected.)
Good to know that this is a possible workaround until the driver is
fixed. This won't work for fan3 though (the bit for fan3_div is used
for something else in the new chips.)

>=20
> #sensors
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:  +38.0=B0C                                   =20
> Core1 Temp:  +25.0=B0C                                   =20
>=20
> it8712-isa-0e80
> Adapter: ISA adapter
> VCore 1:     +1.17 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> VCore 2:     +0.82 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> +3.3V:       +3.01 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> +5V:         +4.89 V  (min =3D  +0.00 V, max =3D  +6.85 V)
> +12V:        +4.99 V  (min =3D  +0.00 V, max =3D +16.32 V)
> -12V:       -13.74 V  (min =3D -27.36 V, max =3D  +3.93 V)
> -5V:         -1.10 V  (min =3D -13.64 V, max =3D  +4.03 V)
> Stdby:       +4.92 V  (min =3D  +0.00 V, max =3D  +6.85 V)
> VBat:        +3.26 V
> fan1:       3375 RPM  (min =3D    0 RPM, div =3D 8)
> fan2:       1548 RPM  (min =3D    0 RPM, div =3D 8)
> M/B Temp:    +20.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D thermal diode
> CPU Temp:    +46.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D thermal diode
> Temp3:       +25.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D transistor
> cpu0_vid:   +1.550 V
>=20
> fan1 =3D CPU fan
>   (pwm1=3D2, pwm1_enable=3D1, pwm1_freq7500)
> fan2 =3D artic cooling themperature controlled FAN
>   (note: a drive-bay fan is controlled by pwm2 but has no
>    tachometer - just in case the chip would make an assumption)
> no fan 3 though pwm3 files exist

The driver asks the chip which fan channels are enabled, and only
exposes the enabled ones (unless none is enabled, in which case it
enables them all.) We didn't implement the same for PWM outputs (yet).

How many fan headers does your motherboard have? And how many fans are
displayed in the BIOS? The driver code assumes, that, if the BIOS
enables some of the fan inputs, it will enable _all_ the inputs which
the motherboard is using. But it is possible that a BIOS enables just
the inputs it needs. If so, we'll have to revisit our strategy.

Now that you mention it, my own it87 chip only displays two fans, too,
while there are 3 fan headers on the board. I don't use the 3rd one
myself, but that's still a problem in general. I wonder if the BIOS
would enable it if there was a 3rd fan connected there.

> > I've asked the original author for an update, let's see if he sends
> > something.
>=20
> I've seen the ping, lets see if he will answer

With this patch, you wouldn't have to care about fan clock divisors at
all, so it would be more comfortable.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
