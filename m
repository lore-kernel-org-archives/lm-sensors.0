From: ericb@aspsys.com (Eric J. Bowersox)
Date: Fri, 29 Jul 2005 18:45:55 +0000
Subject: [lm-sensors] LM93 driver for 2.6
Message-Id: <1122655491.27489.42.camel@wiz.dev.aspsys.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1121815671.1604.16.camel@wiz.dev.aspsys.com>
In-Reply-To: <1121815671.1604.16.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2005-07-29 at 06:12, Rudolf Marek wrote:
> Hehe well done :)

Well, it was kind of done the way the cat learned to swim, if you know
what I mean. :-)

> We will need the patch againts at least 2.6.13rc3

Is there a place where I can download the tarball of this kernel?  If
not, what is the procedure for producing it?  Will I have to download,
say, 2.6.12, and then apply all the various patch-2.6.13-rc[1-3]-git*
patches, in order?  (Actually, there's an rc4 out now, it seems, so I
could go to that if it's more advisable.)

> Things that changed:
> 
> 1) sysfs callback attribute
> 2) hwmon subdirectory in kernel
> 3) hwmon class registration
> 4) ISA removal

I imagine all these aren't a big deal...if necessary, I can look at the
changes to some other driver I'm familiar with, like w83781d, to get a
feel for what this might entail.

> Here are some random comments on the code. Today was so hot so I cant assure I did not miss anything important. The places with no comments at all needs further review,
> but I will leave for quite long time so perhaps the other people can do it.
> 
> We have a policy not to touch configuration of the chip (as opposed of 2.4 that was too bit agresive) So please redo the configuration to optional and not mandatory.

I think this was what tripped me up with the W83792D driver, if you
recall that little incident with the blinking lights, so I can
understand the reasoning.

Bear in mind that, when I ported this driver, I was working under a
couple of constraints:
(1) I tried to touch as little of the original code as I could, to keep
from screwing something up.
(2) I was porting this driver to kernels earlier than the "cutting edge"
stuff, because we needed these drivers *now*, and needed to run them
with kernels that distros are shipping *now*.  (The actual kernel that I
ported this to originally, in fact, was something like 2.6.5, or
whatever it is that SuSE is shipping with Enterprise Server 9.)

> Debug is defined globaly via .config (menuconfig) the symbol name is same

Some of these things were in Mark Hoffman's original module source; I
just left them as-is.  But I can fix 'em as needed.

> > +/* pwm outputs: pwm1-pwm2 (nr => 0-1, reg => 0-3) */
> > +#define LM93_REG_PWM_CTL(nr,reg)	(0xc8 + (reg) + (nr) * 4)
> > +#define LM93_PWM_CTL1	0
> > +#define LM93_PWM_CTL2	1
> > +#define LM93_PWM_CTL3	2
> > +#define LM93_PWM_CTL4	31
> > +
> 
> Hum why not in hex?

Again, I left the numbers as Mark had them originally.  I'll convert the
base.

> > +/* Addresses to scan */
> > +static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
> > +static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
> 
> This line is to be removed due to ISA/I2C separation proces (see gregkh tree for this)

Since this chip appears to be I2C-only that won't be a big deal.

> > +static int init = 1;
> 
> I think our policy is not to init the chip

Again, since I've experienced the ramifications of this first-hand, I
can easily understand this. :-)

> > +static int vccp_limit_type[2] = {0,0};
> > +module_param_array(vccp_limit_type, int, NULL, 0);
> > +MODULE_PARM_DESC(vccp_limit_type, "Configures in7 and in8 limit modes");
> 
> Why this way? sysfs file not enough?

That's the way Mark had it in the original.  I don't know why he did it
that way.

> > +static int vid_agtl = 0;
> > +module_param(vid_agtl, int, 0);
> > +MODULE_PARM_DESC(vid_agtl, "Configures VID pin input thresholds");
> 
> Why this way? sysfs file not enough?

Ditto.

