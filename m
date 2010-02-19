From: "Artem S. Tashkinov" <birdie@permonline.ru>
Date: Fri, 19 Feb 2010 12:26:01 +0000
Subject: Re: [lm-sensors] A question regarding ASRock H55DE3 motherboard
Message-Id: <4B7E8359.6020209@permonline.ru>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010305010600030904070706"
List-Id: <lm-sensors.vger.kernel.org>
References: <4B7A403E.7000103@permonline.ru>
In-Reply-To: <4B7A403E.7000103@permonline.ru>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------010305010600030904070706
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello Jean,

On 02/19/2010 02:52 PM, Jean Delvare wrote:
 > Hi Artem,
 >
 > On Thu, 18 Feb 2010 16:25:48 +0500, Artem S. Tashkinov wrote:
 >> echo adt7473 0x2e>  /sys/class/i2c-adapter/i2c-3/new_device produced =
the
 >> desired results:
 >>
 >> adt7473-i2c-3-2e
 >> Adapter: NVIDIA i2c adapter
 >> in1:         +3.00 V  (min =3D  +0.00 V, max =3D  +2.99 V)
 >> +3.3V:       +3.33 V  (min =3D  +0.00 V, max =3D  +4.39 V)
 >> fan1:        889 RPM  (min =3D    0 RPM)
 >> fan2:          0 RPM  (min =3D    0 RPM)
 >> fan3:          0 RPM  (min =3D  164 RPM)  ALARM
 >> temp1:       +39.2=C2=B0C  (low  =3D +65.0=C2=B0C, high =3D +85.0=C2=B0=
C)  ALARM
 >>                         (crit =3D +100.0=C2=B0C, hyst =3D +98.0=C2=B0=
C)
 >> Board Temp:  +33.8=C2=B0C  (low  =3D +20.0=C2=B0C, high =3D +60.0=C2=B0=
C)
 >>                         (crit =3D +100.0=C2=B0C, hyst =3D +96.0=C2=B0=
C)
 >> temp3:       +39.2=C2=B0C  (low  =3D +80.0=C2=B0C, high =3D +105.0=C2=
=B0C)  ALARM
 >>                         (crit =3D +136.0=C2=B0C, hyst =3D +132.0=C2=B0=
C)
 >>
 >> The output needs to be configured (via /etc/sensors.d/chipname.conf),
 >> but that's not a problem.
 >
 > Looks good indeed. I'd guess in1, fan2 and fan3 aren't used so you can
 > add an "ignore" statement for them. The rest looks good, except the lo=
w
 > limits of temp1 and temp3.

I'm attaching my adt7473.conf if anyone needs it - I'm not sure if it's=20
suitable for lm-sensors wiki - it's you to decide. Now this sensor=20
output looks this way:

adt7473-i2c-3-2e
Adapter: NVIDIA i2c adapter
+3.3V:       +3.32 V  (min =3D  +2.96 V, max =3D  +3.61 V)
GPU Fan:     876 RPM  (min =3D    0 RPM)
GPU Core:    +48.2=C2=B0C  (low  =3D +20.5=C2=B0C, high =3D +92.5=C2=B0C)
                       (crit =3D +107.5=C2=B0C, hyst =3D +105.5=C2=B0C)
