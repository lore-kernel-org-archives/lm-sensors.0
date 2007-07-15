From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 15 Jul 2007 09:40:34 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-fscher-support-fscpos.patch
Message-Id: <4699EB92.3020309@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <46922D2E.60400@hhs.nl>
In-Reply-To: <46922D2E.60400@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Mon, 09 Jul 2007 14:42:55 +0200, Hans de Goede wrote:
>> As already mentioned in various post to the lm-sensors mailing list, the fscher
>> and fscpos chip are very very similar, this patch adds support for the fscpos
>> chip to the fscher driver, so that over time the fscpos driver can be dropped.
>>
>> Notice that this patch applies on top of the earlier posted max alarms patch
>> for the fscher:
>> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020301.html
> 
> Patch looks overall good, just a couple comments:
> 
>> @@ -355,6 +375,11 @@ static int fscher_detect(struct i2c_adap
>>  	/* Register sysfs hooks */
>>  	if ((err = sysfs_create_group(&new_client->dev.kobj, &fscher_group)))
>>  		goto exit_detach;
>> +	
>> +	/* only the fscher has a min fan speed register for fan 3 */ 
>> +	if (data->kind = fscher && (err = device_create_file(&new_client->dev,
>> +			&dev_attr_pwm3)))
>> +		goto exit_remove_files;
> 
> This comment is strange. "pwm3" is supposed to be about controlling a
> fan. "min fan speed for fan 3" would be fan3_min.
> 

I agree, let me try to explain, the fscpos / fscher has fanX_min _registers_ 
(thats what they are called in the driver data struct and in the datasheet).

However these registers do not control a limit which is used for a fan alarm, 
as the fanX_min sysfs attr export. These registers contain the minimum value at 
which the fan will spin, even if the temperature would allow it to go lower, so 
this really should be pwm_X_autopoint1_pwm, however I kept is as pwmX as I 
didn't want to change the kernel -> userspace API.

Notice that the fscher / fscpos driver have more issues like this, for example 
they export a raw version of the temp status registers as tempX_status, with 
the individual alarms patch, this is no longer needed as the 2 used bits in 
this register are exported as tempX_alarm resp tempX_fault, however they cannot 
be removed because libsensors/sensors expect them to be there.

Despite you saying that the individual alarms patch should be split up I 
actually tried to make as little changes as possible. I'm not sure now if that 
is the best plan, these 2 drivers really need a cleanup, they also need dyn 
sysfs attr + handlers for example, but I wanted to safe that for later to keep 
the patches small / manageable.

>> @@ -464,6 +502,8 @@ static struct fscher_data *fscher_update
>>  		data->watchdog[2] = fscher_read_value(client, FSCHER_REG_WDOG_CONTROL);
>>  
>>  		data->global_event = fscher_read_value(client, FSCHER_REG_EVENT_STATE);
>> +		data->global_control = fscher_read_value(client,
>> +							FSCHER_REG_CONTROL);
> 
> This looks like a bugfix, this should have been in the fscher driver
> already. Could you please submit a separate patch for this? So that
> Mark can push it into 2.6.23.
> 

Your right, I will write a seperate patch for this, as always as time permits.

>>  
>>  		data->last_updated = jiffies;
>>  		data->valid = 1;                 
>> @@ -696,11 +736,18 @@ static ssize_t set_watchdog_control(stru
>>  				    fscher_data *data, const char *buf, size_t count,
>>  				    int nr, int reg)
>>  {
>> -	/* bits 0..3 reserved => mask with 0xf0 */  
>> -	unsigned long v = simple_strtoul(buf, NULL, 10) & 0xf0;
>> +	unsigned long v = simple_strtoul(buf, NULL, 10);
>> +	u8 mask;
>> +
>> +	if (data->kind = fscher)
>> +		mask = 0xf0; /* bits 0..3 reserved */
>> +	else
>> +		mask = 0xb0; /* bits 0..3 & 6 reserved */
> 
> The fscpos driver uses mask 0xf0 here...
> 

It does, but according to the datasheet for the fscpos, bit 6 is reserved on 
the fscpos too. Notice that the wachdog interface in general is poorly designed 
just like the tempX_status register its really nothing more then a raw export 
of registers.

>> +
>> +	v &= mask;
>>  
>>  	mutex_lock(&data->update_lock);
>> -	data->watchdog[2] &= ~0xf0;
>> +	data->watchdog[2] &= ~mask;
>>  	data->watchdog[2] |= v;
>>  	fscher_write_value(client, reg, data->watchdog[2]);
>>  	mutex_unlock(&data->update_lock);
>> @@ -709,8 +756,14 @@ static ssize_t set_watchdog_control(stru
>>  
>>  static ssize_t show_watchdog_control(struct fscher_data *data, char *buf, int nr)
>>  {
>> -	/* bits 0..3 reserved, bit 5 write only => mask with 0xd0 */
>> -	return sprintf(buf, "%u\n", data->watchdog[2] & 0xd0);
>> +	u8 mask;
>> +
>> +	if (data->kind = fscher)
>> +		mask = 0xd0; /* bits 0..3 reserved, 5 write only */
>> +	else
>> +		mask = 0x90; /* bits 0..3 & 6 reserved, 5 write only */
> 
> ... and 0xb0 here. Any reason why you use different values? If you
> think the fscpos driver uses the wrong masks, please send a patch to
> fix them.
> 

Bit 5 is write only, so we have no idea what it will return when read, so yes I 
believe the fscpos driver is using the wrong masks. Alternatively to fixing 
this we could concider ripping out the watchdog support completely, I would 
actually prefer that, because as said its nothing more then a couple of raw 
registers exports. If peope want to get to the raw registers they can use i2c-dev.

>> @@ -720,7 +773,7 @@ static ssize_t set_watchdog_status(struc
>>  	unsigned long v = simple_strtoul(buf, NULL, 10) & 0x02;
>>  
>>  	mutex_lock(&data->update_lock);
>> -	data->watchdog[1] &= ~v;
>> +	data->watchdog[1] &= ~v; /* write 1 to clear */
> 
> This comment is confusing. You say "write 1 to clear" while the code
> sets the bit in question to 0, not 1. Please clarify.
> 
>>  	fscher_write_value(client, reg, v);
>>  	mutex_unlock(&data->update_lock);
>>  	return count;
> 

The code in question confused me, hence I added the comment to try and clarify 
it. Notice how v gets masked with 0x02, and thus can only be 0 or 0x02, if its 
zero, the this line: "data->watchdog[1] &= ~v" does nothing, if its 0x02, then 
bit 1 of our copy of the watchdog register gets cleared. IOW if the user writes 
1 to bit 1 its gets cleared. We update our local copy of the register to 
reflect this, clearing the bit if a one is written, notice that v is used later 
to write to the chip, not our copy of the register, so a 1 gets written, 
clearing the bit and the statement I added the comment to updates our in memory 
copy to reflect the change caused by this write.

Suggestions for a clearer comment, while not using as much text as I just did, 
are welcome. Alternatively, we could just leave it as is, without any comment 
at all. Or even better just kill off the pseudo watchdog support entirely.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
