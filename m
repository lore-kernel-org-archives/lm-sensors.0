From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: stub for driver testing (was Re: lm87 ported to Linux 2.6)
Message-Id: <20040825143542.M96484@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040824034244.GA23169@jupiter.solarsys.private>
In-Reply-To: <20040824034244.GA23169@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I'll make it impossible to build this driver into the kernel... it's 
> only useful as a module anyway.

I can't see any technical reason why it couldn't be used into the kernel. But
I don't see why one would want to do that either. So all in all I agree with
you ;)

> Would it be appropriate to mark it experimental as well?

Yes, but not because it's for testing purposes. For that, a clear help text
stating, among other details, "If unsure, say N.", is what you want. The
experimental tag refers to the code stability, not the driver goal.

> > I think that this driver would be even more useful if it was possible to
> > "load" a register map into it. (...)
> 
> Um, i2cset works fine for this.

Ah, correct. For some reason (maybe I'm somewhat stupid, or it was too early
in the morning) I missed that. One more reason to go on providing a way to get
rid of the 5 second delay in i2cset like I did recently for isaset and isadump.

> BTW: note how there are independent arrays for data/byte and 
> data/word commands. Depending on if/how a chip driver mixes them,
>  you'll need to be careful.

Yeah, I noticed that. The LM87 doesn't use words so I guess it should cause no
trouble to me - this time at least.

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
