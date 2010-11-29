From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 29 Nov 2010 20:26:20 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Fix manual fan speed control
Message-Id: <20101129212620.5790ed1d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101129140010.6165cd6e@endymion.delvare>
In-Reply-To: <20101129140010.6165cd6e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Mon, 29 Nov 2010 08:58:49 -0800, Guenter Roeck wrote:
> Hi Jean,
> 
> On Mon, Nov 29, 2010 at 08:00:10AM -0500, Jean Delvare wrote:
> > The manual fan speed control logic of the IT8721F is much different
> > from what older devices had. Update the code to properly support that.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
> Minor comment below, otherwise 
> 
> Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> > ---
> >  drivers/hwmon/it87.c |   61 ++++++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 45 insertions(+), 16 deletions(-)
> > 
> > --- linux-2.6.37-rc3.orig/drivers/hwmon/it87.c	2010-11-24 10:06:22.000000000 +0100
> > +++ linux-2.6.37-rc3/drivers/hwmon/it87.c	2010-11-29 13:56:10.000000000 +0100
> > (...)
> > @@ -2034,10 +2057,16 @@ static void __devinit it87_init_device(s
> >  static void it87_update_pwm_ctrl(struct it87_data *data, int nr)
> >  {
> >  	data->pwm_ctrl[nr] = it87_read_value(data, IT87_REG_PWM(nr));
> > -	if (data->pwm_ctrl[nr] & 0x80)	/* Automatic mode */
> > +	if (data->type = it8721) {
> >  		data->pwm_temp_map[nr] = data->pwm_ctrl[nr] & 0x03;
> > -	else				/* Manual mode */
> > -		data->pwm_duty[nr] = data->pwm_ctrl[nr] & 0x7f;
> > +		data->pwm_duty[nr] = it87_read_value(data,
> > +						     IT87_REG_PWM_DUTY(nr));
> > +	} else {
> > +		if (data->pwm_ctrl[nr] & 0x80)	/* Automatic mode */
> > +			data->pwm_temp_map[nr] = data->pwm_ctrl[nr] & 0x03;
> > +		else				/* Manual mode */
> > +			data->pwm_duty[nr] = (data->pwm_ctrl[nr] & 0x7f) << 1;
> 
> This is a bug fix, isn't it ? You might want to mention it in the commit log.

Huh. No, it isn't. It's me adding a bug actually... Glad you spotted
it, thanks for the careful review. I seem to recall that at some point
when writing this patch, I considered left-aligning the PWM duty cycle
value in the hope to simplify the code, but apparently I changed my
mind half way through.

I'll send a fixed patch...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
