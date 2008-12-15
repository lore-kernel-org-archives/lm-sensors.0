From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 15 Dec 2008 08:42:33 +0000
Subject: Re: [lm-sensors] PATCH: f71882fg: Remove the fan_mode module option
Message-Id: <49461879.9020100@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <49451F0B.8040409@redhat.com>
In-Reply-To: <49451F0B.8040409@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> Hi Hans,
> 
> On Sun, 14 Dec 2008 15:58:19 +0100, Hans de Goede wrote:
>> Remove the fan_mode module option it was a monstrosity to begin with, and
>> when adding support for the F8000 it becomes a real pain!
>> (...)
>> This should be the last preperation patch. The driver was in a less good shape 
>> then I had initially hoped / expected (for which I can blame no-one but myself).
> 
> Don't be too hard to yourself. The driver was doing the job, and wasn't
> that bad anyway. There are many other drivers in drivers/hwmon which
> could benefit from cleanups similar to what you just did for the
> f71882fg.
> 

Thanks :)


> Review:
> 
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> --- linux/drivers/hwmon/f71882fg.c.11-applied	2008-12-14 15:25:34.000000000 +0100
>> +++ linux/drivers/hwmon/f71882fg.c	2008-12-14 15:28:02.000000000 +0100
>> @@ -90,12 +90,6 @@
>>  module_param(force_id, ushort, 0);
>>  MODULE_PARM_DESC(force_id, "Override the detected device ID");
>>  
>> -static int fan_mode[4] = { 0, 0, 0, 0 };
>> -module_param_array(fan_mode, int, NULL, 0644);
>> -MODULE_PARM_DESC(fan_mode, "List of fan control modes (f71882fg only) "
>> -		 "(0=don't change, 1=pwm, 2=rpm)\n"
>> -		 "Note: this needs a write to pwm#_enable to take effect");
>> -
>>  enum chips { f71862fg, f71882fg };
>>  
>>  static const char *f71882fg_names[] = {
>> @@ -841,15 +835,8 @@
>>  	val = fan_to_reg(val);
>>  
>>  	mutex_lock(&data->update_lock);
>> -	data->pwm_enable = f71882fg_read8(data, F71882FG_REG_PWM_ENABLE);
>> -	if (data->pwm_enable & (1 << (2 * nr)))
>> -		/* PWM mode */
>> -		count = -EINVAL;
>> -	else {
>> -		/* RPM mode */
>> -		f71882fg_write16(data, F71882FG_REG_FAN_FULL_SPEED(nr), val);
>> -		data->fan_full_speed[nr] = val;
>> -	}
>> +	f71882fg_write16(data, F71882FG_REG_FAN_FULL_SPEED(nr), val);
>> +	data->fan_full_speed[nr] = val;
> 
> I do not understand this part. Without the fan_mode option, you are
> leaving the fans in the mode in which the BIOS (or, failing that, the
> hardware default) left them.

Correct.

> But now you assume that all fans are
> always in RPM mode?

No, I merely always allow setting of the FAN_FULL_SPEED register, as we also 
allow reading it always. This register is completely not used in pwm mode 
(unlike some other registers which have dual meaning depending on the mode). So 
writing it is just as safe as reading it.

If we want to still check for rpm mode before allowing writes, the correct 
thing to do would be to return -ENXIO, and do the same thing in the show method.

Just removing the check seems best to me as it doesn't gain us anything and 
less code is more :)

>>  	mutex_unlock(&data->update_lock);
>>  
>>  	return count;
>> @@ -1247,16 +1234,6 @@
>>  		data->pwm_enable &= ~(2 << (2 * nr));
>>  		break;		/* Temperature ctrl */
>>  	}
>> -	if (data->type = f71882fg) {
>> -		switch (fan_mode[nr]) {
>> -		case 1:
>> -			data->pwm_enable |= 1 << (2 * nr);
>> -			break;		/* Duty cycle mode */
>> -		case 2:
>> -			data->pwm_enable &= ~(1 << (2 * nr));
>> -			break;		/* RPM mode */
>> -		}
>> -	}
>>  	f71882fg_write8(data, F71882FG_REG_PWM_ENABLE, data->pwm_enable);
>>  	mutex_unlock(&data->update_lock);
>>  
> 
> Other than that, I am always happy to see unneeded code go away :)
> 

+1


Regards,

Hans


p.s.

I think it would be good to:
1) Add a dev_info showing rpm or pwm mode per fan
2) Add some docs explaining the difference. The way the sysfs interface
is implemented both actually work the same, the only difference is that
pwm atrributes go from 0-100% duty cycle in pwm mode and in rpm mode actually 
control the fan rpm not dutycycle, goin from 0 - 100% of fan#_full_speed (which 
I sincerely hope gets set to something sane by the BIOS if the BIOS programs 
the pwm in rpm mode (por default is pwm mode).

But that is for yet another patch.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
