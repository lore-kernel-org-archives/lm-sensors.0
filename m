From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: Third auto-fan control interface proposal
Message-Id: <20040812202059.GD12506@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407051449.i65Enjdq031467@zone3.gcu-squad.org>
In-Reply-To: <200407051449.i65Enjdq031467@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2004-08-12 20:46:31 +0200]:
> > > Yeah, LM93... four tachos, two PWM outputs. Odd, but it seems like
> > > one anticipated configuration is to drive fans 1-2 (tacho's 1-2)
> > > *both* from pwm1.  I could be wrong about that though.
> > >
> > Your not.  A real pending configuration looks like:
> > 
> > 	Fan A1----\
> > 	Fan A2----|---\ 
> >                      >-------PWM1          
> > 	Fan B1----|---/
> > 	Fan B2----/
> > 	
> > 	Fan C1----|------------PWM2
> > 	Fan C2----/ 
> 
> OK, I have to accept Mark's idea then.
> 
> Would it make sense to accept both fanN_pwm and pwmN, and use the
> approriate entries depending on the chip? It would also mean two
> possible names for auto-fan contol files (it87 model), so there would be
> three possible sets of names instead of two. This is not good, but OTOH,
> using pwmN for SMSC-like chips will probably make the user wonder why
> fan1 will stop monitoring when pwm1 is set to 0% duty cycle...
> 
> So I guess we better simply revert to pwmN as Mark suggested.

OK. :)  I'll do the patches in a few days, since I brought it up.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
