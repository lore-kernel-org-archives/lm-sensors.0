From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Thu, 13 Aug 2009 21:31:56 +0000
Subject: Re: [lm-sensors] ina209 driver + using calulate lines
Message-Id: <20090813213156.GH28596@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Aug 13, 2009 at 10:43:08AM -0700, Ira W. Snyder wrote:
> Hello all.
> 
> I'm working on a driver (posted here previously) for the INA209 chip.
> The chip itself has support for power and current readings, though they
> will only be valid if a special calibration register is set
> appropriately. The units used for interpreting the power and current
> registers change depending on the value in the calibration register;
> they are not constant.
> 
> It is possible to calculate the power and current from userspace using
> the sense resistor reading + the sense resistor value (which changes
> between implementations).
> 
> I am aware of the "calculate" lines in sensors3.conf, which should be
> able to do this kind of calculation.
> 
> My previous postings of this driver have mostly been ignored, probably
> due to set the calibration register before use. This is something not
> supported by the hwmon sysfs-interface. Using the userspace sensors
> program to handle this instead removes the need to set the calibration
> register.
> 
> I have two possible solutions:
> 1) Have curr1_input output the sense resistor voltage in mV and use the
>    sensors program (using "calculate") to convert it appropriately
> 2) Have curr1_input always read back 0 uA, and have the sensors program
>    use in0_input (the sense resistor voltage in mV) in the calculate
>    line, ignoring the reading from curr1_input
> 
> I can figure out how to use calculate for #1, but I cannot figure out
> how to reference a different sensor in a calculate line. The
> documentation claims this is possible, but I cannot find any examples.
> 

Ignore the "I don't know how to use other sensor values from a compute
statement" part of this. I've figured it out.

compute power1 curr1_input * in1_input, curr1_input * in1_input

Works perfectly for me. The power1_input value is calculated using the
readings from curr1_input and in1_input.

The rest of my questions still stand.

Thanks,
Ira

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
