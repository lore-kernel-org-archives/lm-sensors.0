From: rnissl@gmx.de (Reinhard Nissl)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <401EAEB3.8020800@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Jean Delvare wrote:

>>You are right. I've attached the fixed drivers and adjusted sample 
>>configuration. Documentation will follow later and explains, how to
>>get the necessary (M)ultiplier, (R)efVoltage and (O)ffset values from
>>dmidecode.
> 
> I have updated the 2.4 driver and sensors.conf. I've slightly changed
> the way input voltages are exported. I exported them as
> pseudo-hundredths of Volts (range 0V - 2.55V) instead of an integer
> value. I know that the value doesn't make much sense per se, but it
> keeps the value within usual ranges and also saves a few conversions
> later. I've updated the 2.6 driver accordingly so the same sensors.conf
> will still work with both.
> 
> As far as the 2.6 driver is concerned, I've included it to a 2.6.2-rc3
> source tree and made the other required changes (Makefile, Kconfig,
> i2c-id.h). Full patch attached.
> 
> I've made a few changes to your original work. Especially I reindented
> everything according to what kernel folks want. I don't like their
> standard more than you seem to do, but we have to comply to it or your
> driver won't be accepted.

Thank you very much for doing that.

> I've also made several unimportant changes (comments, debug stuff, code
> "design"). I left the functional stuff unchanged, since I know you know
> what you're doing and I couldn't possibly test my changes anyway.

It seems, that you've used the latest driver file, I've sent, where all 
occurances of simple_stroul() put their result into a variable of type 
'unsigned long' (instead of int) and where set_fan_div() outputs this message

	dev_info(&client->adapter->dev, "fan_div value %ld not supported. Choose one 
of 2, 4 or 8!\n", v);

when it is called with an unsupported div value.

> I committed a change to libsensors so that it finds fan_rippleX files
> from the 2.6 driver. There are still a few matchings missing (rev,
> control and wdog_*) but I don't think sensors uses them, does it?

We've already discussed about that and I'd like to add them, but I still do 
not know, how to access those values.

> I'd like you to get lm_sensors CVS, ensure that the new 2.4 driver works
> with the updated sensors.conf, lib and sensors. Then try the first
> candidate 2.6 driver, and report how it is going.

Both drivers work as expected. The conversion formula returns correct values. 
But sensors gives the following output on 2.6.1:

fscher-i2c-1-73
Adapter: SMBus I801 adapter at 2000
Temp1/CPU:      failed
Temp2/MB:       failed
Temp3/AUX:      failed
ERROR: Can't get FAN1 data!
ERROR: Can't get FAN2 data!
ERROR: Can't get FAN3 data!
+12V:           +11.79 V
+5V:             +5.05 V
Battery:         +3.04 V

sensors-detect works for both kernels, both times considers fscher as 'todo'.

How can I set pwm* with 'sensors -s', as it gives me

Error: Line 1589: Unknown feature name
Error: Line 1590: Unknown feature name
Error: Line 1591: Unknown feature name

when I enable those lines in 'sensors.conf'.

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de
