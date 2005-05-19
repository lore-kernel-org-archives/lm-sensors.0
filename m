From: rnissl@gmx.de (Reinhard Nissl)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <401FFA13.90204@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Jean Delvare wrote:

>>>It seems, that you've used the latest driver file, I've sent, where
>>>all occurances of simple_stroul() put their result into a variable
>>>of type 'unsigned long' (instead of int) and where set_fan_div()
>>>outputs this message
>>>
>>>	dev_info(&client->adapter->dev, "fan_div value %ld not
>>>	supported. Choose one of 2, 4 or 8!\n", v);
>>>
>>>when it is called with an unsupported div value.
>>
>>You mean that I have *not* being using it. Shame on me. I'll
>>reintegrate these changes into my version, sorry. Nice catching by the
>>way. I'm glad to see you're keeping a serious eye on me.
> 
> Done, with a bit of shaping to keep it in the Good Coding Style (TM).
> New version attached.

I'm sorry that you had to shape my code twice. Did you use some utility?

>>>Temp1/CPU:      failed
>>>Temp2/MB:       failed
>>>Temp3/AUX:      failed
> 
> There was a wrong magnitude in libsensors (statuses are not real
> temperatures so a magnitude of 3 wasn't a very subtle choice, my bad).
> Fixed in CVS, if you care to try.

I'll give it a try later today.

>>>ERROR: Can't get FAN1 data!
>>>ERROR: Can't get FAN2 data!
>>>ERROR: Can't get FAN3 data!
>>>(...)
>>>How can I set pwm* with 'sensors -s', as it gives me
>>>Error: Line 1589: Unknown feature name
>>>Error: Line 1590: Unknown feature name
>>>Error: Line 1591: Unknown feature name
>>>when I enable those lines in 'sensors.conf'.
> 
> Your driver is in fact mixing fan mins and pwm, while these are
> completely different things. I just realize now that the Hermes doesn't
> have PWM capabilities (at least according to your 2.4 driver
> documentation and the data sheet). PWM designates the possibility to
> regulate the fan speed. fan mins are limits under which fan alarms
> trigger. The Hermes has fan mins, bot no PWM. So, whatever you have been
> trying to do, it is obviously not correct.
> 
> Please replace your set_pwm and get_pwm functions with set_fan_min and
> show_fan_min. show_fan_min should look much like show_fan_input. I leave
> set_fan_min to you. Rename sysfs files accoringly. Remember that these
> sysfs files deal with RPM values, not raw register values as you were
> doing with pwm.

Well, none of the two file types (pwm/fan_min) is perfekt for that case. It 
would be necessary to have something like 'pwm_min'!

You are right, that this register has a little bit the functionality of 
fan_min. If the register is set to 0, the fan is allowed to stop. In any other 
case, the fan must be spinning, but the minimum speed is up to the internals 
of HERMES and is not depending on the register's value. If HERMES thinks, that 
the fan speed is too low, it sets the fan's state register to indicate a fan 
failure.

But I think, this register behaves more like 'pwm': as long as the system is 
cool enough, HERMES will honor the registers value and generate a 3.3 V PWM 
signal (T = 30.8 us) with the following timing:

	reg		tp [us]		U [V]		meaning
	0		0		0		OFF
	1		8.4		6.09		MIN
	...		...		...		...
	255		29.6		11.75		MAX

If the system is put under high load and gets hot, HERMES no longer honors the 
user supplied pwm value and overrides it with its own, that will protect the 
system from overheating. One can think of the following equation:

	pwm_to_use = max(pwm_system_safety, pwm_user_supplied)

pwm_system_safety is determined by a sensor-fan-matrix. It is used to have e. 
g. the AUX fan turn faster if the CPU heats up. But for any reason, the BIOS 
doesn't connect any sensor to the AUX fan, which means that the fan will stay 
off forever, when I set it's register to 0.

I've already contacted FSC for additonal information, but they cannot tell, 
how to access the sensor-fan-matrix, due to the fact, that it would allow to 
drop the connection e. g. between CPU sensor and CPU fan. If no reasonable 
values are programmed to the matrix, one will finally detroy its system due to 
overheating. FSC fears, that a huge number of people might take them into 
warrenty for messed up systems, where FSC would then have to prove, that e. g. 
the board was damaged by improper vales programmed into HERMES. But I was also 
told, that future BIOS versions will give more control over HERMES, but there 
is still no release date.

Therefore, I've already thought about a little utility, that reads the sensors 
and writes reasonable values to this register. One more reason to call it pwm.

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de
