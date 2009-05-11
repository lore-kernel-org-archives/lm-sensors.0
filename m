From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 11 May 2009 11:17:22 +0000
Subject: Re: [lm-sensors] Specific configurations - Gigabyte mainboard
Message-Id: <20090511131722.3d1a761e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200905091227.09847.hka@qbs.com.pl>
In-Reply-To: <200905091227.09847.hka@qbs.com.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hubert,

On Sat, 9 May 2009 12:27:09 +0200, Hubert Kario wrote:
> Hello everybody!
> I've created a mainboard specific configuration for Gigabyte EP45-DS3P:
> 
> == snip => chip "it87-*" "it8712-*" "it8716-*" "it8718-*" "it8720-*"

Which actual IT87xxF chip does the EP45-DS3P have?

> 
>         label in0 "Vcore"
>         label in1 "Vram"
>         label in2 "+3.3V"
> 
>         label in3 "+5V"
> 	# Standard resistor
>         compute in3 @ * ( 6.8/10+1), @ / (6.8/10+1)
> 
>         ignore in4
> 
>         label in5 "+12V"
> 	# that's a bit weird, as the value (29.6) is close to typical resistor,
> 	# but it does give proper results (in line with what a multimeter
> 	# and BIOS show)

Could be that the 10 isn't correct. Not that it really matters
though... what matters is that the scaling factor is correct.

>         compute in5 @ * (29.6/10+1), @ / (29.6/10+1)
> 
>         ignore in6
> 
> 	# not sure about this one
>         label in7 "5VSB"
>         compute in7 @ * (6.8/10+1), @ / (6.8/10+1)
> 
>         label in8 "Vbat"
> 
> 	# labels are after the ones printed on the mainboard
>         label fan1 "CPU_FAN"
>         label fan2 "SYS_FAN2"
>         label fan3 "PWR_FAN"
>         label fan4 "SYS_FAN1"

These labels are ugly. What about:

        label fan1 "CPU Fan"
        label fan2 "Sys Fan 2"
        label fan3 "Power Fan"
        label fan4 "Sys Fan 2"


> 
>         label temp1 "Sys Temp"
>         label temp2 "Tcase Temp"

Why "Tcase" and not just "Case"?

>         ignore temp3
> == snip =
Yes it does, thanks for your contribution!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
