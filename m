From: Jan Richling <jan@richling.de>
Date: Sun, 07 Oct 2007 14:49:37 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp driver and Celeron 430 - works
Message-Id: <4708F201.7020506@richling.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4708C611.5040808@assembler.cz>
In-Reply-To: <4708C611.5040808@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

thanks for your answer and the patch. I just reversed my changes (which
were, by the way, equal to yours except one linebreak) and applied your
patch. Compiles and loads with no problems and gives...

hotaru # sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +45 C  (high =  +100 C)

-> works perfectly.

Greetings,

Jan

> Sorry for the delay, I'm busy with other stuff too.
> 
> Thank you for the report, I check the revision guide and everything seems ok. I
> would like you to test attach patch. I think it does only what you did + updates
> the documentation.
> 
> Please can you test that patch?
> 
> Signed-off-by: Rudolf Marek <r.marek@assembler.cz>
> 
> This patch adds support for the Celeron 4xx based on Core 2 core.
> 
> Thanks,
> 
> Rudolf
> 
> 
> 
> 
> Jan Richling wrote:
>> Hi,
>>
>> I just tested your coretemp driver on a Celeron 430 (Core 2 based) and
>> got unknown CPU model 16 which is triggered by the condition that you
>> only accept model 0xe or 0xf as valid devices. The Celeron 4xx is model
>> 22 (0x16) so I patched the driver by adding (|| (c->x86_model = 0x16)).
>> This works out of the box with no further modifications and shows
>> temperatures that are equal to those displayed by a Windows utility on
>> the same machine.
>>
>> So I can tell you that your driver works for family 6, model 22 also.
>>
>> Just to be complete here is the cpuinfo:
>>
>> cat /proc/cpuinfo
>> processor       : 0
>> vendor_id       : GenuineIntel
>> cpu family      : 6
>> model           : 22
>> model name      : Intel(R) Celeron(R) CPU          430  @ 1.80GHz
>> stepping        : 1
>> cpu MHz         : 2400.147
>> cache size      : 512 KB
>> fpu             : yes
>> fpu_exception   : yes
>> cpuid level     : 10
>> wp              : yes
>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
>> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss tm syscall lm
>> constant_tsc pni monitor ds_cpl tm2 ssse3 cx16 xtpr lahf_lm
>> bogomips        : 4802.79
>> clflush size    : 64
>> cache_alignment : 64
>> address sizes   : 36 bits physical, 48 bits virtual
>> power management:
>>
>> (it shows 2400 MHz due to FSB-mod (200->266) and the resulting
>> overclock, stock is 9x200=1,8 GHz)
>>
>> Greetings and many thanks for the driver,
>>
>> Jan
>>
>>    ------------------------------------------------------------------
>>   / Dr. Jan Richling - http://www.richling.de                      /
>>  / Member of Computer Architecture and Communication Group -      /
>> / Department of Computer Science - Humboldt University Berlin    /


-- 

Jan

   ------------------------------------------------------------------
  / Dr. Jan Richling - http://www.richling.de                      /
 / Member of Computer Architecture and Communication Group -      /
/ Department of Computer Science - Humboldt University Berlin    /

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
