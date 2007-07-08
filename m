From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 Jul 2007 17:08:12 +0000
Subject: Re: [lm-sensors] Howto handle alarms which need to be reset?
Message-Id: <20070708190812.4c0c3466@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <468B4474.5070309@hhs.nl>
In-Reply-To: <468B4474.5070309@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

Sorry for the late reply.

On Thu, 05 Jul 2007 18:01:44 +0200, Hans de Goede wrote:
> Replying to my own mails seems to become a bad habbit of mine.

Well, at least that makes always at least one person who replies to
your posts ;)

> I think I've solved this I've done some reverse engineering on the fscher using 
> i2cdump and i2cset and I've found the following undocumented registers (there 
> are more undocumented ones, but for these I've now found the meaning)
> 
> 0x73 temp1_auto_point1_temp (unit degrees celcius + 128, just like temp1_input)
> 0x75 temp1_auto_point2_temp (unit degrees celcius + 128, just like temp1_input)
> 0x76 temp1_max              (unit degrees celcius + 128, just like temp1_input)
> 
> This I'm close to 100% sure off.
> 
> and:
> 0x83 temp2_auto_point1_temp (unit degrees celcius + 128, just like temp2_input)
> 0x86 temp2_max              (unit degrees celcius + 128, just like temp2_input)
> 
> Notice that 0x85 is missing, its 00 and cannot be written too, perhaps this has 
> todo with the fact that my system has only one fan lowering 0x83 below temp2 
> does make that one fan increase its speed. I guess 0x85 being 0 and 0x83 
> influencing the same fan as which is controlled by the temp1 autopoints is 
> regulated through the flags in 0x84, which are different from those in 0x74, I 
> have no idea what these flags mean however.
> 
> and I think:
> 0x93 temp3_auto_point1_temp (unit degrees celcius + 128, just like temp3_input)
> 0x96 temp3_max              (unit degrees celcius + 128, just like temp3_input)
> 
> I say I think as my system doesn't have a third temp sensor connected, but they 
> both have pretty realistic value for a system / case temp sensor, also notice 
> the regular intervals between all the addresses.
> 
> Unfortunately I do not have access to an fscpos machine and thus cannot check 
> if the same is true for the fscpos.
> 
> How to move forward now?
> 
> My plan is to write an updated fscher patch which adds tempX_max rw sysfs 
> attributes, and use those to automatically reset the alarm.

Sounds like a good plan.

> I'm also considering adding autopoints sysfs attributes, but only for those 
> autopoints which do not read 0, as the chip seems to have the ability to 
> disable the 2nd autopoint for each temp and when it is disabled it reads as 0.
> 
> What do you think of adding the autopoints (I'm certain about the ones for 
> temp1, they behave 100% as expected)?

Please make it a separate patch. As these registers are undocumented,
you need to find testers before pushing such a patch upstream.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
