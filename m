From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: Linux Sensor configuration for Tyan S2462UNG, Thunder K7, dual
Message-Id: <3C5898EA.36EB8658@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020128112245.4AC9B17353@corel-linux.shaker-net.com>
In-Reply-To: <20020128112245.4AC9B17353@corel-linux.shaker-net.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

sorry, can't help much.
The chip only supports 3 fans.
For fan/CPU correlation stop the fans 1 by 1 and watch temperatures.
For CPU/temp correlation use 'cpuburn' (link on our links page).
You can try different sensor types for the temps (see doc/chips/w83781d)

Christopher John Shaker wrote:
> 
> I'm wondering if any of you have already configured /etc/sensors.conf for a
> Tyan S2462UNG Thunder K7, dual Athlon SMP board yet? I'm running
> a 2.4.16 SuSE built kernel under SuSE Linux 7.3 Professional.
> 
> The temperatures read very high compared to those reported by the BIOS
> (85C instead of 61C), and I've got no idea about the fan name and voltage
> name correllation. The bios reports four fan speeds, but the w83782d
> supposedly can only report three fan speeds?
> 
> What I've done so far is:
> 
>         modprobe i2c-amd756
>         modprobe w83781d
> 
> root@corel-linux: ll -R /proc/sys/dev/sensors/w83782d-i2c-0-2d
> /proc/sys/dev/sensors/w83782d-i2c-0-2d:
> total 0
> dr-xr-xr-x    2 root     root            0 Jan 28 03:12 .
> dr-xr-xr-x    3 root     root            0 Jan 28 03:12 ..
> -r--r--r--    1 root     root            0 Jan 28 03:12 alarms
> -rw-r--r--    1 root     root            0 Jan 28 03:12 beep
> -rw-r--r--    1 root     root            0 Jan 28 03:12 fan1
> -rw-r--r--    1 root     root            0 Jan 28 03:12 fan2
> -rw-r--r--    1 root     root            0 Jan 28 03:12 fan3
> -rw-r--r--    1 root     root            0 Jan 28 03:12 fan_div
> -rw-r--r--    1 root     root            0 Jan 28 03:12 in0
> -rw-r--r--    1 root     root            0 Jan 28 03:12 in1
> -rw-r--r--    1 root     root            0 Jan 28 03:12 in2
> -rw-r--r--    1 root     root            0 Jan 28 03:12 in3
> -rw-r--r--    1 root     root            0 Jan 28 03:12 in4
> -rw-r--r--    1 root     root            0 Jan 28 03:12 in5
> -rw-r--r--    1 root     root            0 Jan 28 03:12 in6
> -rw-r--r--    1 root     root            0 Jan 28 03:12 in7
> -rw-r--r--    1 root     root            0 Jan 28 03:12 in8
> -rw-r--r--    1 root     root            0 Jan 28 03:12 pwm1
> -rw-r--r--    1 root     root            0 Jan 28 03:12 pwm2
> -rw-r--r--    1 root     root            0 Jan 28 03:12 pwm3
> -rw-r--r--    1 root     root            0 Jan 28 03:12 pwm4
> -rw-r--r--    1 root     root            0 Jan 28 03:12 sensor1
> -rw-r--r--    1 root     root            0 Jan 28 03:12 sensor2
> -rw-r--r--    1 root     root            0 Jan 28 03:12 sensor3
> -rw-r--r--    1 root     root            0 Jan 28 03:12 temp1
> -rw-r--r--    1 root     root            0 Jan 28 03:12 temp2
> -rw-r--r--    1 root     root            0 Jan 28 03:12 temp3
> -r--r--r--    1 root     root            0 Jan 28 03:12 vid
> root@corel-linux: sensors
> w83782d-i2c-0-2d
> Adapter: SMBus AMD7X6 adapter at 80e0
> Algorithm: Non-I2C SMBus adapter
> CPU0Core:  +1.72 V  (min =  +1.66 V, max =  +2.03 V)
> CPU1Core:  +2.83 V  (min =  +1.66 V, max =  +2.03 V)
> +3.3V:     +3.31 V  (min =  +2.97 V, max =  +3.63 V)
> +5V:       +4.94 V  (min =  +4.50 V, max =  +5.48 V)
> +12V:      +4.71 V  (min = +10.79 V, max = +13.11 V)
> -12V:      -2.01 V  (min = -13.21 V, max = -10.90 V)
> -5V:       +2.68 V  (min =  -5.51 V, max =  -4.51 V)
> V5SB:      +4.30 V  (min =  +4.50 V, max =  +5.48 V)
> VBat:      +3.29 V  (min =  +2.70 V, max =  +3.29 V)
> CPU0Fan:  5232 RPM  (min = 3000 RPM, div = 2)
> CPU1Fan:  5232 RPM  (min = 3000 RPM, div = 2)
> ChassisFan1:
>           2922 RPM  (min = 3000 RPM, div = 2)
> temp1:    +80.0?C   (limit = +60?C, hysteresis = +50?C) sensor = PII/Celeron
> diode
> temp2:    +82.5?C   (limit = +60?C, hysteresis = +50?C) sensor = PII/Celeron
> diode   ALARM
> temp3:    +78.0?C   (limit = +60?C, hysteresis = +50?C) sensor = PII/Celeron
> diode   ALARM
> vid:      +1.85 V
> 
> root@corel-linux:
> 
> From /etc/sensors.conf:
> 
> chip "w83782d-*" "w83783s-*" "w83627hf-*"
> 
> # Same as above for w83781d except that in5 and in6 are computed differently.
> # Rather than an internal inverting op amp, the 82d/83s use standard positive
> # inputs and the negative voltages are level shifted by a 3.6V reference.
> # The math is convoluted, so we hope that your motherboard
> # uses the recommended resistor values.
> 
>     label in0 "CPU0Core"
>     label in1 "CPU1Core"
>     label in2 "+3.3V"
> #    ignore in2
>     label in3 "+5V"
>     label in4 "+12V"
>     label in5 "-12V"
>     label in6 "-5V"
> #    ignore in6
>     label in7 "V5SB"
>     label in8 "VBat"
>     label fan1 "CPU0Fan"
>     label fan2 "CPU1Fan"
>     label fan3 "ChassisFan1"
>     label fan4 "ChassisFan2"
>     ignore alarms
> 
>     compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
>     compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
>     compute in5 (5.14 * @) - 14.91  ,  (@ + 14.91) / 5.14
>     compute in6 (3.14 * @) -  7.71  ,  (@ +  7.71) / 3.14
>     compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
> 
> # set limits to  5% for the critical voltages
> # set limits to 10% for the non-critical voltages
> # set limits to 20% for the battery voltage
> 
>     set in0_min vid*0.95
>     set in0_max vid*1.05
>     set in1_min vid*0.95
>     set in1_max vid*1.05
>     set in2_min 3.3 * 0.95
>     set in2_max 3.3 * 1.05
>     set in3_min 5.0 * 0.95
>     set in3_max 5.0 * 1.05
>     set in4_min 12 * 0.90
>     set in4_max 12 * 1.10
>     set in5_min -12 * 0.90
>     set in5_max -12 * 1.10
>     set in6_min -5 * 0.95
>     set in6_max -5 * 1.05
>     set in7_min 5 * 0.95
>     set in7_max 5 * 1.05
>     set in8_min 3.0 * 0.80
>     set in8_max 3.0 * 1.20
> 
> # set up sensor types (thermistor is default)
> # 1 = PII/Celeron Diode; 2 = 3904 transistor;
> # 3435 = thermistor with Beta = 3435
> # If temperature changes very little, try 1 or 2.
>    set sensor1 2
>    set sensor2 2
>    set sensor3 2
> 
> # examples for temperature limits
> #    set temp1_over 40
> #    set temp1_hyst 37
> #    set temp2_over 52
> #    set temp2_hyst 47
> #    set temp3_over 52
> #    set temp3_hyst 47
> 
> I realize I need to do a 'sensors -s' to get the 'set' commands evaluated, but
> if I do that, it may cause my machine to shut down, I presume to an out of
> limit condition.
> 
> Thanks for any advice you can give.
> Chris Shaker
> cjshaker@shaker-net.com
