From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 27 Mar 2009 10:47:23 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-fschmd-add-fscsyl-v2.patch
Message-Id: <49CCAEBB.8070807@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <49743C4C.8010202@hhs.nl>
In-Reply-To: <49743C4C.8010202@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On 03/26/2009 10:34 AM, Jean Delvare wrote:
> Hi Hans,
>
> Sorry again for the late answer.
>

No problem, thanks for the review!

> On Mon, 19 Jan 2009 09:39:40 +0100, Hans de Goede wrote:
>> New version, atleast on the system FSC has provided me with, their is no
>> voltage scaling DMI info the (new) in3 - in5 inputs. So instead in this version
>> the DMI scaling info from Vbat gets re-used for Vcc3.3 and Vcc3.3aux and from
>> Vcc5 for Vcc5aux. This yields correct readings on my system. I'll contact FSC
>> about this as according to the docs there should now also be scaling info for
>> the 3 additional voltage inputs in the DMI tables.
>
> Did you get any news from FSC since then?
>

I'm afraid not.

>> This patch adds support for the FSC Syleus IC to the fschmd driver.
>>
>> Signed-off-by: Hans de Goede<hdegoede@redhat.com>
>
> Review:
>
>> This patch adds support for the FSC Syleus IC to the fschmd driver.
>>
>> Many thanks to Fujitsu Siemens Computers for providing docs and a machine to
>> test the driver on.
>>
>> Signed-off-by: Hans de Goede<hdegoede@redhat.com>
>> --- /home/hans/fschmd.c	2009-01-18 23:17:16.000000000 +0100
>> +++ fschmd.c	2009-01-19 09:17:53.000000000 +0100
>> @@ -1,6 +1,6 @@
>>   /* fschmd.c
>>    *
>> - * Copyright (C) 2007,2008 Hans de Goede<hdegoede@redhat.com>
>> + * Copyright (C) 2007 - 2009 Hans de Goede<hdegoede@redhat.com>
>>    *
>>    * This program is free software; you can redistribute it and/or modify
>>    * it under the terms of the GNU General Public License as published by
>> @@ -19,7 +19,7 @@
>>
>>   /*
>>    *  Merged Fujitsu Siemens hwmon driver, supporting the Poseidon, Hermes,
>> - *  Scylla, Heracles and Heimdall chips
>> + *  Scylla, Heracles, Heimdall and Syleus chips
>
> That's quite unfortunate that "Syleus" and "Scylla" are so similar. I
> predict some confusion in the future.
>

Ack.

<snip>

>>   /* voltages, weird order is to keep the same order as the old drivers */
>> -static const u8 FSCHMD_REG_VOLT[3] = { 0x45, 0x42, 0x48 };
>> +static const u8 FSCHMD_REG_VOLT[6][6] = {
>> +	{ 0x45, 0x42, 0x48 },				/* pos */
>> +	{ 0x45, 0x42, 0x48 },				/* her */
>> +	{ 0x45, 0x42, 0x48 },				/* scy */
>> +	{ 0x45, 0x42, 0x48 },				/* hrc */
>> +	{ 0x45, 0x42, 0x48 },				/* hmd */
>> +	{ 0x21, 0x20, 0x22, 0x23, 0x24, 0x25 },		/* syl */
>> +};
>> +
>> +static const int FSCHMD_NO_VOLT_SENSORS[6] = { 3, 3, 3, 3, 3, 6 };
>
> They managed to change the only thing that was left common amongst all
> chips. How brilliant! Sometimes I wonder if it was such a good idea to
> merge support for all the FSC chips into a single driver. Oh well.
>

As the maintainer I'm still happy with that decision, the lookup tables
are not all that bad to have, and other then FSC playing lets put the
register at a different address each version, the contents of the registers
rarely change. If you compare this driver to other multi device drivers,
the amounts of ifs is not bad at all IMHO. I still think this is way better
then maintaining *7* different drivers, with lots of code duplication.

>>   /* These were found through experimenting with an fscher, currently they are
>>      not used, but we keep them around for future reference.
>> +   On the fscsyl these are 0x#c 0x#e and 0x#1 is a bitmask defining which
>> +   temps influence the 0x## fan.
>
> This comment doesn't make any sense to me. What is "#" supposed to
> represent? 0x## is a little vague ;) I suspect this all belongs to
> Documentation/hwmon/fschmd.
>

Er, all the fan and temp registers for a single temp/fan combo are
grouped together at 0x5# for fan/temp1, 0x6# for fan/temp2, etc.

So the # is the base address for the fan-temp register group, and the
## should be #* I guess, I'll try to improve the comment a bit, this
is mostly as a reminder to myself in case we ever want to do anything
with these (undocumented) registers.

<snip>

>> @@ -912,6 +968,12 @@
>>   			dmi_mult[i] = mult[i] * 10;
>>   			dmi_offset[i] = offset[i] * 10;
>>   		}
>> +		/* According to the docs there should be separate dmi entries
>> +		   for the mult's and offsets of in3-5 of the syl, but on
>> +		   my test machine these are not present */
>> +		dmi_mult[3] = dmi_mult[2]; dmi_offset[3] = dmi_offset[2];
>> +		dmi_mult[4] = dmi_mult[1]; dmi_offset[4] = dmi_offset[1];
>> +		dmi_mult[5] = dmi_mult[2]; dmi_offset[5] = dmi_offset[2];
>
> One statement per line, please. Also, shouldn't you make these
> conditional, in case future machines have the proper DMI entries?
>

That would be a good idea, if I know how machines with proper dmi entries
would look like, if you look a bit up in the code you will see:

                 /* entity 1 - 3: voltage multiplier and offset */
                 if (dmi_data[i] >= 1 && dmi_data[i] <= 3) {
                         /* Our in sensors order and the DMI order differ */
                         const int shuffle[3] = { 1, 0, 2 };
                         int in = shuffle[dmi_data[i] - 1];

                         /* Check for twice the same entity */
                         if (found & (1 << in))
                                 return;

                         mult[in] = dmi_data[i + 1] | (dmi_data[i + 2] << 8);
                         offset[in] = dmi_data[i + 3] | (dmi_data[i + 4] << 8);

                         found |= 1 << in;
                 }

	<snip>

         if (found = 0x0F) {
                 for (i = 0; i < 3; i++) {
                         dmi_mult[i] = mult[i] * 10;
                         dmi_offset[i] = offset[i] * 10;
                 }

So we only fill the first 3 from dmi currently, the problem is that according
to the datasheet the dmi info for the 3 new voltage inputs does not live in
"entity" 4-6, but in 40, 42, 41 (yes in that order), however with the
test machine I have there are *no* extra entities at all. So until we can
actually see what the dmi table will look like for a machine which actually
has the info for the 3 additional voltage inputs, and write parsing code
for them, copying the info unconditionally is the best we can do.

I agree that once there is a fixed BIOS, and the parsing code is extended
to handle this, the copying should be made conditional.

<snip>

Note I've <snipped> all the comments I agree with 100%, I will soon post a
new version taking care of all of those.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
