From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: A7V8X-X and lm sensors
Message-Id: <20030918202326.18bb93ba.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030918153623.GA3679@pvv.org>
In-Reply-To: <20030918153623.GA3679@pvv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I have a A7V8X-X motherboard and I'm running kernel 2.4.21. I
> downloaded and tried the lm sensors 2.8.0.
> 
> I get the same wrong results as I saw somebody had reported already.
> However I played a bit with the temp_type setting of it87. 
> 
> I'm ignoring Temp3:

Yes, you have to.

> If it do:
> modprobe it87 temp_type=0x1c
> or
> modprobe it87 temp_type=0x38

(which is the same once temp3 is ignored)

> I get:
>    it87-isa-0290
>    Adapter: ISA adapter
>    Algorithm: ISA algorithm
>    VCore 1:   +1.68 V  (min =  +1.53 V, max =  +1.87 V)   
>    VCore 2:   +0.00 V  (min =  +2.25 V, max =  +2.75 V)   ALARM

I believe you should ignore VCore 2 (i.e. in1).

>    +3.3V:     +6.58 V  (min =  +2.96 V, max =  +3.60 V)   ALARM

This is a FAQ, there's a line to comment out in /etc/sensors.conf.

>    +5V:       +4.77 V  (min =  +4.50 V, max =  +5.48 V)   
>    +12V:     +12.32 V  (min = +11.36 V, max = +13.80 V)   
>    -12V:     -27.36 V  (min = -15.86 V, max = -13.40 V)   ALARM
>    -5V:      -13.64 V  (min = -10.13 V, max =  -9.44 V)   ALARM

We have an alternate formula in /etc/sensors.conf for in5 and in6, you
could give them a try.

>    Stdby:     +4.99 V  (min =  +4.50 V, max =  +5.48 V)   
>    VBat:      +4.08 V
>    fan1:     2800 RPM  (min = 3000 RPM, div = 2)          ALARM
>    fan2:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
>    fan3:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
>    Temp1/MB:    +49?C  (min =  +20?C, max =  +60?C) 
>    Temp2/CPU:   +30?C  (min =  +20?C, max =  +60?C) 
>    Temp3:      +127?C  (min =  +20?C, max =  +60?C) 
> 
> BIOS reports that my MB temperature is about 30C and that the CPU is
> about 59C. So here is actually looks like Temp1 and Temp2 should be
> swapped. I don't know if this makes sense though.

It does, and it is known to be true for the A7V8X-X. Motherboard
manufacturers are free to link whichever sensor input to whatever they
want (although we consider it a Bad Practice (TM)).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
