From: Roderick Johnstone <rmj@ast.cam.ac.uk>
Date: Wed, 20 Jan 2010 12:11:28 +0000
Subject: Re: [lm-sensors] ADT 7490 report
Message-Id: <4B56F2F0.9090700@ast.cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B56E28D.6080704@ast.cam.ac.uk>
In-Reply-To: <4B56E28D.6080704@ast.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On 20/01/10 11:53, Jean Delvare wrote:
> Hi Roderick,
>
> On Wed, 20 Jan 2010 11:01:33 +0000, Roderick Johnstone wrote:
>> I have an Intel DP55WB motherboard which sensors-detect reports has an
>> adt 7490 chip.
>>
>> Probing for `Analog Devices ADT7490'...                     Success!
>>       (confidence 5, driver `to-be-written')
>>
>> I downloaded the standalone driver from:
>> http://khali.linux-fr.org/devel/misc/adt7490/
>> as linked from:
>> http://www.lm-sensors.org/wiki/Devices
>>
>> After building and modprobing, sensors reports:
>>
>> linux>  sensors
>> adt7490-i2c-0-2c
>> Adapter: SMBus I801 adapter at 1000
>> in0:         +1.50 V  (min =  +0.00 V, max =  +3.31 V)
>> in1:         +0.87 V  (min =  +0.00 V, max =  +2.99 V)
>> in2:         +3.29 V  (min =  +0.00 V, max =  +4.39 V)
>> in3:         +5.16 V  (min =  +0.00 V, max =  +6.68 V)
>> in4:        +12.01 V  (min =  +0.00 V, max = +15.69 V)
>> in5:         +2.17 V  (min =  +0.00 V, max =  +4.48 V)
>> fan1:        728 RPM  (min =    0 RPM)
>> fan2:          0 RPM  (min =    0 RPM)
>> fan3:       1124 RPM  (min =    0 RPM)
>> fan4:          0 RPM  (min =    0 RPM)
>> temp1:         FAULT  (low  = -127.0°C, high = +127.0°C)  ALARM
>>                         (crit = +100.0°C, hyst = +100.0°C)
>> temp2:       +35.2°C  (low  = -127.0°C, high = +127.0°C)
>>                         (crit = +65.0°C, hyst = +61.0°C)
>> temp3:       +37.8°C  (low  = -127.0°C, high = +127.0°C)
>>                         (crit = +65.0°C, hyst = +61.0°C)
>
> Thanks for reporting. Glad to seem it seems to work fine for you.
>
>> The fan speeds look plausible, compared with what I have seen reported
>> in the bios.
>>
>> But, I was expecting to see temperatures for each of the 4 cores in the
>> i7-860 cpu.
>>
>> I'd be happy to work with the developer in testing any updates that
>> might fix this.
>
> The CPU core temperatures would be reported by another driver:
> coretemp.
>
> The temperatures reported by the ADT7490 are the temperature of that
> chip itself (temp2) and the temperatures of 2 external thermal diodes
> (temp1 and temp3). temp1 isn't connected on your system. As the ADT7490
> is on your motherboard, temp2 is the motherboard temperature. temp3
> could be anything on the motherboard: CPU, CPU socket, north bridge...

Thank you for such a quick and clear explanation.

>
> As a starter, you can add the following to your configuration file:
>
> chip "adt7490-i2c-*-2c"
>
>     label temp2 "M/B Temp"

Done.

linux> sensors
adt7490-i2c-0-2c
Adapter: SMBus I801 adapter at 1000
in0:         +1.50 V  (min =  +0.00 V, max =  +3.31 V)
in1:         +0.87 V  (min =  +0.00 V, max =  +2.99 V)
in2:         +3.29 V  (min =  +0.00 V, max =  +4.39 V)
in3:         +5.16 V  (min =  +0.00 V, max =  +6.68 V)
in4:        +12.00 V  (min =  +0.00 V, max = +15.69 V)
in5:         +2.17 V  (min =  +0.00 V, max =  +4.48 V)
fan1:        754 RPM  (min =    0 RPM)
fan2:          0 RPM  (min =    0 RPM)
fan3:       1130 RPM  (min =    0 RPM)
fan4:          0 RPM  (min =    0 RPM)
temp1:         FAULT  (low  = -127.0°C, high = +127.0°C)  ALARM
                       (crit = +100.0°C, hyst = +100.0°C)
M/B Temp:    +38.0°C  (low  = -127.0°C, high = +127.0°C)
                       (crit = +65.0°C, hyst = +61.0°C)
temp3:       +39.0°C  (low  = -127.0°C, high = +127.0°C)
                       (crit = +65.0°C, hyst = +61.0°C)

>
>
> I don't know which kernel version is needed for the coretemp driver to
> support the i7. Please share the contents of /proc/cpuinfo with us (the
> first core is enough) and also let us know which kernel version you're
> running.
>

linux> cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 30
model name      : Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
stepping        : 5
cpu MHz         : 1197.000
cache size      : 8192 KB
physical id     : 0
siblings        : 8
core id         : 0
cpu cores       : 4
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 11
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good xtopology 
tsc_reliable nonstop_tsc pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida tpr_shadow vnmi 
flexpriority ept vpid
bogomips        : 5599.23
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

linux> uname -a
Linux xpc7.ast.cam.ac.uk 2.6.31.9-174.fc12.x86_64 #1 SMP Mon Dec 21 
05:33:33 UTC 2009 x86_64 x86_64 x86_64 GNU/Linux

This is the current Fedora 12 kernel.

Roderick

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
