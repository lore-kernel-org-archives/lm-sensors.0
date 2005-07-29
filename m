From: ericb@aspsys.com (Eric J. Bowersox)
Date: Fri, 29 Jul 2005 19:59:41 +0000
Subject: [lm-sensors] LM93 driver for 2.6
Message-Id: <1122659943.27489.62.camel@wiz.dev.aspsys.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1121815671.1604.16.camel@wiz.dev.aspsys.com>
In-Reply-To: <1121815671.1604.16.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2005-07-29 at 11:36, Mark M. Hoffman wrote:
> I haven't been able to look at the port in depth (yet).  But it
> looks like I owe you some feedback sooner, rather than later.

Thanks for keeping an eye out.

> BTW: I would rather you didn't combine lm93.h into lm93.c, but that's
> just my personal preference.

I did it that way because I wasn't sure how to encode the dependency
information for a header file into the Makefile.  None of the other chip
drivers have separate header files, so I wasn't able to get any guidance
there.

> The #define DEBUG 1 is OK for 2.4/CVS.  What ruik suggests is better
> for Linus' 2.6.

I was planning to take that out anyway, as per his original suggestion.

> > > > +#define LM93_PWM_CTL4	31
> > > > +
> > > 
> > > Hum why not in hex?
> 
> Eh?  The original code has #define LM93_PWM_CTL4 _3_, not 31.  So does Eric's
> patch?  ruik... ?

Ai yai yai!  If it's in my original patch, then I must have made a typo;
your original header does indeed say 3.  (Fortunately, nothing we use
the driver for has anything to do with PWM!)

> > > > +static int vccp_limit_type[2] = {0,0};
> > > > +module_param_array(vccp_limit_type, int, NULL, 0);
> > > > +MODULE_PARM_DESC(vccp_limit_type, "Configures in7 and in8 limit modes");
> > > 
> > > Why this way? sysfs file not enough?
> > 
> > That's the way Mark had it in the original.  I don't know why he did it
> > that way.
> 
> I only put parameters in sysfs that you might reasonably want to change
> during normal operation.  The correct setting for this module param (and
> vid_agtl) depends on how the chip is wired; it can't change later.

Good point.  I should leave this alone then...

> > > > +/* VID:	mV
> > > > +   REG: 6-bits, right justified, *always* using Intel VRM/VRD 10 */
> > > > +static int LM93_VID_FROM_REG(u8 reg)
> > > > +{
> > > > +	return vid_from_reg((reg & 0x3f), 100);
> > > > +}
> > > 
> > > Is there a reason not to rely on autodetection?
> > 
> > Again, I don't necessarily know what Mark was driving at here...I do
> > have an LM93 datasheet on hand, so I can try to find out.
> 
> Yes, there is a reason:  LM93 is specifically designed to work with
> VRM/VID 10 - so much so, that I highly doubt any OEM would pick this
> chip for any other application.  Browse through the datasheet and you
> will understand.

I'm not touching this, either, in that case.

> > > > +	/* <TODO> what to return in case of error? */
> > > 
> > > same as down. Return old value.
> 
> The TODO comments were mine.  But, I don't think that returning the old value
> is obviously better.  There is no way to forward this error up into userspace
> where it is more appropriately handled.  At some point, we should address this
> fundamental flaw in the hwmon/sysfs/libsensors stack.
> 
> > Presumably I would put an extra parameter to this function, say, "u8
> > prev_value", and then return that in case of failure?  That would
> > probably be the easiest way to deal with this, as the "previous values"
> > could be inferred from the context in which the function is called.
> 
> Concrete example of why I think this is bad: I2C/SMBus dies or locks up,
> two minutes later a fan dies also.  Userspace continues to poll the driver
> and believes that the fan is still working.

Yow!  That *is* a bad way of dealing with this.  I think, instead of
trying to fix these, I'll leave them as-is then.  (If I were writing
this code, I'd probably comment those areas with the tag "FUTURE:"
instead of "TODO:".)  Same applies to lm93_write_word.

> > Or maybe issue an error message and then retry the read using ordinary
> > byte/word reads, as if block operations were disabled for the driver? 
> > (And, if it keeps happening, maybe automatically disable the block
> > operations?)
> 
> The option to disable block reads was for my own debugging.  In normal
> operation, if block reads are supported by the bus driver, we should
> just assume they work and use them.  If they don't work, it's much
> more likely that the whole bus is dead (vs. just block ops are broken.)

OK, this should probably be left as-is then; this also relates to the
whole question of how read or write errors get propagated up the stack,
which, as you've indicated, is a major issue touching more than just
this one driver.

> > > > +static void lm93_init_client(struct i2c_client *client)
> > > > +{
> > > > +	int i;
> > > > +	u8 reg;
> > > > +
> > > > +	/* configure VID pin input thresholds */
> > > > +	reg = lm93_read_byte(client, LM93_REG_GPI_VID_CTL);
> > > > +	lm93_write_byte(client, LM93_REG_GPI_VID_CTL,
> > > > +			reg | (vid_agtl ? 0x03 : 0x00));
> > > 
> > > can you move this to init part? We assume mostly that bios did good job in most cases.
> > 
> > You mean, move it down inside the "if (init)" block?  That would make
> > sense, I suppose.  (This is more copy-and-paste from the original).  On
> > the other hand, note that it depends on that "vid_agtl" configuration
> > parameter.  I may need to study what that's supposed to do more closely,
> > to understand why Mark did it the way he did.
> 
> Nah, I think ruik's right about that one.  It *should* be init'ed properly
> by the BIOS.  Rather than move it into the init section, you could make it
> a tri-state module param where the default state is "leave it alone".

I need to figure out how tri-state module parameters work then.  Unless
just moving that part down into the "if (init)" block would be
satisfactory?

> Finally... what about the documentation?  Please include it in your patch
> and update it if/where necessary.

I assume you mean, take the doc file for the chip from lm_sensors CVS,
put it in Documentation/hwmon, and update any pieces of it that are
necessary for the 2.6 version rather than the 2.4 version.  (The older
versions of the kernel I was working with for the original port didn't
have the chip documentation included, and it's not as if our customers
would have cared anyway.)

					Eric

-- 
Eric J. Bowersox, Software Engineer     Aspen Systems, Inc.
<ericb@aspsys.com>                      3900 Youngfield Street
Tel: +01 303 431 4606 x113              Wheat Ridge, CO  80033, USA
Fax: +01 303 431 7196                   <http://www.aspsys.com>

