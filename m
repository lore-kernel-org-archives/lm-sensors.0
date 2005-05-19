From: charles@defenderhosting.com (Charles Galpin)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: i2c-amd756 and dual opteron sensors not foun
Message-Id: <545044F4-6B98-11D8-9854-000A958E5EF8@defenderhosting.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
In-Reply-To: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Philip

I can't find a adm1027 module, source or binary. When I modprobe lm85 I 
get no errors.

[root@opteron root]# modprobe lm85
[root@opteron root]# lsmod
Module                  Size  Used by    Not tainted
lm85                   24052   0  (unused)
i2c-proc                9800   0  [lm85]
i2c-dev                 5696   0
i2c-amd756              5138   0
i2c-core               25124   0  [lm85 i2c-proc i2c-dev i2c-amd756]
..

Mar  1 07:44:30 opteron kernel: i2c-proc.o version 2.8.4 (20040207)
Mar  1 07:44:30 opteron kernel: lm85: Version 2.8.4 (20040207)
Mar  1 07:44:30 opteron kernel: lm85: See 
http://www.penguincomputing.com/lm_sensors for more info.

[root@opteron root]# uname -a
Linux opteron 2.4.22-1.2135.nptlsmp #1 SMP Mon Dec 15 15:45:38 EST 2003 
x86_64 x86_64 x86_64 GNU/Linux

[root@opteron root]# ls 
/lib/modules/2.4.22-1.2135.nptlsmp/kernel/drivers/i2c/chips/adm*
/lib/modules/2.4.22-1.2135.nptlsmp/kernel/drivers/i2c/chips/adm1021.o
/lib/modules/2.4.22-1.2135.nptlsmp/kernel/drivers/i2c/chips/adm1024.o
/lib/modules/2.4.22-1.2135.nptlsmp/kernel/drivers/i2c/chips/adm1025.o
/lib/modules/2.4.22-1.2135.nptlsmp/kernel/drivers/i2c/chips/adm1026.o
/lib/modules/2.4.22-1.2135.nptlsmp/kernel/drivers/i2c/chips/adm9240.o

thanks,

charles

On Mar 1, 2004, at 10:20 AM, Philip Pokorny wrote:

> The ADM1027 is a monitoring chip.  There is a driver written for it. 
> "adm1027"
>
> What happens when you "modprobe adm1027" or "insmod 
> kernel/chips/adm1027.o"?
>
> If there is an error message, post that and the output from "dmesg | 
> tail -30"
>
> Thanks,
> :v)
>
> Charles Galpin wrote:
>
>>
>> On Feb 29, 2004, at 5:14 PM, Jean Delvare wrote:
>>
>>> Hi Charles,
>>>
>>> The Super-I/O chip on your board seems to be a PC87366 by National
>>> Semiconductor. At least the device ID matches. That said, it still  
>>> looks
>>> like a disabled chip (at least the hardware monitoring part of it).
>>>
>>> Please confirm this information if you can (docs, manufacturer,
>>> visual... whatever).
>>
>>
>> Hi Jean
>>
>> I was trying not to bother everyone before emailing again. I have  
>> requested more info from the vendor who has a close relationship with 
>>  MSI and *should* be able to provide the info.
>>
>> I did get to look at the hardware last night though. It turns out the 
>>  motherboard is a MS-9145 - which I cannot find any info on. The only 
>>  winbond chip I see is a W986432DH-6 which is SDRAM.  I'm honestly 
>> not  exactly sure what I'm looking for so I wrote down the info for 
>> any  chips i could see. I did find info on one marked 'ADM1027 51'. 
>> google  pointed me to
>>
>> http://www.analog.com/Analog_Root/productPage/productHome/ 
>> 0%2C%2CADM1027%2C00.html
>>
>> Which looks right on the money. Not sure it jives with your PC87366  
>> identification though?
>>
>> Everything else was clearly not a sensor, and I did not see anything  
>> with PC87366 on it.
>>
>> Does this help?
>>
>> I'll let you know what I get from the vendor. Thanks again for  
>> continuing to look into this!
>>
>> charles
>>
>
