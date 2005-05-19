From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: Questions
Message-Id: <41CC3A02.8070004@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021028183912.5520a527.khali@linux-fr.org>
In-Reply-To: <20021028183912.5520a527.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

since your chip is an lm85 you must have a chip section headed with
chip "lm85-*"


Paul Aviles wrote:
> Jean,
> 
> Happy holidays to you all and best wishes for the new year!!
> 
> 
> 
> Quick question, I have sensors 2.8.8  running on a Tyan GS12 server with 
> FC1 and kernel 2.4.22-1.2174.nptl and I got everything working.
> 
> 
> 
> I am curious about a problem. Take a look at my results of sensors. I 
> have an alarm on in4 and also shows fan4 which I don't have. My 
> sensors.conf is also below and it is supposed to ignore in4 and fan4. Is 
> there any other way to eliminate those from being reported?
> 
> 
> 
> Thanks so much.
> 
> 
> 
> Paul
> 
> 
> #sensors
> 
> lm85-i2c-0-2e
> Adapter: SMBus I801 adapter at 1480
> in0:        +2.62 V  (min =  +0.00 V, max =  +3.32 V)
> in1:        +1.31 V  (min =  +0.00 V, max =  +2.99 V)
> in2:        +3.37 V  (min =  +0.00 V, max =  +4.38 V)
> in3:       +5.13 V  (min =  +0.00 V, max =  +6.64 V)
> in4:       +0.00 V  (min =  +0.00 V, max = +15.94 V)   ALARM
> fan1:      9294 RPM  (min =    0 RPM)
> fan2:      8169 RPM  (min =    0 RPM)
> fan3:      9712 RPM  (min =    0 RPM)
> fan4:         0 RPM  (min =    0 RPM)
> temp1:       +61?C  (low  =  -127?C, high =  +127?C)
> temp2:       +41?C  (low  =  -127?C, high =  +127?C)
> temp3:       +43?C  (low  =  -127?C, high =  +127?C)
> pwm1:       86
> pwm2:      113
> pwm3:       88
> vid:      +1.325 V  (VRM Version 9.1)
> 
> /etc/sensors.conf
> chip "adt7463-*"
> 
>    ignore pwm1
>    ignore pwm2
>    ignore pwm3
>    ignore in4
>    ignore fan4
> 
>    label in0 "+2.6V"
>    label in1 "CPU Volt"
>    label in2 "+3.3V"
>    label in3 "+5V"
> 
>    label fan1 "fan2"
>    label fan2 "fan1"
>    label fan3 "fan3"
> 
>    label pwm1 "pwm1 fan"
>    label pwm2 "pwm2 fan"
>    label pwm3 "pwm3 fan"
> 
>    label temp1 "CPU Temp"
>    label temp2 "Local Temp"
>    label temp3 "System Temp"
> 
>    set in0_min  2.6 * 0.95
>    set in0_max  2.6 * 1.05
>    set in1_min  1.45 * 0.95
>    set in1_max  1.45 * 1.05
>    set in2_min  3.3 * 0.95
>    set in2_max  3.3 * 1.05
>    set in3_min  5.0 * 0.95
>    set in3_max  5.0 * 1.05
> 
>    set vrm  9.1[
> 
> 
