From: arno@natisbad.org (Arnaud Ebalard)
Date: Fri, 19 Apr 2013 11:30:51 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] Add support for GMT G72/G763 PWM fan controller
Message-Id: <87y5ceahas.fsf@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1366322287.git.arno@natisbad.org>
 <4f4a821bbc61e2da28fd70553fd717ada255097d.1366322287.git.arno@natisbad.org>
 <20130419055054.GD18115@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Olivier Mouchet <olivier.mouchet@gmail.com>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Rob Landley <rob@landley.net>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, Simon Guinot <simon.guinot@sequanux.org>

Hi,

Andrew Lunn <andrew@lunn.ch> writes:

> Hi Arnaud
>
>> +static DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, get_pwm, set_pwm);
>> +static DEVICE_ATTR(pwm1_polarity, S_IWUSR | S_IRUGO,
>> +		   get_pwm_polarity, set_pwm_polarity);
>> +static DEVICE_ATTR(pwm1_mode, S_IWUSR | S_IRUGO,
>> +		   get_pwm_mode, set_pwm_mode);
>> +static DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO,
>> +		   get_speed_control_mode, set_speed_control_mode);
>> +static DEVICE_ATTR(pwm1_freq, S_IWUSR | S_IRUGO,
>> +		   get_pwm_freq, set_pwm_freq);
>> +
>> +static DEVICE_ATTR(fan1_input, S_IRUGO, get_fan_rpm, NULL);
>> +static DEVICE_ATTR(fan1_alarm, S_IRUGO, get_fan_ooc, NULL);
>> +static DEVICE_ATTR(fan1_alarm_detection, S_IWUSR | S_IRUGO,
>> +		   get_fan_ooc_detection, set_fan_ooc_detection);
>> +static DEVICE_ATTR(fan1_fault, S_IRUGO, get_fan_failure, NULL);
>> +static DEVICE_ATTR(fan1_fault_detection, S_IWUSR | S_IRUGO,
>> +		   get_fan_failure_detection, set_fan_failure_detection);
>> +static DEVICE_ATTR(fan1_target, S_IWUSR | S_IRUGO,
>> +		   get_fan_target, set_fan_target);
>> +static DEVICE_ATTR(fan1_pulses, S_IWUSR | S_IRUGO,
>> +		   get_fan_pulses, set_fan_pulses);
>> +static DEVICE_ATTR(fan1_div, S_IWUSR | S_IRUGO,
>> +		   get_fan_clk_div, set_fan_clk_div);
>> +static DEVICE_ATTR(fan1_gear_mode, S_IWUSR | S_IRUGO,
>> +		   get_fan_gear_mode, set_fan_gear_mode);
>> +static DEVICE_ATTR(fan1_startup_voltage, S_IWUSR | S_IRUGO,
>> +		   get_fan_startup_voltage, set_fan_startup_voltage);
>
> It is normal to use SENSOR_ATTR, not DEVICE_ATTR. Take a look at the
> existing fan drivers.

I will take a look and use SENSOR_ATTR if it is the expected way. For
the records, the g760a.c which I used as basis uses DEVICE_ATTR ;-)

> I also think a lot of these are not needed. They are fixed properties
> of the board and cannot change dynamically. They are set once using DT
> and user space does not need to care.

I added those knobs for a simple reason: I don't have all the various
characteristics of the target platform I am working on (Netgear
ReadyNAS Duo v2) and needed to be able to test various values w/o
rebooting to get those rights. I thought this knobs would be useful for
people with the same issue (for instance, the new ReadyNAS 102 also has
a G762) and would not hurt.

Anyway, I will split the patch in two parts and keep the useless knobs
on my side.

Thanks for your feedback,

Cheers,

a+

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
