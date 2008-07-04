From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 04 Jul 2008 12:02:26 +0000
Subject: Re: [lm-sensors] PATCH: abituguru3-fix-detect.patch
Message-Id: <486E1152.6050704@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4836D061.9080501@hhs.nl>
In-Reply-To: <4836D061.9080501@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Thu, 03 Jul 2008 22:18:51 +0200, Hans de Goede wrote:
>> Alistair John Strachan wrote:
>>> Hi,
>>>
>>> On Sunday 08 June 2008 16:16:33 Mark M. Hoffman wrote:
>>>>> It has been reported that the abituguru3 driver fails to load after a
>>>>> BIOS update. This patch fixes this by loosening the detection routine so
>>>>> that it will work after the BIOS update too. To compensate for the now
>>>>> very loose detection an additional check is added on the DMI Base Board
>>>>> vendor string to make sure we only load on Abit motherboards, this is the
>>>>> same as the check in the abituguru (1 / 2) driver.
>>>>>
>>>>> Signed-of-by: Hans de Goede <j.w.r.degoede@hhs.nl>
>>>> Applied to hwmon-2.6.git/testing, thanks.
>>>>
>>>> (will include in final batch to Linus for 2.6.26 also)
>>> After updating my BIOS (from 16 to 17) the driver has stopped loading
>>> again. This is with 2.6.26-rc8. The reason is that the command byte has
>>> changed value to 0xFF (this is reproducible across cold and warm starts).
>>>
>>> The following diff fixes it, but the "probe" is now looking even more creaky..
>>>
>> Ah what fun, well luckily I've added the DMI based check so the detection 
>> routine is less important now.
>>
>> Mark, please apply.
> 
> I have to object. 0xff is the value you would get without a chip at
> this address. So the change is roughly equivalent to not testing the
> port at all... Plus, if the possible values change with every BIOS
> update, we have to admit that the detection method isn't reliable. What
> about switching to a DMI-based check? Not only checking the board
> manufacturer but also the board product name. The abituguru3 driver
> requires board-specific data anyway, so that's not a big change. And
> there's always the "force" parameter to bypass the check for new boards.
> 

I understand where you're coming from, but I have to object to switching to DMI 
based detection. I would be happy to make that switch if and when I've got DMI 
strings for all currently supporting motherboards. I can start working on 
collecting those, but without those, switching to DMI based detection would 
cause regressions which IMHO is unacceptable.

I agree that the 0xff check is not pretty, but please keep in mind that:
1) This driver normally is never autoloaded, so it either has to be compiled in
    or explicitly loaded by the user (this is something where dmi based
    detection would be a win as dmi based autoloading is possible).

2) If someone has either compiled the driver in and/or loads it deliberately it
    will still only load (without the force parameter) on Abit motherboards.

3) After this simple read check, the driver does some reads from the chip
    (which involve isa writes) and if these fail the driver doesn't load. Note
    that these reads will most likely fail if there is no uguru3, as the uguru3
    has a quite complex handshaking scheme.

So move to DMI based detection in the future, sure. But for now I would like to 
see this patch applied.

Regards,

Hans


>> Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>
>>
>>> ---
>>>
>>> Fix loading of abituguru3 on Abit IP35 Pro with BIOS 17. The magic bytes have
>>> changed value (again).
>>>
>>> Signed-off-by: Alistair John Strachan <alistair@devzero.co.uk>
>>>
>>> diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
>>> index f00f497..53ee148 100644
>>> --- a/drivers/hwmon/abituguru3.c
>>> +++ b/drivers/hwmon/abituguru3.c
>>> @@ -1118,7 +1118,7 @@ static int __init abituguru3_detect(void)
>>>  	u8 cmd_val = inb_p(ABIT_UGURU3_BASE + ABIT_UGURU3_CMD);
>>>  	if (((data_val = 0x00) || (data_val = 0x08)) &&
>>>  			((cmd_val = 0xAC) || (cmd_val = 0x05) ||
>>> -			 (cmd_val = 0x55)))
>>> +			 (cmd_val = 0x55) || (cmd_val = 0xFF)))
>>>  		return ABIT_UGURU3_BASE;
>>>  
>>>  	ABIT_UGURU3_DEBUG("no Abit uGuru3 found, data = 0x%02X, cmd = "
>>>
>>>
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
