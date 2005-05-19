From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: i2c-amd756 and dual opteron sensors not foun
Message-Id: <404354A5.7010600@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
In-Reply-To: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The ADM1027 is a monitoring chip.  There is a driver written for it. 
"adm1027"

What happens when you "modprobe adm1027" or "insmod kernel/chips/adm1027.o"?

If there is an error message, post that and the output from "dmesg | 
tail -30"

Thanks,
:v)

Charles Galpin wrote:

>
> On Feb 29, 2004, at 5:14 PM, Jean Delvare wrote:
>
>> Hi Charles,
>>
>> The Super-I/O chip on your board seems to be a PC87366 by National
>> Semiconductor. At least the device ID matches. That said, it still  
>> looks
>> like a disabled chip (at least the hardware monitoring part of it).
>>
>> Please confirm this information if you can (docs, manufacturer,
>> visual... whatever).
>
>
> Hi Jean
>
> I was trying not to bother everyone before emailing again. I have  
> requested more info from the vendor who has a close relationship with  
> MSI and *should* be able to provide the info.
>
> I did get to look at the hardware last night though. It turns out the  
> motherboard is a MS-9145 - which I cannot find any info on. The only  
> winbond chip I see is a W986432DH-6 which is SDRAM.  I'm honestly not  
> exactly sure what I'm looking for so I wrote down the info for any  
> chips i could see. I did find info on one marked 'ADM1027 51'. google  
> pointed me to
>
> http://www.analog.com/Analog_Root/productPage/productHome/ 
> 0%2C%2CADM1027%2C00.html
>
> Which looks right on the money. Not sure it jives with your PC87366  
> identification though?
>
> Everything else was clearly not a sensor, and I did not see anything  
> with PC87366 on it.
>
> Does this help?
>
> I'll let you know what I get from the vendor. Thanks again for  
> continuing to look into this!
>
> charles
>

