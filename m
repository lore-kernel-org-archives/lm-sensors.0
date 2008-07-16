From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Jul 2008 21:14:38 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (thmc50) Convert to a new-style i2c
Message-Id: <20080716231438.2913afc4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080716173316.1e8c5c42@hyperion.delvare>
	<487E624B.4060908@hhs.nl>
In-Reply-To: <487E624B.4060908@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <j.w.r.degoede@hhs.nl>
Cc: Krzysztof Helt <krzysztof.h1@wp.pl>, Linux I2C <i2c@lm-sensors.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Hans,

Thanks for all the reviews :)

On Wed, 16 Jul 2008 23:04:11 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > The new-style thmc50 driver implements the optional detect()
> > callback to cover the use cases of the legacy driver.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> > @@ -307,21 +304,22 @@ static int thmc50_detect(struct i2c_adap
> >  	}
> >  	if (err = -ENODEV) {
> >  		pr_debug("thmc50: Detection of THMC50/ADM1022 failed\n");
> > -		goto exit_free;
> > +		return err;
> >  	}
> > -	data->type = kind;
> >  
> >  	if (kind = adm1022) {
> >  		int id = i2c_adapter_id(client->adapter);
> >  		int i;
> >  
> >  		type_name = "adm1022";
> > -		data->has_temp3 = (config >> 7) & 1;	/* config MSB */
> >  		for (i = 0; i + 1 < adm1022_temp3_num; i += 2)
> >  			if (adm1022_temp3[i] = id &&
> > -			    adm1022_temp3[i + 1] = address) {
> > +			    adm1022_temp3[i + 1] = client->addr) {
> >  				/* enable 2nd remote temp */
> > -				data->has_temp3 = 1;
> > +				config |= (1 << 7);
> > +				i2c_smbus_write_byte_data(client,
> > +							  THMC50_REG_CONF,
> > +							  config);
> >  				break;
> >  			}
> >  	} else {
> 
> Hmm, This does not seem right, you are _writing_ to the device in a the detect 
> function changing its configuration. I understand you can no longer set 
> data->has_temp3 as there is no data yet in the detect, instead the entire loop 
> which checks if the device has temp3 forced through a module option should be 
> moved to the probe function. Writing to a config register in the detect 
> function feels wrong to me.

Note that:
* This is only done when the user passes a specific kernel module
  parameter. By default the chip configuration is left unchanged.
* The behavior is exactly the same as those of the original code. It is
  more clearly visible now, but the original code would set
  data->has_temp3, and then call the initialization function which
  itself would write to the chip if data->has_temp3 is set.

So I don't think there is any problem here. If you think that my patch
changes the behavior, then please point this out to me, as this was not
my intent.

I am not shocked by the fact that the detect function is processing the
module parameter. After all, the other module parameters (force,
ignore, etc.) are also handled at this point in the code too (just
before, actually.) And I don't want to do it later because the
initialization function is shared between legacy clients and new-style
ones, and module parameters should not affect new-style clients IMHO.
Chip-specific configuration for new-style clients should be done
through platform data, not module parameters.

If you insist on doing it clean, then the solution would be to convert
the module parameter to platform data in the detection function, and
process that platform data in the probe function (or initialization
function - that's pretty much the same.) If there ever is a new-style
THMC50 or ADM1022 device, we will certainly do that anyway. But I hope
that we agree that this is only moving the code around and not changing
the functional behavior.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
