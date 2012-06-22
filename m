From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 22 Jun 2012 06:34:10 +0000
Subject: Re: [lm-sensors] Configuration for EL620-C motherboard
Message-Id: <20120622083410.655c123c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FE232BE.7060409@sat.dundee.ac.uk>
In-Reply-To: <4FE232BE.7060409@sat.dundee.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paul,

On Wed, 20 Jun 2012 21:29:50 +0100, Paul Crawford wrote:
> Attached is the sensors configuration file for the DFI EL620-C 
> industrial motherboard (it has ISA slots which we need), details of 
> which are here:
> 
> http://www.dfi.com/products/ProductDetails.jsp?productIdq36&mainCategoryId=1&subCategoryIdf

Wow, I thought ISA slots died 10 years ago! I'm a bit curious what kind
of cards you plug in them and if they work OK with recent Linux
kernels. Some times ago, Alan Cox wanted to kill ISA support altogether!

> We were impressed that our query about the sensors chip was answered 
> quickly and comprehensively!

I had limited experience with DFI so far, good to know they have great
support.

> Hopefully the figures used are all correct, but if not we would 
> appreciate such feedback.

Overall it looks very good. Thanks for your contribution, I have added
it to our wiki:
http://www.lm-sensors.org/wiki/Configurations/DFI/EL620-C

Random comments:

> # lm_sensors configuration file for DFI Itox EL620-C industrial motherboard
> # 2012-06-20, Paul Crawford <psc@sat.dundee.ac.uk>
> # Based on feedback from DFI and the schematic sheet 15 of 24, revision A1, 28 October 2011
> 
> # Winbond W83627DHG configuration for EL620-C
> chip "w83627dhg-*"
> 
>     label in0 "VCore"
>     label in1 "+5V"
>     label in2 "AVCC"
>     label in3 "+3.3V"
>     label in4 "+1.1V"
>     label in5 "Vmemory"
>     label in6 "+12V"
>     label in7 "Vstandby"
>     label in8 "VBAT"
>     
> # +12V and +5V use dividers from schematic
>     compute in1 @*(1+(30.1/10)),  @/(1+(30.1/10))
>     compute in6 @*(1+(60.4/10)),  @/(1+(60.4/10))
> 
> # We need to set voltage limits. Note you may need to adapt in0 depending on your CPU
>     set in0_min   0.9
>     set in0_max   1.7

1.7 seems a little high for a Socket 775 CPU. I don't think any of them
can take more than 1.5 V. OTOH some models can go as low as 0.85 V.

> 
>     set in1_min   5.0*0.95
>     set in1_max   5.0*1.05
> 
>     set in2_min   3.3*0.95
>     set in2_max   3.3*1.05
> 
>     set in3_min   3.3*0.95
>     set in3_max   3.3*1.05
> 
>     set in4_min   1.1*0.95
>     set in4_max   1.1*1.05
> 
> # DDR3 voltage ranges?
>     set in5_min   1.30
>     set in5_max   1.65

According to Wikipedia quoting JEDEC, "1.575 volts should be considered
the absolute maximum when memory stability is the foremost
consideration." Which incidentally is 1.5V + 5%, so in line with ATX12V
rules. For the lower end, it depends if the board supports low-voltage
(1.35V) DDR3.

> # Original ATX spec was +/-10% on +12V, but recent ATX12V version 2.2 spec is 5% (still 10% on unmonitored -12V)
>     set in6_min   12.0*0.95
>     set in6_max   12.0*1.05
> 
>     set in7_min   3.3*0.95
>     set in7_max   3.3*1.05
> 
> # Battery voltage, assume CR2032 Lithium-Manganese Dioxide Battery.
> # This actually seems not to be needed as hard-coded?
>     set in8_min   2.7
>     set in8_max   3.3

Maybe it has hardware defaults, or maybe the BIOS sets proper limits,
yes.

> # Fans
>    label fan1		"System fan"
>    label fan2		"CPU Fan"
>    label fan3		"2nd fan"

This is a rather poor label. Either don't give it a label at all, or
use the connector name on the board, or a name describing the intended
usage for the extra fan (e.g. "Front fan", "Rear fan", "PSU fan"...)

>    ignore fan4
>    ignore fan5
>    
> # Fan minimums, disable fan1 & fan2 as a case fan is not always connected

I guess you mean "fan1 & fan3"?

>   set fan1_min    0
>   set fan2_min    500
>   set fan3_min    0  
> 
> # Temperatures. Can we assume temp2 limit for CPU is set by BIOS?

Very likely, yes. You may even be able to chose the limit in the BIOS
setup screens.

>    label temp1     "Board temp #1"
>    label temp2     "CPU Temp"
>    label temp3     "Board temp #2"
> 
>    set temp1_max       65
>    set temp1_max_hyst  55
> 
>    set temp3_max       65
>    set temp3_max_hyst  55
> 
> # Not sure what this is, always reported 0.000 and the VID0-VID7 pins are not connected on schematic.
>    ignore cpu0_vid

This would report the nominal CPU core voltage, if VID pins were used.
If they aren't, then this ignore statement is right to have.

> # From the Intel CPU itself? Seems not to need any special configuration.
> #chip "coretemp-*"

Correct.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
