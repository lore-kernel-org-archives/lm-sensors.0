From: Robert Kaiser <kairo@kairo.at>
Date: Thu, 10 Mar 2011 00:25:43 +0000
Subject: Re: [lm-sensors] RFC: nct6776f support in the w83627ehf and fan RPM
Message-Id: <il95q7$k6l$1@dough.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
In-Reply-To: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Guenter Roeck schrieb:
> All I know is that there is a sequence of patches in linux-next adding se=
veral
> PCI IDs plus related code to the kernel which seem to be related to Sandy=
 Bridge.
> Look for PCI IDs with "DH89XXCC". I am kind of vague here; I was told tha=
t the added
> PCI IDs match those of Sandy Bridge, but I have not seen the specificatio=
n myself
> so I don't really know for sure.
>
> Do those changes address your problem ? No idea, but it might be worth a =
try.

I'm looking forward to seeing if 2.6.39-rc does better, then, once the=20
merge window has closed and openSUSE's Kernel:HEAD has it.

> Just downloading those with wget seems to be more straightforward than cr=
eating a git clone.

OK, did that (needed to switch to the other KERNEL_BUILD line in the=20
Makefile, but fortunately I'm familiar enough with those Makefiles from=20
Mozilla work).
FYI, here's the sensors output and used kernel version on my Intel=20
DH67CL board:

# sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +52.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +49.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +54.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +48.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)

nct6775-isa-0290
Adapter: ISA adapter
Vcore:                 +1.15 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:                   +1.11 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
AVCC:                  +3.31 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
+3.3V:                 +3.31 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
in4:                   +1.02 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
in5:                   +1.05 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
in6:                   +1.08 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
3VSB:                  +3.41 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
Vbat:                  +3.38 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
fan1:                    0 RPM  (min =3D    0 RPM, div =3D 64)
fan2:                 1110 RPM  (min =3D    0 RPM, div =3D 32)  ALARM
fan3:                    0 RPM  (min =3D    0 RPM, div =3D 64)
fan4:                    0 RPM  (div =3D 64)
SYSTIN:                +39.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C) =
 ALARM=20
  sensor =3D diode
CPUTIN:                +38.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C) =
 sensor=20
=3D diode
SMBUSMASTER 1:         +54.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C) =
 sensor=20
=3D diode
PCH_CHIP_CPU_MAX_TEMP: +65.0=B0C
SMBUSMASTER 2:          +0.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
cpu0_vid:             +2.050 V

# uname -a
Linux robert.box.kairo.at 2.6.38-rc7-18-desktop #1 SMP PREEMPT=20
2011-03-08 01:01:25 +0100 x86_64 x86_64 x86_64 GNU/Linux


I hope those values are somewhat reasonable for what you'd expect.=20
Thanks for your work on this!


Robert Kaiser



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
