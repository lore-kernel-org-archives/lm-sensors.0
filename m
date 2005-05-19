From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: Possible incorrectness in w83627hf.c
Message-Id: <20040222105653.35688eea.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040212194619.40fc8495.khali@linux-fr.org>
In-Reply-To: <20040212194619.40fc8495.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > According to the data sheets, this register (0x5C) does only have a
> > meaning for the W83627HF. So I'd suggest changing the condition to "type
> > = w83627hf" so that we don't access that register on the W83627THF (and
> > possibly others such as the W83637HF, which I plan to add support for).

BTW, I already fixed that when adding support for the W83637HF.

> > And, as we come to speak about this, I don't frankly see the point
> > in writing anything to this register. You seem to try and write the
> > default value anyway (and possibly change the value of reserved bits
> > BTW, which is no good). Can't we simply get rid of that write?
> 
> What should really happen is adding code to w83627hf_pwm()
> that turns the PWM on and off when the user writes the second value in
> the pwm file.

OK, that makes sense. I don't have any hardware to test this driver, so
I don't feel much comfortable with making changes to it. Could anyone
with supported hardware do it please?

> I note that there's still way too much initialization code in the
> driver. At the very least init should be set to 0, no?
> Either I didn't rip out enough code or some of it snuck
> back in later.

Correct. My opinion is that we should *never* reset chips by default. In
the drivers I wrote, I don't even give the user the possibility to do
so. Due to the sensibility of the hardware monitoring realm, I believe
that we have to be the as less intrusive as possible. And, more
importantly, we have to remember that BIOSes know things we ignore, and
resetting the chips make us lose this knowledge.

The number of problems users reported that could be solved by skipping
the "initialization" (which in most drivers should be called "reset and
force" really) are countless.

> The PWM pulses have a certain duty cycle (that's what you set with
> the pwm entry in /proc to control the fan speed)
> and a certain frequency.
> The frequency generally doesn't matter but some fans may
> work better, or be less noisy, with a higher or lower frequency.
> We don't support frequency changing in any driver.

Oh OK I see what you mean. I wouldn't think that fans could be sensible
to this.

> > PS: Looks like this driver would benefit a massive refresh. The
> > references to w83781d everywhere make things hard to understand
> > sometimes.
> > 
> 
> feel free :)

I did some changes as I added support for the W83637HF, and MMH cleaned
up some comments too. Still many things do to though, and I'm out of
time :/

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
