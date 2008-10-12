From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 12 Oct 2008 10:12:19 +0000
Subject: Re: [lm-sensors] [RFC] [PATCH] hwmon: Add LTC4245 driver
Message-Id: <48F1CD83.1060402@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081010222831.GC8570@ovro.caltech.edu>
In-Reply-To: <20081010222831.GC8570@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ira Snyder wrote:
> Add Linux support for the Linear Technology LTC4245 Multiple Supply Hot
> Swap controller I2C monitoring interface.
> 
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>

Hi Ira,

Welcome to our (small) hwmon community.

I've reviewed your driver, and I'm happy to report the code looks good! However 
as you already indicated yourself the sysfs interface needs some work. I've 
been reading the data sheet and I think I have a solution for most of the sysfs 
issues.

> ---
>  Documentation/hwmon/ltc4245 |   63 ++++++
>  drivers/hwmon/Kconfig       |   11 +
>  drivers/hwmon/Makefile      |    1 +
>  drivers/hwmon/ltc4245.c     |  471 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 546 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/hwmon/ltc4245
>  create mode 100644 drivers/hwmon/ltc4245.c
> 
> As the subject says, this is RFC. I was not sure how to make the alarms
> on this chip fit into the alarms framework specified in sysfs-interface,
> so I left them out. I'm completely open to suggestions on what to do. I
> also exposed a number of registers straight from the chip to userspace
> (via sysfs). I don't know what the policy is for this.

The policy is to never, ever do this. We made this mistake in the past and we 
really don't want to repeat this. Device drivers should abstract hardware so 
userspace can talk to a device of a certain type/class without needing to know 
which device it is talking to, exporting registers directly is pretty much thhe 
opposite of hardware abstraction! Well with that lecture done, lets start 
looking into a solution for this :)

I think we can atleast represent the Overcurrent and Undervoltage faults in a 
standard way, as for the other features I think it would be best to ignore 
those, esp. the ability to turn on/off certain power rails certainly leaves the 
realm of hardware *monitoring*

So on to the Overcurrent and Undervoltage faults, those are quite easy actually 
once we get the input rights, currently you use the following representation 
for for example the 12V inputs:

in0_input	12v input  voltage (mV), range 0 - 14xxx mv
in1_input	12v sense  voltage (mV), range 0 - 63 mv
in2_input	12v output voltage (mV), range 0 - 14xxx mv

Notice the very strange scale for the 12v sense voltage, this is because this 
is not an absolute voltage, but a delta voltage, compared to the 12v input 
voltage, and it is how much lower this voltage is (it can never be higher!).

The reason for this is, because the 12v sense input is not a Voltage input at 
all, it is an input to measure current! However as current cannot be measured, 
it is first converted to a (delta) voltage using a sense resistor, see table 2 
"Sense Resistance Values" in the datasheet. So what we have here is a current 
input, and we have a standard sysfs interface for that:

"""
************
* Currents *
************

Note that no known chip provides current measurements as of writing,
so this part is theoretical, so to say.

curr[1-*]_max   Current max value
                 Unit: milliampere
                 RW

curr[1-*]_min   Current min value.
                 Unit: milliampere
                 RW

curr[1-*]_input Current input value
                 Unit: milliampere
                 RO
"""

So we could change in1 "12v sense  voltage (mV)" to curr1 "12v current (mA)", 
then the overcurrent fault for 12v, would become curr1_max_alarm. Mapping the 
undervolt alarm is easy too, as the datasheet specifies that this is an alarm 
when then input voltage becomes to low, so that would be in0_min_alarm.

That only leaves one issue, it would be nice to be able to map the currents and 
voltages together by something other then labels, but allas we have no API in 
place for that. We could however try to give them to same numbers.

So what I would like to suggest is to have the following sysfs attributes for 
inputs:

in1_input	12v input  voltage (mV)
in2_input	5v  input  voltage (mV)
in3_input	3v  input  voltage (mV)
curr1_input	12v amperage (mA)
curr2_input	12v amperage (mA)
curr3_input	12v amperage (mA)
in4_input	12v output voltage (mV)
in5_input	5v  output voltage (mV)
in6_input	3v  output voltage (mV)
in7_input	VEEout input  voltage (mV)
in8_input	VEEout sense  voltage (mV)
in9_input	VEEout output voltage (mV)
in10_input	GPIO #0 voltage (mV)
in11_input	GPIO #1 voltage (mV)
in12_input	GPIO #2 voltage (mV)
in13_input	GPIO #3 voltage (mV)

Note how inX begins at 1 here whereas the docs say it starts at 0, but skipping 
numbers (including 0) is allowed. Also note that we have no userspace code for 
current measuring yet, but that can be added to the current libsensors and 
sensors program easily.

This would then ofcourse be completed with the following alarm sysfs attributes:
in1_min_alarm
in2_min_alarm
in3_min_alarm
curr1_max_alarm
curr2_max_alarm
curr3_max_alarm


Given that we measure both output voltage and current, I think it would be cool 
to also add power#_input's to the driver, as thats just "output voltage * 
current". I know people will start screaming that we should do things like this 
in userspace, but given the fact that we have no API to match voltages and 
currents, let alone one to do the interesting mapping here, where one current 
corresponds to 2 voltages, and given how easy it is to add these 2 this driver, 
I'm in favor of adding them, so then we would also get:

power1_input 12v power consumption (micro watt)
power2_input 5v power consumption (micro watt)
power3_input 3v power consumption (micro watt)

Jean, whats your 2 cents on this ?

> Take it easy on me, this is my first hwmon driver :) I'd love
> suggestions for improvements, however.

Don't worry, for a first driver it is pretty good :) If you agree with my 
proposed sysfs interface and change the driver to match, I think we can get it 
in to 2.6.28.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