GPU Ambient: +35.2=C2=B0C  (low  =3D +20.0=C2=B0C, high =3D +60.0=C2=B0C)
                       (crit =3D +100.0=C2=B0C, hyst =3D +96.0=C2=B0C)

 >
 >> (...)
 >> I apologize - it's my double blunder - HWMon shows Winbond W83627DHG
 >> chip. So I tried w83627dhg driver and it perfectly works on my system
 >> when loaded this way (as you suggested in a previous letter):
 >>
 >> modprobe w83627ehf force_id=3D0xa020
 >>
 >> w83627dhg-isa-0290
 >> Adapter: ISA adapter
 >> Vcore:       +0.82 V  (min =3D  +0.00 V, max =3D  +1.74 V)
 >> in1:         +1.85 V  (min =3D  +0.69 V, max =3D  +1.91 V)
 >> AVCC:        +3.39 V  (min =3D  +2.00 V, max =3D  +0.56 V)   ALARM
 >> VCC:         +3.39 V  (min =3D  +2.86 V, max =3D  +1.76 V)   ALARM
 >> in4:         +0.05 V  (min =3D  +1.53 V, max =3D  +1.94 V)   ALARM
 >> in5:         +1.71 V  (min =3D  +1.32 V, max =3D  +1.86 V)
 >> in6:         +0.05 V  (min =3D  +1.66 V, max =3D  +1.90 V)   ALARM
 >> 3VSB:        +3.49 V  (min =3D  +1.50 V, max =3D  +2.99 V)   ALARM
 >> Vbat:        +3.34 V  (min =3D  +3.71 V, max =3D  +3.74 V)   ALARM
 >> fan1:          0 RPM  (min =3D  217 RPM, div =3D 64)  ALARM
 >> fan2:       1004 RPM  (min =3D  397 RPM, div =3D 32)
 >> fan3:          0 RPM  (min =3D  357 RPM, div =3D 64)  ALARM
 >> fan4:          0 RPM  (min =3D   84 RPM, div =3D 128)  ALARM
 >> fan5:          0 RPM  (min =3D  703 RPM, div =3D 16)  ALARM
 >> temp1:       +33.0=C2=B0C  (high =3D -13.0=C2=B0C, hyst =3D -46.0=C2=B0=
C)  ALARM  sensor =3D
 >> thermistor
 >> temp2:       +36.0=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0=
C)  sensor =3D=20
thermistor
 >> temp3:      +127.5=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0=
C)  ALARM  sensor =3D
 >> thermistor
 >> cpu0_vid:   +0.000 V
 >
 >  From the above output, it's hard to claim it works "perfectly". Some
 > values look good, yes, but more careful inspection would be needed to
 > confirm that all inputs and limits work they way they are supposed to.

In the meantime I cannot find the right formula for +12V which is shown=20
by Windows utilities, so probably I need to wait for a dedicated nuvoton=20
driver - alas, it only exists as a patch and I've no idea how to compile=20
and test it. The next strange thing is that in this output only VCore,=20
in1, in4, in6 and 3VSB change their values, all other sensors remain the=20
same no matter what my load is. Temp2 temperature which is theoretically=20
a CPU temperature changes much slower than coretemp indicates.

 >
 >> However this means two things, w83627ehf driver needs to be updated t=
