From: Adam Nielsen <a.nielsen@shikadi.net>
Date: Mon, 19 Oct 2009 11:07:09 +0000
Subject: Re: [lm-sensors] Gigabyte GA-P35-DS3P - VID Zero value
Message-Id: <4ADC485D.2000300@shikadi.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
In-Reply-To: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

> I have the same board and would like to know as well, my output:

Well as long as we're comparing outputs I have a GA-P35-DS4 and my output
looks much the same:

it8718-isa-0290
Adapter: ISA adapter
in0:         +1.25 V  (min =  +0.00 V, max =  +4.08 V)
in1:         +1.87 V  (min =  +0.00 V, max =  +4.08 V)
in2:         +3.33 V  (min =  +0.00 V, max =  +4.08 V)
in3:         +3.01 V  (min =  +0.00 V, max =  +4.08 V)
in4:         +0.46 V  (min =  +0.00 V, max =  +4.08 V)
in5:         +0.06 V  (min =  +0.00 V, max =  +4.08 V)
in6:         +0.10 V  (min =  +0.00 V, max =  +4.08 V)
in7:         +3.04 V  (min =  +0.00 V, max =  +4.08 V)
in8:         +3.28 V
fan1:       1973 RPM  (min =   10 RPM)
fan2:       1229 RPM  (min =    0 RPM)
fan3:       1225 RPM  (min =    0 RPM)
fan4:       1231 RPM  (min =    0 RPM)
temp1:       +41.0°C  (low  = +127.0°C, high = +127.0°C)  sensor = thermistor
temp2:       +42.0°C  (low  = +127.0°C, high = +60.0°C)  sensor = thermal diode
temp3:        -2.0°C  (low  = +127.0°C, high = +127.0°C)  sensor = thermistor
cpu0_vid:   +0.000 V

As far as I can gather, it's because the hwmon-vid module doesn't recognise my
CPU.  Which is odd, because I don't have a message in my logs indicating so.
My kernel is 2.6.30 which is a little on the old side now, but looking at the
latest git kernel there doesn't seem to be any mention of the Intel Core2 series.

Am I reading that right?  This is my CPU:

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 6
model           : 15
model name      : Intel(R) Core(TM)2 Quad CPU    Q6600  @ 2.40GHz
stepping        : 11
cpu MHz         : 2997.028
cache size      : 4096 KB
physical id     : 0
siblings        : 4
core id         : 1
cpu cores       : 4
apicid          : 1
initial apicid  : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm
constant_tsc arch_perfmon pebs bts rep_good pni dtes64 monitor ds_cpl vmx est
tm2 ssse3 cx16 xtpr pdcm lahf_lm tpr_shadow vnmi flexpriority
bogomips        : 5993.91
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

Cheers,
Adam.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