> > +/* Driver data */
> > +static struct i2c_driver lm93_driver = {
> > +	.owner          = THIS_MODULE,
> 
> use tabs please

I must have slipped...my editor isn't set up to use tabs; I was
inserting the tab characters manually and must have missed a spot.

> > +/* For each registered client, we need to keep some data in memory. That
> > +   data is pointed to by client->data. The structure itself is dynamically
> > +   allocated, at the same time the client itself is allocated. */
> > +struct lm93_data {
> > +	struct semaphore lock;
> 
> Somewhere here will be the hwmon class struct

For that, I'll probably look at the way one of the other drivers does it
and copy that.

> > +	/* prochot1 - prochot2: readings */
> > +	struct { u8 cur; u8 avg; } block4[2];
> 
> Is this allowed by codingstyle?

Again, this was the way it was in the original driver; I just pasted
this in verbatim.  If you've got a better suggestion, I'll employ it. 
(Ditto for the other instance of this 10 lines down or so.)

> > +/* VID:	mV
> > +   REG: 6-bits, right justified, *always* using Intel VRM/VRD 10 */
> > +static int LM93_VID_FROM_REG(u8 reg)
> > +{
> > +	return vid_from_reg((reg & 0x3f), 100);
> > +}
> 
> Is there a reason not to rely on autodetection?

Again, I don't necessarily know what Mark was driving at here...I do
have an LM93 datasheet on hand, so I can try to find out.

> > +/* min, max, and nominal register values, per channel (u8) */
> > +static const u8 lm93_vin_reg_min[16] = {
> > +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
> > +	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xae, 
> 
> extra spaces at the end.

More copy-and-paste from the original...(ditto the other instances of
this)

> > +sysfs_in_offsets(1);
> > +sysfs_in_offsets(2);
> > +sysfs_in_offsets(3);
> > +sysfs_in_offsets(4);
> > +sysfs_in_offsets(5);
> > +sysfs_in_offsets(6);
> > +sysfs_in_offsets(7);
> > +sysfs_in_offsets(8);
> > +sysfs_in_offsets(9);
> > +sysfs_in_offsets(10);
> > +sysfs_in_offsets(11);
> > +sysfs_in_offsets(12);
> > +sysfs_in_offsets(13);
> > +sysfs_in_offsets(14);
> > +sysfs_in_offsets(15);
> > +sysfs_in_offsets(16);
> 
> The dummy functions can be replaced using sysfsattribute.

If so, thank God!  This way of metaprogramming the sysfs entries using
macro expansion was giving me fits. :-)

> > +show_temp_reg(min);
> > +show_temp_reg(max);
> 
> The min/max stuff as well as in other cases can be replaced with 2D variables (so two attributes) or use one array that maps
> to low part the temps min next and max on the top.

Again, I'll probably have to refer to one of the existing drivers to see
exactly how this works.

> > +static ssize_t store_regs_prochot_##offset##_##rop (struct device *dev, \
> > +					const char *buf, size_t count) \
> > +{ \
> > +	return store_prochot_##rop(dev, buf, count, offset - 1); \
> > +} \
> 
> This can be eliminated when using sysfattr

Yeah, I've pretty much resigned myself to having to look at this entire
part of the code again, much as I did translating it from /proc to /sys
in the first place...

> > +static u8 lm93_read_byte(struct i2c_client *client, u8 reg)
> > +{
> > +	int value, i;
> > +
> > +	/* retry in case of read errors */
> > +	for (i=1; i<=MAX_RETRIES; i++) {
> > +		if ((value = i2c_smbus_read_byte_data(client, reg)) >= 0) {
> > +			return value;
> > +		} else {
> > +			dev_warn(&client->dev,"lm93: read byte data failed, "
> > +				"address 0x%02x.\n", reg);
> > +			mdelay(i + 3);
> > +		}
> > +
> > +	}
> > +
> > +	/* <TODO> what to return in case of error? */
> 
> same as down. Return old value.

Presumably I would put an extra parameter to this function, say, "u8
prev_value", and then return that in case of failure?  That would
probably be the easiest way to deal with this, as the "previous values"
could be inferred from the context in which the function is called.

> > +static u16 lm93_read_word(struct i2c_client *client, u8 reg)
> > +{
> > +	int value, i;
> > +
> > +	/* retry in case of read errors */
> > +	for (i=1; i<=MAX_RETRIES; i++) {
> > +		if ((value = i2c_smbus_read_word_data(client, reg)) >= 0) {
> > +			return value;
> > +		} else {
> > +			dev_warn(&client->dev,"lm93: read word data failed, "
> > +				 "address 0x%02x.\n", reg);
> > +			mdelay(i + 3);
> > +		}
> > +
> > +	}
> > +
> > +	/* <TODO> what to return in case of error? */
> 
> You can supply to function as parameter old value and return it in case of read error.

Same thing, except the extra parameter would be "u16 prev_value", I'd
think.  (The <TODO> comments are Mark's; this is more code I just copied
without diddling with it.)

> > +static int lm93_write_word(struct i2c_client *client, u8 reg, u16 value)
> > +{
> > +	int result;
> > +
> > +	/* <TODO> how to handle write errors? */
> 
> Retry later?

If I had to give an answer here, I'd probably just keep the warning
message and remove that <TODO> comment, maybe change it to an "error"
message (dev_err instead of dev_warn).  That also goes for a similar
comment in lm93_write_byte.

> > +static u8 lm93_block_buffer[I2C_SMBUS_BLOCK_MAX];
> > +
> > +/*
> > +	read block data into values, retry if not expected length
> > +	fbn => index to lm93_block_read_cmds table
> > +		(Fixed Block Number - section 14.5.2 of LM93 datasheet)
> > +*/
> > +static void lm93_read_block(struct i2c_client *client, u8 fbn, u8 *values)
> > +{
> > +	int i, result=0;
> > +
> > +	for (i = 1; i <= MAX_RETRIES; i++) {
> > +		result = i2c_smbus_read_i2c_block_data(client, 
> > +			lm93_block_read_cmds[fbn].cmd, lm93_block_buffer);
> > +
> > +		if (result = lm93_block_read_cmds[fbn].len) {
> > +			break;
> > +		} else {
> > +			dev_warn(&client->dev,"lm93: block read data failed, "
> > +				 "command 0x%02x.\n", 
> > +				 lm93_block_read_cmds[fbn].cmd);
> > +			mdelay(i + 3);
> > +		}
> > +	}
> > +
> > +	if (result = lm93_block_read_cmds[fbn].len) {
> > +		memcpy(values,lm93_block_buffer,lm93_block_read_cmds[fbn].len);
> > +	} else {
> > +		/* <TODO> what to do in case of error? */
> 
> Issue a error message and use old values?

Or maybe issue an error message and then retry the read using ordinary
byte/word reads, as if block operations were disabled for the driver? 
(And, if it keeps happening, maybe automatically disable the block
operations?)

> > +static void lm93_init_client(struct i2c_client *client)
> > +{
> > +	int i;
> > +	u8 reg;
> > +
> > +	/* configure VID pin input thresholds */
> > +	reg = lm93_read_byte(client, LM93_REG_GPI_VID_CTL);
> > +	lm93_write_byte(client, LM93_REG_GPI_VID_CTL,
> > +			reg | (vid_agtl ? 0x03 : 0x00));
> 
> can you move this to init part? We assume mostly that bios did good job in most cases.

You mean, move it down inside the "if (init)" block?  That would make
sense, I suppose.  (This is more copy-and-paste from the original).  On
the other hand, note that it depends on that "vid_agtl" configuration
parameter.  I may need to study what that's supposed to do more closely,
to understand why Mark did it the way he did.

(Mark, if you're watching this thread, feel free to jump in anytime!)

					Eric

-- 
Eric J. Bowersox, Software Engineer     Aspen Systems, Inc.
<ericb@aspsys.com>                      3900 Youngfield Street
Tel: +01 303 431 4606 x113              Wheat Ridge, CO  80033, USA
Fax: +01 303 431 7196                   <http://www.aspsys.com>

