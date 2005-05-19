From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: Question about chip driver policy
Message-Id: <3F52F31E.30805@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <629E717C12A8694A88FAA6BEF9FFCD440224B3AB@brigadoon.spirentcom.com>
In-Reply-To: <629E717C12A8694A88FAA6BEF9FFCD440224B3AB@brigadoon.spirentcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Many of the older sensor chips, had basic Analog to Digital converters on 
them.  They depended on the implementer (motherboard manufacturer) to use 
external resistors to bring the measured voltage into the valid range for the 
analog input.  To further complicate things, negative voltages cannot usually 
be measured at all (the valid input range for the A/D is usually 0 to 3V or 
4V).  To measure a negative voltage a positive "reference" voltage is required 
in addition to the resistors.

All that means that it's unwise to hard code resistor dividers in the driver 
as it would make the sensors.conf *much* more complicated.  It's much better 
in that case to simply export the measured voltage and let sensors.conf and 
libsensors scale based on user supplied equations that are customized for the 
motherboard.

Unlike the voltage sensors, fan readings generally have no dependancies on 
external configuration values.  They are relative to clocks built into the 
chip.  So in that case, it makes sense for the driver to export something more 
directly useful.  However, sometimes the motherboard vendor will use a 
different speed crystal to clock a chip and then the speeds will be wrong.  In 
that case, scaling equations in sensors.conf/libsensors are again necessary.

More recently, sensor chips have been coming with on-board, laser trimmed 
scaling resistors.  These are as good or better than the ones used with older 
chips.  In this case, we again know with certainty everything necessary to 
convert the reading into an accurate voltage reading.  So in this case (since 
I wrote the LM85 driver...) I was asked to scale the voltage in the driver.

But as before, sometimes the motherboard vendors still add additional scaling 
resistors or in-line resistors.  This affects the measured voltages and again 
requires sensors.conf/libsensors.

So my recommended rule is, if the chip provides all the information necessary 
to scale the value, then do it.  Otherwise, report the raw value.

:v)

Jean Delvare wrote:

>>In the new-drivers document, under the heading "Write the new driver",
>>it says:
>>
>>  "Remember that you want to output the direct measurements done by
>>  the chip. If these sensor values need scaling, this should be done
>>  through the configuration file."
>>
>>However, many of the existing drivers don't do this. For example,
>>lm85.c has this macro:
>>
>>#define FAN_FROM_REG(val) ((val)=0?-1:(val)=0xffff?0:5400000/(val))
>>
>>which the driver uses to convert from register values to rps. There
>>are lots of similar constructs in other drivers.
>>
>>Which is the right way for new drivers - the code or the
>>documentation?
>>
> 
> The documentation sure would need some clarifications. Yes, most drivers
> convert values to output useful information. Chips behave too
> differently and it would be a complete mess if we were really outputing
> raw values (what would the drivers be worth to then?). I think that what
> the documentation tries to prevent there is hardcoding resistor values
> for +5V, +12V, -12V and -5V. These values are likely to change from
> motherboard to motherboard, and that's why they are set in
> /etc/sensors.conf. For the rest, drivers tend to convert from registers
> to "real" values (that is, values that make direct sense for a human
> being).
> 
> Most of the time you will want to believe the driver code :) However,
> the best thing to do would be to fix the documentation to match what we
> actually do. I have made some modifications to the documentation at the
> time I wrote a chip driver myself, feel free to do the same.
> 
> And don't hesitate to ask other questions that may come to your mind :)
> 
> 

