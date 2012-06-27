From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 27 Jun 2012 19:40:44 +0000
Subject: Re: [lm-sensors] Reducing fan speed for w83627ehf
Message-Id: <20120627194044.GA12949@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAP3RjSfZQevwuBONgEbA0XaE_aiUik6sDdYY6ZJA+bWmZW1MQw@mail.gmail.com>
In-Reply-To: <CAP3RjSfZQevwuBONgEbA0XaE_aiUik6sDdYY6ZJA+bWmZW1MQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 27, 2012 at 02:28:34PM -0400, Arun Raghavan wrote:
> Hi,
> 
> I need to get fairly fine grain control on my CPU fan speed for some
> experiments, but I am currently unable to set the fan speed below 1054 RPM.
> pwmconfig confirms the same across the divisor range. Processor is i7-2600,
> motherboard
> 
> I tried setting pwm2_enable to 1 and pwm2 to 1 manually and I see that the
> fan speed varies but the min RPM remains 1054.  Info below.
> 
What happens if you write 0 into pwmX ? Also, did you select manual fan speed
control ?

Thanks,
Guenter

> Any pointers on whether it is possible to reduce fan speed further, and if
> so how would be very helpful.
> 
> thanks,
> -arun
> 
> root@sandy:/sys/devices/platform/w83627ehf.656# echo 255 > pwm2
> root@sandy:/sys/devices/platform/w83627ehf.656# sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Physical id 0:  +46.0°C  (high = +78.0°C, crit = +98.0°C)  ALARM (CRIT)
> Core 0:         +46.0°C  (high = +78.0°C, crit = +98.0°C)  ALARM (CRIT)
> 
> nct6775-isa-0290
> Adapter: ISA adapter
> Vcore:         +0.82 V  (min =  +0.00 V, max =  +1.74 V)
> in1:           +1.12 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> AVCC:          +3.46 V  (min =  +2.98 V, max =  +3.63 V)
> +3.3V:         +3.46 V  (min =  +2.98 V, max =  +3.63 V)
> in4:           +1.06 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in5:           +1.05 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in6:           +1.08 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> 3VSB:          +3.41 V  (min =  +2.98 V, max =  +3.63 V)
> Vbat:          +3.34 V  (min =  +2.70 V, max =  +3.30 V)  ALARM
> fan1:            0 RPM  (min =    0 RPM, div = 128)
> fan2:         2109 RPM  (min =    0 RPM, div = 128)  ALARM <----
> fan3:            0 RPM  (min =    0 RPM, div = 128)
> fan4:            0 RPM  (div = 128)
> SYSTIN:        +31.0°C  (high =  +0.0°C, hyst =  +0.0°C)  ALARM  sensor
> = CPU diode
> CPUTIN:        +29.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = CPU
> diode
> AUXTIN:        +22.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor =
> thermistor
> PECI Agent 0:  +45.5°C
> cpu0_vid:     +2.050 V
> intrusion0:   OK
> 
> root@sandy:/sys/devices/platform/w83627ehf.656# echo 1 > pwm2
> root@sandy:/sys/devices/platform/w83627ehf.656# sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Physical id 0:  +46.0°C  (high = +78.0°C, crit = +98.0°C)  ALARM (CRIT)
> Core 0:         +46.0°C  (high = +78.0°C, crit = +98.0°C)  ALARM (CRIT)
> 
> nct6775-isa-0290
> Adapter: ISA adapter
> Vcore:         +0.85 V  (min =  +0.00 V, max =  +1.74 V)
> in1:           +1.12 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> AVCC:          +3.46 V  (min =  +2.98 V, max =  +3.63 V)
> +3.3V:         +3.46 V  (min =  +2.98 V, max =  +3.63 V)
> in4:           +1.06 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in5:           +1.05 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in6:           +1.08 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> 3VSB:          +3.41 V  (min =  +2.98 V, max =  +3.63 V)
> Vbat:          +3.34 V  (min =  +2.70 V, max =  +3.30 V)  ALARM
> fan1:            0 RPM  (min =    0 RPM, div = 128)
> fan2:         1054 RPM  (min =    0 RPM, div = 128)  ALARM
> fan3:            0 RPM  (min =    0 RPM, div = 128)
> fan4:            0 RPM  (div = 128)
> SYSTIN:        +30.0°C  (high =  +0.0°C, hyst =  +0.0°C)  ALARM  sensor
> = CPU diode
> CPUTIN:        +29.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = CPU
> diode
> AUXTIN:        +22.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor =
> thermistor
> PECI Agent 0:  +44.5°C
> cpu0_vid:     +2.050 V
> intrusion0:   OK

> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
