From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: LM93 not getting fan nreading
Message-Id: <20041124053735.GC5231@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041119122315.50064.qmail@web8506.mail.in.yahoo.com>
In-Reply-To: <20041119122315.50064.qmail@web8506.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Nithin:

* Jean Delvare <khali@linux-fr.org> [2004-11-22 07:47:54 +0100]:
> >     In LM93 driver there is no such fan divisors
> > present.Is there any other way to solve the problem.
> 
> Oh, you're right. It's quite rare to see fan monitoring chips without
> dividers, sorry I missed that.
> 
> > Shall i get fan values by using 3 pin fan.It is
> > specified in the data sheet that 4th pin is needed to
> > get the fan values while using PWM.
> 
> If the datasheet says you need 4-wire fans, and it doesn't work without
> it, then I guess you really need these. I believe these are rather news
> since I never heard about nor saw 4-wire fans so far. Sounds like a
> smart idea to allow PWM fan speed control while still reliably
> monitoring the fan speed (which is hardly the case with 3-wire fans).
> 
> I cannot tell you more as I don't know the LM93 very well, nor do I know
> your specific motherboard.

I'm the author of the lm93 driver, and I don't understand about the 4-wire
fans either.  AFAICS the datasheet says no such thing.

To clarify about fan tach. vs. PWM: when a fan is driven by low-side
drive PWM (which is very common) the tach. signal gets ugly and un-readable
especially at low speeds.  I don't know how a "4th wire" would correct that.
(Although, my degree is CS not EE.  When stuff like this comes up I ask an
EE coworker.)

The lm93 in particular has a "smart fan tach" mode which changes the whole
way the "3rd wire" is sampled, and supposedly corrects this problem.  The
driver supports that mode; please read the available documentation for how
to enable it.  I have no idea if this mode works or how well.  But, if you're
not using it already, try it.  I would be interested to know if that fixes
the problem for you.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
