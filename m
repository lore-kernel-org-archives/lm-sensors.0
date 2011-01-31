From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 31 Jan 2011 08:07:37 +0000
Subject: Re: [lm-sensors] W83795AG on SuperMicro 7046T-NTR+ board
Message-Id: <20110131090737.300862a3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D44621B.40506@earthlink.net>
In-Reply-To: <4D44621B.40506@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 30 Jan 2011 13:13:24 -0800, David Anderson wrote:
> Here is a configure file that worked (to go with the new
> kernel module).  It may not be perfect.  inserted it as
> /etc/sensors.d/w83795ag.conf
> 
> chip "w83795-*"

This can't work, as the chip will be named w83795adg-* or w83795g-* by
libsensors.

> 
>     label fan1 "Fan1"
>     label fan2 "Fan2"
>     label fan3 "Fan3"
>     label fan4 "Fan4"
>     label fan5 "Fan5"
>     label fan6 "Fan6"
>     label fan7 "fanignore"
>     label fan8 "Fan8"
> 
>     label in0  "vCPU2"
>     label in1  "vCPU1"
>     label in3  "+5V"
>     label in4  "+12V"
>     label in5  "5vSB"
>     label in6  "vcpu2dimm"
>     label in7  "vcpu1dimm"
>     label in11 "VTT"
>     label in12 "+3.3V"
>     label in13 "+3.3Vsb"
>     label in14 "Vbatt"
> 
> 
>     label temp5 "System temp"
>     label temp7 "CPU1 temp"
>     label temp8 "CPU2 temp"
> 
>     compute in3 @*(40/10), @/(40/10)
>     compute in4 @*(10/66.2), @/(10/66.2)

This is extremely unlikely. Scaling factors are never less than 1.0.

>     compute in5 @*(40/10), @/(40/10)
> 
> 
> 
> 
> chip "w83627hf-*"
> 
> # SuperIO chip used only for the FDC, UARTs and GPIO
> # SENSORS ARE NOT WIRED
> # Power Supply Failure, GP31(From W83627DHG-P)    1 = Good, 0 = Bad

There is some inconsistency here. A W83627DHG-P chip would be named
w83627dhg-* by libsensors, not w83627hf-*.

> 
> ignore fan1
> ignore fan2
> ignore fan3
> ignore fan4
> ignore fan5
> ignore temp1
> ignore temp2
> ignore temp3
> ignore in0
> ignore in1
> ignore in2
> ignore in3
> ignore in4
> ignore in5
> ignore in6
> ignore in7
> ignore in8
> ignore cpu0_vid

It's more efficient to just not load the w83627hf (or w83627ehf) driver
on this board.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
