From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 20 Sep 2006 20:05:18 +0000
Subject: [lm-sensors] Asus P5B
Message-Id: <20060920220518.785d1ab2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <b62408800609201018k102f2869wa8f97d0c83021fc8@mail.gmail.com>
In-Reply-To: <b62408800609201018k102f2869wa8f97d0c83021fc8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Please reply to the list rather than to me only.

> I have a feeling output is way out ... atm
> 
> lm78-isa-0290
> Adapter: ISA adapter
> VCore 1:   +2.59 V  (min =  +0.00 V, max =  +3.49 V)
> VCore 2:   +3.65 V  (min =  +2.30 V, max =  +0.03 V)
> +3.3V:     +3.31 V  (min =  +0.00 V, max =  +1.34 V)
> +5V:       +5.54 V  (min =  +0.48 V, max =  +0.22 V)
> +12V:     +10.03 V  (min =  +2.19 V, max =  +0.49 V)
> -12V:     -11.01 V  (min =  -0.45 V, max = -10.35 V)
> -5V:       -3.88 V  (min =  -0.12 V, max =  -1.25 V)
> fan1:        0 RPM  (min = 5273 RPM, div = 2)
> fan2:        0 RPM  (min = 168750 RPM, div = 4)
> fan3:        0 RPM  (min = 10546 RPM, div = 2)
> temp:      +36.0?C  (high =    +1?C, hyst =  -120?C)
> vid:       +3.00 V

Ah, this is a misdetection. You don't have an LM78 chip. So the output
above is crap. You must unload the lm78 driver, and use the w83627ehf
driver instead - once David is done with adding support for your chip.

-- 
Jean Delvare

