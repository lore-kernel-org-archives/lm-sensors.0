From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 20 Feb 2014 20:55:03 +0000
Subject: Re: [lm-sensors] Configuration ASUS H87-PRO for Wiki
Message-Id: <20140220215503.0cd8b996@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <52F7AFB9.8040109@tuxedo.ath.cx>
In-Reply-To: <52F7AFB9.8040109@tuxedo.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mathias,

On Sun, 09 Feb 2014 17:41:29 +0100, Mathias Gerber wrote:
> Would you like to add this configuration to the lm-sensors wiki?
> - -- 
> greetings
>  mathias
> 
> 
> # Configuration file for ASUS H87-PRO
> # 2014-01-21/mg
> 
> chip "nct6791-*"
> 
> label in0 "VCCin" # CPU Input Voltage

We typically use "Vcore" for the CPU voltage, even though I see Asus
names it VCCIN in the BIOS.

>   compute in0  @*2    , @/2

This is very surprising. The NCT6791 has a 2.04 V ADC so any voltage
below 2 V doesn't need to be scaled. CPU core voltage is typically way
below 2 V on modern CPUs. 

> 
> label in1 "+5V" # 5V

How did you figure out?

As a general comment, I don't see the point of these comments
duplicating the label.

>   compute in1 @ * (40/8), @ / (40/8)
>   set in1_min 5 * 0.95
>   set in1_max 5 * 1.05
> 
> label in2 "AVCC?" # AVCC?
>   set in2_min 3.3 * 0.95
>   set in2_max 3.3 * 1.05
> 
> label in3 "+3.3V?" # 3.3V?
>   set in3_min 3.3 * 0.95
>   set in3_max 3.3 * 1.05

Yes, these are AVCC and +3.3V, no need for question marks. These are
hardwired in the chipset so they can't be wrong.

> 
> label in4 "+12V" # 12V

How did you figure out?

>   compute  in4  @ * (96/8), @ / (96/8)
>   set in4_min 12 * 0.95
>   set in4_max 12 * 1.05
> 
> ignore in5 # always 0.17V here
> ignore in6 # always 0.82V here
> 
> label in7 "3VSB?" # 3VSB?
>   set in7_min 3.3 * 0.95
>   set in7_max 3.3 * 1.05
> 
> label in8 "VBAT?" # VBAT?
>   set in8_min 3
>   set in8_max 3 * 1.2

Again, yes they are, no need for question marks.

Setting  in8_min to 3 V seems a bit optimistic, it's a 3 V battery so
it could easily go slightly below 3 V. 3 * 0.95 would seem more
reasonable. Likewise, in8_max doesn't need to be so high, worst case
the battery is backed by 3VSB which is 3.3 V +/- 5% according to the
ATX specification. So a max of 3.3 * 1.05 seems reasonable.

> 
> ignore in9
> ignore in10
> ignore in11
> ignore in12
> ignore in13
> ignore in14
> 
> label fan1 "CHA_FAN1"
>   ignore fan1	# not in use in _my_ configuration
>   set fan1_min 300
> 
> label fan2 "CPU fan"
>   set fan2_min 300
> 
> label fan3 "CHA_FAN2"
>   ignore fan3	# not in use in _my_ configuration
>   set fan3_min 300
> 
> label fan4 "CHA_FAN3"
>   set fan4_min 300

For the wiki, we don't put ignore statements for inputs which do exist
on the board (although I understand you put them in your local copy of
the file.)

> 
> ignore fan5	# does not exist on this MB
> 
> #label CPUTIN "CPU temperature"

I suppose you really mean temp2. But why is it commented out?

> 
> ignore temp1		# SYSTIN
> ignore temp3		# AUXTIN, gets smaller under load
> ignore temp4		# AUXTIN1
> ignore temp5		# AUXTIN2
> ignore temp6		# AUXTIN3
> ignore intrusion0

Is the intrusion detection feature not available on the board?

> ignore intrusion1
> ignore beep_enable
> ignore temp7		# PECI Agent 0 => value is the same as coretemp, phys ID0

That's not a reason to ignore it. Having more sources can be useful,
for example to setup automatic fan speed control, or to use the min/max
settings which the coretemp driver doesn't have.

> ignore temp8		# PCH_CHIP_CPU_MAX_TEMP
> ignore temp9		# PCH_CHIP_TEMP
> ignore temp10		# PCH_CPU_TEMP


-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
