From: Sebastian Werner <Sebastian.Werner@shd-online.de>
Date: Tue, 07 May 2013 16:23:51 +0000
Subject: Re: [lm-sensors] Getting correct temperature information from Intel 945GSE/ICH7M
Message-Id: <CE0521C9E8FCC646A7D4D5C05886A09560500025@SHDEXMBX1.shd-online.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <CE0521C9E8FCC646A7D4D5C05886A095604FFD4A@SHDEXMBX1.shd-online.de>
In-Reply-To: <CE0521C9E8FCC646A7D4D5C05886A095604FFD4A@SHDEXMBX1.shd-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> On Tue, May 07, 2013 at 12:54:21PM +0000, Sebastian Werner wrote:
> > >
> > >>On Mon, May 06, 2013 at 12:31:11PM +0000, Sebastian Werner wrote:
> > >> Hello,
> > >>
> > >> I am trying to get the right temperature from two different pieces of
> hardware.
> > >> The first, newest piece (http://www.jetwaycomputer.com/ITX-
> JBC362F36.html) works right out of the box. Got lm-sensor on the debian
> system, sensors-detect tells me to modprobe lm78 and the temperature is
> roughly the same as the one shown in the bios.
> > >>
> > >> Acpitz-virtual-0
> > >> Adapter: Virtual device
> > >> Temp1:              +40.0=B0C  (crit =3D +127.0=B0C)
> > >> Temp2:              +26.8=B0C  (crit =3D +127.0=B0C)
> > >> Temp3:              +26.8=B0C  (crit =3D +100.0=B0C)
> > >>
> > >This output is not from the lm78 driver.
> > >
> > >The "coretemp" driver works with this CPU (Atom N2600). Load it and see
> what it reports.
> >
> > Weirdly enough, trying to load "coretemp" on the new hardware gives me
> > a  "No such device" error ...
> >
> Old drivers, most likely. What is the output of /proc/cpuinfo ?

old system:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 28
model name      : Intel(R) Atom(TM) CPU N270   @ 1.60GHz
stepping        : 2
cpu MHz         : 1600.128
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
apicid          : 0
initial apicid  : 0
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov=
 pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe constant_tsc arch_perf=
mon pebs bts aperfmperf pni dtes64 monitor ds_cpl est tm2 ssse3 xtpr pdcm m=
ovbe lahf_lm
bogomips        : 3200.25
clflush size    : 64
cache_alignment : 64
address sizes   : 32 bits physical, 32 bits virtual
power management:

new system:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 54
model name      : Intel(R) Atom(TM) CPU N2600   @ 1.60GHz
stepping        : 1
cpu MHz         : 1596.218
cache size      : 512 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 2
apicid          : 0
initial apicid  : 0
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush dts acpi mmx fxsr s
se sse2 ss ht tm pbe nx lm constant_tsc arch_perfmon pebs bts nonstop_tsc a=
perfmperf pni dtes64 monitor ds_cpl est tm
2 ssse3 cx16 xtpr pdcm movbe lahf_lm arat
bogomips        : 3192.43
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

> > Like Jean mentioned, I am running a rather old version, due to having
> > old packages and all their baggage. I took the newest version from
> > http://dl.lm- sensors.org/lm-sensors/files/sensors-detect and reran it
> > on all the systems I have access to.
> > sensors-detect output:
> >
> > Driver `coretemp':
> >   * Chip `Intel digital thermal sensor' (confidence: 9)
> >
> > Driver `f71882fg':
> >   * ISA bus, address 0x295
> >     Chip `Fintek F71808A Super IO Sensors' (confidence: 9)
> >
> > #----cut here----
> > # Chip drivers
> > modprobe coretemp
> > modprobe f71882fg
> > /usr/bin/sensors -s
> > #----cut here----
> >
> >
> > >> Not temp2 and temp3 though. Both temperatures never change and
> they have no connection to anything I can read in the bios.
> > >> I presumed that those are 'dead wires' and I am at the moment ignori=
ng
> those, since temp1 is good enough for me.
> > >>
> > >The temperatures are reported by ACPI. No idea how that translates to
> > >hardware temperatures. If the temperature never changes, there may be
> > >a bug in the ACPI tables. Those are controlled by the board
> > >manufacturer, and would be updated with the BIOS. Do you have the
> latest BIOS versions installed ?
> > >
> > >> The second, the older piece (http://www.jetwaycomputer.com/ITX-
> JBC360F33-B.html) does not seem to work. Sensors-detect tells me to load
> coretemp, using the latest version of sensors-detect from the site wants =
to
> also me to load the f71882fg driver. That doesn't work out with a 'No such
> device' error.
> > >>
> > >What is your kernel version, and what exactly does sensors-detect repo=
rt
> ?
> >
> > I am on debian sqeeze, running 2.6.32-5-686
> >
> You will need a more recent kernel version, or install stand-alone driver=
s for
> both coretemp and f71882fg. Not sure what the lm78 detection is about, but
> that doesn't look correct as Jean pointed out.

That is sadly out of the question, at least for the foreseeable future.
Which means I have to work with the coretemp on the old model and that one
acpi value on the new.

> > All in all I am not after exact values. I need to find out if the
> > system had been used in the wrong environments, which might have lead
> > to the demise of the hardware. How accurate are we talking here? I
> > just want to set a threshold to watch over, maybe setting it to ~50 deg=
rees
> as a first stepping stone.
> >
> TjMax for the CPU is 90 degrees C. If you set your limit to 15-20 degrees=
 C
> below that, you will be absolutely fine.
>=20
> To give you a reference, here is what my SandyBridge system is running at
> right now (full load):
>=20
> coretemp-isa-0000
> Adapter: ISA adapter
> Physical id 0:  +85.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
> Core 0:         +82.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
> Core 1:         +82.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
> Core 2:         +85.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
> Core 3:         +82.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)

This gives me at least a something to hold onto, let's see if it works out.
***************************************************
Automatisch angehangener Disclaimer von SHD
aufgrund der aktuellen Rechtslage
***************************************************
SHD System-Haus-Dresden GmbH - Computerloesungen=20
Geschaeftsfuehrer: Dr. Frank Karow, Dr. Falk Ambos
Sitz der Gesellschaft ist Dresden
Handelsregister: HRB Nr. 329 Amtsgericht Dresden
Umsatzsteueridentifikationsnummer: DE140131570
***************************************************

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
