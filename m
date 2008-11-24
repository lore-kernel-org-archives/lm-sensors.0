From: "Jon Hewer" <jonhewer@gmail.com>
Date: Mon, 24 Nov 2008 10:15:12 +0000
Subject: Re: [lm-sensors] Gigabyte GA-MA69G-S3H it8716 temperatures?
Message-Id: <d76c7b8f0811240215i19c545cbh82d7f086b8321b65@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <d76c7b8f0811240127y1e8d1f5etdc5dd76fd0b5b29@mail.gmail.com>
In-Reply-To: <d76c7b8f0811240127y1e8d1f5etdc5dd76fd0b5b29@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

Thanks very much for your reply.

I've just tried running two "md5sum /dev/zero" commands in parallel.
After about 30 seconds or so temp2 increased from 25 to 31 and temp3
from 19 to 28.  I suppose this along with your comment about thermal
diode measurement type suggests temp3 is my CPU temp.

My CPU isn't water cooled, however it is an Athlon X2 4450e which is
meant to run pretty cool, and I've also upgraded to a better heatsink
than the retail one.

After building my server I did check the temperatures in the BIOS,
which returned a temperature of about 26 degrees or so for the CPU.  I
don't have a monitor hooked up to my server at the moment, but might
do so to check the BIOS again now that I have the lm-sensors output
for comparison.

As requested, here is the contents of /proc/cpuinfo

$ cat /proc/cpuinfo
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 107
model name	: AMD Processor model unknown
stepping	: 2
cpu MHz		: 2305.229
cache size	: 512 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 2
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
rdtscp lm 3dnowext 3dnow rep_good pni cx16 lahf_lm cmp_legacy svm
extapic cr8_legacy 3dnowprefetch
bogomips	: 4614.17
TLB size	: 1024 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc 100mhzsteps

processor	: 1
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 107
model name	: AMD Processor model unknown
stepping	: 2
cpu MHz		: 2305.229
cache size	: 512 KB
physical id	: 0
siblings	: 2
core id		: 1
cpu cores	: 2
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
rdtscp lm 3dnowext 3dnow rep_good pni cx16 lahf_lm cmp_legacy svm
extapic cr8_legacy 3dnowprefetch
bogomips	: 4610.51
TLB size	: 1024 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc 100mhzsteps

Thanks for your help,
Jon

On Mon, Nov 24, 2008 at 9:52 AM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Jon,
>
> On Mon, 24 Nov 2008 09:27:08 +0000, Jon Hewer wrote:
>> The output of sensors for my Gigabyte GA-MA69G-S3H motherboard is as fol=
lows:
>>
>> k8temp-pci-00c3
>> Adapter: PCI adapter
>> Core0 Temp:   -6.0=B0C
>> Core0 Temp:   +1.0=B0C
>> Core1 Temp:   -8.0=B0C
>> Core1 Temp:   -5.0=B0C
>>
>> it8716-isa-0228
>> Adapter: ISA adapter
>> VCore:       +1.18 V  (min =3D  +0.00 V, max =3D  +4.08 V)
>> VDDR:        +1.94 V  (min =3D  +0.00 V, max =3D  +4.08 V)
>> +3.3V:       +3.25 V  (min =3D  +0.00 V, max =3D  +4.08 V)
>> +5V:         +4.92 V  (min =3D  +0.00 V, max =3D  +6.85 V)
>> +12V:       +12.10 V  (min =3D  +0.00 V, max =3D +16.32 V)
>> in5:         +3.14 V  (min =3D  +0.00 V, max =3D  +4.08 V)
>> in6:         +0.10 V  (min =3D  +0.00 V, max =3D  +4.08 V)
>> 5VSB:        +4.92 V  (min =3D  +0.00 V, max =3D  +6.85 V)
>> VBat:        +3.10 V
>> fan1:       1341 RPM  (min =3D    0 RPM)
>> fan2:       1002 RPM  (min =3D    0 RPM)
>> temp1:       +33.0=B0C  (low  =3D +127.0=B0C, high =3D +60.0=B0C)  senso=
r =3D transistor
>> temp2:       +25.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sens=
or =3D transistor
>> temp3:       +19.0=B0C  (low  =3D +127.0=B0C, high =3D +60.0=B0C)  senso=
r =3D thermal diode
>> cpu0_vid:   +1.200 V
>
> Preliminary note: the "transistor" above should read "thermistor",
> that's a bug in the it87 driver which has been fixed already.
>
>> Firstly, I am trying to identify the three temperature readings
>> returned by the it8716 module.  I have checked the sensors.conf and
>> there is a note saying that it is motherboard specific.  I have
>> contacted the manufacturer of my motherboard, but they haven't been
>> able to help.
>>
>> Has anybody else been able to identify which readings these are?  I'm
>> guessing temp1=3Dnorthbridge, temp2=3Dcpu and temp3=3Dsystem...
>
> As a rule of thumb, CPU temperature is most often measured by a thermal
> diode and motherboard temperature by a thermistor. That would be
> temp1=3Dsystem and temp3=3Dcpu. That being said, I have to admit that 19
> degrees C is very low for CPU temperature, unless it is water-cooled.
>
> A quick test you can do to find out who is who is to put significant
> load on the CPU (for example, "md5sum /dev/zero" running twice in
> parallel for a dual-core CPU) and see which temperature is rising
> faster. That will be the CPU temperature.
>
> You can also compare the readings in the BIOS with those returned by
> "sensors" under Linux. The readings in the BIOS should be equivalent to
> those of "sensors" under moderate load.
>
> Also note that Gigabyte has a long record of doing nasty things with
> temperature sensors. For example, temp2 reads 25 degrees C... did it
> ever change? On many Gigabyte boards, one temperature input is
> connected to a simple resistor instead of a thermistor, so it reads 25
> degrees C all the time. Such inputs should be ignored by adding "ignore
> temp2" in sensors.conf.
>
>> Secondly, the core temps returned by the k8temp module look a bit odd.
>>  Am I just misunderstanding these readings, or do I need to tweak my
>> conf?
>
> This is a hardware issue, many K8 rev. F and later have broken sensors.
> There's nothing we can do. Please send the contents of /proc/cpuinfo,
> when we have enough data we might be able to blacklist the CPU models
> that are known to be broken.
>
> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
