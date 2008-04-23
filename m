From: Gabriel C <crazy@frugalware.org>
Date: Wed, 23 Apr 2008 21:45:54 +0000
Subject: Re: [lm-sensors] ASUS P5E-VM DO and unknown chip with ID 0x0b00
Message-Id: <480FAE12.7000304@frugalware.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <48077504.4000905@frugalware.org>
In-Reply-To: <48077504.4000905@frugalware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:
>> 0xA is the size, 0x290 + 0xA - 1 = 0x299 is the last I/O port. Nothing
>> wrong here from a mathematical point of view (but this I/O range makes
>> no sense from a hardware point of view.
> 
> Aha good point. Seems I forgot about last -1. Sorry.
> 
>>> [   19.961068] ACPI: I/O resource w83627ehf [0x295-0x296] conflicts with ACPI
>>> region HWRE [0x290-0x299]
>>>
>>> The ATK driver has no extra funcs then the classic driver so I think you can use
>>>  what you have right now.
>> You mean that without the ATK0110 driver _nothing_ will access the I/O
>> range? How can you be so sure?
> 
> Yes I can be sure beacuse I checked the DSDT. There is no thermal zone, only the
> proprietary ATK methods to read the chip. Nothing calls them. Gabriel could do
> modprobe thermal ; acpi -V and it should not print any temperature info.

Yes you are right it does not report any temperature info.

BTW would be possible to have at least some sort ATK* ACPI driver which just prints some infos about
wth this thing is supposed to do so one could write at least some usable sensors configurations for these
ASUS motherboards ?

Oh and I still cannot find anything saying that motherboard has any SMSC chip any idea why sensors-detect thinks I have one at 0x0b00 ?

> 
> Thanks,
> Rudolf

Gabriel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
