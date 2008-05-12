From: Achim Gottinger <achim@ag-web.biz>
Date: Mon, 12 May 2008 10:53:02 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Check for 1-register-only
Message-Id: <4828218E.1050500@ag-web.biz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080508224145.41cfa3ef@hyperion.delvare>
In-Reply-To: <20080508224145.41cfa3ef@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I agree, perfect timeframe. :) You mentioned two patches so i assume the 
third patch (address issue with typo) is already in SVN.
>>                     Now without breaking at 0x4c the chip at 0x4e is
>> detected as an overclock controller. 
>>     
>
> Aha, interesting :) I am curious if this chip is also the one answering
> at 0x2e. The datasheet doesn't suggest so, but as we saw several boards
> with this overclocking chip and the mysterious chip at 0x2e, I start
> wondering if it could be the same chip...
>   
Also grabbed the datasheet and inspected that chip. Seems it is only 
used as a watchdog here.
The value of address 0x00 is 0x02 after i boot. Bit 2 indicates " New 
CPU". I can change that value
if i eighter write 0x00 or 0x04 (clear new cpu) to 0x00. Both writes 
result in the value 0x00.
The VID modification part seems to be unused. Also i can not enable it 
setting bit 2 or  bit 2 and 4.
None of the vid related registers can be modified.

The chip must be located below the heatpipes or it is part of another chip.
>   
>> Well, we have the atxp1 driver under drivers/hwmon already... But I
>> don't think it should be there. Anything related to overclocking should
>> be clearly labelled so and moved to a dedicated subsystem with a
>> separate maintainer. The target audience of these chips is clearly
>> different.
>>
>> As for libsensors, no, I would rather not add the features of
>> overclocking chips to it. Better write a separate library if needed.
>> Again, separate audience.
>>
>> We have the detection of these overclocking chips in sensors-detect
>> simply because they happen to live at an address which is frequently
>> used by thermal sensor chips. If they were living at different
>> addresses, we wouldn't care about them at all.
>>
>>     

Yeah, that different audience argument is a point. :)
So for a different subsystem i can simply use hwmon.c as a basis i 
guess. Supported chips would be all types of voltage regulators, 
overclocking controllers and clock generators and cpu's.
Overall i'm more interested in underclocking and energy saving than in 
overclocking but both areas require good controll over above mentioned 
chips.
Gotta consider if i can donate an presumably huge amount of time into 
getting this project going. :)



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
