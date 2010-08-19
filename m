From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Aug 2010 16:27:59 +0000
Subject: Re: [lm-sensors] Config file for Gigabyte MA785GM-US2H
Message-Id: <20100819182759.51f20d5f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1281670026.2676.3.camel@honcho>
In-Reply-To: <1281670026.2676.3.camel@honcho>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Glen,

On Thu, 12 Aug 2010 20:27:06 -0700, Glen wrote:
> Here's a config file I worked up for the Gigabyte MA758GM-US2H.  It's
> based off of one taken from your web site. This is NOT confirmed by
> examination of the MB, just by observed readings.

Out of curiosity, which configuration file did you start from?

> # lm_sensors configuration file for the Gigabyte MA785GM-US2H motherboard
> # 8-12-2010 G. Journeay <journeay@gmail.com>

Please follow ISO-8601 for dates, otherwise it's ambiguous. I read the
above as December 8th, withe you certainly meant August 12th.

> ### Voltages
> 
>    label  in0  "Vcore"
>    label  in1  "Vram"    # "DDR2" in BIOS
>    label  in2  "+3.3V"
>    label  in3  "+5V"     # Not in BIOS
>    ignore in4
>    ignore in5
>    ignore in6
>    label  in7  "+12V"
>    label  in8  "Vbat"    # Not in BIOS
> 
>    # Vcore, Vram, +3.3V and Vbat are connected directly, so no compute
>    # line is needed for these. For +5V the chip is configured to use
>    # internal scaling. For +12V the default resistors seem to have been
>    # used.
>    compute  in0  @ * (  3/10+1), @ / (  3/10+1)

This is inconsistent. You just said that Vcore didn't need any scaling,
yet you have a compute statement for Vcore. In all honestly, I would be
very surprised if it were correct... Vcore is never scaled, it doesn't
need to (it's way below the +4.08V limit.) How did you come up with it?

>    compute  in3  @ * (6.8/10+1), @ / (6.8/10+1)
>    compute  in7  @ * ( 45/10+1), @ / ( 45/10+1)

> ### Temperatures
> 
>    label  temp1  "CPU Temp"
>    label  temp3  "NBr Temp"
>    label  temp2  "MB Temp"

Would be more intuitive to leave them in order.

>    set temp1_min 0
>    set temp1_max 60
>    set temp2_min 0
>    set temp3_max 50
>    set temp3_min 0
>    set temp3_max 50

You're setting temp3_max twice, and you're never setting temp2_max.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
