From: "Ger vermeulen" <geve002@casema.nl>
Date: Mon, 04 Jun 2012 19:23:40 +0000
Subject: Re: [lm-sensors] System: "Point of View ION-MB330-1" produces wrong values with lm-sensors 3.3.2
Message-Id: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAOB5NSGJmSkyng5C4YDACgcKAAAAQAAAAZTITCb0MqUmRRVCEkGUtKAEAAAAA@casema.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAOB5NSGJmSkyng5C4YDACgcKAAAAQAAAARsa0Leonh0i8VcwkGa2IBgEAAAAA@casema.nl>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAOB5NSGJmSkyng5C4YDACgcKAAAAQAAAARsa0Leonh0i8VcwkGa2IBgEAAAAA@casema.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Added requested cpuinfo at the bottom

I also noticed a logging in the syslog "Unable to read TjMax from CPU",
Maybe gives a hint to reason.

root@atom:~# rmmod coretemp
root@atom:~# modprobe coretemp

Jun  4 21:06:48 atom kernel: [88459.638772] coretemp coretemp.0: Unable to
read TjMax from CPU.
Jun  4 21:06:48 atom kernel: [88459.640633] coretemp coretemp.1: Unable to
read TjMax from CPU.

root@atom:~# sensors
coretemp-isa-0000
Adapter: ISA adapter
Core0:         -1.0=B0C  (crit =3D +90.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core1:        +10.0=B0C  (crit =3D +90.0=B0C)

root@atom:~# cat /sys/devices/platform/coretemp.0/temp1_input
-1000
root@atom:~# cat /sys/devices/platform/coretemp.1/temp1_input
10000


root@atom:~# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 28
model name      : Intel(R) Atom(TM) CPU  330   @ 1.60GHz
stepping        : 2
cpu MHz         : 1599.991
cache size      : 512 KB
physical id     : 0
siblings        : 2
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
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc
arch_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl tm2 ssse3 cx16
xtpr pdcm movbe lahf_lm dts
bogomips        : 3199.98
clflush size    : 64
cache_alignment : 64
address sizes   : 32 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 28
model name      : Intel(R) Atom(TM) CPU  330   @ 1.60GHz
stepping        : 2
cpu MHz         : 1599.991
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
apicid          : 2
initial apicid  : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc
arch_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl tm2 ssse3 cx16
xtpr pdcm movbe lahf_lm dts
bogomips        : 3199.56
clflush size    : 64
cache_alignment : 64
address sizes   : 32 bits physical, 48 bits virtual
power management:


> -----Original Message-----
> From: Guenter Roeck [mailto:guenter.roeck@ericsson.com]
> Sent: Monday, 04 June, 2012 01:17
> To: geve002@casema.nl
> Cc: lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] System: "Point of View ION-MB330-1" produces
> wrong values with lm-sensors 3.3.2
>=20
> On Sun, Jun 03, 2012 at 01:50:14PM -0400, geve001@casema.nl wrote:
> > On slackware, sensors produce a wrong value for CPU temperature for the
> MB
> > "Point of View ION-MB330-1"
> >
> >
> >
> > It is off at least 20 degrees.
> >
> > CPU-0 and CPU-1 differ 10 degrees which is odd. CPU-0 has more load and
> lower
> > temp (see mpstat)
> >
> > Critical temperature should be 125 according to datasheets
> >
> >
> >
> > Some Google topics suggest to add 20 degrees, but in those cases the
> cpu=92s have
> > the same low temp.
> >
> >
> >
> > =3D=3D> How to tackle this problem??
> >
> >
> >
> > ------------- Linux kernel 2.6.37.6
> >
> > root@atom:~# uname -a
> >
> > Linux atom 2.6.37.6-smp #2 SMP Sat Apr 9 23:39:07 CDT 2011 i686 Intel(R)
> Atom
> > (TM) CPU  330   @ 1.60GHz GenuineIntel GNU/Linux
> >
> >
> >
> Looks like the CPU does not provide a value for TjMax itself, and we don't
> detect
> the CPU type correctly to adjust it.
>=20
> Can you provide the output of /proc/cpuinfo ?
>=20
> As workaround, you can set the module parameter force_tjmax to 125.
>=20
> Thanks,
> Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
