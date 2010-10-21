From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 21 Oct 2010 22:16:13 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: add generic GPIO fan driver
Message-Id: <1287699373.9690.360.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1287592646-18109-1-git-send-email-sguinot@lacie.com>
	<1287592646-18109-2-git-send-email-sguinot@lacie.com>
	<20101021064145.GA25095@ericsson.com>
	<20101021140626.GQ29120@kw.sim.vm.gnt>
	<20101021144346.GA26460@ericsson.com>
	<20101021215928.GS29120@kw.sim.vm.gnt>
In-Reply-To: <20101021215928.GS29120@kw.sim.vm.gnt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Thu, 2010-10-21 at 17:59 -0400, Simon Guinot wrote:
> Hi Guenter,
> 
> On Thu, Oct 21, 2010 at 07:43:46AM -0700, Guenter Roeck wrote:
> > > > 
> > > > The combination of DIV_ROUND_UP() and DIV_ROUND_CLOSEST() causes inconsistency.
> > > > 
> > > > Assume num_speed = 8, pwm is set to 128.
> > > > 
> > > > set: 128 * (8 - 1) / 255 = 3.513 => 4
> > > > get: 4 * 255 / (8 - 1) = 145.7 => 146
> > > > set: 146 * (8 - 1) / 255 = 4.007 => 5
> > > > get: 5 * 255 / (8 - 1) = 182.142 => 182
> > > > set: 182 * (8 - 1) / 255 = 4.996 => 5
> > > > 
> > > > Unless there is a really good reason to use DIV_ROUND_UP(), you might
> > > > want to use DIV_ROUND_CLOSEST() instead.
> > > 
> > > This choice is coherent with the rpm interface one and the reason is the
> > > same: start the fan even with a low value. In your example, 36 is first
> > > speed threshold.
> > > 
> > Yes, but here it causes an inconsistency between setting and reporting.
> > I don't expect the speed to change if I set the same value that was read.
> > Exactly this happens if one writes 146 in my example. That is much worse
> > than a potential startup problem, or the observation that pwm values below X 
> > don't start the fan.
> 
> Mmm. Convert a speed index into a low round pwm value (and not use
> DIV_ROUND_CLOSEST() at all) fix the inconsistency too. If you agree,
> I would prefer this option.

Ok if it works. I am mostly concerned about inconsistencies. 

Not sure I understand what you mean with "low round pwm value", though.

Guenter





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
