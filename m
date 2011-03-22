From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Tue, 22 Mar 2011 00:29:57 +0000
Subject: Re: [lm-sensors] [RFC PATCH 3/3] hwmon: sht15: add support for
Message-Id: <20110322002957.GC14559@v0n.mtl.sfl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1300301050-15529-4-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1300301050-15529-4-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jonathan,

On Mon, Mar 21, 2011 at 07:55:20PM +0000, Jonathan Cameron wrote:
> On 03/16/11 18:44, Vivien Didelot wrote:
> > This patch adds support to change options on the SHT15 device, such as:
> > * The measurement resolution through temp_resolution sysfs attribute;
> But not the humidity one? That's rather inconsistent.
It was updated by temp_resolution as well. You're right, that's not
consistent. I'll use another name for the platform data field, as you
suggested. See below.

> > * The heater usage through the heater_enable sysfs attribute;
> > * The usage of reload from OTP through the otp_reload sysfs attribute.
> It's still a cryptic name.  Use fine calibration might be better terminology?
For the moment, the field in the platform data is no_otp_reload, as in the
datasheet. What would you suggest, 'calibration' instead?

> > 
> > It also fixes CRC calculation:
> > CRC calculation now initializes the CRC register with the value of the
> > lower nibble of the value of the status register, as described in the
> > SHT1x CRC calculation technical note.
> Hang on, so the original crc patch is broken?  Please rework this series
> so that patch is valid in the first place!
The original patch is not broken. The CRC calculation uses the lower nibble
of the status register, which is 0 by default. This 'fix' comes here
because this patch allow to change the status register, that is to say the
lower nibble.
It does not make sense to fix it in the first patch, before add the support
to write the status register (even read it). Don't you agree?
> 
> Glad to see someone working with this driver. It's been a while since I
> even checked it worked at all!  Thanks.
;)
> 
> Jonathan
> >   * it under the terms of the GNU General Public License version 2 as
> >   * published by the Free Software Foundation.
> >   *
> These docs kind of meant sense when they were a list of restrictions (basically a todo list).
> I'd just drop them entirely now (other than the conservative timings one perhaps as I think
> that is still true).
Ok, should I remove this?

> >  /**
> >   * sht15_crc8() - compute crc8
> > - * @data:	sht15 retrieved data
> > + * @data:	sht15 specific data
> Definitely roll this into the first patch.
> > + * @value:	sht15 retrieved data
> >   *
> >   * This implements section 2 of the crc data sheet
> >   */
> > -static u8 sht15_crc8(const unsigned char *data, unsigned char len)
> > +static u8 sht15_crc8(struct sht15_data *data,
> > +		const unsigned char *value,
> > +		unsigned char len)
> >  {
> > -	unsigned char crc = 0;
> > +	unsigned char crc = reverse(data->val_status & 0x0F);
> >  
> >  	while (len--) {
> > -		crc = sht15_crc8_table[*data ^ crc];
> > -		data++;
> > +		crc = sht15_crc8_table[*value ^ crc];
> > +		value++;
See the comment above about the CRC calcultation fix.
> >  	}
> >  
> >  	return crc;
> > @@ -360,6 +364,40 @@ static inline void sht15_soft_reset(struct sht15_data *data)
> >  }
> >  
> >  /**
> It's times like this when you wonder who decided to call it status on the
> datasheet.  Now state would be a reasonable name, but the concept of changing
> status seems a little odd!
> 
You're right. Should I rename every sht15_*_status() functions into
sht15_*_state()?

> > + * sht15_send_status() - write the status register byte
> > + * @data:	sht15 specific data
> > + * @feature:	the option to update the status register with.
> > + * @value:	the value to set.
> > + *
> > + * As described in figure 14 and table 5 of the data sheet.
> > + */
> > +
> > +static int sht15_send_status(struct sht15_data *data, u8 feature, int value)
> > +{
> > +	int ret;
> > +	u8 status;
> > +
> Ah, so the cache in the previous patch now makes sense. Ideally it would have
> only been introduced in this one, but doesn't really matter.
> > +	status = data->val_status;
> > +	if (value)
> > +		status |= feature;
> > +	else
> > +		status &= ~feature;
> > +
> > +	ret = sht15_send_cmd(data, SHT15_WRITE_STATUS);
> > +	if (ret)
> > +		return ret;
> > +	gpio_direction_output(data->pdata->gpio_data, 1);
> > +	ndelay(SHT15_TSU);
> > +	sht15_send_byte(data, status);
> > +	ret = sht15_wait_for_response(data);
> > +	if (ret)
> > +		return ret;
> > +	/* Needed for the next CRC calculation */
> > +	sht15_apply_status(data, status);
> > +	return 0;
> > +}
> > +
> > +/**
> >   * sht15_update_status() - get the status register from device
> >   * @data:	device instance specific data.
> >   *
> > @@ -382,7 +420,7 @@ static int sht15_update_status(struct sht15_data *data)
> >  		dev_checksum = reverse(sht15_read_byte(data));
> >  		checksum_values[0] = SHT15_READ_STATUS;
> >  		checksum_values[1] = status;
> > -		data->checksum_ok = (sht15_crc8(checksum_values, 2) = dev_checksum);
> > +		data->checksum_ok = (sht15_crc8(data, checksum_values, 2) = dev_checksum);
> >  	}
> >  
> >  	sht15_end_transmission(data);
> > @@ -489,6 +527,7 @@ error_ret:
> >  static inline int sht15_calc_temp(struct sht15_data *data)
> >  {
> >  	int d1 = temppoints[0].d1;
> This becomes cleaner if you make that a data->high_resolution flag
> (and it's smaller to store tat)
Great idea! I think I'll rename the platform data field into low_resolution
as the default value is 0 which means high resolution.

> > +	mutex_lock(&data->read_lock);
> > +	if (strict_strtol(buf, 10, &value)) {
> > +		mutex_unlock(&data->read_lock);
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = sht15_send_status(data, SHT15_STATUS_OTP_RELOAD, !value);
> > +	if (ret) {
> Check ret after the mutex is unlocked to simplify this code a touch.
> > +		mutex_unlock(&data->read_lock);
> > +		return ret;
> > +	}
> > +
> > +	mutex_unlock(&data->read_lock);
> > +	return count;
> > +}
Fine.

Thanks,
Vivien.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
