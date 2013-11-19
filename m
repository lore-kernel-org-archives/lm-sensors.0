From: Mike Gilbert <mike@baymicrosystems.com>
Date: Tue, 19 Nov 2013 17:24:13 +0000
Subject: Re: [lm-sensors] Ticket #2382
Message-Id: <528B9EBD.1030303@baymicrosystems.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <528A62DC.9030107@baymicrosystems.com>
In-Reply-To: <528A62DC.9030107@baymicrosystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Guenter,

I think we understand this better now. Here is a table of diode temp & 
core temp:

diode core
   43  read error
   44    6
   45    7
   46   10
   48   13
   49   14
   50   15
   55   24
   66   40
   73   52
   76   58
   83   67
thermal shutdown

We got these readings by heating the CPU card.

 From 
http://www.lm-sensors.org/wiki/FAQ/Chapter3#coretempreturnsunrealisticvalues:
> The temperature value returned by the coretemp driver isn't absolute. 
> It's a thermal margin from the critical limit, and the greater the 
> margin, the worse the accuracy.

It appears that the new CPU has a very different core temperature 
profile from the previous CPU.

Mike


On 11/19/2013 11:38 AM, Guenter Roeck wrote:
> On Tue, Nov 19, 2013 at 10:04:08AM -0500, Mike Gilbert wrote:
>> Guenter,
>>
>> We're evaluating the new card in a open chassis. It is on the test
>> bench with a table fan for cooling. I turned off the fan and got:
>>
>>      ENTER show_temp
>>      cpu 0 (0)
>>      status_reg @ 19C
>>      eax = 885E0000 edx = 0
>>      temp = 1770 valid = 1
>>      EXIT show_temp
>>
>> It seems like you've seen this before. What's going on?
>>
> No, I was just throwing darts at a wall with my eyes closed.
> Seriously, it was just a wild guess. Idea was that the valid bit may be 0
> if the temperature is too low to be even remotely close to the maximum.
> For this chip, just to give you an example, the datasheet says that any
> reported temperature below 50 degrees C only means that the temperature
> is below 50 degrees C.
>
> Jean, any idea what we can do about this ? Report X degrees C (some constant
> below TjMax) if valid is 0 ?
>
> Guenter
>
>> Thanks,
>> Mike
>>
>>
>> On 11/19/2013 09:33 AM, Guenter Roeck wrote:
>>> On 11/19/2013 06:05 AM, Mike Gilbert wrote:
>>>> Guenter,
>>>>
>>>> Thanks for responding. The cards are both made by Emerson. The
>>>> old one is a COMX-430. The new one is a COMX-440.
>>>>
>>>> Mike
>>>>
>>>>
>>>> Here's the info from the old CPU card:
>>>>
>>>> processor    : 0
>>>> vendor_id    : GenuineIntel
>>>> cpu family    : 15
>>>> model        : 4
>>>> model name    : Intel(R) Xeon(TM) CPU 3.00GHz
>>>> stepping    : 3
>>>> cpu MHz        : 3000.000
>>>> cache size    : 2048 KB
>>>> physical id    : 0
>>>> siblings    : 2
>>>> core id        : 0
>>>> cpu cores    : 1
>>>> apicid        : 0
>>>> initial apicid    : 0
>>>> fpu        : yes
>>>> fpu_exception    : yes
>>>> cpuid level    : 5
>>>> wp        : yes
>>>> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
>>>> pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht
>>>> tm pbe syscall nx lm constant_tsc pebs bts nopl pni dtes64
>>>> monitor ds_cpl cid cx16 xtpr
>>>> bogomips    : 5986.15
>>>> clflush size    : 64
>>>> cache_alignment    : 128
>>>> address sizes    : 36 bits physical, 48 bits virtual
>>>> power management:
>>>>
>>>> processor    : 1
>>>> vendor_id    : GenuineIntel
>>>> cpu family    : 15
>>>> model        : 4
>>>> model name    : Intel(R) Xeon(TM) CPU 3.00GHz
>>>> stepping    : 3
>>>> cpu MHz        : 3000.000
>>>> cache size    : 2048 KB
>>>> physical id    : 0
>>>> siblings    : 2
>>>> core id        : 0
>>>> cpu cores    : 1
>>>> apicid        : 1
>>>> initial apicid    : 1
>>>> fpu        : yes
>>>> fpu_exception    : yes
>>>> cpuid level    : 5
>>>> wp        : yes
>>>> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
>>>> pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht
>>>> tm pbe syscall nx lm constant_tsc pebs bts nopl pni dtes64
>>>> monitor ds_cpl cid cx16 xtpr
>>>> bogomips    : 5985.19
>>>> clflush size    : 64
>>>> cache_alignment    : 128
>>>> address sizes    : 36 bits physical, 48 bits virtual
>>>> power management:
>>>>
>>>>
>>>> Here's the info from the new CPU card:
>>>>
>>>> processor       : 0
>>>> vendor_id       : GenuineIntel
>>>> cpu family      : 6
>>>> model           : 28
>>>> model name      : Intel(R) Atom(TM) CPU D510   @ 1.66GHz
>>> Yes, Jean was right, same issue, same response.
>>>
>>> One thing to try might be to see what happens
>>> if you put the system under load, ie heat up the CPU.
>>> Can you try that ?
>>>
>>> Thanks,
>>> Guenter
>>>
>>>> stepping        : 10
>>>> microcode       : 0x107
>>>> cpu MHz         : 1662.657
>>>> cache size      : 512 KB
>>>> physical id     : 0
>>>> siblings        : 4
>>>> core id         : 0
>>>> cpu cores       : 2
>>>> apicid          : 0
>>>> initial apicid  : 0
>>>> fpu             : yes
>>>> fpu_exception   : yes
>>>> cpuid level     : 10
>>>> wp              : yes
>>>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep
>>>> mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2
>>>> ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts
>>>> rep_good nopl aperfmperf pni dtes64 monitor ds_cpl tm2 ssse3
>>>> cx16 xtpr pdcm movbe lahf_lm dtherm
>>>> bogomips        : 3325.31
>>>> clflush size    : 64
>>>> cache_alignment : 64
>>>> address sizes   : 36 bits physical, 48 bits virtual
>>>> power management:
>>>>
>>>> processor       : 1
>>>> vendor_id       : GenuineIntel
>>>> cpu family      : 6
>>>> model           : 28
>>>> model name      : Intel(R) Atom(TM) CPU D510   @ 1.66GHz
>>>> stepping        : 10
>>>> microcode       : 0x107
>>>> cpu MHz         : 1662.657
>>>> cache size      : 512 KB
>>>> physical id     : 0
>>>> siblings        : 4
>>>> core id         : 0
>>>> cpu cores       : 2
>>>> apicid          : 1
>>>> initial apicid  : 1
>>>> fpu             : yes
>>>> fpu_exception   : yes
>>>> cpuid level     : 10
>>>> wp              : yes
>>>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep
>>>> mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2
>>>> ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts
>>>> rep_good nopl aperfmperf pni dtes64 monitor ds_cpl tm2 ssse3
>>>> cx16 xtpr pdcm movbe lahf_lm dtherm
>>>> bogomips        : 3325.31
>>>> clflush size    : 64
>>>> cache_alignment : 64
>>>> address sizes   : 36 bits physical, 48 bits virtual
>>>> power management:
>>>>
>>>> processor       : 2
>>>> vendor_id       : GenuineIntel
>>>> cpu family      : 6
>>>> model           : 28
>>>> model name      : Intel(R) Atom(TM) CPU D510   @ 1.66GHz
>>>> stepping        : 10
>>>> microcode       : 0x107
>>>> cpu MHz         : 1662.657
>>>> cache size      : 512 KB
>>>> physical id     : 0
>>>> siblings        : 4
>>>> core id         : 1
>>>> cpu cores       : 2
>>>> apicid          : 2
>>>> initial apicid  : 2
>>>> fpu             : yes
>>>> fpu_exception   : yes
>>>> cpuid level     : 10
>>>> wp              : yes
>>>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep
>>>> mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2
>>>> ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts
>>>> rep_good nopl aperfmperf pni dtes64 monitor ds_cpl tm2 ssse3
>>>> cx16 xtpr pdcm movbe lahf_lm dtherm
>>>> bogomips        : 3325.31
>>>> clflush size    : 64
>>>> cache_alignment : 64
>>>> address sizes   : 36 bits physical, 48 bits virtual
>>>> power management:
>>>>
>>>> processor       : 3
>>>> vendor_id       : GenuineIntel
>>>> cpu family      : 6
>>>> model           : 28
>>>> model name      : Intel(R) Atom(TM) CPU D510   @ 1.66GHz
>>>> stepping        : 10
>>>> microcode       : 0x107
>>>> cpu MHz         : 1662.657
>>>> cache size      : 512 KB
>>>> physical id     : 0
>>>> siblings        : 4
>>>> core id         : 1
>>>> cpu cores       : 2
>>>> apicid          : 3
>>>> initial apicid  : 3
>>>> fpu             : yes
>>>> fpu_exception   : yes
>>>> cpuid level     : 10
>>>> wp              : yes
>>>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep
>>>> mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2
>>>> ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts
>>>> rep_good nopl aperfmperf pni dtes64 monitor ds_cpl tm2 ssse3
>>>> cx16 xtpr pdcm movbe lahf_lm dtherm
>>>> bogomips        : 3325.31
>>>> clflush size    : 64
>>>> cache_alignment : 64
>>>> address sizes   : 36 bits physical, 48 bits virtual
>>>> power management:
>>>>
>>>>
>>>> On 11/18/2013 05:39 PM, Guenter Roeck wrote:
>>>>> What Atom chip ? Can you provide output of /proc/cpuinfo ?
>>>>>
>>>>> Thanks,
>>>>> Guenter
>>>>>
>>>>> On Mon, Nov 18, 2013 at 01:56:28PM -0500, Mike Gilbert wrote:
>>>>>> Do you have any additional information pertaining to ticket 2382?
>>>>>>
>>>>>> The CPU card we use in our products is going end-of-life. The CPU
>>>>>> card vendor send us a new card that is supposed to be a drop in
>>>>>> replacement (it's the same card with a newer Atom chip). The new
>>>>>> card returns an error when reading the coretemp:
>>>>>>
>>>>>>     # cat /sys/bus/platform/devices/coretemp.0/temp2_input
>>>>>>     cat: read error: Resource temporarily unavailable
>>>>>>     #
>>>>>>
>>>>>> Some printk debugging yields:
>>>>>>
>>>>>>     ENTER show_temp
>>>>>>     status_reg @ 19C
>>>>>>     eax = 8620000 edx = 0
>>>>>>     temp = 0 valid = 0
>>>>>>     EXIT show_temp
>>>>>>
>>>>>> This looks like the same issue described in your ticket 2382.
>>>>>>
>>>>>> Any information you can provide will be appreciated.
>>>>>>
>>>>>> Mike Gilbert
>>>>>> Principle Engineer
>>>>>> Bay Microsystems, Inc.
>>>>>>
>>>>>>
>>>>>> _______________________________________________
>>>>>> lm-sensors mailing list
>>>>>> lm-sensors@lm-sensors.org
>>>>>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>>>>>>
>>>>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
