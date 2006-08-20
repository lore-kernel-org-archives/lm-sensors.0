From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 20 Aug 2006 11:21:10 +0000
Subject: [lm-sensors] voltage reading too low: what next?
Message-Id: <44E845A6.2090204@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi James,

> <quote>
> w83627thf-isa-0290
> Adapter: ISA adapter
> VCore:     +1.02 V  (min =  +0.94 V, max =  +0.96 V)
> +12V:      +4.13 V  (min = +10.82 V, max = +13.19 V)
> +3.3V:     +1.92 V  (min =  +3.14 V, max =  +3.47 V)

Well how the inputs are connected knows only the MSI. They may have used
different scaling factors. This is the reason why you see this value.

> +5V:       +5.04 V  (min =  +4.75 V, max =  +5.25 V)
> -12V:     -14.91 V  (min = -10.80 V, max = -13.18 V)
> V5SB:      +5.08 V  (min =  +4.76 V, max =  +5.24 V)
> VBat:      +2.93 V  (min =  +2.40 V, max =  +3.60 V)
> fan1:     5578 RPM  (min = 9375 RPM, div = 2)
> CPU Fan:  5769 RPM  (min =   -1 RPM, div = 2)
> fan3:        0 RPM  (min = 112500 RPM, div = 2)
> M/B Temp:    +47 C  (high =    +5 C, hyst =    +0 C)   sensor = thermistor
> CPU Temp:  +42.0 C  (high =   +80 C, hyst =   +75 C)   sensor = thermistor
> temp3:     +39.0 C  (high =   +80 C, hyst =   +75 C)   sensor = thermistor
> vid:      +0.275 V  (VRM Version 9.0)

All in all if you want to know what MSI did please ask them what scaling
resistors they used for the ADC voltage inputs of w83627thf chip on this
motherboard.

The CPU has not 42C (even if it is nice value and the ultimate answer) because
it is the temperature under the CPU rather inside. I implemented a driver that
reads the CPU temp from the CPU. Hopefully it will be in 2.6.19. You may find it
here:
http://assembler.cz/download/amd_digital_temp.tar.gz

I hope it helps,
Regards
Rudolf

