From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Jun 2007 16:30:09 +0000
Subject: Re: [lm-sensors] Fintek F71805F on Jetway J7F4K1G5D - fancontrol?
Message-Id: <20070614183009.33924ec4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070609191229.GB16891@warped.org>
In-Reply-To: <20070609191229.GB16891@warped.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 13 Jun 2007 17:43:15 -0700, Max Baker wrote:
> On Wed, Jun 13, 2007 at 11:17:34PM +0100, Phil Endecott wrote:
> > This is odd; the Fintek datasheet shows a capacitor in this position, 
> > but doesn't give a value.  Putting a largish capacitor here (this is 10 
> > uF I think) will rather screw up the PWM control in exactly the way 
> > that Jean and I have been discussing, i.e. even if the "on" period is 
> > quite short it will be enough to charge the capacitor for the whole 
> > cycle.  Having experimented I have not added a capacitor in that 
> > position on my hack.
> > 
> > They may be imagining that it has the effect of "smoothing" the PWM 
> > signal (e.g. 50% 12v smoothed to 6v).  To make this work you would need 
> > an inductor and a diode and you'd have built yourself a simple 
> > switch-mode supply.
> 
> I was confused on this too, since you would now have an exponential
> discharge at every pulse... so you get that weird ramp / triangle-wave
> behavior you were seeing.   Is there something about the fans that makes
> it better to always have some sort of DC available instead of switching to
> ground?  The only other thing I could think of would be for noise / EM
> reasons -- so that you are not switching all the way to ground?

Maybe this was an attempt to guarantee valid fan speed readings even
when PWM is in use? I don't know much about electronics, unlike both of
you, but Phil said he observed the phenomenon only on high frequencies.
If the F71805F is capable to sample the fan speed at times it knows the
PWM signal is up, it may require that the sampling periods are not too
short. Just a random idea...

OTOH you wonder why Fintek had the chip generate these high frequencies
if it can't cope with them.

> > Do you have any firm indication that the EPIA C7 board does have fan 
> > control?
> 
> Only annectodal evidence of people getting lm-sensors/fancontrol working
> on some EPIA boards.  I have a request open with the local Via FAE to get
> an official answer.  I'm hoping that the local electronics store might
> have some in stock and I can go eyeball em.

Every board is different. I have a Jetway motherboard here where it
works, when Phil and you have Jetway boards where it doesn't.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
