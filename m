From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 10 Mar 2011 22:11:31 +0000
Subject: Re: [lm-sensors] RFC: nct6776f support in the w83627ehf and fan
Message-Id: <20110310221131.GA29548@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
In-Reply-To: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Mar 10, 2011 at 04:03:58PM -0500, Robert Kaiser wrote:
> Ian Dobson schrieb:
> > Any chance you can have a look in the BIOS and email the exact values
> > you see there.
> 
> Ah, right, good idea, wrote a note and will do so tomorrow when I get up 
> and boot the machine!
> 
> > What
> > motherboard do you have? Maybe the manufacturer has some documentation.
> 
> As I mentioned in the first message where I posted this, I have an Intel 
> DH67CL - as this is one of the relatively new Sandy Bridge 
> graphics-enabled board, I guess we'll see those in wider circulation in 
> the next months (esp. once the B3 version with the fixed SATA channels 
> is available everywhere).
> 
> > Maybe something similar would be correct for your board. If you add this
> > to your config file
> 
> I'll look into that - are your values better for those voltages that 
> already get named (and calculated) by Guenther's standalone driver or 
> are those just duplicates of what it already does by default?
> 
Hi Robert,

this is what I configured for my board (Intel DH57JG). Some of it is guessing,
some of it is common practice with Winbond/Nuvoton chips.

chip "nct6775-*"

    label in0 "VCore"
    label in1 "+12V"
    label in2 "AVCC"
    label in3 "+3.3V"
    label in4 "+5V"
    label in5 "+1.5V"
#    label in6 "VIN3"
    label in7 "VSB"
    label in8 "VBAT"

    compute in1 (16 *@) ,  (@/16)
    compute in4 (4*@) ,  (@/4)
    compute in5 (2*@) ,  (@/2)
#    compute in6 (5*@) ,  (@/5)

    set in0_min   0.5
    set in1_min   12*0.9
    set in1_max   12*1.1
    set in2_min   3.3*0.9
    set in2_max   3.3*1.1
    set in3_min   3.3*0.95
    set in3_max   3.3*1.05
    set in4_min   5*0.95
    set in4_max   5*1.05
    set in5_min   1.5*0.95
    set in5_max   1.5*1.05
    set in7_min  3.3 * 0.90
    set in7_max  3.3 * 1.10
    set in8_min  3.0 * 0.90
    set in8_max  3.0 * 1.10

    ignore in6

Regarding the temperature sensor labels - those are straight from the chip manual.
The NCT677x chips are quite flexible in temperature channel to fan control assignments.
SYSTIN, CPUIN, and AUXTIN are actual pins on the NCT6557F, the PCH_ values are
from the PCH (Sandy Bridge in your case), and then there are several PECI channel
values which come from the CPU. The complete list of possible temperature sources
for NCT6775F is

SYSTIN
CPUTIN
AUXTIN
AMD SB-TSI
PECI Agent 0
PECI Agent 1
PECI Agent 2
PECI Agent 3
PECI Agent 4
PECI Agent 5
PECI Agent 6
PECI Agent 7
PCH_CHIP_CPU_MAX_TEMP
PCH_CHIP_TEMP
PCH_CPU_TEMP
PCH_MCH_TEMP
PCH_DIMM0_TEMP
PCH_DIMM1_TEMP
PCH_DIMM2_TEMP
PCH_DIMM3_TEMP

Hope this helps,

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
