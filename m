From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: Fwd: ls_sensors, fscscy.o & watchdog
Message-Id: <20030603200318.GA12437@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030603170000.78ca4d75.khali@linux-fr.org>
In-Reply-To: <20030603170000.78ca4d75.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2003-06-03 20:20:32 +0200]:

> > > Do you mean that the 6th bit has no effect, or that setting it to 1
> > > disables the watchdog?
> > 5th, not 6th
> 
> 6th, I insist. Bit number 5 is the 6th bit. You usually start numbering
> with 0, but the "zeroth bit" makes no sense to me (although the word do
> exist). Or maybe is it just me? Let's call it the bit accounting for 32
> :)

A pedantic note: this is still ambiguous, depending on convention.  E.g.
Motorola's MPC500 RCPU manual labels the MSb as 0, instead of the more
common LSb 0 (of Intel, and even other Motorola like 68k).  I think
I've heard MSb 0 called "IBM ordering".

Also, this difference is unrelated to endianness.  To change bit-numbering
schemes has no effect on the code you write... it only affects the comments.
It's more likely to screw up hardware designers though. :)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
