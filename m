From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 29 Jul 2005 19:36:28 +0000
Subject: [lm-sensors] LM93 driver for 2.6
Message-Id: <20050729173603.GA15704@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <1121815671.1604.16.camel@wiz.dev.aspsys.com>
In-Reply-To: <1121815671.1604.16.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Eric, ruik:

I haven't been able to look at the port in depth (yet).  But it
looks like I owe you some feedback sooner, rather than later.

BTW: I would rather you didn't combine lm93.h into lm93.c, but that's
just my personal preference.

On Fri, 2005-07-29 at 06:12, Rudolf Marek wrote:
> > Debug is defined globaly via .config (menuconfig) the symbol name is same

* Eric J. Bowersox <ericb@aspsys.com> [2005-07-29 10:44:51 -0600]:
> Some of these things were in Mark Hoffman's original module source; I
> just left them as-is.  But I can fix 'em as needed.

The #define DEBUG 1 is OK for 2.4/CVS.  What ruik suggests is better
for Linus' 2.6.

> > > +/* pwm outputs: pwm1-pwm2 (nr => 0-1, reg => 0-3) */
> > > +#define LM93_REG_PWM_CTL(nr,reg)	(0xc8 + (reg) + (nr) * 4)
> > > +#define LM93_PWM_CTL1	0
> > > +#define LM93_PWM_CTL2	1
> > > +#define LM93_PWM_CTL3	2
> > > +#define LM93_PWM_CTL4	31
> > > +
> > 
> > Hum why not in hex?

Eh?  The original code has #define LM93_PWM_CTL4 _3_, not 31.  So does Eric's
patch?  ruik... ?

> > > +static int vccp_limit_type[2] = {0,0};
> > > +module_param_array(vccp_limit_type, int, NULL, 0);
> > > +MODULE_PARM_DESC(vccp_limit_type, "Configures in7 and in8 limit modes");
> > 
> > Why this way? sysfs file not enough?
> 
> That's the way Mark had it in the original.  I don't know why he did it
> that way.

I only put parameters in sysfs that you might reasonably want to change
during normal operation.  The correct setting for this module param (and
vid_agtl) depends on how the chip is wired; it can't change later.

> > > +/* VID:	mV
> > > +   REG: 6-bits, right justified, *always* using Intel VRM/VRD 10 */
> > > +static int LM93_VID_FROM_REG(u8 reg)
> > > +{
> > > +	return vid_from_reg((reg & 0x3f), 100);
> > > +}
> > 
> > Is there a reason not to rely on autodetection?
> 
> Again, I don't necessarily know what Mark was driving at here...I do
> have an LM93 datasheet on hand, so I can try to find out.

Yes, there is a reason:  LM93 is specifically designed to work with
VRM/VID 10 - so much so, that I highly doubt any OEM would pick this
chip for any other application.  Browse through the datasheet and you
will understand.

> > > +static u8 lm93_read_byte(struct i2c_client *client, u8 reg)
> > > +{
> > > +	int value, i;
> > > +
> > > +	/* retry in case of read errors */
> > > +	for (i=1; i<=MAX_RETRIES; i++) {
> > > +		if ((value = i2c_smbus_read_byte_data(client, reg)) >= 0) {
> > > +			return value;
> > > +		} else {
> > > +			dev_warn(&client->dev,"lm93: read byte data failed, "
> > > +				"address 0x%02x.\n", reg);
> > > +			mdelay(i + 3);
> > > +		}
> > > +
> > > +	}
> > > +
> > > +	/* <TODO> what to return in case of error? */
> > 
> > same as down. Return old value.

The TODO comments were mine.  But, I don't think that returning the old value
is obviously better.  There is no way to forward this error up into userspace
where it is more appropriately handled.  At some point, we should address this
fundamental flaw in the hwmon/sysfs/libsensors stack.

> Presumably I would put an extra parameter to this function, say, "u8
> prev_value", and then return that in case of failure?  That would
> probably be the easiest way to deal with this, as the "previous values"
> could be inferred from the context in which the function is called.

Concrete example of why I think this is bad: I2C/SMBus dies or locks up,
two minutes later a fan dies also.  Userspace continues to poll the driver
and believes that the fan is still working.

> > > +static int lm93_write_word(struct i2c_client *client, u8 reg, u16 value)
> > > +{
> > > +	int result;
> > > +
> > > +	/* <TODO> how to handle write errors? */
> > 
> > Retry later?
> 
> If I had to give an answer here, I'd probably just keep the warning
> message and remove that <TODO> comment, maybe change it to an "error"
> message (dev_err instead of dev_warn).  That also goes for a similar
> comment in lm93_write_byte.

Again, the fundamental problem is that there is no path for these errors
to reach userspace.  This applies to all hwmon drivers, not just LM93.

> Or maybe issue an error message and then retry the read using ordinary
> byte/word reads, as if block operations were disabled for the driver? 
> (And, if it keeps happening, maybe automatically disable the block
> operations?)

The option to disable block reads was for my own debugging.  In normal
operation, if block reads are supported by the bus driver, we should
just assume they work and use them.  If they don't work, it's much
more likely that the whole bus is dead (vs. just block ops are broken.)

> > > +static void lm93_init_client(struct i2c_client *client)
> > > +{
> > > +	int i;
> > > +	u8 reg;
> > > +
> > > +	/* configure VID pin input thresholds */
> > > +	reg = lm93_read_byte(client, LM93_REG_GPI_VID_CTL);
> > > +	lm93_write_byte(client, LM93_REG_GPI_VID_CTL,
> > > +			reg | (vid_agtl ? 0x03 : 0x00));
> > 
> > can you move this to init part? We assume mostly that bios did good job in most cases.
> 
> You mean, move it down inside the "if (init)" block?  That would make
> sense, I suppose.  (This is more copy-and-paste from the original).  On
> the other hand, note that it depends on that "vid_agtl" configuration
> parameter.  I may need to study what that's supposed to do more closely,
> to understand why Mark did it the way he did.

Nah, I think ruik's right about that one.  It *should* be init'ed properly
by the BIOS.  Rather than move it into the init section, you could make it
a tri-state module param where the default state is "leave it alone".

Finally... what about the documentation?  Please include it in your patch
and update it if/where necessary.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