o
 >> work with my PC (I can send any system information if it's required)
 >
 > Correct.... We must add support for your chip.
 >
 >> and  sensors-detect script should also be modified to correctly
 >> identify my sensors (it missed coretemp driver altogether).
 >
 > No, sensors-detect does the right thing at the moment. It properly
 > identifies your Super-I/O chip (which is _not_ a W83627DHG so we just
 > can't claim it is). As for the coretemp driver, the driver currently
 > doesn't support your CPU so we can't point the user to it. If we did,
 > we would receive complaints like "sensors-detect told me to load drive=
r
 > coretemp but it doesn't work." So we have to do changes in the right
 > order, that is, first add support to the coretemp driver, and then
 > change sensors-detect to point to it.
 >
 > In the meantime, please attach the contents of /proc/cpuinfo for the
 > records.

I've filed a bug report on this topic:=20
http://bugzilla.kernel.org/show_bug.cgi?id=3D15348

Anyway, here's the information you requested:

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 37
model name      : Intel(R) Core(TM) i5 CPU         650  @ 3.20GHz
stepping        : 2
cpu MHz         : 1200.000
cache size      : 4096 KB
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
cpuid level     : 11
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge=20
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx=20
rdtscp lm constant_tsc arch_perfmon pebs bts xtopology nonstop_tsc=20
aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3=20
cx16 xtpr pdcm sse4_1 sse4_2 popcnt aes lahf_lm ida arat tpr_shadow vnmi=20
flexpriority ept vpid
bogomips        : 6626.04
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

 >
 >> coretemp driver started working after I applied the attached patch,
 >> however the readings are wrong, so probably this driver is not yet
 >> capable of monitoring Intel Core i5 650 CPU (temperatures are all wro=
ng,
 >> there are only two physical CPU cores):
 >>
 >> coretemp-isa-0000
 >> Adapter: ISA adapter
 >> Core 0:      +23.0=C2=B0C  (high =3D +84.0=C2=B0C, crit =3D +100.0=C2=
=B0C)
 >>
 >> coretemp-isa-0001
 >> Adapter: ISA adapter
 >> Core 1:      +26.0=C2=B0C  (high =3D +84.0=C2=B0C, crit =3D +100.0=C2=
=B0C)
 >>
 >> coretemp-isa-0002
 >> Adapter: ISA adapter
 >> Core 2:      +23.0=C2=B0C  (high =3D +84.0=C2=B0C, crit =3D +100.0=C2=
=B0C)
 >>
 >> coretemp-isa-0003
 >> Adapter: ISA adapter
 >> Core 3:      +26.0=C2=B0C  (high =3D +84.0=C2=B0C, crit =3D +100.0=C2=
=B0C)
 >
 > This is the reason why I am waiting for the Intel folks to give us the
 > details. Apparently your Windows application is reporting temperatures
 > 10 degrees higher, so I would guess that it assumes a critical
 > temperature limit of 110=C2=B0C for this CPU model (current temperatur=
e is
 > reported relative to the critical limit.) But I wouldn't really assume
 > they know it for sure either, given how hard it was to get the
 > information for the other CPU models.

I have found out that TJMax for this CPU is 105C.

 >
 > As for the core count, the coretemp driver will show one device for
 > each separate CPU entry. If you have 4 entries in /proc/cpuinfo, you
 > get 4 coretemp devices. If this is a dual core CPU then I have no idea
 > why you have 4 entries in /proc/cpuinfo.

This CPU has only two physical cores and it has HT (hyperthreading)=20
enabled, thus it shows itself as four cores for an operating system.=20
However I have a firm belief that HT "cores" should be omitted in=20
coretemp sensors output. I tried disabling the third and the fourth=20
cores using this configuration

chip "coretemp-*"

ignore temp3
ignore temp4

and even

ignore core3
ignore core4

but it doesn't seem to work.

 >
 >> Thank you very much, Jean, for your invaluable help.
 >
 > You're welcome.
 >

--------------010305010600030904070706
Content-Type: text/plain;
 name="adt7473.conf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="adt7473.conf"

IyBsbV9zZW5zb3JzIGNvbmZpZ3VyYXRpb24gZm9yIGFkdDc0NzMgY2hpcCBvbiBOVklESUEg
R2VGb3JjZSA4ODAwR1QgR1BVIGJ5IEFydGVtIFMuIFRhc2hraW5vdgojIFJlcXVpcmVtZW50
czoKIyAgICogbG9hZGVkIE5WSURJQSBiaW5hcnkgbW9kdWxlOwojICAgKiBlY2hvIGFkdDc0
NzMgMHgyZSA+IC9zeXMvY2xhc3MvaTJjLWFkYXB0ZXIvaTJjLTMvbmV3X2RldmljZSAoYWRq
dXN0IGZvciB5b3VyIGVudmlyb25tZW50KQoKY2hpcCAiYWR0NzQ3My0qIgoKIyBWb2x0YWdl
cwoKICAgIGlnbm9yZSBpbjEgICMgQWx3YXlzIHNob3dzIDMuMFYgaGVyZSwgbGV0J3Mgb21p
dCBpdAoKIyBUZW1wZXJhdHVyZXMKCiAgICBsYWJlbCAgdGVtcDEgICJHUFUgQ29yZSIKICAg
IGxhYmVsICB0ZW1wMiAgIkdQVSBBbWJpZW50IgogICAgaWdub3JlIHRlbXAzICMgU2hvdyB0
aGUgc2FtZSB0ZW1wZXJhdHVyZSBhcyB0ZW1wMSBzZW5zb3IKCiAgICBjb21wdXRlIHRlbXAx
IEArNy41LCBALTcuNQogICAgY29tcHV0ZSB0ZW1wMyBAKzcuNSwgQC03LjUKCiAgICBzZXQg
dGVtcDFfbWluICAgMjAKICAgIHNldCB0ZW1wM19taW4gICAyMAoKIyBGYW5zCgogICAgbGFi
ZWwgIGZhbjEgIkdQVSBGYW4iCiAgICBpZ25vcmUgZmFuMiAgIyBNeSA4ODAwR1QgR1BVIGhh
cyB0aGUgb25seSBmYW4KICAgIGlnbm9yZSBmYW4zICAjIExpa2V3aXNlCgo=
--------------010305010600030904070706
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------010305010600030904070706--
