From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 07 Feb 2011 20:35:04 +0000
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <20110207213504.5d7450c9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205175852.GA26672@ericsson.com>
In-Reply-To: <20110205175852.GA26672@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 7 Feb 2011 09:44:12 -0800, Guenter Roeck wrote:
> Hi Andrew,
> 
> On Mon, Feb 07, 2011 at 11:50:48AM -0500, Andrew Lutomirski wrote:
> [ ... ]
> > >
> > > So what you'll have to do is to set a minimum speed, and the problem will go away.
> > 
> > I admit I'm a bit confused as to what fan2_min does.  I have a minimum
> > (to warn?) fan speed set in BIOS, which seems to have nothing to do
> > with the initial value of fan2_min.  Changing fan2_min will cause
> > fan2_alarm to become set or unset, when I decrease min below input,
> > alarm stays set until I read it once.
> > 
> Interesting; it means that it works, but the BIOS seems to use another set
> of registers to set the minimum speed.

The BIOS doesn't necessarily use limit registers. It is totally
possible that the speed is simply checked at boot time against the
specified limit, and the hardware monitoring chip isn't even aware of
it.

Motherboard vendors have been under- or even misusing the hardware
monitoring features of the chips they selected for years, and while it
gets slowly better over time, it's still dangerous to assume that they
always know what they are doing and that they always do the right thing.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
