From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 10 Feb 2012 08:12:05 +0000
Subject: Re: [lm-sensors] [RFC] (F75387) How expose automatic fan control in sysfs?
Message-Id: <20120210081205.GA32087@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120209222304.GA28989@luigi.zusammrottung.local>
In-Reply-To: <20120209222304.GA28989@luigi.zusammrottung.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 10, 2012 at 02:38:40AM -0500, Jean Delvare wrote:
> On Thu, 9 Feb 2012 18:13:35 -0800, Guenter Roeck wrote:
> > On Thu, Feb 09, 2012 at 05:54:52PM -0500, Nikolaus Schulz wrote:
> > > Unfortunately, the F75387 uses the very same registers for both modes.
> > > The values are only interpreted differently, depending on the open vs
> > > closed loop mode, either as RPM values, or raw PWM.
> >
> > Other chips do the same, or something similar. For example, the NCT6775F
> > uses the same register for the target speed in one mode, and for the target
> > temperature in another.
> > 
> > In this example, we have to be able to set both. The w83627ehf driver "solves"
> > that problem by implementing pwmX_target, which is specified in the driver
> > documentation as target temperature. Depending on the mode, it can also be
> > interpreted by the chip as target speed. Not the most elegant solution,
> > but at least it works (though maybe we should document it ;).
> > Unless Jean has a better idea, I would suggest to do the same.
> 
> In this specific case, what you want to do is decouple the register
> cache from the actual hardware registers. In your per-device private
> data structure, have room to store all the settings for all mode. This
> means that a given hardware register can have 2 or more corresponding
> members in the data structure, one for each meaning it can have
> depending on the mode.
> 
> You can see an example of this in driver it87:
> 
> struct it87_data {
> 	(...)
> 	/* The following 3 arrays correspond to the same registers up to
> 	 * the IT8720F. The meaning of bits 6-0 depends on the value of bit
> 	 * 7, and we want to preserve settings on mode changes, so we have
> 	 * to track all values separately.
> 	 * Starting with the IT8721F, the manual PWM duty cycles are stored
> 	 * in separate registers (8-bit values), so the separate tracking
> 	 * is no longer needed, but it is still done to keep the driver
> 	 * simple. */
> 	u8 pwm_ctrl[3];		/* Register value */
> 	u8 pwm_duty[3];		/* Manual PWM value set by user */
> 	u8 pwm_temp_map[3];	/* PWM to temp. chan. mapping (bits 1-0) */
> 
> When reading the register value from the chip, you write them to the
> right struct member for the given mode, and leave the other untouched.
> When values are changed by the user through sysfs, you store them in
> the data structure. If they relate to the currently selected mode, you
> write them to the chip immediately. If not, you keep them for later.
> 
> When the user changes the mode through sysfs, you write that mode
> change to the chip, and then automatically program the new mode using
> the settings from the data structure.
> 
> So, to make it clear, it is perfectly possible (and desirable) to
> handle such devices without coming up with a custom and obscure sysfs
> interface. The shared registers can and must be abstracted by the
> driver and the user shouldn't notice.
> 
Excellent idea. I think I'll do the same for the nct6775f if/when I have time.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
