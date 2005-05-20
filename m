From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 20 May 2005 18:56:55 +0000
Subject: [lm-sensors] No temperature/fan values with 83627THF chip
Message-Id: <428E16A8.60202@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.56.0505201624000.1858@io.tertial.org>
In-Reply-To: <Pine.LNX.4.56.0505201624000.1858@io.tertial.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

The page says it support IPMI. Unfortunately I do not know much about IPMI too.
Basicaly it is some platform for idependent management including sensors.
Maybe you should take a look to openipmi.sf.net Also to i2c-ipmi and bmcsensors.
(they are part of lm_sensors package if I recall corectly)
I think they are currently ported to 2.6. So I suggest to try 2.4 kernel version first.

I hope others on the list will add missing info :)

As for the rest:

> 'sensors' gives this output:
> w83627thf-isa-0290
> Adapter: ISA adapter
> VCore:     +1.94 V  (min =  +1.94 V, max =  +1.94 V)       ALARM  (beep)
> +12V:     +15.50 V  (min = +15.50 V, max = +15.50 V)       ALARM  (beep)
> +3.3V:     +4.08 V  (min =  +4.08 V, max =  +4.08 V)       ALARM  (beep)
> +5V:       +6.80 V  (min =  +6.80 V, max =  +6.80 V)       ALARM  (beep)
> -12V:     -14.91 V  (min = -10.80 V, max = -13.18 V)       ALARM  (beep)
> V5SB:      +6.85 V  (min =  +6.85 V, max =  +6.85 V)       ALARM  (beep)
> VBat:      +4.08 V  (min =  +4.08 V, max =  +4.08 V)       ALARM  (beep)

Voltage conversion formulas are known by manufacturer only. Or they may be even left floating.

> fan1:        0 RPM  (min =    0 RPM, div = 128)              ALARM  (beep)
> CPU Fan:     0 RPM  (min =    0 RPM, div = 128)              ALARM  (beep)
> fan3:        0 RPM  (min =    0 RPM, div = 128)              ALARM  (beep)

Try setting fan divisor to 2 or 4 or 8. But it is more likely not connected.

Put similar lines to correct part of sensors.conf
set fan1_div 2

dont forget to run sensors -s to "apply" changes.

> M/B Temp:     -1 C  (high =    -1 C, hyst =    -1 C)   sensor = diode   
> ALARM   (beep)
> CPU Temp:   +0.0 C  (high =    +0 C, hyst =    +0 C)   sensor = diode   
> ALARM   (beep)

Again if there is smth connected it is not connected in "recomended" way so again we do not know the formulas.

> vid:      +0.275 V  (VRM Version 9.0)
Hmm this is strange. Anyone some ideas?

Recomended steps:
Try above and pay attention to IPMI.

I hope this helps a bit.

Regards

Rudolf
