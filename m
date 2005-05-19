From: jthiessen@penguincomputing.com (Justin Thiessen)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: adm1026 driver port for kernel 2.6.X
Message-Id: <20041021194717.GB31072@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041018210758.GB14960@penguincomputing.com>
In-Reply-To: <20041018210758.GB14960@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Excellent. Thanks for the feedback!

Most everything looks straightforward.  Assume that the parts of your
recommendations that I've cut out have already been applied.

I can already see that I should have done less cut 'N' pasting from the 2.4.X
driver code.

On Tue, Oct 19, 2004 at 12:09:43PM +0200, Jean Delvare wrote:

<snip>

> >/* Analog output is a voltage, but it's used like a PWM
> > *   Seems like this should be scaled, but to be consistent
> > *   with other drivers, we do it this way.
> > */
> >#define DAC_TO_REG(val) (SENSORS_LIMIT(val,0,255))
> >#define DAC_FROM_REG(val) (val)
> 
> Analog output should be a voltage value in mV, just like analog inputs.

Ok, technically, that should be true.  But you'll notice in the code I 
submitted this is just a vestigal macro, and should have been cleared out
along with a lot of other cruft...

In the board I have access to(Arima HDAMA), the DAC is only used as one of two 
possible means to drive the speed-controlled fans.  Essentially it doesn't look
any different to the end user than the PWM output.  I've chosen to expose it
as the set of sysfs files:

pwm2
pwm2_enable
pwm2_auto_pwm_min

And allow the user to choose which "pwm" drives the fans, as only one is 
allowed control at a time.  In line with this decision, I intend to keep
the visible value for the DAC (pwm2) on the same scale as pwm1 (0-255).

> >/* Typically used with systems using a v9.1 VRM spec ? */
> >#define ADM1026_INIT_VRM  91
> >#define ADM1026_INIT_VID  -1
> 
> Rudolf Marek introduced a new VRM detection mechanism recently. It picks
> the correct VRM version from the CPU, so the driver don't have to deal
> with that. See any driver with VID support (except lm78) from 2.6.9-rc1
> or above (I think) for an example.
> 
> >struct pwm_data {
> >	u8 pwm;
> >	u8 enable;
> >	u8 auto_pwm_min;
> >};
> 
> Any special reason why pwm has a special structure?

*note that both pwm1_* corresponds to the actual PWM output, and pwm2_*
is really the DAC output, which for our purposes may as well be treated
identically, and is therefore lumped in with the PWM output to avoid end-user
confusion.*

I introduced pwm[12]_enable and pwm[12]_auto_pwm_min.  These don't correspond
directly to register entries, but do provide automatic fan control
functionality in line with that outlined in the 1st-4th fan control interface
proposals.  Because the minimum value for pwm with automatic fan control is 
taken from the 4 MSB of the PWM register, I elected to provide a separate
sysfs entry that allows the selection, storage, and retention of minimum 
pwm value indendent of changes in the PWM register.

The PWM interface is designed to avoid inadvertent overheating situations.

(1) PWM values cannot be changed directly unless manual control (pwmN_enable
    = 1) is set.
(2) pwmN_auto_pwm_min values initialize at their maximum value of 15.
(3) pwmN_auto_pwm_min values can be changed at any time, but are not applied
    until/unless the corresponding pwmN_enable = 2 (automatic fan control mode)
(4) Switching modes from automatic->manual, automatic->off, manual->off
    results in the corresponding pwmN being set to its maximum value of 255.

I just decided that a pwm structure would help keep things tidy variable-
wise and enforce the association of pwmN with pwmN_enable and
pwmN_auto_pwm_min, making the code more easily parseable for other people
besides myself.

Is there any reason *not* to do this?

