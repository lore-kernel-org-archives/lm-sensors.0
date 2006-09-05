From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 05 Sep 2006 08:50:23 +0000
Subject: [lm-sensors] Random thoughts on fan speed control
Message-Id: <20060905105023.46f7d404.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060904231231.c7dc7e1f.khali@linux-fr.org>
In-Reply-To: <20060904231231.c7dc7e1f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> > * Reading the F71805F documentation, I learned that the external
> > circuitery needed for PWM fan speed control is completely different
> > from the one needed for DC fan speed control. So I wonder if it is a
> > good idea to let the user change between the two modes. Clearly the
> > BIOS should set it right. I tried to switch to DC mode and it had no
> > effect at all on my fan (not even on/off). I wonder if it is possible
> > to confuse or even damage the hardware by using the wrong mode?
> 
> Yes DC/PWM settings were already removed from W83793 and imho not implemented on 
> EHF too.

Well, I have no problem with chip makers implementing both and letting
the integrators choose what they want to do. But in that case the BIOS
should set the proper operation mode.

> You need to know what circuits are onboard -> BIOS should do that for you. If 
> you want to implement this I would suggest just a kernel param for BIOS fixups.

I usually avoid adding BIOS fixups unless really needed. I don't want
to incite motherboard manufacturers to ship broken BIOSes. As long as
nobody reports a problem with this, I won't implement it. And even
then, I'd rather ask the user to request a fixed BIOS, as it makes much
more sense.

So my current plan is:
* Provide pwmN_mode, but read-only.
* Only provide pwmN_freq in PWM mode.

Thanks,
-- 
Jean Delvare

