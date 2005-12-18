From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Dec 2005 16:38:09 +0000
Subject: [lm-sensors] Question regarding temperature readings
Message-Id: <20051218173809.4636a780.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1134675134.4454.90.camel@gimli>
In-Reply-To: <1134675134.4454.90.camel@gimli>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

> Maybe the question sounds a little stupid, but I currently have no good
> option to reliably find out, so...
> 
> Let's assume that one sensor is to report a temperature of 42 degrees
> celcius. The system is running on 2.4.x. doc/developers/proc (in the
> latest lm_sensors package) says that temperatures are given as
> "millidegrees celcius". That would be "42000" then, right?

I just checked and doc/developers/proc doesn't say that, which is good
because that's not true. Temperatures are reported in millidegrees
Celsius in Linux 2.6 (sysfs interface) as integer values. In Linux 2.4
(procfs interface, which is what is documented in lm_sensors),
temperatures are reported in degrees Celsius as real values. The number
of digits after the decimal point is driver-dependant.

> The reason for asking is that lm77.c (which is the only driver I can use
> here atm) reports "4200.0" - the value isn't matching what I'd expect
> (can be fixed easily, though), and the decimal point is a bit
> irritating.
> 
> Did I miss something?

It would be easier to help you with the code.

As the LM77 reports temperature values with a resolution of 0.5 degree
Celsius, your driver should declare a magnitude (number of digits after
the decimal point) of 1, and should report the temperature values with
a LSB representing 0.1 degree Celsius.

The magnitude is returned by the procfs callbacks when operation =
SENSORS_PROC_REAL_INFO. The temperature value is returned for operation
= SENSORS_PROC_REAL_READ. Take a look at function lm75_temp in the
lm75 driver for an example. The lm77 case should be very similar. If
the driver currently reports 4200.0 for 42 degrees, it means that the
magnitude is properly set to 1, but the temperature value has been
multiplied by 500 (from the register value) instead of 5.

-- 
Jean Delvare