> >void adm1026_init_client(struct i2c_client *client)
> >{
> >int value, i;
> >struct adm1026_data *data = i2c_get_clientdata(client);
> >
> >dev_dbg(&client->dev, "adm1026(%d): Initializing device\n",
> >client->id);
>
>dev_dbg will already print "adm1026" in front of the line if I'm not
>mistaking, so you shouldn't repeat it.

It also looks like it prints out the bus id string, so I can drop "(%d)" as
well.  Right?

> >	/* If the user asks us to reprogram the GPIO config, then
> >	 *   do it now.  But only if this is the first ADM1026.
> >	 */
> >	if( client->id = 0
> 
> Why is the first client special? You don't even know which one will be
> picked first by the core.

You know, I'm not sure why.  This is one of the bits just pasted in from the
2.4.X driver.  Phil Pokorny ought to weigh in here with his reasoning.

> >	for( i = 0 ; i <= 7 ; ++i ) {
> 
> BTW, watch your coding style. No white space inside parenthesis, white
> space betweem keywork and opening parenthesis, no white space before
> semicolon: for (i = 0; i <= 7; ++i).

Heh.  That's what I get for copying code without really reviewing it.  I'll 
make a pass through the code to fix these and standardize spacing conventions 
between the inherited code and my own bits.

> >	/* We don't know where or even _if_ the VID might be on the GPIO
> >	 *    pins.  But the datasheet gives an example config showing
> >	 *    GPIO11-15 being used to monitor VID0-4, so we go with that
> >	 *    but make the vid WRITEABLE so if it's wrong, the user can
> >	 *    set it in /etc/sensors.conf perhaps using an expression or
> >	 *    0 to trigger a re-read from the GPIO pins.
> >	 */
> 
> Doesn't make much sense to me. If the vid reading isnt't correct (which
> can happen with any chip if the pins are not provided) then the user can
> simply not use in in the configuration file at all. Making it writable
> means that the user-space writes it to kernel-space just in order to
> read it again for configuring the chip. Since the vid value is only
> really used by "sensors -s", hardcoding it into the configuration file
> is easier and more efficiemt.

Again, Phil Pokorny ought to weigh in on this, as it's not my original work,
nor has my perusal of the data sheet given me any particular insight as to
why the code is set up this way.

<snip>

> >static ssize_t set_fan_min(struct device *dev, const char *buf,
> >		size_t count, int nr)
> >{
> >	struct i2c_client *client = to_i2c_client(dev);
> >	struct adm1026_data *data = i2c_get_clientdata(client);
> >	int     val;
> >
> >	down(&data->update_lock);
> >	val = simple_strtol(buf, NULL, 10);
> >	data->fan_min[nr] = FAN_TO_REG(val, data->fan_div[nr]);
> >	adm1026_write_value(client, ADM1026_REG_FAN_MIN(nr),
> >		data->fan_min[nr]);
> >	up(&data->update_lock);
> >	return count;
> >}
> 
> I see no reason to use the update_lock semaphore here. Other I2C client
> drivers don't.

I started reviewing the other drivers, and noticed that several of them
embedded the use of the update_lock semaphore in their "XXXX_write_value"
functions as opposed to the "set_XXX" functions.  I admit to blindly following
observed behavior here.  Can you enlighten me on the subject?  It looks as
if the other drivers still use update_lock...

> >/* static ssize_t show_analog_out_reg(struct device *dev, char *buf)
> >{
> >	struct adm1026_data *data = adm1026_update_device(dev);
> >	return sprintf(buf,"%d\n", DAC_FROM_REG(data->analog_out) );
> >}
> >static ssize_t set_analog_out_reg(struct device *dev, const char *buf,
> >		size_t count)
> >{
> >	struct i2c_client *client = to_i2c_client(dev);
> >	struct adm1026_data *data = i2c_get_clientdata(client);
> >	int     val;
> >
> >	down(&data->update_lock);
> >	val = simple_strtol(buf, NULL, 10);
> >	data->analog_out = DAC_TO_REG(val);
> >	adm1026_write_value(client, ADM1026_REG_DAC, data->analog_out);
> >	up(&data->update_lock);
> >	return count;
> >}
> >
> >static DEVICE_ATTR(analog_out, S_IRUGO | S_IWUSR, show_analog_out_reg,
> >	set_analog_out_reg)
> >
> >*/
> 
> Why is that part commented out?

Because it's associated with the transmogrification of the DAC output into 
"pwm2".  I should have X-ed it out of the code before I sent it to you.

<snip>

> 
> >	/* Set the VRM version */
> >	data->vrm = ADM1026_INIT_VRM ;
> >	data->vid = ADM1026_INIT_VID ;
> 
> Use Rudolf Marek's functions instead.

Already fixed the assignment for data->vrm.

Unless Phil weighs in with a good reason why we should leave the VID setup
as it is, I'll change this be in line with how it's done in the other drivers.

> >	device_create_file(&new_client->dev, &dev_attr_temp1_offset);
> >	device_create_file(&new_client->dev, &dev_attr_temp2_offset);
> >	device_create_file(&new_client->dev, &dev_attr_temp3_offset);
> 
> These are not standardized in the sysfs interface yet. It seems that
> several chips have that functionality though, so it could be fine to
> introduce it. Please propose a patch against
> Documentation/i2c/sysfs-interface if you use these.

Ok.

> >	device_create_file(&new_client->dev, &dev_attr_temp1_therm);
> >	device_create_file(&new_client->dev, &dev_attr_temp2_therm);
> >	device_create_file(&new_client->dev, &dev_attr_temp3_therm);
> 
> What are these files for?

Fooey.  I left these in from the 2.4.X driver, and never noticed that there
needed to be a way presented to turn the "therm" function on.  My fault for
assuming that the old driver was had the complete set of necessary files.

I just added:

temp_therm_enable  (values {0,1})

to the list of sysfs files and the associated:

show_temp_therm_enable();
set_temp_therm_enable();

functions.

The adm1026 has a set of 3 registers (one for each temperature channel) that
allow for a "maximum failsafe" temperature to be set.  As you might guess,
when any one of the temperatures reaches its respective therm value, an
interrupt is generated, and all fans go to full speed.  This operates
independently of the temperature-moderated fan control.

Because it operates independently of the automatic fan control, it seems
improper to lump it in with the "tempN_auto_pointM_temp" group.  Were I to
do so, and create "temp[123]_auto_point3_temp", then when automatic fan
control was enabled, there would be TWO distinct points at which the fans 
would be expected to go to full speed.

(1)  temp[123]_auto_point2_temp, which is fixed internally by the chip at
     temp[123]_auto_point1_temp + 20 degrees C
(2)  temp[123]_auto_point3_temp  (AKA, temp[123]_therm)

This looks obnoxiously confusing.  Moreover, it obscures the reason for the
existence of tempN_therm, which is to provide a guaranteed failsafe "keep-
the-magic-smoke-in-the-system" mechanism, no matter whether the PWM/DAC 
output is being manually or automatically controlled.

> I have admittedly skipped through most of the sysfs callback functions
> code, since I don't have enough time to fully review this part.
> 
> Please provide patches for the CVS/2.4 driver when changes you do to the
> 2.6 driver would be welcome there too.

Ok.


Thanks again for the feedback!

Justin Thiessen
---------------
jthiessen@penguincomputing.com

