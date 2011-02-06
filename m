From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 06 Feb 2011 15:53:55 +0000
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <20110206165355.3329ac80@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205175852.GA26672@ericsson.com>
In-Reply-To: <20110205175852.GA26672@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Sun, 6 Feb 2011 14:37:48 +0100, Ian Dobson wrote:
> OK Here's the infomation
> nct6776-isa-0290
> Adapter: ISA adapter
> Vcore:       +1.18 V  (min =  +0.00 V, max =  +1.74 V)
> in1:         +1.02 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> AVCC:        +3.36 V  (min =  +2.98 V, max =  +3.63 V)
> +3.3V:       +3.34 V  (min =  +2.98 V, max =  +3.63 V)
> in4:         +1.03 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> in5:         +2.04 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> in6:         +0.78 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> 3VSB:        +3.42 V  (min =  +2.98 V, max =  +3.63 V)
> Vbat:        +3.30 V  (min =  +2.70 V, max =  +3.30 V)   ALARM
> fan1:        550 RPM  (min =    0 RPM)  ALARM
> fan2:       1013 RPM  (min =    0 RPM)  ALARM
> fan3:          0 RPM  (min =    0 RPM)  ALARM
> fan4:        824 RPM  (min =    0 RPM)  ALARM
> fan5:          0 RPM  (min =    0 RPM)  ALARM
> temp1:       +24.0°C  (high =  +0.0°C, hyst =  +0.0°C)  ALARM  sensor = 
> thermistor
> temp2:       -60.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = diode
> temp3:       +38.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = 
> thermistor
> cpu0_vid:   +2.050 V
> 
> and BIOS
> CPU temp 43
> MB temp 25
> 
> CPU Volt 1.114-1.1176
> 3.3Volt     3.36 - 3.34
> 5Volt     5.160
> 12Volt  12.288
> 
> So it looks as if in4 * 5 is 5Volt, in5 * 6 is 12volt. This is on a asus 
> p8p67 pro, but I've seen the same values on a asus p8p67 delux.

in4 * 5 = 5V is possible, in5 * 6 = 12V is not. 2.04 is the saturation
value for the ADC so it looks like in5 isn't used on your system. I'd
rather think that in1 * 12 = 12V.

> Looking in the n6776f specification if looks as if AUXTIN(temp3) and in6 
> share the same pin (pin 109) so we can't have both enabled.

This was the case on the W83667HG already, so I'm not surprised, and it
should be very easy to implement in the driver.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
