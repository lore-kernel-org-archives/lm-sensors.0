From: Anish Patel <anish.mailing.list@gmail.com>
Date: Tue, 18 Jan 2011 22:25:23 +0000
Subject: Re: [lm-sensors] patch to sensor-detect script to support SMSC
Message-Id: <4D361353.5040801@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D346ACA.8050601@gmail.com>
In-Reply-To: <4D346ACA.8050601@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 01/18/11 17:15, Guenter Roeck wrote:
> On Tue, Jan 18, 2011 at 05:02:46PM -0500, Anish Patel wrote:
> [ ... ]
>>>>> Chip		Register 0xed
>>>>> emc1043		0x0c .. 0x0f, 0x2c
>>>>> emc1053		0x3c .. 0x3f
>>>>> emc1063		0x30 .. 0x33
>>>>>
>>>>> So I wonder if you might really have emc1043 on your board instead of
>>>>> emc1023. Would that be possible ?
>>>> its possible, but i just found a spare CPU carrier card and looked at
>>>> it.  the IC is def a 1023.
>>>> I guess it is possible that i have fake/rebadged 1023.
>>> Interesting. Should be easy to find out, though. emc1043 has register
>>> 0x04 with a default value of 0x09. That register does not exist on
>>> emc1023 and should either return the previously read value or an error.
>>> emc1043 also has registers 0x29 and 0x2a which don't exist on the
>>> emc1023. Maybe you can use i2cdump to see what registers the chip
>>> supports, and send the result to the list.
>>>
>>> Thanks,
>>> Guenter
>>>
>>>
>>>
>> here is the i2cdump for both ic's
>>
>> its pretty strange, i have the dump of what seems to be a 1043, but the part is labeled 1023
>> link to imgshack ->   http://img692.imageshack.us/img692/1006/20110118165728.jpg
>>
> Thought so. On the plus side, we can get support for four chips, not just one...
>
> Guenter
>
i just sent of a req to the board vendor for the MNF PN and datasheet 
for that part, hopefully i get it tonight


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
