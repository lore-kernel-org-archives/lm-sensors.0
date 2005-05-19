From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: help?
Message-Id: <20030227101236.77243cc6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0302252341500.5703-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0302252341500.5703-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I have installed lm_sensors on a dual Athlon MP2200+ Tyan motherboard.
> A Winbond chip is detected and this is the evidently wrong output of 
> sensors:
> 
> w83627hf-i2c-0-2c
> Adapter: SMBus AMD7X6 adapter at 80e0
> Algorithm: Non-I2C SMBus adapter
> VCore 1:   +1.66 V  (min =  +1.48 V, max =  +1.80 V)              
> VCore 2:   +1.66 V  (min =  +1.48 V, max =  +1.80 V)              
> +3.3V:     +3.29 V  (min =  +2.97 V, max =  +3.63 V)              
> +5V:       +4.89 V  (min =  +4.50 V, max =  +5.48 V)              
> +12V:      +9.42 V  (min = +10.79 V, max = +13.11 V)              
> -12V:     -12.29 V  (min = -13.21 V, max = -10.90 V)              
> -5V:       +0.01 V  (min =  -5.51 V, max =  -4.51 V)              
> V5SB:      +5.38 V  (min =  +4.50 V, max =  +5.48 V)              
> VBat:      +3.28 V  (min =  +2.70 V, max =  +3.29 V)              
> fan1:     2721 RPM  (min = 3000 RPM, div = 2)                     
> fan2:     2848 RPM  (min = 3000 RPM, div = 2)                     
> fan3:        0 RPM  (min = 1500 RPM, div = 4)                     
> temp1:       +67?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 
> PII/Celeron diode           
> temp2:      +1.5?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 
> PII/Celeron diode           
> temp3:      +3.5?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 
> PII/Celeron diode           
> vid:       +1.65 V
> alarms:   Chassis intrusion detection                      ALARM
> beep_enable:
>           Sound alarm disabled

Well, it's not that wrong. The incorrect values may just mean you don't
have the sensor and you have to ignore the value. Having a look "in the
BIOS" sometimes show which sensors your motherboard is supposed to have.

> What should I do? Perhaps changing from "PII/Celeron diode" according
> to the suggestion in /usr/share/doc/lm_sensors-2.6.3/doc/chips/w83781d
> 
>         sensor[1-3]: (782d/783s only)
>           Controls the sensor type. To change to a different
>           sensor type, for example, do 'echo 2 > sensor1'.
>           Valid values:
>                1: Pentium II / Celeron diode
>                2: 2N3904 Transistor in a diode configuration
>             3435: Thermistor with Beta = 3435. Beta is a measure
>                   of sensitivity to temperature.
> 
> But I haven't quite understood how.

You have to edit /etc/sensors.conf. Look for "w83627hf" and you should
find where to change it a few dozen lines below. However, it is supposed
to work with 782d/783s only. You still can give it a try, though.

If it doesn't work, you may just want to suppress the output for values
that don't make a sense for you. To do this, you'll have to add "ignore"
lines in /etc/sensors.conf. For exemple, "ignore temp3" will remove the
"temp3" line. Just make sure you add the line in the right section of
the config file, or it won't work.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
