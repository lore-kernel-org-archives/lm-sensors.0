From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 13 Oct 2008 10:00:05 +0000
Subject: Re: [lm-sensors] [RFC] [PATCH] hwmon: Add LTC4245 driver
Message-Id: <20081013120005.1d5a7ab2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081010222831.GC8570@ovro.caltech.edu>
In-Reply-To: <20081010222831.GC8570@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 12 Oct 2008 12:12:19 +0200, Hans de Goede wrote:
> Ira Snyder wrote:
> > Add Linux support for the Linear Technology LTC4245 Multiple Supply Hot
> > Swap controller I2C monitoring interface.
> (...)
> That only leaves one issue, it would be nice to be able to map the currents and 
> voltages together by something other then labels, but allas we have no API in 
> place for that. We could however try to give them to same numbers.
> 
> So what I would like to suggest is to have the following sysfs attributes for 
> inputs:
> 
> in1_input	12v input  voltage (mV)
> in2_input	5v  input  voltage (mV)
> in3_input	3v  input  voltage (mV)
> curr1_input	12v amperage (mA)
> curr2_input	12v amperage (mA)

I guess you mean 5v...

> curr3_input	12v amperage (mA)

... and 3v.

> in4_input	12v output voltage (mV)
> in5_input	5v  output voltage (mV)
> in6_input	3v  output voltage (mV)
> in7_input	VEEout input  voltage (mV)
> in8_input	VEEout sense  voltage (mV)
> in9_input	VEEout output voltage (mV)
> in10_input	GPIO #0 voltage (mV)
> in11_input	GPIO #1 voltage (mV)
> in12_input	GPIO #2 voltage (mV)
> in13_input	GPIO #3 voltage (mV)
> 
> Note how inX begins at 1 here whereas the docs say it starts at 0, but skipping 
> numbers (including 0) is allowed. Also note that we have no userspace code for 
> current measuring yet, but that can be added to the current libsensors and 
> sensors program easily.
> 
> This would then ofcourse be completed with the following alarm sysfs attributes:
> in1_min_alarm
> in2_min_alarm
> in3_min_alarm
> curr1_max_alarm
> curr2_max_alarm
> curr3_max_alarm
> 
> 
> Given that we measure both output voltage and current, I think it would be cool 
> to also add power#_input's to the driver, as thats just "output voltage * 
> current". I know people will start screaming that we should do things like this 
> in userspace, but given the fact that we have no API to match voltages and 
> currents, let alone one to do the interesting mapping here, where one current 
> corresponds to 2 voltages, and given how easy it is to add these 2 this driver, 
> I'm in favor of adding them, so then we would also get:
> 
> power1_input 12v power consumption (micro watt)
> power2_input 5v power consumption (micro watt)
> power3_input 3v power consumption (micro watt)
> 
> Jean, whats your 2 cents on this ?

I don't have enough free time these days to afford having an objection.
I am not too happy to see non-independent inputs in sysfs, as there's
no way for the user to know which values are independent and which are
computer, but indeed we lack a good way to express the relations
between different inputs. That's the same problem we had for fan# and
pwm#, or pwm# and temp# for automatic fan speed control. At some point
it might be convenient to introduce virtual sub-devices grouping
together things related items. For now, all we have is
pwm[1-*]_auto_channels_temp to map temperature channels to pwm outputs.
I guess we could do something similar to link voltage and current
channels.

But then again I do not have enough time to properly think about this
and propose something. So I'd say, do whatever you want, and whoever
really cares will have to do the thinking and the proposal and update
the drivers and libsensors if/as needed.

> > Take it easy on me, this is my first hwmon driver :) I'd love
> > suggestions for improvements, however.
> 
> Don't worry, for a first driver it is pretty good :) If you agree with my 
> proposed sysfs interface and change the driver to match, I think we can get it 
> in to 2.6.28.

That's a pretty optimistic statement from someone who isn't in charge ;)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
