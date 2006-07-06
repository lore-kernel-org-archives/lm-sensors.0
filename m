From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 06 Jul 2006 18:33:53 +0000
Subject: [lm-sensors] Winbond W83627HF - deactivated
Message-Id: <44AD5791.10501@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <44AD4B8C.1010002@sh.cvut.cz>
In-Reply-To: <44AD4B8C.1010002@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Albert,

> It seems that I was too hasty in replying. I ran sensors-detect again
> and it did detect the chip.

Good.

> # sensors
> w83627hf-isa-0290
> Adapter: ISA adapter
> VCore 1:   +0.90 V  (min =  +0.00 V, max =  +0.00 V)       ALARM
> VCore 2:   +1.52 V  (min =  +0.00 V, max =  +0.00 V)       ALARM
> +3.3V:     +3.30 V  (min =  +3.14 V, max =  +3.47 V)
> +5V:       +4.95 V  (min =  +4.76 V, max =  +5.24 V)
> +12V:     +11.92 V  (min = +10.82 V, max = +13.19 V)       ALARM
> -12V:      -2.16 V  (min = -13.18 V, max = -10.80 V)
> -5V:       -3.49 V  (min =  -5.25 V, max =  -4.75 V)       ALARM
> V5SB:      +5.03 V  (min =  +4.76 V, max =  +5.24 V)       ALARM
> VBat:      +2.05 V  (min =  +2.40 V, max =  +3.60 V)
> fan1:        0 RPM  (min = 225000 RPM, div = 2)
> fan2:        0 RPM  (min = 7417 RPM, div = 2)
> fan3:        0 RPM  (min = 675000 RPM, div = 2)
> temp1:       +47??C  (high =   +73??C, hyst =   -28??C)   sensor = thermistor
> temp2:     +73.0??C  (high =   +80??C, hyst =   +75??C)   sensor = thermistor
> temp3:     -46.0??C  (high =   +80??C, hyst =   +75??C)   sensor = thermistor
> vid:      +0.000 V  (VRM Version 8.2)
> alarms:   Chassis intrusion detection                      ALARM
> beep_enable:
>           Sound alarm disabled

> Now to set up the alarms...

Vcore1 is wrong. There might be some scaling resistors, only the company knows
which. You should ask them what resitors were used for scaling -> what scaling
factor each input has.

(you may edit /etc/sensors.conf)  check the files for hints.

You may use "ignore" statements to ignore selected voltages. (or check some
voltage formulas there, if you need more help with this you will need to know
what are the scaleling factors anyway)

As for the FANs maybe they are unconnected, maybe they need to change the divisor.

Put in correct configuration section of /etc/sensors.conf this:

set fan1_div 8
set fan2_div 8
set fan3_div 8

Save it, run sensors -s
to "apply" the changes.

Then run sensors again to see if FAN is non-zero

As for the temps. The manual says there are two temps, thermistor sensors. Temp1
and Temp2 seems that are connected. You may change the limits in
/etc/sensors.conf (hysteresis limit and max limit)

> Thanks for your help. It is much appreciated.

You welcome.

I hope it helps.
Regards
Rudolf

