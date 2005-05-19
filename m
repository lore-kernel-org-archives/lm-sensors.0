From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: ASB100 PWM
Message-Id: <20031121222524.4481195f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031111062929.GA30118@earth.solarsys.private>
In-Reply-To: <20031111062929.GA30118@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Mark, can you explain to Vitaly how to produce a complete dump, as
> > you just did?
> 
> Look again, he already did that.

Oh, you're right. Sorry.

> > I'd also need at least a third user's dump, together with the model
> > information (A or not). Without that, there will be too many
> > registers that could be the one we are after. Of course, more dumps
> > would be welcome. The more we have, the easier the work will be.
> 
> OK, if the opportunity comes up.  Really I'm not sure the effort 
> would be worth it... my ASB100 !A ignores writes to pwm1 with no
> harm done AFAICS.

You're right. I sure have better things to do, and actually it's simply
impossible to come to a conclusion with only two dumps. Let's keep them
in a corner until the day we have at least two more, then we'll see.
After all, we don't have a datasheet for the ASB100 so we shouldn't even
be supporting it.

That said, had I to bet on a register, I would choose 0x85 in bank 3.
But I admit I must have less than 1% chance to have it right ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
