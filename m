From: Michael Markusch <markuschmichael@gmx.de>
Date: Wed, 20 Jun 2012 17:34:38 +0000
Subject: Re: [lm-sensors] Lifebook E8020, no sensors
Message-Id: <4FE209AE.4060606@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FE0EE87.8080806@gmx.de>
In-Reply-To: <4FE0EE87.8080806@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

>> After "sudo modprobe coretemp", did you get an error message, or do you
>> see anything in the kernel log ?

I got no messages in kern.log or shell.

Thanks,
Michael

Am 20.06.2012 19:12, schrieb Guenter Roeck:
> On Wed, 2012-06-20 at 12:40 -0400, Michael Markusch wrote:
>> Hi Jean,
>>
>> thank you for your answer!
>>
>>>> I'm not sure. Please try:
>>>> * The latest version of sensors-detect:
>>>>   http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
>>>> * Loading the coretemp driver manually even if sensors-detect did not
>>>>   recommend it.
>>
>> I tried this steps, but it doesn't work.
>>
> After "sudo modprobe coretemp", did you get an error message, or do you
> see anything in the kernel log ?
> 
> Thanks,
> Guenter
> 
>>>> If that doesn't work, please provide the contents of /proc/cpuinfo.
>>
>> processor	: 0
>> vendor_id	: GenuineIntel
>> cpu family	: 6
>> model		: 13
>> model name	: Intel(R) Pentium(R) M processor 2.00GHz
>> stepping	: 8
>> microcode	: 0x20
>> cpu MHz		: 2000.000
>> cache size	: 2048 KB
>> fdiv_bug	: no
>> hlt_bug		: no
>> f00f_bug	: no
>> coma_bug	: no
>> fpu		: yes
>> fpu_exception	: yes
>> cpuid level	: 2
>> wp		: yes
>> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
>> clflush dts acpi mmx fxsr sse sse2 ss tm pbe nx up bts est tm2
>> bogomips	: 3990.13
>> clflush size	: 64
>> cache_alignment	: 64
>> address sizes	: 32 bits physical, 32 bits virtual
>> power management:
>>
>>>> Do you have a special file named /dev/cpu/0/cpuid after loading the
>>>> cpuid driver?
>>
>> Yes, there is an empty file named cpuid.
>>
>> Do you have an idea?
>>
>> Thanks,
>> Michael
>>
>> Am 20.06.2012 09:00, schrieb Jean Delvare:
>>> On Tue, 19 Jun 2012 23:26:31 +0200, Michael Markusch wrote:
>>>> Hi all,
>>>>
>>>> I have an old Fujitsu Siemens Lifebook E8020 notebook. Since Ubuntu 9.??
>>>> update I can not read CPU temperature by lm-sensors. Before that it was
>>>> possible to display the temperature, but I can not say how I did it. I
>>>> guess, I used coretemp... Now, the notebook runs with
>>>> Ubuntu 12.04 and the problem is the same, see the log-files.
>>>>
>>>> What could be the problem?
>>>
>>> I'm not sure. Please try:
>>> * The latest version of sensors-detect:
>>>   http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
>>> * Loading the coretemp driver manually even if sensors-detect did not
>>>   recommend it.
>>>
>>> If that doesn't work, please provide the contents of /proc/cpuinfo. I
>>> admit I am surprised because your CPU supposedly has feature DTS (so
>>> coretemp should work) although product number is 13 when I thought DTS
>>> was first implemented with family 14.
>>>
>>> Do you have a special file named /dev/cpu/0/cpuid after loading the
>>> cpuid driver?
>>>
>>
>> _______________________________________________
>> lm-sensors mailing list
>> lm-sensors@lm-sensors.org
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
