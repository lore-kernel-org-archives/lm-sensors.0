From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Thu, 13 Aug 2009 17:43:08 +0000
Subject: [lm-sensors] ina209 driver + using calulate lines in sensors3.conf
Message-Id: <20090813174308.GC28596@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all.

I'm working on a driver (posted here previously) for the INA209 chip.
The chip itself has support for power and current readings, though they
will only be valid if a special calibration register is set
appropriately. The units used for interpreting the power and current
registers change depending on the value in the calibration register;
they are not constant.

It is possible to calculate the power and current from userspace using
the sense resistor reading + the sense resistor value (which changes
between implementations).

I am aware of the "calculate" lines in sensors3.conf, which should be
able to do this kind of calculation.

My previous postings of this driver have mostly been ignored, probably
due to set the calibration register before use. This is something not
supported by the hwmon sysfs-interface. Using the userspace sensors
program to handle this instead removes the need to set the calibration
register.

I have two possible solutions:
1) Have curr1_input output the sense resistor voltage in mV and use the
   sensors program (using "calculate") to convert it appropriately
2) Have curr1_input always read back 0 uA, and have the sensors program
   use in0_input (the sense resistor voltage in mV) in the calculate
   line, ignoring the reading from curr1_input

I can figure out how to use calculate for #1, but I cannot figure out
how to reference a different sensor in a calculate line. The
documentation claims this is possible, but I cannot find any examples.

Which of these two solutions would be more acceptable?

Thanks,
Ira

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
