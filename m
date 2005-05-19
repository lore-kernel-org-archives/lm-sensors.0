From: erek@necrotec.com (erek)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: EP-9NDA3+ w/ Winbond W83627THF LPC
Message-Id: <32861.216.9.170.73.1103650141.spork@webmail.necrotec.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <32906.216.9.170.171.1103272080.spork@webmail.necrotec.com>
In-Reply-To: <32906.216.9.170.171.1103272080.spork@webmail.necrotec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> * Jean Delvare <khali@linux-fr.org> [2004-12-19 16:06:46 +0100]:
>> Hi Mark,
>>
>> > > I have come up with a very simplified patch that would do that. Not
>> > > exactly elegant but it keeps the changes to a minimum. The one I
>> > > worked on while we were on IRC was really too complex and had
>> > > drawbacks too.
>> >
>> > It looks OK to me; not sure what you don't like about it.
>>
>> Global variable sucks. The way I supported the secondary Super-I/O
>> address to the pc87360 driver looks far better to me, but unfortunately
>> it doesn't work for the w83627hf driver because it accesses the
>> Super-I/O space outside of the "find" function.
>>
>> > > +	dev_info(&client->dev, "Reading VID from GPIO5\n");
>> >
>> > I think this should be dev_dbg().
>>
>> Why? I think it's useful for the regular user to know that we are
>> reading the VID value from GPIO pins (which by definition could be used
>> for something different). It would also help us track problems if people
>> report about bad cpu0_vid value with that driver. If you can come up
>> with a better message, let me know.
>
> Oops, we read the VID just once, not every update.  Nevermind.
>
>> Maybe it would be even better to *not* create any cpu0_vid file when the
>> GPIO pins are not possibly used for that, instead of returning the
>> default value (all bits set) which in turn will result in a 0V value.
>> This would require more changes (including in the sensors program), and
>> I don't think I'll go into that until I get a supported chip myself.
>
> Nah, I think it's fine the way it is for now.
>
> Regards,
>
> --
> Mark M. Hoffman
> mhoffman@lightlink.com
>
>


thanks a lot for working so quickly
