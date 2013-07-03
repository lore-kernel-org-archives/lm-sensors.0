From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 03 Jul 2013 14:42:01 +0000
Subject: Re: [lm-sensors] 3.10: NCT6776F sensor question with Supermicro X9SRL-F motherboard
Message-Id: <20130703144201.GA10323@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <002901ce77e9$dfac4f20$9f04ed60$@lucidpixels.com>
In-Reply-To: <002901ce77e9$dfac4f20$9f04ed60$@lucidpixels.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Wed, Jul 03, 2013 at 08:35:59AM -0400, Justin Piszcz wrote:
> Hello,
> 
> Currently running 3.10 with:
> CONFIG_SENSORS_NCT6775=y
> 
> Motherboard: Supermicro X9SRL-F
> 
> A couple questions:
> 1) Was curious if the PCH CHIP/CPU/MCH temperatures should be populated for
> this board? 

No, but the driver doesn't know, so you'll have to create an ignore entry in
sensors3.conf.

> 2) Additionally, why is the CPUTIN in alarm?
> 
Because of a bug in the driver. Should get fixed with 3.10.1 or 3.10.2.

> I also found:
> http://www.lm-sensors.org/wiki/Configurations/SuperMicro/X9SRA
> 
> Does Super Micro also have such a config file for the X9SRL-F?
> This board uses a NCT6776F.
> 
Supermicro does not provide configuration files. You can take the above file,
test and update it, and let us know so we can add it to the wiki.

> Relevant output from lm_sensors 3.6.0+dfsg1-1:
> 
> nct6776-isa-0a30
> Adapter: ISA adapter
> Vcore:          +0.81 V  (min =  +0.54 V, max =  +1.49 V)
> in1:            +1.85 V  (min =  +1.62 V, max =  +1.99 V)
> AVCC:           +3.30 V  (min =  +2.98 V, max =  +3.63 V)
> +3.3V:          +3.30 V  (min =  +2.98 V, max =  +3.63 V)
> in4:            +1.51 V  (min =  +1.35 V, max =  +1.65 V)
> in5:            +1.27 V  (min =  +1.13 V, max =  +1.38 V)
> in6:            +1.06 V  (min =  +0.92 V, max =  +1.34 V)
> 3VSB:           +3.57 V  (min =  +2.98 V, max =  +3.63 V)
> Vbat:           +3.49 V  (min =  +2.70 V, max =  +3.63 V)
> fan1:           986 RPM  (min =  700 RPM)
> fan2:          1322 RPM  (min =  700 RPM)
> fan3:          1103 RPM  (min =  700 RPM)
> fan4:          1080 RPM  (min =  700 RPM)
> fan5:          1001 RPM  (min =  700 RPM)
> SYSTIN:         +42.0 C  (high = +75.0 C, hyst = +70.0 C)  sensor > thermistor
> CPUTIN:         +33.0 C  (high = +95.0 C, hyst = +92.0 C)  ALARM  sensor > thermistor
> AUXTIN:         +23.0 C  (high = +80.0 C, hyst = +75.0 C)  sensor > thermistor
> PECI Agent 0:    +0.0 C  (high = +95.0 C, hyst = +92.0 C)
>                          (crit = +100.0 C)

This is surprising and might be where the alarm comes from. What output do you
get if you load the coretemp driver ? 

> PCH_CHIP_TEMP:   +0.0 C  
> PCH_CPU_TEMP:    +0.0 C  
> PCH_MCH_TEMP:    +0.0 C  
> intrusion0:    ALARM
> intrusion1:    ALARM

Are those not connected ?

> 
> sensors3.conf snippet:
> 
> chip "w83627ehf-*" "w83627dhg-*" "w83667hg-*" "nct6775-*" "nct6776-*"
> 
>     label in0 "Vcore"
>     label in2 "AVCC"
>     label in3 "+3.3V"
>     label in7 "3VSB"
>     label in8 "Vbat"
> 
>     set in2_min  3.3 * 0.90
>     set in2_max  3.3 * 1.10
>     set in3_min  3.3 * 0.90
>     set in3_max  3.3 * 1.10
>     set in7_min  3.3 * 0.90
>     set in7_max  3.3 * 1.10
>     set in8_min  3.0 * 0.90
>     set in8_max  3.3 * 1.10
> 
Supermicro tends to set the limits in the BIOS, so you should not have to do
that.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
