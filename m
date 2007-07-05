From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 05 Jul 2007 16:01:44 +0000
Subject: Re: [lm-sensors] Howto handle alarms which need to be reset?
Message-Id: <468D15E8.4010408@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <468B4474.5070309@hhs.nl>
In-Reply-To: <468B4474.5070309@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Replying to my own mails seems to become a bad habbit of mine.

Hans de Goede wrote:
> Jean Delvare wrote:
>> Hi Hans,
>>
>> On Wed, 04 Jul 2007 11:03:31 +0200, Hans de Goede wrote:
>> We have another example of the behavior you describe with the DS1621
>> chip. Here is how the alarm handling is implemented in the ds1621
>> driver, maybe you can just do the same in the fscher driver?
>>
>>         /* reset alarms if necessary */
>>         new_conf = data->conf;
>>         if (data->temp[0] > data->temp[1])    /* input > min */
>>             new_conf &= ~DS1621_ALARM_TEMP_LOW;
>>         if (data->temp[0] < data->temp[2])    /* input < max */
>>             new_conf &= ~DS1621_ALARM_TEMP_HIGH;
>>         if (data->conf != new_conf)
>>             ds1621_write_value(client, DS1621_REG_CONF,
>>                        new_conf);
>>
> 
> Unfortunately the limits for temperature are hardwired into the fscher / 
> fscpos chip and not specified, so although the above sounds feasible, I 
> don't know when to clear the alarm. For the fans this is feasible, and 
> it is already implemented in the fscpos driver, but not in the fscher 
> driver.
> 
> Notice that the fscpos driver also already has a mechanism to reset the 
> temp alarms, using an tempX_reset file, which is identical to making the 
> alarm files rw if you ask me, except that it adds yet another sysfs 
> attribute.
> 
> So summarising, I can make the fan alarms auto-reset, but temperature is 
> a problem. Suggestions ? Once we have a solution for this I'll write a 
> third revision of the fscher / fscpos patches as time permits.
> 

I think I've solved this I've done some reverse engineering on the fscher using 
i2cdump and i2cset and I've found the following undocumented registers (there 
are more undocumented ones, but for these I've now found the meaning)

0x73 temp1_auto_point1_temp (unit degrees celcius + 128, just like temp1_input)
0x75 temp1_auto_point2_temp (unit degrees celcius + 128, just like temp1_input)
0x76 temp1_max              (unit degrees celcius + 128, just like temp1_input)

This I'm close to 100% sure off.

and:
0x83 temp2_auto_point1_temp (unit degrees celcius + 128, just like temp2_input)
0x86 temp2_max              (unit degrees celcius + 128, just like temp2_input)

Notice that 0x85 is missing, its 00 and cannot be written too, perhaps this has 
todo with the fact that my system has only one fan lowering 0x83 below temp2 
does make that one fan increase its speed. I guess 0x85 being 0 and 0x83 
influencing the same fan as which is controlled by the temp1 autopoints is 
regulated through the flags in 0x84, which are different from those in 0x74, I 
have no idea what these flags mean however.

and I think:
0x93 temp3_auto_point1_temp (unit degrees celcius + 128, just like temp3_input)
0x96 temp3_max              (unit degrees celcius + 128, just like temp3_input)

I say I think as my system doesn't have a third temp sensor connected, but they 
both have pretty realistic value for a system / case temp sensor, also notice 
the regular intervals between all the addresses.

Unfortunately I do not have access to an fscpos machine and thus cannot check 
if the same is true for the fscpos.

How to move forward now?

My plan is to write an updated fscher patch which adds tempX_max rw sysfs 
attributes, and use those to automatically reset the alarm.

I'm also considering adding autopoints sysfs attributes, but only for those 
autopoints which do not read 0, as the chip seems to have the ability to 
disable the 2nd autopoint for each temp and when it is disabled it reads as 0.

What do you think of adding the autopoints (I'm certain about the ones for 
temp1, they behave 100% as expected)?

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
