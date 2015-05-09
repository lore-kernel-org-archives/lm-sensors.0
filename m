From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 09 May 2015 16:10:50 +0000
Subject: Re: [lm-sensors] Additional PWM driver support for w83792d
Message-Id: <554E318A.2040407@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <003901d08a57$bc46f8a0$34d4e9e0$@hiddenengine.co.uk>
In-Reply-To: <003901d08a57$bc46f8a0$34d4e9e0$@hiddenengine.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 05/09/2015 08:30 AM, Jean Delvare wrote:
> Hi Roger,
>
> Good to see you again :)
>
> On Sat, 9 May 2015 13:57:41 +0100, vt8231@hiddenengine.co.uk wrote:
>> Dear LM-Sensors,
>>
>> I have a Dell FS12-NV7 server and it has two W83792G chips on it (as well as
>> an IT87).  One of the W83792G devices is connected to three fans on PWM
>> outputs 3,4 and 5 respectively.
>>
>> I am running with Ubuntu 15.04 (Linux 3.19.0) and the W83792D driver only
>> has support for PWM outputs 1,2 and 3.
>>
>> The patch below adds the 4 missing PWM outputs which are supported by the
>> chip.  This has been tested and works as expected on my motherboard.
>
> It's amazing that nobody ever noticed the missing pwm files before,
> thanks for reporting.
>
>>
>> --- linux-3.19.0/drivers/hwmon/w83792d.c        2015-02-09
>> 02:54:22.000000000 +0000
>> +++ linux-3.19.0-new/drivers/hwmon/w83792d.c    2015-05-08
>> 21:53:06.637515282 +0100
>> @@ -1075,6 +1075,10 @@
>>   static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 0);
>>   static SENSOR_DEVICE_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 1);
>>   static SENSOR_DEVICE_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 2);
>> +static SENSOR_DEVICE_ATTR(pwm4, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 3);
>> +static SENSOR_DEVICE_ATTR(pwm5, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 4);
>> +static SENSOR_DEVICE_ATTR(pwm6, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 5);
>> +static SENSOR_DEVICE_ATTR(pwm7, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 6);
>>   static SENSOR_DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO,
>>                          show_pwmenable, store_pwmenable, 1);
>>   static SENSOR_DEVICE_ATTR(pwm2_enable, S_IWUSR | S_IRUGO,
>> @@ -1270,6 +1274,10 @@
>>          &sensor_dev_attr_pwm3.dev_attr.attr,
>>          &sensor_dev_attr_pwm3_mode.dev_attr.attr,
>>          &sensor_dev_attr_pwm3_enable.dev_attr.attr,
>> +       &sensor_dev_attr_pwm4.dev_attr.attr,
>> +       &sensor_dev_attr_pwm5.dev_attr.attr,
>> +       &sensor_dev_attr_pwm6.dev_attr.attr,
>> +       &sensor_dev_attr_pwm7.dev_attr.attr,
>>          &dev_attr_alarms.attr,
>>          &dev_attr_intrusion0_alarm.attr,
>>          &sensor_dev_attr_tolerance1.dev_attr.attr,
>>
>> I hope this patch is of use to others who are using the same server or have
>> a similar situation.
>
> Yes we want to apply something like this. However your e-mail client
> broke the formatting. Any chance you can resend using a client which
> does not mangle white space nor fold long lines?
>
> I think the new attributes should go in w83792d_attributes_fan rather
> than w83792d_attributes, as they are not always enabled (mutually
> exclusive with other functions.)
>
> Your patch should also add files pwm[4-7]_mode.
>
> Also there is this comment in the code:
>
> 	u8 pwm[7];		/*
> 				 * We only consider the first 3 set of pwm,
> 				 * although 792 chip has 7 set of pwm.
> 				 */
>
> which should be removed. Documentation/hwmon/w83792d should be updated
> accordingly, as it currently claims that fan outputs 4-7 aren't
> supported and doesn't mention attributes pwm[4-7] and pwm[4-7]_mode.
>
> We'll need your Signed-off-by line so that the patch can be applied.
>
> Last note: registers 0xA3-0xA6 have extra configuration bits "Sync
> T1/2/3". Maybe the driver should handle them but I am not sure how. It
> could be that the extra outputs should only be exposed to user-space if
> these bits are 0 (stand alone.) Guenter, any idea/opinion on this?
>

Hi Jean,

Good point.

How about using pwm[4567]_enable ? If I understand correctly, the possible
modes would be manual or sync(x). In this case we could have 1 (manual),
2 (sync with fan1), 3 (sync with fan2), and 4 (sync with fan3), with the
caveat that the sync settings only make sense if the matching pwmX_enable
is set to thermal cruise mode.

Does this make sense ?

Btw, do you have a datasheet for the chip with 7 fan controls/status pins ?

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
