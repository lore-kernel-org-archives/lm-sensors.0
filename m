From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 21 Oct 2008 11:27:37 +0000
Subject: Re: [lm-sensors] [RFC] PATCH: f71882fg add support for the f71862fg
Message-Id: <48FDBCA9.7050707@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48FC9ED8.5020206@redhat.com>
In-Reply-To: <48FC9ED8.5020206@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> Hi Hans,
> 
> On Mon, 20 Oct 2008 17:08:08 +0200, Hans de Goede wrote:
>> This patch adds support for the Fintek f71862fg superio monitoring functions to
>> the f71882fg driver.
>>
>> This patch applies on to of the patches adding pwm support to the f71882fg driver.
>>
>> I'm waiting for feedback from Tony McConnell to actually test this as I don't 
>> have the hardware. I expect no troubles with testing and would appreciate a 
>> review now, so that this patch can get merged into 2.6.28 as soon as its tested.
> 
> Here you go:
> 
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>> --- f71882fg.c.pre-f71862fg	2008-10-20 11:32:17.000000000 +0200
>> +++ f71882fg.c	2008-10-20 16:45:00.000000000 +0200
> 
> Full path please, so that I can apply the patch without editing it
> first.
> 

/me stupid, will fix.

<snip>

>> @@ -106,8 +114,14 @@
>>  static inline void superio_select(int base, int ld);
>>  static inline void superio_exit(int base);
>>  
>> +struct f71882fg_sio_data {
>> +	enum chips type;
>> +};
>> +
>>  struct f71882fg_data {
>>  	unsigned short addr;
>> +	enum chips type;
>> +	const char *name;
> 
> Not sure why you store the name here, given that you could simply look
> it up as f71882fg_names[data->type] when you need it (which is only
> once as far as I can see.
> 

Good point I'll stop storing the name.

>>  	struct device *hwmon_dev;
>>  
>>  	struct mutex update_lock;
>> @@ -229,10 +243,6 @@
>>  
>>  static int __devinit f71882fg_probe(struct platform_device * pdev);
>>  static int __devexit f71882fg_remove(struct platform_device *pdev);
>> -static int __init f71882fg_init(void);
>> -static int __init f71882fg_find(int sioaddr, unsigned short *address);
>> -static int __init f71882fg_device_add(unsigned short address);
>> -static void __exit f71882fg_exit(void);
>>  
> 
> That kind of cleanup would be nicer to have as a preliminary patch.
> 

I will split this in 2 patches with the next revision.

>>  static struct platform_driver f71882fg_driver = {
>>  	.driver = {
>> @@ -243,20 +253,15 @@
>>  	.remove		= __devexit_p(f71882fg_remove),
>>  };
>>  
>> -static struct device_attribute f71882fg_dev_attr[] >> +static struct sensor_device_attribute_2 f71882fg_dev_attr[] >>  {
>> -	__ATTR( name, S_IRUGO, show_name, NULL ),
>> +	SENSOR_ATTR_2(name, S_IRUGO, show_name, NULL, 0, 0),
>>  };
> 
> This change makes little sense to me. I understand that you want to
> have this array in the same format as the other attribute arrays so
> that you can call f71882fg_create_sysfs_files() on it... But isn't it a
> bit overkill to have an array of sensor_device_attribute_2 structures
> for just one attribute which doesn't even need these extra parameters?
> You could simply use DEVICE_ATTR() and call device_create_file()
> directly on it.
> 
> Not to mention that the name of this attribute array isn't even
> consistent with the other names.
> 

I will move it over to DEVICE_ATTR()

<snip>

>> @@ -608,14 +667,19 @@
>>  {
>>  	struct f71882fg_data *data = dev_get_drvdata(dev);
>>  	int nr, reg, reg2;
>> +	int no_fans = (data->type = f71862fg) ? 3 : 4;
> 
> I suggest renaming this to nr_fans or just n_fans. "no_fans" is
> ambiguous.
> 

Will do.

>>  
>>  	mutex_lock(&data->update_lock);
>>  
>>  	/* Update once every 60 seconds */
>>  	if ( time_after(jiffies, data->last_limits + 60 * HZ ) ||
>>  			!data->valid) {
>> -		data->in1_max = f71882fg_read8(data, F71882FG_REG_IN1_HIGH);
>> -		data->in_beep = f71882fg_read8(data, F71882FG_REG_IN_BEEP);
>> +		if (data->type = f71882fg) {
>> +			data->in1_max >> +				f71882fg_read8(data, F71882FG_REG_IN1_HIGH);
>> +			data->in_beep >> +				f71882fg_read8(data, F71882FG_REG_IN_BEEP);
>> +		}
>>  
>>  		/* Get High & boundary temps*/
>>  		for (nr = 0; nr < 3; nr++) {
>> @@ -656,24 +720,42 @@
>>  						      F71882FG_REG_FAN_HYST0);
>>  		data->pwm_auto_point_hyst[1] = f71882fg_read8(data,
>>  						      F71882FG_REG_FAN_HYST1);
>> -		for (nr = 0; nr < 4; nr++) {
>> -			int point;
>> -
>> +		for (nr = 0; nr < no_fans; nr++) {
>>  			data->pwm_auto_point_mapping[nr] >>  			    f71882fg_read8(data,
>>  					   F71882FG_REG_POINT_MAPPING(nr));
>>  
>> -			for (point = 0; point < 5; point++) {
>> -				data->pwm_auto_point_pwm[nr][point] >> -				    f71882fg_read8(data,
>> -						   F71882FG_REG_POINT_PWM
>> -						   (nr, point));
>> -			}
>> -			for (point = 0; point < 4; point++) {
>> -				data->pwm_auto_point_temp[nr][point] >> -				    f71882fg_read8(data,
>> -						   F71882FG_REG_POINT_TEMP
>> -						   (nr, point));
>> +			if (data->type = f71882fg) {
>> +				int point;
>> +				for (point = 0; point < 5; point++) {
>> +					data->pwm_auto_point_pwm[nr][point] >> +						f71882fg_read8(data,
>> +							F71882FG_REG_POINT_PWM
>> +							(nr, point));
>> +				}
>> +				for (point = 0; point < 4; point++) {
>> +					data->pwm_auto_point_temp[nr][point] >> +						f71882fg_read8(data,
>> +							F71882FG_REG_POINT_TEMP
>> +							(nr, point));
>> +				}
>> +			} else {
>> +				data->pwm_auto_point_pwm[nr][1] >> +					f71882fg_read8(data,
>> +						F71882FG_REG_POINT_PWM
>> +						(nr, 1));
>> +				data->pwm_auto_point_pwm[nr][4] >> +					f71882fg_read8(data,
>> +						F71882FG_REG_POINT_PWM
>> +						(nr, 4));
>> +				data->pwm_auto_point_temp[nr][0] >> +					f71882fg_read8(data,
>> +						F71882FG_REG_POINT_TEMP
>> +						(nr, 0));
>> +				data->pwm_auto_point_temp[nr][3] >> +					f71882fg_read8(data,
>> +						F71882FG_REG_POINT_TEMP
>> +						(nr, 3));
>>  			}
>>  		}
>>  		data->last_limits = jiffies;
>> @@ -691,7 +773,7 @@
>>  
>>  		data->fan_status = f71882fg_read8(data,
>>  						F71882FG_REG_FAN_STATUS);
>> -		for (nr = 0; nr < 4; nr++) {
>> +		for (nr = 0; nr < no_fans; nr++) {
>>  			data->fan[nr] = f71882fg_read16(data,
>>  						F71882FG_REG_FAN(nr));
>>  			data->fan_target[nr] >> @@ -703,7 +785,8 @@
>>  			    f71882fg_read8(data, F71882FG_REG_PWM(nr));
>>  		}
>>  
>> -		data->in_status = f71882fg_read8(data,
>> +		if (data->type = f71882fg)
>> +			data->in_status = f71882fg_read8(data,
>>  						F71882FG_REG_IN_STATUS);
> 
> Moving this up with the other in-related reads would save you a test.
> 

The other in related reads are done only once a minute, this needs to be read 
every second as we actually expect it to change.

<snip>

>>  exit_unregister_sysfs:
>> -	for (i = 0; i < ARRAY_SIZE(f71882fg_dev_attr); i++)
>> -		device_remove_file(&pdev->dev, &f71882fg_dev_attr[i]);
>> -
>> -	for (i = 0; i < ARRAY_SIZE(f71882fg_in_temp_attr); i++)
>> -		device_remove_file(&pdev->dev,
>> -					&f71882fg_in_temp_attr[i].dev_attr);
>> -
>> -	for (i = 0; i < ARRAY_SIZE(f71882fg_fan_attr); i++)
>> -		device_remove_file(&pdev->dev, &f71882fg_fan_attr[i].dev_attr);
>> -
>> -	kfree(data);
>> +	f71882fg_remove(pdev); /* Will unregister the sysfs files for us */
> 
> If you do that then f71882fg_remove can no longer be marked __devexit.
> 

I will remove the __devexit marking.

>> @@ -1519,23 +1646,35 @@
>>  	*address &= ~(REGION_LENGTH - 1);	/* Ignore 3 LSB */
>>  
>>  	data.addr = *address;
>> -	start_reg = f71882fg_read8(&data, F71882FG_REG_START);
>> -	if (!(start_reg & 0x03)) {
>> +	reg = f71882fg_read8(&data, F71882FG_REG_START);
> 
> Unrelated to this patch, but as I just notice it... Here you access I/O
> ports which you did not yet request. This is bad. All these tests
> belong to f71882fg_probe() anyway.
> 

I will move this over to probe.

>> +	if (!(reg & 0x03)) {
>>  		printk(KERN_WARNING DRVNAME
>>  			": Hardware monitoring not activated\n");
>>  		goto exit;
>>  	}
>>  
>> +	/* If its a 71862 and the fan / pwm part is enabled sanity check
> 
> Spelling: "it is".
> 

Will fix.

<snip>

>> @@ -1573,14 +1719,18 @@
>>  {
>>  	int err = -ENODEV;
>>  	unsigned short address;
>> +	struct f71882fg_sio_data sio_data;
> 
> Please memset() sio_data. I've been bitten by that recently.
> 

Will do.

<snip>

>> @@ -1598,7 +1748,7 @@
>>  }
>>  
>>  MODULE_DESCRIPTION("F71882FG Hardware Monitoring Driver");
>> -MODULE_AUTHOR("Hans Edgington (hans@edgington.nl)");
>> +MODULE_AUTHOR("Hans de Goede (hdegoede@redhat.com)");
> 
> Adding yourself is fine. Removing the other Hans, on the other hand, is
> a bit harsh IMHO. Remove his e-mail address if you want, but please
> leave his name.
> 

Ok, so that would look like this? :
MODULE_AUTHOR("Hans Edgington, Hans de Goede (hdegoede@redhat.com)");

> Let me know how you want to proceed from here. There are only 3 days
> left until the end of the merge window, and I don't want to delay my
> pull request to Linus until the very last moment. So if you want this
> patch in kernel 2.6.28, we have to be very quick.
> 

I will start working on this right away and send you 3 patches before the end 
of the day:
1) cleanups
2) move ioport access to probe function
3) add f71862fg support

Hmm, that means there is no more time left for my fschmd watchdog patches, ah 
well. This one actually was requested by users, which is why I bumped its prio.

That leaves us plenty of time to get the fschmd watchdog and ti tmp401 stuff in 
shape for the next release, I promise I'l be quicker this time around and not 
wait till the last moment (again).

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
