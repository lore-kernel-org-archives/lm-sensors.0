From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Wed, 08 Feb 2006 09:20:34 +0000
Subject: [lm-sensors] New abituguru driver using platform_device
Message-Id: <43E9B7E2.3070205@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <43E4ABF8.4010201@hhs.nl>
In-Reply-To: <43E4ABF8.4010201@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Many thanks for clarifying your review, I only have one question left, 
see below.

Jean Delvare wrote:
> Hi Hans,
> 
> Please answer to the list rather than just me.
> 

Oops, sorry. I'm not used to the write to list and CC the author kinda 
use of mailinglist. Right now I'm only writing this to the list, is this 
ok, or do you always want a direct CC?

>>>> static int abituguru_wait(struct abituguru_data *data, u8 state)
>>>> {
>>>> 	int timeout = ABIT_UGURU_WAIT_TIMEOUT;
>>>>
>>>> 	while (inb_p(data->addr + ABIT_UGURU_DATA) != state) {
>>>> 		timeout--;
>>>> 		if (timeout = 0)
>>>> 			return -EBUSY;
>>>> 	}
>>>> 	return 0;
>>>> }
>>> Hm, this is a busy waiting loop. Not recommended. Why don't you msleep()
>>> between retries? Or at the very least yield()? In both cases, the
>>> timeout should be a duration rather than a number of tries.
>>>
>> Usually this succeeds within 100 - 150 reads (max 250) which assuming 
>> the isa bus is the bottleneck and tacking the _p into account translates 
>> to 300 isa cycles which is 37.5 usec, since the timing can vary I could 
>> complicate the code by first during a small usleep which will translate 
>> to a busy wait 
> 
> No, by definition, this isn't a busy wait if you are sleeping.
> 

My bad, the kernel doesn't have a usleep function, because sleeping for 
such short amounts is not supported, its called udelay, which translates 
to a busy wait, see arch/xxx/lib/delay.c


>> (...) and then do some isa bus busy waiting, but that 
>> complicates stuff without winning anything.
> 
> What I don't get is why you need to do ISA bus waiting at all. Why
> don't you just sleep-wait? 10 us sleeps shoud do. Please keep in mind
> that your device isn't the only user of the ISA bus
> (check /proc/ioports).
> Given that all uGuru registers are read at once
> by design, if you saturate the ISA bus, other devices may experience
> increased latency.
> 

I only do an update once every second, thus reducing the ISA bus load. 
During an update the wait function gets called 147 times, resulting in 
circa 5 ms ISA-bus usage.

But the real point is that using delay functions doesn't win all that 
much since we still keep the CPU occupied, thus although it will keep 
the ISA bus free there will be no CPU to use it and if we get preempted 
we'll also stop using the ISA bus. The only exception to this is SMP 
systems, but SMP systems really shouldn't rely on the ISA-bus.

I could change the code to use delay functions if you insist, but I'd 
rather not as the current version has already been tested thoroughly by 
a small team of beta testers I've build up and thus I'd rather not touch 
this piece of code.

An other option to be nicer to other processes would be to yield between 
reads in the update function, this way the code-path of a single read 
doesn't get any changes, so I'm pretty sure this won't cause any 
problems. Then again if something else wants the CPU, we would get 
preempted anyways, so I don't know if this really helps.


> As a side note, I don't think the _p has any effect on modern systems,
> does it?
> 

It still does, it causes a read of isa address 0x80, see 
include/asm/io.h, thus causing a one isa cycle delay.

Regards,

Hans

