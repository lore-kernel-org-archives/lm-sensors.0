From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 08 Feb 2006 11:23:53 +0000
Subject: [lm-sensors] New abituguru driver using platform_device
Message-Id: <o656gEMl.1139397833.4364720.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <43E4ABF8.4010201@hhs.nl>
In-Reply-To: <43E4ABF8.4010201@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Hans,

On 2006-02-08, Hans de Goede wrote:
> Oops, sorry. I'm not used to the write to list and CC the author kinda
> use of mailinglist. Right now I'm only writing this to the list, is this
> ok, or do you always want a direct CC?

The easiest for you, both are equally fine as far as I am concerned.

> > No, by definition, this isn't a busy wait if you are sleeping.
>
> My bad, the kernel doesn't have a usleep function, because sleeping for
> such short amounts is not supported, its called udelay, which translates
> to a busy wait, see arch/xxx/lib/delay.c

Ah, right, I had missed that point. It's indeed msleep() we use in i2c
bus drivers. Obviously not an option here.

> I could change the code to use delay functions if you insist, but I'd
> rather not as the current version has already been tested thoroughly by
> a small team of beta testers I've build up and thus I'd rather not touch
> this piece of code.

No, I am not insisting. The only conclusion this leads me to is: what a
crappy hardware design. No surprise Abit didn't want to document it
publicly.

> An other option to be nicer to other processes would be to yield between
> reads in the update function, this way the code-path of a single read
> doesn't get any changes, so I'm pretty sure this won't cause any
> problems. Then again if something else wants the CPU, we would get
> preempted anyways, so I don't know if this really helps.

I'm not a specialist of preemption and yield, but given that preemption
may be disabled, using yield() at times would indeed probably be fair.

> > As a side note, I don't think the _p has any effect on modern systems,
> > does it?
>
> It still does, it causes a read of isa address 0x80, see
> include/asm/io.h, thus causing a one isa cycle delay.

Thanks for the pointer once again. What I was in fact told some times ago
is that modern systems did not need the additional cycle, not that the
cycle wasn't done; I remember now.

So, inb uses one single ISA bus cycle and inb_p uses two, right? If so,
and if we agree that the ISA bus is clocked at 8 MHz, then the 37.5 us
max you announced for a read are in fact more like 75 us max, aren't
they? Not that it matters much for your driver implementation - just
trying to make sure I understand how things work.

Thanks,
--
Jean Delvare

