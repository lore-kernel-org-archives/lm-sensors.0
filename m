From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 10 Mar 2011 03:45:30 +0000
Subject: Re: [lm-sensors] RFC: nct6776f support in the w83627ehf and fan RPM
Message-Id: <20110310034530.GA22156@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
In-Reply-To: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Robert,

On Wed, Mar 09, 2011 at 07:25:43PM -0500, Robert Kaiser wrote:
> Guenter Roeck schrieb:
> > All I know is that there is a sequence of patches in linux-next adding =
several
> > PCI IDs plus related code to the kernel which seem to be related to San=
dy Bridge.
> > Look for PCI IDs with "DH89XXCC". I am kind of vague here; I was told t=
hat the added
> > PCI IDs match those of Sandy Bridge, but I have not seen the specificat=
ion myself
> > so I don't really know for sure.
> >
> > Do those changes address your problem ? No idea, but it might be worth =
a try.
>=20
> I'm looking forward to seeing if 2.6.39-rc does better, then, once the=20
> merge window has closed and openSUSE's Kernel:HEAD has it.
>=20
> > Just downloading those with wget seems to be more straightforward than =
creating a git clone.
>=20
> OK, did that (needed to switch to the other KERNEL_BUILD line in the=20
> Makefile, but fortunately I'm familiar enough with those Makefiles from=20
> Mozilla work).
> FYI, here's the sensors output and used kernel version on my Intel=20
> DH67CL board:
>=20
> # sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +52.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
>=20
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +49.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
>=20
> coretemp-isa-0002
> Adapter: ISA adapter
> Core 2:      +54.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
>=20
> coretemp-isa-0003
> Adapter: ISA adapter
> Core 3:      +48.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
>=20
> nct6775-isa-0290
> Adapter: ISA adapter
> Vcore:                 +1.15 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> in1:                   +1.11 V  (min =3D  +0.00 V, max =3D  +0.00 V)   AL=
ARM
> AVCC:                  +3.31 V  (min =3D  +0.00 V, max =3D  +0.00 V)   AL=
ARM
> +3.3V:                 +3.31 V  (min =3D  +0.00 V, max =3D  +0.00 V)   AL=
ARM
> in4:                   +1.02 V  (min =3D  +0.00 V, max =3D  +0.00 V)   AL=
ARM
> in5:                   +1.05 V  (min =3D  +0.00 V, max =3D  +0.00 V)   AL=
ARM
> in6:                   +1.08 V  (min =3D  +0.00 V, max =3D  +0.00 V)   AL=
ARM
> 3VSB:                  +3.41 V  (min =3D  +0.00 V, max =3D  +0.00 V)   AL=
ARM
> Vbat:                  +3.38 V  (min =3D  +0.00 V, max =3D  +0.00 V)   AL=
ARM
> fan1:                    0 RPM  (min =3D    0 RPM, div =3D 64)
> fan2:                 1110 RPM  (min =3D    0 RPM, div =3D 32)  ALARM
> fan3:                    0 RPM  (min =3D    0 RPM, div =3D 64)
> fan4:                    0 RPM  (div =3D 64)
> SYSTIN:                +39.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C=
)  ALARM=20
>   sensor =3D diode
> CPUTIN:                +38.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C=
)  sensor=20
> =3D diode
> SMBUSMASTER 1:         +54.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C=
)  sensor=20
> =3D diode
> PCH_CHIP_CPU_MAX_TEMP: +65.0=B0C
> SMBUSMASTER 2:          +0.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
> cpu0_vid:             +2.050 V
>=20
> # uname -a
> Linux robert.box.kairo.at 2.6.38-rc7-18-desktop #1 SMP PREEMPT=20
> 2011-03-08 01:01:25 +0100 x86_64 x86_64 x86_64 GNU/Linux
>=20
>=20
> I hope those values are somewhat reasonable for what you'd expect.=20
> Thanks for your work on this!
>=20
Looks reasonable. There is one problem which I had wondered about - the ALA=
RM=20
which tends to show up for running fans.

I finally tracked that down. Turns out the chip has a "maximum RPM" registe=
r.
Apparently that register is not set, which causes the alarm.

There is a sysfs attribute for maximum RPM - fanX_max. The w83627ehf driver=
 does not
support / use this attribute. Guess I'll have to add it .... that will have=
 to be
a separate patch.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
