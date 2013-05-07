From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 May 2013 15:18:24 +0000
Subject: Re: [lm-sensors] Getting correct temperature information from Intel 945GSE/ICH7M
Message-Id: <20130507151824.GB1853@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CE0521C9E8FCC646A7D4D5C05886A095604FFD4A@SHDEXMBX1.shd-online.de>
In-Reply-To: <CE0521C9E8FCC646A7D4D5C05886A095604FFD4A@SHDEXMBX1.shd-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, May 07, 2013 at 12:54:21PM +0000, Sebastian Werner wrote:
> >
> >>On Mon, May 06, 2013 at 12:31:11PM +0000, Sebastian Werner wrote:
> >> Hello,
> >>=20
> >> I am trying to get the right temperature from two different pieces of =
hardware.
> >> The first, newest piece (http://www.jetwaycomputer.com/ITX-JBC362F36.h=
tml) works right out of the box. Got lm-sensor on the debian system, sensor=
s-detect tells me to modprobe lm78 and the temperature is roughly the same =
as the one shown in the bios.
> >>=20
> >> Acpitz-virtual-0
> >> Adapter: Virtual device
> >> Temp1:              +40.0=B0C  (crit =3D +127.0=B0C)
> >> Temp2:              +26.8=B0C  (crit =3D +127.0=B0C)
> >> Temp3:              +26.8=B0C  (crit =3D +100.0=B0C)
> >>=20
> >This output is not from the lm78 driver.
> >
> >The "coretemp" driver works with this CPU (Atom N2600). Load it and see =
what it reports.
>=20
> Weirdly enough, trying to load "coretemp" on the new hardware gives me a
>  "No such device" error ...
>=20
Old drivers, most likely. What is the output of /proc/cpuinfo ?

> Like Jean mentioned, I am running a rather old version, due to having old
> packages and all their baggage. I took the newest version from http://dl.=
lm-
> sensors.org/lm-sensors/files/sensors-detect and reran it on all the syste=
ms I
> have access to.
> sensors-detect output:
>=20
> Driver `coretemp':
>   * Chip `Intel digital thermal sensor' (confidence: 9)
>=20
> Driver `f71882fg':
>   * ISA bus, address 0x295
>     Chip `Fintek F71808A Super IO Sensors' (confidence: 9)
>=20
> #----cut here----
> # Chip drivers
> modprobe coretemp
> modprobe f71882fg
> /usr/bin/sensors -s
> #----cut here----
>=20
>=20
> >> Not temp2 and temp3 though. Both temperatures never change and they ha=
ve no connection to anything I can read in the bios.
> >> I presumed that those are 'dead wires' and I am at the moment ignoring=
 those, since temp1 is good enough for me.
> >>=20
> >The temperatures are reported by ACPI. No idea how that translates to ha=
rdware
> >temperatures. If the temperature never changes, there may be a bug in the
> >ACPI tables. Those are controlled by the board manufacturer, and would be
> >updated with the BIOS. Do you have the latest BIOS versions installed ?
> >
> >> The second, the older piece (http://www.jetwaycomputer.com/ITX-JBC360F=
33-B.html) does not seem to work. Sensors-detect tells me to load coretemp,=
 using the latest version of sensors-detect from the site wants to also me =
to load the f71882fg driver. That doesn't work out with a 'No such device' =
error.
> >>=20
> >What is your kernel version, and what exactly does sensors-detect report=
 ?
>=20
> I am on debian sqeeze, running 2.6.32-5-686
>=20
You will need a more recent kernel version, or install stand-alone drivers =
for
both coretemp and f71882fg. Not sure what the lm78 detection is about, but =
that
doesn't look correct as Jean pointed out.

> sensors-detect gives me this:
>=20
> Driver `coretemp':
>   * Chip `Intel digital thermal sensor' (confidence: 9)
>=20
> Driver `lm78':
>   * ISA bus, address 0x290
>     Chip `National Semiconductor LM78' (confidence: 6)
>=20
> Driver `f71882fg':
>   * ISA bus, address 0x295
>     Chip `Fintek F71869F/E Super IO Sensors' (confidence: 9)
>=20
> #----cut here----
> # Chip drivers
> modprobe coretemp
> modprobe f71882fg
> modprobe lm78
> /usr/bin/sensors -s
> #----cut here----
>=20
> coretemp is loadable, but f71882fg gives me this:
> ~/detect# modprobe --first-time -v f71882fg
> insmod /lib/modules/2.6.32-5-686/kernel/drivers/hwmon/f71882fg.ko=20
> FATAL: Error inserting f71882fg (/lib/modules/2.6.32-5-686/kernel/drivers=
/hwmon/f71882fg.ko): No such device
>=20
> >If I interpret the information I find on the web correctly, the board mi=
ght
> >be MI812 or MI810 from iBT. If so, the Fintek chip on the board is only =
used
> >for COM ports. Try loading the w83627ehf driver instead.
>=20
> Trying to load w83627ehf gives me the same "No such device" error.
>=20
> >> Acpitz-virtual-0
> >> Adapter: Virtual device
> >> Temp1:              +30.0=B0C  (crit =3D +100.0=B0C)
> >> Coretemp-iso-0000
> >> Core 0:               +30.0=B0C  (crit =3D +90.0=B0C)
> >>=20
> >The CPU is Atom N270, so the reported critical core temperature is corre=
ct.
> >CPU temperature measurements are highly inaccurate that far below the ma=
ximum
> >temperature, so the reported value is as good as it gets. Accuracy is be=
tter
> >with higher temperatures.
>=20
> All in all I am not after exact values. I need to find out if the system =
had
> been used in the wrong environments, which might have lead to the demise =
of the
> hardware. How accurate are we talking here? I just want to set a threshol=
d to
> watch over, maybe setting it to ~50 degrees as a first stepping stone.
>=20
TjMax for the CPU is 90 degrees C. If you set your limit to 15-20 degrees C
below that, you will be absolutely fine.

To give you a reference, here is what my SandyBridge system is running at
right now (full load):

coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:  +85.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
Core 0:         +82.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
Core 1:         +82.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
Core 2:         +85.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
Core 3:         +82.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
