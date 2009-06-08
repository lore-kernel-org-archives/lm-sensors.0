From: Frank Myhr <fmyhr@fhmtech.com>
Date: Mon, 08 Jun 2009 15:28:49 +0000
Subject: Re: [lm-sensors] hwmon-vid driver from linux 2.6.29
Message-Id: <4A2D2E31.2070107@fhmtech.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A0C6BF7.9010107@assembler.cz>
In-Reply-To: <4A0C6BF7.9010107@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Mon, 08 Jun 2009 10:05:08 -0400, Frank Myhr wrote:
>> Jean Delvare wrote:
>>> You could contact the motherboard vendor and tell them about the
>>> problem (the question is "Is VID5 properly routed from CPU to
>>> IT8716F?") and see what they have to say about this.
>>>
>>> I don't really know how to work around this. I suspect that only the
>>> late 0Fh family CPUs actually make use of VID5. If I am right then we
>>> could tweak the hwmon-vid VRM selection table and use 5-pin VID (VRM
>>> code 24) for some of the 0Fh family CPUs. I don't know where to put the
>>> limit, and this is fixing the problem where it is not... which is
>>> likely to cause even more problems on other systems in the future.
>>>
>>> Frank, can you please tell us for which 0Fh family CPU model you did
>>> need the 6th VID pin decoding originally?
>> Hi Jean and others,
>>
>> I'm sorry, that system is currently offline and I (not so) cleverly
>> didn't back up log files so I don't have kernel-reported cpu info. But
>> here is hardware spec:
>>
>> cpu: AMD Athlon X2 64 4850e, ADH4850IAA5DO
>> mainboard: Gigabyte GA-MA770-DS3, IT8718
> 
> Mmm, this is strange. This CPU should operate at 1.1 to 1.25 V just
> like Hleb's. For this range the 5-bit VID codes are sufficient (VRM
> code 24 in hwmon-vid). Thus it shouldn't have made a difference when
> you added support for 6-bit VID codes. Do you remember why you wrote
> that patch in the first place?

I dimly recall that it87 was reporting my cpu voltage incorrectly. In
the course of investigating that I saw AMD 32559 Table 71 and decided to
update hwmon-vid to match it.

I think I continued to have sporadic problems with incorrect VID being
reported after making the change. And in any case, I wasn't using
voltages in the range that would have required 6-bit VID decoding (see
below).


> Actually I am not aware of _any_ 0Fh family CPU model running at a core
> voltage below 0.9 V. This makes me wonder if we shouldn't simply map
> the 0Fh family to 5-bit VID decoding and be done with it. This would
> avoid potential issues such as the one Hleb is hitting (although I
> don't disagree this appears to be a mainboard wiring issue in the first
> place.)
> 
> Opinions?

I was undervolting the cpu, but still limited to 0.8V or above by BIOS.
No objection here to go back to 5-bit VID decoding.

Sorry for the problems my patch apparently created :-(

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
