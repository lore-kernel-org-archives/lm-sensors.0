From: Nikolaus Schulz <mail@microschulz.de>
Date: Fri, 10 Feb 2012 22:46:56 +0000
Subject: Re: [lm-sensors] [RFC] (F75387) How expose automatic fan control in sysfs?
Message-Id: <20120210224651.GA12734@luigi.zusammrottung.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120209222304.GA28989@luigi.zusammrottung.local>
In-Reply-To: <20120209222304.GA28989@luigi.zusammrottung.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 10, 2012 at 08:38:40AM +0100, Jean Delvare wrote:
> On Thu, 9 Feb 2012 18:13:35 -0800, Guenter Roeck wrote:
> > On Thu, Feb 09, 2012 at 05:54:52PM -0500, Nikolaus Schulz wrote:
> > > Unfortunately, the F75387 uses the very same registers for both modes.
> > > The values are only interpreted differently, depending on the open vs
> > > closed loop mode, either as RPM values, or raw PWM.
> >
> > Other chips do the same, or something similar. For example, the NCT6775F
> > uses the same register for the target speed in one mode, and for the target
> > temperature in another.

[...]

> In this specific case, what you want to do is decouple the register
> cache from the actual hardware registers. In your per-device private
> data structure, have room to store all the settings for all mode. This
> means that a given hardware register can have 2 or more corresponding
> members in the data structure, one for each meaning it can have
> depending on the mode.
[...]
> When reading the register value from the chip, you write them to the
> right struct member for the given mode, and leave the other untouched.
> When values are changed by the user through sysfs, you store them in
> the data structure. If they relate to the currently selected mode, you
> write them to the chip immediately. If not, you keep them for later.
> 
> When the user changes the mode through sysfs, you write that mode
> change to the chip, and then automatically program the new mode using
> the settings from the data structure.

Very elegant and convincing.  My thinking obviously has been too tied to
the device specific details, thanks for your guidance. :)

I will apply this to the f75375 driver.

Nikolaus

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
