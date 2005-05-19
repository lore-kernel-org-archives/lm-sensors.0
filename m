From: joden@lee.k12.nc.us (James Olin Oden)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: Third auto-fan control interface proposal
Message-Id: <Pine.LNX.4.58.0408120858580.22836@malachi.lee.k12.nc.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407051449.i65Enjdq031467@zone3.gcu-squad.org>
In-Reply-To: <200407051449.i65Enjdq031467@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 11 Aug 2004, Mark M. Hoffman wrote:

> Hi Jean:
> 
> * Jean Delvare <khali@linux-fr.org> [2004-08-11 22:26:16 +0200]:
> > > I think these should be named e.g. pwm1_auto_channels to make clear
> > > the distinction between a tacho input (fanX) and a pwm output (pwmX).
> > > 
> > > (/me goes off to look at 2.6 sysfs_interface doc again)
> > > 
> > > Oh dear.  I'm sorry I wasn't paying attention to this sooner, but I
> > > think our interface needs revision again.  All of the fan[nr]_pwm*
> > > files should really just be pwm[nr]*.
> > > 
> > > The association between tacho input and pwm output is arbitrary and
> > > depends on mainboard maker.  E.g. our script prog/pwm/pwmconfig is
> > > made to discover the relationships.
> > > 
> > > Would anyone object to such a patch for 2.6 kernel drivers?
> > 
> > I wish someone noticed that *before* I did the change the other way
> > around back in version 2.6.5...
> > 
> > I'm not sure I agree with you. Old chips clearly had PWM outputs and
> > tachometers unlinked, but newer chips (Analog ADM1031, SMSC LPC47M1xx,
> > National PC8736x) clearly assume that pwmN and fanN refer to the same
> > physical fan. Of course, some motherboard manufacturers will ignore that
> > recommendation, but they are to blame. For example, the SMSC LPC47M1xx
> > chips will stop monitoring fan1 when pwm1 is enabled and has a duty
> > cycle of 0%. Thus the driver has to force fan1 to 0 in this case. If the
> > manufacturer used fan1 and pwm1 for different fans, then the monitored
> > fan cannot be monitored anymore when the controlled fan is turned off.
> > 
> > Are there examples of recent chips which obviously don't consider that
> > pwmN and fanN are linked? For example chips having a different count of
> > tachometers and PWM outputs?
> 
> Yeah, LM93... four tachos, two PWM outputs. Odd, but it seems like one
> anticipated configuration is to drive fans 1-2 (tacho's 1-2) *both*
> from pwm1.  I could be wrong about that though.
>
Your not.  A real pending configuration looks like:

	Fan A1----\
	Fan A2----|---\ 
                       >-------PWM1          
	Fan B1----|---/
	Fan B2----/
	
	Fan C1----|------------PWM2
	Fan C2----/ 

Cheers...james
<snip>
