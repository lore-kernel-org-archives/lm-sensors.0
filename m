From: Agile Aspect <agile.aspect@gmail.com>
Date: Fri, 25 Jul 2008 19:51:40 +0000
Subject: Re: [lm-sensors] temperature monitor
Message-Id: <488A2ECC.5060202@GMail.COM>
List-Id: <lm-sensors.vger.kernel.org>
References: <487CCD71.8000909@GMail.COM>
In-Reply-To: <487CCD71.8000909@GMail.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Frank - enclosed is the /proc/cpuinfo file.

Typically where 'coretemp' is displayed the output
of 'sensor-detect' displayed  'to-be-written'.

-- Ken


Frank Phillips wrote:
>> Here's the summary of the sensors that 'sensor-detect' detected:
>>
>>   Detects correctly:
>>  * Chip `Intel AMB FB-DIMM thermal sensor' (confidence: 9)
>>
>> However,  it indicated
>>
>>   Intel AMB FB-DIMM thermal sensor...                         Success!
>>   (driver `to-be-written')
>>
>> Does this imply I'm out of luck?
>>
>> -- Ken
>>     
>
> The driver i5k_amb was added to kernel 2.6.24. Looks like no one has
> sent a patch for lm_sensors to use it.
>
> Did it not detect coretemp? Rudolf, is this processor not covered by
> your Penryn patch? Ken, please send your /proc/cpuinfo output.
>
> Thanks,
> Frank
>
>   
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Intel(R) Xeon(R) CPU           X5460  @ 3.16GHz
stepping        : 6
cpu MHz         : 3158.792
cache size      : 6144 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 4
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall 
nx lm pni monitor ds_cpl est tm2 cx16 xtpr
bogomips        : 6321.75
clflush size    : 64
cache_alignment : 64
address sizes   : 38 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Intel(R) Xeon(R) CPU           X5460  @ 3.16GHz
stepping        : 6
cpu MHz         : 3158.792
cache size      : 6144 KB
physical id     : 1
siblings        : 4
core id         : 4
cpu cores       : 4
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall 
nx lm pni monitor ds_cpl est tm2 cx16 xtpr
bogomips        : 6317.59
clflush size    : 64
cache_alignment : 64
address sizes   : 38 bits physical, 48 bits virtual
power management:

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Intel(R) Xeon(R) CPU           X5460  @ 3.16GHz
stepping        : 6
cpu MHz         : 3158.792
cache size      : 6144 KB
physical id     : 0
siblings        : 4
core id         : 2
cpu cores       : 4
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall 
nx lm pni monitor ds_cpl est tm2 cx16 xtpr
bogomips        : 6317.56
clflush size    : 64
cache_alignment : 64
address sizes   : 38 bits physical, 48 bits virtual
power management:

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Intel(R) Xeon(R) CPU           X5460  @ 3.16GHz
stepping        : 6
cpu MHz         : 3158.792
cache size      : 6144 KB
physical id     : 1
siblings        : 4
core id         : 6
cpu cores       : 4
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall nx lm pni 
monitor
ds_cpl est tm2 cx16 xtpr
bogomips        : 6317.60
clflush size    : 64
cache_alignment : 64
address sizes   : 38 bits physical, 48 bits virtual
power management:

processor       : 4
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Intel(R) Xeon(R) CPU           X5460  @ 3.16GHz
stepping        : 6
cpu MHz         : 3158.792
cache size      : 6144 KB
physical id     : 0
siblings        : 4
core id         : 1
cpu cores       : 4
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall 
nx lm pni monitor ds_cpl est tm2 cx16 xtpr
bogomips        : 6317.52
clflush size    : 64
cache_alignment : 64
address sizes   : 38 bits physical, 48 bits virtual
power management:

processor       : 5
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Intel(R) Xeon(R) CPU           X5460  @ 3.16GHz
stepping        : 6
cpu MHz         : 3158.792
cache size      : 6144 KB
physical id     : 1
siblings        : 4
core id         : 5
cpu cores       : 4
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall 
nx lm pni monitor ds_cpl est tm2 cx16 xtpr
bogomips        : 6317.60
clflush size    : 64
cache_alignment : 64
address sizes   : 38 bits physical, 48 bits virtual
power management:

processor       : 6
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Intel(R) Xeon(R) CPU           X5460  @ 3.16GHz
stepping        : 6
cpu MHz         : 3158.792
cache size      : 6144 KB
physical id     : 0
siblings        : 4
core id         : 3
cpu cores       : 4
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall 
nx lm pni monitor ds_cpl est tm2 cx16 xtpr
bogomips        : 6317.57
clflush size    : 64
cache_alignment : 64
address sizes   : 38 bits physical, 48 bits virtual
power management:

processor       : 7
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Intel(R) Xeon(R) CPU           X5460  @ 3.16GHz
stepping        : 6
cpu MHz         : 3158.792
cache size      : 6144 KB
physical id     : 1
siblings        : 4
core id         : 7
cpu cores       : 4
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall 
nx lm pni monitor ds_cpl est tm2 cx16 xtpr
bogomips        : 6317.60
clflush size    : 64
cache_alignment : 64
address sizes   : 38 bits physical, 48 bits virtual
power management:





-- 
Article. VI. Clause 3 of the constitution of the United States states: 

"The Senators and Representatives before mentioned, and the Members of 
the several State Legislatures, and all executive and judicial Officers, 
both of the United States and of the several States, shall be bound by 
Oath or Affirmation, to support this Constitution; but no religious Test 
shall ever be required as a Qualification to any Office or public Trust 
under the United States." 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
