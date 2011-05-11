From: Jeff Rickman <jrickman@myamigos.us>
Date: Wed, 11 May 2011 17:59:35 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <4DCACE87.5070400@myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 5/11/2011 10:08 AM, Jean Delvare wrote:
> On Wed, 11 May 2011 16:28:04 +0200, Luca Tettamanti wrote:
>> On Wed, May 11, 2011 at 04:15:45PM +0200, Jean Delvare wrote:
>>> On Wed, 11 May 2011 15:48:59 +0200, Luca Tettamanti wrote:
>>>> The driver uses lahf to copy the lowest byte of EFLAGS to eax, then
>>>> shifts it to right and test the lowest bit (CF).
>>>> Using pushf instead we get the whole EFLAGS and test the lowest bit.
>>>> Does it make sense? Someone should double check the patch, I don't trust
>>>> my assembly skills ;)
>>>>
>>>> diff --git a/drivers/char/i8k.c b/drivers/char/i8k.c
>>>> index d72433f..3554d10 100644
>>>> --- a/drivers/char/i8k.c
>>>> +++ b/drivers/char/i8k.c
>>>> @@ -139,8 +139,8 @@ static int i8k_smm(struct smm_regs *regs)
>>>>   		"movl %%edi,20(%%rax)\n\t"
>>>>   		"popq %%rdx\n\t"
>>>>   		"movl %%edx,0(%%rax)\n\t"
>>>> -		"lahf\n\t"
>>>> -		"shrl $8,%%eax\n\t"
>>>> +		"pusfh\n\t"
>>>
>>> I think you meant pushf, not pusfh, right?
>>
>> Yeah, right... hand me that brown paper bag ;)
>>
>>>
>>>> +		"popl %%eax\n\t"
>>>>   		"andl $1,%%eax\n"
>>>>   		:"=a"(rc)
>>>>   		:    "a"(regs)
>>>
>>> I am no asm expert, but I don't get why you removed the shrl
>>> instruction. As I understand it, your pushf+popl replaces only lahf,
>>> the bit shifting is still needed (I assume the code wants to test bit 8
>>> in the flag register.)
>>
>> AFAIK lahf loads the lowest byte of EFLAGS into AH which is the upper
>> half of AX, hence the shift.
>
> Yes, you're right, of course. So much for my asm skills. Please return
> the brown paper bag to me when you're done ;)
>
>> The popl is wrong though, pushf only pushes 2 bytes... so let's try
>> again:
>>
>> diff --git a/drivers/char/i8k.c b/drivers/char/i8k.c
>> index d72433f..f71f266 100644
>> --- a/drivers/char/i8k.c
>> +++ b/drivers/char/i8k.c
>> @@ -139,8 +139,8 @@ static int i8k_smm(struct smm_regs *regs)
>>   		"movl %%edi,20(%%rax)\n\t"
>>   		"popq %%rdx\n\t"
>>   		"movl %%edx,0(%%rax)\n\t"
>> -		"lahf\n\t"
>> -		"shrl $8,%%eax\n\t"
>> +		"pushf\n\t"
>> +		"pop %%ax\n\t"
>>   		"andl $1,%%eax\n"
>>   		:"=a"(rc)
>>   		:    "a"(regs)
>
> Looks reasonable. I can't test it as I don't have the hardware, but I
> have updated the driver at:
>    http://khali.linux-fr.org/devel/misc/i8k/
> with the above fix. Jeff, Harry, can you test?
>
> Thanks,

[test results]
compile new i8k module
no compile errors noticed
do not load new i8k module
do not copy new module to /lib/modules tree

load "stock" driver (to verify baseline behavior)
non-fatal crash results
reboot

remove "stock" i8k module
copy new i8k module to /lib/modules/`uname -r`/kernel/drivers/char
run depmod -a

modinfo /lib/modules/`uname -r`/kernel/drivers/char/i8k.ko 

filename: 
/lib/modules/2.6.35.12-90.fc14.x86_64/kernel/drivers/char/i8k.ko
license:        GPL
description:    Driver for accessing SMM BIOS on Dell laptops
author:         Massimo Dal Zotto (dz@debian.org)
srcversion:     0FCA3FE04945CA449B9A849
depends:
vermagic:       2.6.35.12-90.fc14.x86_64 SMP mod_unload
parm:           force:Force loading without checking for supported 
models (bool)
parm:           ignore_dmi:Continue probing hardware even if DMI data 
does not match (bool)
parm:           restricted:Allow fan control if SYS_ADMIN capability set 
(bool)
parm:           power_status:Report power status in /proc/i8k (bool)
parm:           fan_mult:Factor to multiply fan speed with (int)

load new i8k module

modprobe -v i8k
insmod /lib/modules/2.6.35.12-90.fc14.x86_64/kernel/drivers/char/i8k.ko
FATAL: Error inserting i8k 
(/lib/modules/2.6.35.12-90.fc14.x86_64/kernel/drivers/char/i8k.ko): No 
such device

from /var/log/messages
May 11 12:39:11 XX kernel: [  263.320306] i8k: unable to get SMM Dell 
signature

modprobe -v i8k force
insmod /lib/modules/2.6.35.12-90.fc14.x86_64/kernel/drivers/char/i8k.ko 
force

from /var/log/messages
May 11 12:39:11 XX kernel: [  263.320306] i8k: unable to get SMM Dell 
signature
May 11 12:40:52 XX kernel: [  365.019189] i8k: unable to get SMM Dell 
signature
May 11 12:40:52 XX kernel: [  365.020148] i8k: unable to get SMM BIOS 
version
May 11 12:40:52 XX kernel: [  365.027736] Dell laptop SMM driver v1.14 
21/02/2005 Massimo Dal Zotto (dz@debian.org)

I will guess that this detection issue is not due to the changes made by 
Jean and Luca. This module may be at a dead end for my hardware.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
