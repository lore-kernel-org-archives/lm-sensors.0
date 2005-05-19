From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: Request for driver
Message-Id: <20040213215011.7baa6260.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4006AFFA.80500@mart.ck.ua>
In-Reply-To: <4006AFFA.80500@mart.ck.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> It works. But, I don't now what does that mean :)
> In bios I see:
> 
> System temp		32 C
> CPU temp		36 C
> SYS Fan			3245
> CPU Fan			3125
> PWR Fan			3300
> CPU VCore		1.52
> 	1.5V		1.5V
> 	3.3V		3.36V
> 	5.0V		5.29V
> Battery Voltage		3.37V
> 
> # sensors -s
> # sensors
> w83627hf-isa-0290
> Adapter: ISA adapter
> Algorithm: ISA algorithm
> VCore 1:   +2.70 V  (min =  +1.23 V, max =  +1.36 V)
> VCore 2:   +1.50 V  (min =  +1.23 V, max =  +1.36 V)
> +3.3V:     +3.38 V  (min =  +3.14 V, max =  +3.46 V)
> +5V:       +5.28 V  (min =  +4.74 V, max =  +5.24 V)       ALARM
> +12V:      +0.00 V  (min = +10.83 V, max = +13.19 V)
> -12V:     -14.60 V  (min = -13.16 V, max = -10.90 V)
> -5V:       -7.71 V  (min =  -5.26 V, max =  -4.76 V)
> V5SB:      +5.07 V  (min =  +4.74 V, max =  +5.24 V)
> VBat:      +3.38 V  (min =  +2.40 V, max =  +3.60 V)
> fan1:     3169 RPM  (min = 18243 RPM, div = 2)
> fan2:     3068 RPM  (min = 3515 RPM, div = 2)
> fan3:     3245 RPM  (min = 42187 RPM, div = 8)
> temp1:       +31?C  (high =   +10?C, hyst =   +16?C)   sensor > thermistor temp2:     +30.0?C  (high =  +120?C, hyst =  +115?C)  
> sensor = PII/Celeron diode
> temp3:     +22.0?C  (high =  +120?C, hyst =  +115?C)   sensor > thermistor vid:      +1.300 V
> alarms:
> beep_enable:
>            Sound alarm disabled
> 
> I suppose that fans 1,2,3 are equivalent to SYS, CPU, PWR fans.

Correct, although I would not take a guess on the exact matching. Since
all fans have almost the same speed, it doesn't matter much anyway.

> But how to interpret other numbers?

Well, it's easy. VCore2 is your BIOS' 1.5V (probably AGP), +3.3V and +5V
match their likes in the BIOS, VBat is the battery voltage. temp2 must
by CPU Temp, temp1 is System Temp.

The only strange thing is that VCore1 doesn't match CPU VCore in the
BIOS. I can't say why.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
