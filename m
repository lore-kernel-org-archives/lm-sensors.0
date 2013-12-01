From: Kevin Lo <kevlo@kevlo.org>
Date: Sun, 01 Dec 2013 15:20:04 +0000
Subject: Re: [lm-sensors] w83l786ng driver bug, questions, and 1st round patch
Message-Id: <529B53A4.1040707@kevlo.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <CABhEY3OZAkB=NxDj-QSjWATQAPG-Akhr2a0CHTB7wahLJVH6aQ@mail.gmail.com>
In-Reply-To: <CABhEY3OZAkB=NxDj-QSjWATQAPG-Akhr2a0CHTB7wahLJVH6aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Brian,
>
> On Fri, 29 Nov 2013 23:57:49 -0800, Brian Carnes wrote:
>

[snip]

> Indeed, Richard (Cc'd) noticed some problems with fan speed control
> back then, but he did not provide enough details for investigation. The
> bug you found could well explain these problems, and Richard would
> probably be interested in testing your fix.
>
>> Patch addressing just problem #1:
>> --- a/w83l786ng.c
>> +++ b/w83l786ng.c
>> @@ -523,7 +523,7 @@ store_pwm_enable(struct device *dev, struct
>> device_attribute *attr,
>>          mutex_lock(&data->update_lock);
>>          reg = w83l786ng_read_value(client, W83L786NG_REG_FAN_CFG);
>>          data->pwm_enable[nr] = val;
>> -       reg &= ~(0x02 << W83L786NG_PWM_ENABLE_SHIFT[nr]);
>> +       reg &= ~(0x03 << W83L786NG_PWM_ENABLE_SHIFT[nr]);
>>          reg |= (val - 1) << W83L786NG_PWM_ENABLE_SHIFT[nr];
>>          w83l786ng_write_value(client, W83L786NG_REG_FAN_CFG, reg);
>>          mutex_unlock(&data->update_lock);
>> @@ -790,7 +790,7 @@ static struct w83l786ng_data
>> *w83l786ng_update_device(struct device *dev)
>>                              ((pwmcfg >> W83L786NG_PWM_MODE_SHIFT[i]) & 1)
>>                              ? 0 : 1;
>>                          data->pwm_enable[i] >> -                           ((pwmcfg >> W83L786NG_PWM_ENABLE_SHIFT[i]) & 2)
>> + 1;
>> +                           ((pwmcfg >> W83L786NG_PWM_ENABLE_SHIFT[i]) & 3)
>> + 1;
>>                          data->pwm[i] = w83l786ng_read_value(client,
>>                              W83L786NG_REG_PWM[i]);
>>                  }
>> -----PATCH END-----
>>
>> In short:
>> chunk 1 used to clear just bit 2 (so no modes 3 or 4), then always OR in
>> bit 1.
>>    Once set, no going back!  Now we clear both bits, and then OR in the mode.
>> chunk 2 used to always request bit 2 (which this driver always set to zero),
>>    and add one.  Thus you always appeared to be in "mode 1", unless the
>> hardware
>>    was in mode 3 or 4 by means other than the driver, then you would
>>    appear to be in mode 3...
>>    Now the driver will correctly report the mode (1, 2, 3, or 4).
> Yes, I came up to the same conclusion, your patch is correct. It should
> be backported to the stable kernel series as well. However formatting
> was destroyed by your e-mail client. Please resend with long line
> wrapping disabled (or as an attachment if you can't manage to do that.)
> You also must add your Signed-off-by line to it as explained in
> Documentation/SubmittingPatches section 12.
>
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches#n307

First off, I'm sorry that I don't have any hardware with a w83l786ng chip.
Second, your patch looks correct to me after reading the datasheet and
the code.  Thanks for fixing it.

>
>> Transcript after loading patched module:
>>
>> $ sudo rmmod w83l786ng
>> $ sudo insmod ./w83l786ng.ko
>> $ cat pwm1_enable pwm2_enable
>> 1
>> 1
>> $ i2cget -f -y 0 0x2e 0x80
>> 0x00
>> $ echo 1 > pwm1_enable
>> $ cat pwm1_enable pwm2_enable
>> 1
>> 1
>> $ i2cget -f -y 0 0x2e 0x80
>> 0x00
>> $ echo 2 > pwm1_enable
>> $ cat pwm1_enable pwm2_enable
>> 2
>> 1
>> $ i2cget -f -y 0 0x2e 0x80
>> 0x04
>> $ echo 1 > pwm1_enable
>> $ cat pwm1_enable pwm2_enable
>> 1
>> 1
>> $ i2cget -f -y 0 0x2e 0x80
>> 0x00
>>
>> Which is the expected behaviour.
> Indeed. Thanks for finding and fixing this bug. Please resend your
> patch as explained above and I'll be happy to apply it, forward it to
> the stable kernel maintainers, and make the updated driver available in
> a stand-alone flavor.

     Kevin

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
