From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 22 Mar 2011 10:34:37 +0000
Subject: Re: [lm-sensors] [RFC PATCH 3/3] hwmon: sht15: add support for
Message-Id: <4D887B3D.4080809@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1300301050-15529-4-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1300301050-15529-4-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

... 
>>> * The usage of reload from OTP through the otp_reload sysfs attribute.
>> It's still a cryptic name.  Use fine calibration might be better terminology?
> For the moment, the field in the platform data is no_otp_reload, as in the
> datasheet. What would you suggest, 'calibration' instead?
Could do. Naming is less critical for something only controlled via platform
data (as people writing those files will need to be data sheet diving
anyway). As long as it is well documented it probably doesn't matter what it
is called.
> 
>>>
>>> It also fixes CRC calculation:
>>> CRC calculation now initializes the CRC register with the value of the
>>> lower nibble of the value of the status register, as described in the
>>> SHT1x CRC calculation technical note.
>> Hang on, so the original crc patch is broken?  Please rework this series
>> so that patch is valid in the first place!
> The original patch is not broken. The CRC calculation uses the lower nibble
> of the status register, which is 0 by default. This 'fix' comes here
> because this patch allow to change the status register, that is to say the
> lower nibble.
> It does not make sense to fix it in the first patch, before add the support
> to write the status register (even read it). Don't you agree?
Ah. I understand - didn't read your comment properly.  Please just replace
the word 'fixes' with say 'updates' in the description.
>>>   *
>> These docs kind of meant sense when they were a list of restrictions (basically a todo list).
>> I'd just drop them entirely now (other than the conservative timings one perhaps as I think
>> that is still true).
> Ok, should I remove this?
Yes.
> 
>>>  /**
>>>   * sht15_crc8() - compute crc8
>>> - * @data:	sht15 retrieved data
>>> + * @data:	sht15 specific data
>> Definitely roll this into the first patch.
>>> + * @value:	sht15 retrieved data
>>>   *
>>>   * This implements section 2 of the crc data sheet
>>>   */
>>> -static u8 sht15_crc8(const unsigned char *data, unsigned char len)
>>> +static u8 sht15_crc8(struct sht15_data *data,
>>> +		const unsigned char *value,
>>> +		unsigned char len)
>>>  {
>>> -	unsigned char crc = 0;
>>> +	unsigned char crc = reverse(data->val_status & 0x0F);
>>>  
>>>  	while (len--) {
>>> -		crc = sht15_crc8_table[*data ^ crc];
>>> -		data++;
>>> +		crc = sht15_crc8_table[*value ^ crc];
>>> +		value++;
> See the comment above about the CRC calcultation fix.
>>>  	}
>>>  
>>>  	return crc;
>>> @@ -360,6 +364,40 @@ static inline void sht15_soft_reset(struct sht15_data *data)
>>>  }
>>>  
>>>  /**
>> It's times like this when you wonder who decided to call it status on the
>> datasheet.  Now state would be a reasonable name, but the concept of changing
>> status seems a little odd!
>>
> You're right. Should I rename every sht15_*_status() functions into
> sht15_*_state()?
Difficult choice.  Do we stick with silly data sheet naming or fix it.
Personally I think in this case fix it and go with the name _state.
...

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
