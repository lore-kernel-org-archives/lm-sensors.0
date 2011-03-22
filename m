From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 22 Mar 2011 10:28:40 +0000
Subject: Re: [lm-sensors] [RFC PATCH 2/3] hwmon: sht15: add support for
Message-Id: <4D8879D8.6040008@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1300301050-15529-3-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1300301050-15529-3-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 03/22/11 00:00, Vivien Didelot wrote:
> Hi Jonathan.
> On Mon, Mar 21, 2011 at 07:43:59PM +0000, Jonathan Cameron wrote:
>> On 03/16/11 18:44, Vivien Didelot wrote:
>>> Add support to read the sht15 status register. Explicitly:
>>> * The measurement resolution through the temp_resolution and
>>>   humidity_resolution sysfs attributes;
>>> * An end of battery indicator through the battery_alarm sysfs attribute;
>>> * Embedded heater support using the heater_enable sysfs attribute;
>>> * Reload from OTP available through the otp_reload sysfs attribute.
>> Hi Vivien.
>>
>> As Guenter said, these definitely need documenting.. Once that is available
>> I expect people will debate naming etc.
> Sure. After discussing about that, checksumming, otp_reload and
> *_resolution attributes have been removed. battery_alarm will be splitted into
> temp1_alarm and humidity1_alarm to respect the convention.
Really, Guenter / Jean is the is the right option?  The alarm isn't really about
either of the individual sensors, but rather about power to the chip?
> 
> I'll also add a documentation in Documentation/hwmon/ for the device.
...
>> Why cached the raw status?  Can't see any users.
>>> +	u8				val_status;
> As you've seen, it will be used in the next patch.
Ideally it would therefore be introduced in the next patch, but that's
a minor point.
...

>>>  /**
>>> @@ -378,6 +460,9 @@ static int sht15_update_vals(struct sht15_data *data)
>>>  	mutex_lock(&data->read_lock);
>>>  	if (time_after(jiffies, data->last_updat + timeout)
>>>  	    || !data->valid) {
>> As with the previous version, I'd make this optional controlled
>> by platform data.  Not everyone cares and it just made their gpio's
>> jump up and down a fair bit more.  Obviously if it's turned off, you
>> will also want to change what attributes are registered.
>>> +		ret = sht15_update_status(data);
>>> +		if (ret)
>>> +			goto error_ret;
> I put the sht15_update_status() call here so it could have benefit of the
> jiffies calculation. I also thought that it could be useful to update the
> device state before each measurement, in order to notice an eventual low
> power notice. Maybe I'm wrong and this test should be done separately?
The question is not whether it is worth doing in some cases, but rather
whether this is a change that will effect anyone in a negative fashion.
Its a balance between providing more error checking vs extra transactions
on what may be an extremely slow bus.

Lets go with butting this in.
> 
>>> +	/* Technically no need to read temperature and humidity as well */
>> Given we do a fresh read here, why bother having the cache at all?  Just
>> read it explicitly when we care.
>>> +	ret = sht15_update_vals(data);
> According to the previous comment, what about adding a mask as an argument
> to the sht15_update_vals() function to know which measurement to do (only
> status, temperature + humidity, etc.)?  Because the discussion could also
> be pointed on the temperature measurement, which update unnecessarily the
> humidity as well.
Good idea.
...

Jonathan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
